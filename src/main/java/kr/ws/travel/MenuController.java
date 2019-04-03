package kr.ws.travel;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.ws.travel.boardtable.BoardTableService;
import kr.ws.travel.boardtable.BoardTableVO;
import kr.ws.travel.groupboard.GroupBoardService;
import kr.ws.travel.groupboard.GroupBoardVO;
import kr.ws.travel.menu.MenuService;
import kr.ws.travel.menu.MenuVO;

@Controller
public class MenuController {
	
	@Autowired
	private MenuService menuService;
	
	@Autowired
	private BoardTableService boardTable;
	
	@Autowired
	private GroupBoardService groupBoard;
	
	@RequestMapping(value="admin/menulist")
	public String list(Model model) {
		List<MenuVO> list = menuService.selectAll();
		model.addAttribute("list", list);
		return "admin/menulist";
	}
	
	@RequestMapping(value="admin/menuwrite")
	public String selectmenu(@RequestParam String menu_type, Model model, HttpServletRequest request) {
		String me_type = "";
		String code ="";
		if(request.getParameter("code") != null) {
			 code = request.getParameter("code");
			 model.addAttribute("code", code);
			 int code2 = menuService.selectCountmenucode(code);
			 model.addAttribute("code2", code2);
		}
		
		if(request.getParameter("me_type") != null) {
			me_type = request.getParameter("me_type");
			menu_type = request.getParameter("menu_type");
			int cnt =  menuService.selectCountBig(menu_type);
			model.addAttribute("menu_code", cnt);
		}
		List<BoardTableVO> btlist = boardTable.selectAll();
		List<GroupBoardVO> gblist = groupBoard.selectAll();
		model.addAttribute("menu_type", menu_type);
		model.addAttribute("btlist", btlist);
		model.addAttribute("gblist", gblist);
		model.addAttribute("me_type" , me_type);
		return "admin/menuwrite";
	}
	
	@RequestMapping(value="admin/insertmenusuccess")
	public String insertMenu(@ModelAttribute MenuVO menuVO) {
		menuService.insertMenu(menuVO);
		return "redirect:/admin/menulist";
	}
	
	@RequestMapping(value="admin/deleteMenu")
	public String deleteMenuSuccess(int menu_id) {
			menuService.deleteMenu(menu_id);
		return "redirect:/admin/menulist";
	}
	
}
