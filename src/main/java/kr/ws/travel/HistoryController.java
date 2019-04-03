package kr.ws.travel;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.ws.travel.history.HistoryService;
import kr.ws.travel.history.HistoryVO;
import kr.ws.travel.member.MemberVO;
import kr.ws.travel.menu.MenuService;
import kr.ws.travel.menu.MenuVO;
import kr.ws.travel.paging.Paging;

@Controller
public class HistoryController {
	
	@Autowired
	private HistoryService historyService;
	
	@Autowired 
	private MenuService menuService;
	
	@RequestMapping(value="loginHistory")
	public String loginHistory(
			@RequestParam(required=false) Integer p,
			@RequestParam(required=false) Integer s,
			@RequestParam(required=false) Integer b,
			@RequestParam String mb_id,
			HttpSession session,
			Model model) {
		MemberVO vo = (MemberVO)session.getAttribute("vo");
		int currentPage = 1;
		int pageSize = 10;
		int blockSize = 10;
		if (p != null) 
			currentPage = p;
		if (s != null)
			pageSize = s;
		if (b != null) 	
			blockSize = b;
		Paging<HistoryVO> paging =historyService.historyByAll(mb_id, currentPage, pageSize, blockSize);
		List<List<MenuVO>> mlist = menuService.listoflist();
 		model.addAttribute("mlist",mlist);
 		model.addAttribute("paging",paging);
 		if(vo!=null) {
 			return "index/mypage/loginHistory";
 		}else {
			return "redirect:/";
		}
 		
		
	}
	
}
