package kr.ws.travel.groupboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GroupBoardService {

	@Autowired
	GroupBoardDAO groupBoardDAO;
	
	// 전체 얻기
	public List<GroupBoardVO> selectAll(){
		return groupBoardDAO.selectAll();
	}
	
	// 1개 얻기
	public GroupBoardVO selectByIdx(int gb_idx) {
		return groupBoardDAO.selectByIdx(gb_idx);
	}
	
	// 그룹 번호 가져오기
	public int selectidx(String gb_subject) {
		return groupBoardDAO.selectidx(gb_subject);
	}
	
	// 저장
	public void insertGroup(GroupBoardVO groupBoardVO) {
		groupBoardDAO.insertGroup(groupBoardVO);
	}
	
	// 수정
	public void updateGroup(GroupBoardVO groupBoardVO) {
		groupBoardDAO.updateGroup(groupBoardVO);
	}
	
	// 삭제
	public void deleteGroup(int gb_idx) {
		groupBoardDAO.deleteGroup(gb_idx);
	}
}
