package kr.ws.travel.menu;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MenuService {

	@Autowired 
	private MenuDAO menuDAO;
	
	//전체 가져오기
	public List<MenuVO> selectAll(){
		return menuDAO.selectAll();
	}
	
	// 메뉴 분류
	public List<List<MenuVO>> listoflist(){
		List<MenuVO> list = menuDAO.listoflist();
		List<List<MenuVO>> allList = new ArrayList();
		List<MenuVO> list2 = null; 
		for(MenuVO vo : list) {
			if(vo.getMenu_sub()==0) {
				if(list2!=null) allList.add(list2);
				list2 = new ArrayList<MenuVO>();
			}
			list2.add(vo);
		}
		allList.add(list2);
		return allList;
	}
	
	
	// 갯수 가져오기
	public int selectCountBig(String menu_type) {
		return menuDAO.selectCountBig(menu_type);
	}
	
	// 대분류의 소분류 갯수 가져오기
	public int selectCountmenucode(String code) {
		return menuDAO.selectCountmenucode(code);
	}
	
	// 저장
	public void insertMenu(MenuVO menuVO) {
		menuDAO.insertMenu(menuVO);
	}
	
	// 삭제
	public void deleteMenu(int menu_id) {
		menuDAO.deleteMenu(menu_id);
	}
	
}