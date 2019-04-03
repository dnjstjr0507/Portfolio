package kr.ws.travel.groupboard;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class GroupBoardDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	// 전체 개수 구하기
	public int selectCount() {
		return sqlSession.selectOne("group.board.selectCount");
	}
	
	// 전체 얻기
	public List<GroupBoardVO> selectAll() {
		return sqlSession.selectList("group.board.selectAll");
	}
	
	// 1개 얻기
	public GroupBoardVO selectByIdx(int gb_idx) {
		return sqlSession.selectOne("group.board.selectByIdx", gb_idx);
	}
	
	// 그룹 번호 가져오기
	public int selectidx(String gb_subject) {
		return sqlSession.selectOne("group.board.selectidx", gb_subject);
	}
	
	// 저장
	public void insertGroup(GroupBoardVO groupBoardVO) {
		sqlSession.insert("group.board.insertGroupBoard", groupBoardVO);
	}

	// 수정
	public void updateGroup(GroupBoardVO groupBoardVO) {
		sqlSession.update("group.board.updateGroupBoard", groupBoardVO);
	}
	
	// 삭제
	public void deleteGroup(int gb_idx) {
		sqlSession.delete("group.board.deleteGroupBoard", gb_idx);
	}
}
