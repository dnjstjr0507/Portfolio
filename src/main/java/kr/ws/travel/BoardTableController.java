package kr.ws.travel;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.ws.travel.boardtable.BoardTableService;
import kr.ws.travel.boardtable.BoardTableVO;
import kr.ws.travel.groupboard.GroupBoardService;
import kr.ws.travel.groupboard.GroupBoardVO;

@Controller
public class BoardTableController {
	
	@Autowired
	private BoardTableService boardTableService;
	
	@Autowired
	private GroupBoardService groupboard;
	
	@RequestMapping(value="admin/tablelist")
	public String selectAll(Model model){
		List<BoardTableVO> list = boardTableService.selectAll();
		model.addAttribute("list", list);
		return "admin/tablelist";
	}
	
	// 그룹 번호 가져오기 ajax
	@RequestMapping(value="admin/selectidx")
	@ResponseBody
	public String selectidx(@RequestParam String gb_subject) {
		return groupboard.selectidx(gb_subject) + "";
	}
	
	// 저장하기
	@RequestMapping(value="admin/tablewrite", method=RequestMethod.POST)
	public String wirtePost(Model model) {
		List<GroupBoardVO> list = groupboard.selectAll();
		model.addAttribute("list", list);
		return "admin/tablewrite";
	}
	
	@RequestMapping(value = "admin/tablewrite", method = RequestMethod.GET)
	public String writeGet() {
		return "redirect:/";
	}
	
	
	@RequestMapping(value = "admin/writeOk", method = RequestMethod.POST)
	public String writePostOk(
			@ModelAttribute BoardTableVO boardTableVO  
			){
		System.out.println("===================================================");
		System.out.println(boardTableVO);
		System.out.println("===================================================");
		boardTableService.insertTable(boardTableVO);
		// POST 전송
		return "redirect:/admin/tablelist";
	}

	@RequestMapping(value = "admin/writeOk", method = RequestMethod.GET)
	public String writeGetOk() {
		return "redirect:/";
	}
	
	@RequestMapping(value="admin/tabledelete", method=RequestMethod.POST)
	public String deleteTable(@RequestParam int bt_idx) {
		String bt_table = boardTableService.selectTable(bt_idx);
		if(bt_table!=null) {
			boardTableService.deleteTable(bt_table);
		}
		return "redirect:/admin/tablelist";
	}
	
	@RequestMapping(value="admin/tabledelete", method=RequestMethod.GET )
	public String deleteTableGet() {
		return "redirect:/";
	}
	
	@RequestMapping(value="admin/tableview", method=RequestMethod.POST)
	public String tableview(@RequestParam int bt_idx, Model model) {
		BoardTableVO boardTableVO = boardTableService.selectGetOne(bt_idx);
		model.addAttribute("vo", boardTableVO);
		return "admin/tableview";
	}
	
	@RequestMapping(value="admin/tableupdate")
	public String tableupdate(@ModelAttribute BoardTableVO boardTableVO) {
		boardTableService.updateTable(boardTableVO);
		return "redirect:/admin/tablelist";
	}
}
