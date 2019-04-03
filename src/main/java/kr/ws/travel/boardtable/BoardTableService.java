package kr.ws.travel.boardtable;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ws.travel.groupboard.GroupBoardVO;

@Service
public class BoardTableService {

	@Autowired
	private BoardTableDAO boardTableDAO;
	
	// 리스트 가져오기
	public List<BoardTableVO> selectAll() {
		return boardTableDAO.selectAll();
	}
	
	// 1개 가져오기
	public BoardTableVO selectGetOne(int bt_idx) {
		return boardTableDAO.selectGetOne(bt_idx);
	}
	
	// 테이블 가져오기
	public String selectTable(int bt_idx) {
		return boardTableDAO.selectTable(bt_idx);
	}
	
	// 테이블 생성하기
	public void insertTable (BoardTableVO boardTableVO) {
		boardTableDAO.insertTable(boardTableVO);
	}
	
	// 테이블 삭제하기
	public void deleteTable (String bt_table) {
		boardTableDAO.deleteTable(bt_table);
	}
	 
	// 테이블 수정하기
	public void updateTable(BoardTableVO boardTableVO) {
		boardTableDAO.updateTable(boardTableVO);
	}
}
