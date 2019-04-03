package kr.ws.travel;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.ws.travel.paging.Paging;
import kr.ws.travel.reply.ReplyService;
import kr.ws.travel.reply.ReplyVO;
import kr.ws.travel.util.ClientUtils;

@Controller
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	
	// 댓글 저장
	@RequestMapping(value="writeReply")
	@ResponseBody
	public void ajax_writeReply(@ModelAttribute ReplyVO replyVO, HttpServletRequest request) {
		String ip = ClientUtils.getRemoteIP(request);
		replyVO.setAr_ip(ip);
		 replyService.insertReply(replyVO);
	}
	
	// 댓글 가져오기(Ajax)
	@RequestMapping(value="listReply")
	public String ajax_listReply(
			@RequestParam(required=false) Integer p,
			@RequestParam(required=false) Integer s,
			@RequestParam(required=false) Integer b,
			@RequestParam String bt_table,
			@RequestParam Integer ab_idx,
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
		Paging<ReplyVO> pagingReply = replyService.selectAll(bt_table, ab_idx, currentPage, pageSize, blockSize);

		model.addAttribute("pagingReply", pagingReply);
		model.addAttribute("bt_table", bt_table);
		model.addAttribute("ab_idx", ab_idx);
		model.addAttribute("p", p);
		model.addAttribute("s", s);
		model.addAttribute("b", b);
		return "index/listReply";
	}
	
	// 갯수 가져오기
	@RequestMapping(value="countReply")
	@ResponseBody
	public int ajax_countReply(@RequestParam String bt_table, @RequestParam int ab_idx ) {
		return replyService.selectCount(bt_table, ab_idx);
	}
	
	// 수정
	@RequestMapping(value="updateReply", method=RequestMethod.POST)
	@ResponseBody
	public String ajax_updateReply(@ModelAttribute ReplyVO replyVO) {
			replyService.updateReply(replyVO);
		return "redirect:/listReply";
	}
	
	// 삭제
	@RequestMapping(value="deleteReply", method=RequestMethod.POST)
	@ResponseBody
	public void ajax_deleteReply(@RequestParam String mb_id, @RequestParam int ar_idx, @RequestParam int ab_idx, @RequestParam String bt_table) {
		ReplyVO replyVO = new ReplyVO();
		replyVO.setMb_id(mb_id);
		replyVO.setAr_idx(ar_idx);
		replyVO.setAb_idx(ab_idx);
		replyVO.setBt_table(bt_table);
		replyService.deleteReply(replyVO);
	}
}
