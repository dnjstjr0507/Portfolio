package kr.ws.travel.board;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	// 1개 가져오기
	public BoardVO selectGetOn(String bt_table, int ab_idx) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("bt_table", bt_table);
		map.put("ab_idx", ab_idx+"");
		return sqlSession.selectOne("board.selectGetOn", map);
	}
	
	// maxidx가져오기
	public int selectMaxidx(String bt_table) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("bt_table", bt_table);
		return sqlSession.selectOne("board.selectMaxidx", map);
	}
	
	// 전체 갯수 구하기
	public int selectCount (String bt_table) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("bt_table", bt_table);
		return sqlSession.selectOne("board.selectCount", map);
	}
	
	// 전체 가져오기
	public List<BoardVO> selectAll(HashMap<String, String> map){
		return sqlSession.selectList("board.selectAll",map);
	}
	
	// 저장
	public void insertBoard(BoardVO boardVO) {
		sqlSession.insert("board.insertBoard", boardVO);
	}
	
	// 수정
	public void updateBoard(HashMap<String, String> map) {
		sqlSession.update("board.updateBoard", map);
	}
	
	// 삭제
	public void deleteBoard(HashMap<String, String> map) {
		sqlSession.delete("board.deleteBoard", map);
	}
	
	// 조회수 증가
	public void hitupdate(String bt_table, int ab_idx) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("bt_table", bt_table);
		map.put("ab_idx", ab_idx+"");
		sqlSession.update("board.hitUpdate", map);
	}
}
