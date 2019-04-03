package kr.ws.travel;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.ws.travel.groupboard.GroupBoardService;
import kr.ws.travel.groupboard.GroupBoardVO;

@Controller
public class GroupController {

	@Autowired
	GroupBoardService groupBoardService;

	@Autowired
	SqlSession sqlSession;

	// 목록
	@RequestMapping(value = "admin/listGroup")
	public String list(Model model) {
		List<GroupBoardVO> list = groupBoardService.selectAll();
		model.addAttribute("list", list);
		return "admin/listGroup";
	}

	// 그룹추가
	@RequestMapping(value = "admin/addGroup", method=RequestMethod.POST)
	public String addGroupPost() {
		return "admin/addGroup";
	}
	@RequestMapping(value = "admin/addGroup", method=RequestMethod.GET)
	public String addGroupGet() {
		return "redirect:/";
	}

	// 그룹추가 로직
	@RequestMapping(value = "admin/insertGroup", method = RequestMethod.POST)
	public String insertGroupPOST(
			@ModelAttribute GroupBoardVO groupBoardVO,
			Model model) {
		if (groupBoardVO != null) {
			groupBoardService.insertGroup(groupBoardVO);
		}
		return "redirect:/admin/listGroup";
	}
	@RequestMapping(value = "admin/insertGroup", method = RequestMethod.GET)
	public String insertGroupGET() {
		return "redirect:/";
	}

	// 그룹 수정
	@RequestMapping(value = "admin/updateGroup", method=RequestMethod.POST)
	public String updateGroup(@RequestParam int gb_idx, Model model) {
		GroupBoardVO groupBoardVO = groupBoardService.selectByIdx(gb_idx);
		model.addAttribute("groupBoardVO", groupBoardVO);
		return "admin/updateGroup";
	}

	@RequestMapping(value = "admin/GroupupdateOk", method=RequestMethod.POST)
	public String updateGroupOkPOST(@ModelAttribute GroupBoardVO groupBoardVO) {
		groupBoardService.updateGroup(groupBoardVO);
		return "redirect:/admin/listGroup";
	}
	@RequestMapping(value = "admin/GroupupdateOk", method=RequestMethod.GET)
	public String updateGroupOkGET() {
		return "redirect:/";
	}
	
	@RequestMapping(value="admin/deleteGroupOK", method=RequestMethod.POST)
	public String deleteGroupOkPOST(@RequestParam int gb_idx) {
			groupBoardService.deleteGroup(gb_idx);
		return "redirect:/admin/listGroup";
	}
	@RequestMapping(value="admin/deleteGroupOK", method=RequestMethod.GET)
	public String deleteGroupOkGET() {
		return "redirect:/";
	}
}
