package kr.ws.travel.menu;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MenuDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	// 전체 가져오기
	public List<MenuVO> selectAll(){
		return sqlSession.selectList("menu.selectAll");
	}
	
	// 분류된것만 가져오기
	public List<MenuVO> listoflist(){
		return sqlSession.selectList("menu.listoflist");
	}
	
	// 대분류갯수 가져오기
	public int selectCountBig(String menu_type) {
		return sqlSession.selectOne("menu.selectCountBig", menu_type);
	}
	
	//소분류갯수 가져오기
	public int selectCountmenucode(String code) {
		return sqlSession.selectOne("menu.selectCountmenucode", code);
	}
	
	
	// 저장
	public void insertMenu(MenuVO menuVO) {
		sqlSession.insert("menu.insertMenu", menuVO);
	}
	
	// 삭제
	public void deleteMenu(int menu_id) {
		sqlSession.delete("menu.deleteMenu", menu_id);
	}
}
