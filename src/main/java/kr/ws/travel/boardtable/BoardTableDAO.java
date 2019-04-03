package kr.ws.travel.boardtable;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ws.travel.groupboard.GroupBoardVO;

@Repository
public class BoardTableDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	// 전부 가져오기
	public List<BoardTableVO> selectAll() {
		return sqlSession.selectList("boardtable.selectAll");
	}

	// 전체 갯수 가져오기
	public int selectCountAll() {
		return sqlSession.selectOne("boardtable.selectCountAll");
	}
	
	// 1개 가져오기
	public BoardTableVO selectGetOne(int bt_idx) {
		return sqlSession.selectOne("boardtable.selectGetOne", bt_idx);
	}
	
	// 테이블 가져오기
	public String selectTable(int bt_idx) {
		return sqlSession.selectOne("boardtable.selectTable", bt_idx);
	}
	
	// 게시판관리 저장(시퀀스, 게시판, 댓글, 파일) 생성
	public void insertTable(BoardTableVO boardTableVO) {
		sqlSession.insert("boardtable.insertTable",boardTableVO);
		HashMap<String, String> map = new HashMap<String, String>();
		
		map.put("bt_table", boardTableVO.getBt_table());
		sqlSession.update("boardtable.createBoardSeq", map);
		sqlSession.update("boardtable.createReplySeq", map);
		sqlSession.update("boardtable.createFileSeq", map);
		sqlSession.update("boardtable.createBoard", map);
		sqlSession.update("boardtable.createReply", map);
		sqlSession.update("boardtable.createFile", map);
	}
	
	// 게시판관리 삭제(시퀀스, 게시판, 댓글, 파일) 삭제
	public void deleteTable(String bt_table) {
		sqlSession.delete("boardtable.deleteTable", bt_table);
		sqlSession.delete("boardtable.dropBoardSeq", bt_table);
		sqlSession.delete("boardtable.dropReplySeq", bt_table);
		sqlSession.delete("boardtable.dropFileSeq", bt_table);
		sqlSession.delete("boardtable.dropBoard", bt_table);
		sqlSession.delete("boardtable.dropReply", bt_table);
		sqlSession.delete("boardtable.dropFile", bt_table);
	}
	
	// 테이블 수정
	public void updateTable(BoardTableVO boardTableVO) {
		sqlSession.update("boardtable.updateTable", boardTableVO);
	}
}
