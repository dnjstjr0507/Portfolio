package kr.ws.travel;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.ws.travel.board.BoardService;
import kr.ws.travel.board.BoardVO;
import kr.ws.travel.file.FileBucket;
import kr.ws.travel.file.FilesService;
import kr.ws.travel.file.FilesVO;
import kr.ws.travel.file.MultiFileBucket;
import kr.ws.travel.member.MemberVO;
import kr.ws.travel.menu.MenuService;
import kr.ws.travel.menu.MenuVO;
import kr.ws.travel.paging.Paging;
import kr.ws.travel.reply.ReplyService;
import kr.ws.travel.util.ClientUtils;

@Controller
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private BoardService boardService;
	
	@Autowired 
	private MenuService menuService;
	
	@Autowired
	private ReplyService replyService;
	
	@Autowired
	private FilesService fliesService;
	
	// 리스트
	@RequestMapping(value="listBoard")
	public String selectAll(
			@RequestParam(required=false) Integer p,
			@RequestParam(required=false) Integer s,
			@RequestParam(required=false) Integer b,
			@RequestParam(required=false) String bt_table, 
			HttpServletRequest request,
			Model model) {
		Map<String, ?> map = RequestContextUtils.getInputFlashMap(request);
		if(map != null) {
			bt_table = (String)map.get("bt_table");
			p = (Integer)map.get("p");
			s = (Integer)map.get("s");
			b = (Integer)map.get("b");
		}
		
		int currentPage = 1;
		int pageSize = 10;
		int blockSize = 10;
		if (p != null) 
			currentPage = p;
		if (s != null)
			pageSize = s;
		if (b != null) 	
			blockSize = b;
		Paging<BoardVO> paging = boardService.selectAll(bt_table, currentPage, pageSize, blockSize);
		model.addAttribute("bt_table", bt_table);
		List<List<MenuVO>> mlist = menuService.listoflist();
 		model.addAttribute("mlist",mlist);
 		model.addAttribute("paging", paging);
 		
		return "index/listBoard";
	}
	
	// 1개 보기
	@RequestMapping(value="viewBoard", method= {RequestMethod.POST,RequestMethod.GET})
	public String selectGetOne(
			@RequestParam(required=false) Integer p,
			@RequestParam(required=false) Integer s,
			@RequestParam(required=false) Integer b,
			@RequestParam(required=false) Integer m,
			@RequestParam(required=false) Integer ab_idx, 
			@RequestParam(required=false) String bt_table, 
			HttpServletRequest request,
			HttpServletResponse response,
			RedirectAttributes redirectAttributes,
			Model model) {
		Map<String, ?> map = RequestContextUtils.getInputFlashMap(request);
		if(map != null) {
			bt_table = (String)map.get("bt_table");
			ab_idx = (Integer)map.get("ab_idx");
			p = (Integer)map.get("p");
			s = (Integer)map.get("s");
			b = (Integer)map.get("b");
		}
		
		// 기본값
		int index = 0;
		int mode = 0;
		int currentPage = 1;
		int pageSize = 10;
		int blockSize = 10;
		// 값이 넘어왔을 경우에만 값 변경
		if (ab_idx != null) index = ab_idx;
		if (m != null) mode = m;
		if (p != null) currentPage = p;
		if (s != null) pageSize = s;
		if (b != null) blockSize = b;
		
		// ----------------------------------------------------------------------------
		// 쿠키에 해당게시판 글번호가 저장되어있는지 확인을 한다.
		Cookie[] cookies = request.getCookies();
		boolean isRead = false;
		if (cookies != null && cookies.length > 0) {
			for (Cookie cookie : cookies) {
				if (("free" + index).equals(cookie.getName())) {
					isRead = true;
					break;
				}
			}
		}
		if (isRead) {
			// 저장되어 있으면 이미 글을 본적이 있다 --- 조회수 증가시키지 않는다
			mode = 0;
		} else {
			// 저장되어있지 않으면 조회수를 증가시키고 글번호를 쿠키로 저장해준다.
			mode = 1;
			Cookie cookie = new Cookie("free" + index, "free" + index);
			cookie.setMaxAge(60 * 60 * 24); // 1일동안 저장
			response.addCookie(cookie);
		}
		// ----------------------------------------------------------------------------
		
		BoardVO WriteVO = boardService.selectGetOn(bt_table, ab_idx, mode);
		if(WriteVO == null) {
			Map<String, Object> map2 = new HashMap<String, Object>();
			redirectAttributes.addFlashAttribute("bt_table", bt_table);
			redirectAttributes.addFlashAttribute("p", p);
			redirectAttributes.addFlashAttribute("s", s);
			redirectAttributes.addFlashAttribute("b", b);
			return "redirect:/listBoard";
		}
		List<FilesVO> fileslist = fliesService.selectRefAll(bt_table, ab_idx);
		List<List<MenuVO>> mlist = menuService.listoflist();
		model.addAttribute("p", p);
		model.addAttribute("s", s);
		model.addAttribute("b", b);
		model.addAttribute("bt_table", bt_table);
		model.addAttribute("mlist", mlist);
		model.addAttribute("WriteVO", WriteVO);
		model.addAttribute("fileslist", fileslist);
		return "index/viewBoard";
	}
	
	// 파일 저장
	@RequestMapping(value="down")
	public void down(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getRealPath("/upload/");
		String file_original = request.getParameter("o");
		String file_subfile = request.getParameter("s");
		
	    InputStream in = null;
	    OutputStream os = null;
	    File file = null;
	    boolean skip = false; // 존재하지않는 파일일경우 패스
	    String client = "";
	    try{
	        // 파일을 읽어 스트림에 담기
	        try{
	            file = new File(path, file_subfile);
	            in = new FileInputStream(file);
	        }catch(FileNotFoundException fe){
	            skip = true;
	        }
			// 브라우져 종류         
	        client = request.getHeader("User-Agent");

	        // 파일 다운로드 헤더 지정
	        response.reset() ;
	        response.setContentType("application/octet-stream"); // 핸제 데이터가 스트림이다라고 알려준다.
	        // response.setHeader("Content-Description", "JSP Generated Data");
	        if(!skip){ // 파일이 존재 한다면
	            // 한글 파일명 처리
	            if(client.indexOf("Trident")==-1){
	            	file_original = new String(file_original.getBytes("utf-8"),"iso-8859-1");
	            }else{
	            	file_original = URLEncoder.encode(file_original, "UTF-8" ).replaceAll("\\+","%20" );
	            }
	            response.setHeader("Content-Disposition", "attachment; filename=\"" + file_original + "\"");
	            response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
	            response.setHeader ("Content-Length", ""+file.length() );
				
				os = response.getOutputStream();
				// 복사
				byte b[] = new byte[(int)file.length()]; // 파일 크기만큼 배열선언
	            int leng = 0;
	            while( (leng = in.read(b)) > 0 ){ // 읽기
	                os.write(b,0,leng); // 쓰기
	                os.flush();
	            }
	        }
	        in.close();
	        os.close();
	    }catch(Exception e){
	      e.printStackTrace();
	    }
	}
	
	
	// 저장
	@RequestMapping(value="writeBoard", method = RequestMethod.POST)
	public String insertBoard(
			@RequestParam(required=false) Integer p,
			@RequestParam(required=false) Integer s,
			@RequestParam(required=false) Integer b,
			@RequestParam String bt_table,
			Model model,
			HttpServletRequest request){
		int currentPage = 1;
		int pageSize = 10;
		int blockSize = 10;
		if (p != null) 
			currentPage = p;
		if (s != null)
			pageSize = s;
		if (b != null) 
			blockSize = b;
		
		List<List<MenuVO>> mlist = menuService.listoflist();
		model.addAttribute("p", p);
		model.addAttribute("b", b);
		model.addAttribute("s", s);
		model.addAttribute("bt_table", bt_table);
		model.addAttribute("mlist",mlist);
		return "index/writeBoard";
	}
	
	// 저장 로직
	@RequestMapping(value="insertSuccess", method = RequestMethod.POST)
	public String insertSuccess(
			@RequestParam(required=false) Integer p,
			@RequestParam(required=false) Integer s,
			@RequestParam(required=false) Integer b,
			@ModelAttribute BoardVO boardVO,
			@ModelAttribute MultiFileBucket multiFileBucket,
			HttpServletRequest request,
			RedirectAttributes redirectAttributes,
			Model model)throws IOException {
			String ip = ClientUtils.getRemoteIP(request);
			boardVO.setAb_ip(ip);
			boardService.insertBoard(boardVO,multiFileBucket,request);
			int idx =  boardService.selectMaxidx(boardVO.getBt_table());
			redirectAttributes.addFlashAttribute("bt_table", boardVO.getBt_table());
			redirectAttributes.addFlashAttribute("ab_idx", idx);
			redirectAttributes.addFlashAttribute("p", p);
			redirectAttributes.addFlashAttribute("b", b);
			redirectAttributes.addFlashAttribute("s", s);
		return "redirect:/viewBoard";
	}
	
	// 수정
	@RequestMapping(value="updateBoard", method = RequestMethod.POST)
	public String updateBoard(
			@RequestParam(required=false) Integer p,
			@RequestParam(required=false) Integer s,
			@RequestParam(required=false) Integer b,
			@RequestParam(required=false) Integer m,
			@RequestParam String bt_table,
			@RequestParam int ab_idx,
			RedirectAttributes redirectAttributes,
			HttpSession session,
			Model model) {
		MemberVO vo = (MemberVO) session.getAttribute("vo");
		int mode = 0;
		BoardVO updateVO = boardService.selectGetOn(bt_table, ab_idx, mode);
	
		if(updateVO==null) {
			redirectAttributes.addFlashAttribute("p", p);
			redirectAttributes.addFlashAttribute("s", s);
			redirectAttributes.addFlashAttribute("b", b);
			redirectAttributes.addFlashAttribute("bt_table", bt_table);
			return "redirect:/index/listBoard";
		}
		
		int filecount = fliesService.selectCount(bt_table, ab_idx);
		List<FilesVO> fileslist = fliesService.selectRefAll(bt_table, ab_idx);
		List<List<MenuVO>> mlist = menuService.listoflist();
		model.addAttribute("updateVO", updateVO);
		model.addAttribute("fileslist", fileslist);
		model.addAttribute("filecount", filecount);
		model.addAttribute("p", p);
		model.addAttribute("b", b);
		model.addAttribute("s", s);
		model.addAttribute("m", m);
		model.addAttribute("bt_table", bt_table);
		model.addAttribute("mlist",mlist);
		if(vo != null) {
			return "index/updateBoard";
		}else {
			return "redirect:/";
		}
	}
	
	// 수정 로직
	@RequestMapping(value="updateSuccess", method= RequestMethod.POST)
	public String updateSuccess(
			@RequestParam(required=false) Integer p,
			@RequestParam(required=false) Integer s,
			@RequestParam(required=false) Integer b,
			@RequestParam(required=false) Integer m,
			@RequestParam(required=false) Integer[] file_idx,
			@RequestParam String bt_table,
			@RequestParam String ab_subject,
			@RequestParam String ab_content,
			@RequestParam String mb_id,
			@RequestParam int ab_idx,
			@ModelAttribute MultiFileBucket multiFileBucket,
			HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		int idx =  boardService.selectMaxidx(bt_table);
		
		System.out.println(Arrays.toString(file_idx));
		
		
		for (Integer fileidx : file_idx) {
			boardService.updateBoard(bt_table,ab_subject,ab_content,mb_id,ab_idx,fileidx,multiFileBucket,request);
		}

		redirectAttributes.addFlashAttribute("bt_table", bt_table);
		redirectAttributes.addFlashAttribute("ab_idx", idx);
		redirectAttributes.addFlashAttribute("p", p);
		redirectAttributes.addFlashAttribute("s", s);
		redirectAttributes.addFlashAttribute("b", b);
		redirectAttributes.addFlashAttribute("m", 0);
		return "redirect:/viewBoard";
	}
	
	// 삭제
	@RequestMapping(value="deleteBoard", method=RequestMethod.POST)
	public String deleteBoard(
			@RequestParam(required=false) Integer p,
			@RequestParam(required=false) Integer s,
			@RequestParam(required=false) Integer b,
			@RequestParam String bt_table,
			@RequestParam String mb_id,
			@RequestParam int ab_idx,
			RedirectAttributes redirectAttributes,
			Model model
			) {
		boardService.deleteBoard(bt_table, mb_id, ab_idx);
		fliesService.deleteFileAll(bt_table, ab_idx);
		replyService.deleteAllReply(bt_table, ab_idx);
		redirectAttributes.addFlashAttribute("bt_table", bt_table);
		redirectAttributes.addFlashAttribute("p", p);
		redirectAttributes.addFlashAttribute("b", b);
		redirectAttributes.addFlashAttribute("s", s);
		return "redirect:/listBoard";
	}
	
	

}
