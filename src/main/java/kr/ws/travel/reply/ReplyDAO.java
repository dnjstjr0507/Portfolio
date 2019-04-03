package kr.ws.travel.reply;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReplyDAO {

	@Autowired
	private SqlSession sqlSession;
	
	// 전체 갯수 구하기
	public int selectCount(HashMap<String, Object> map) {
		return sqlSession.selectOne("reply.selectCount", map);
	}
	
	// 전체  구하기
	public List<ReplyVO> selectAll(HashMap<String, String> map) {
		return sqlSession.selectList("reply.selectAll",map);
	}
	
	// 저장
	public void insertReply(ReplyVO replyVO) {
		sqlSession.insert("reply.insertReply", replyVO);
	}
	
	// 수정
	public void updateReply(ReplyVO replyVO) {
		sqlSession.insert("reply.updateReply", replyVO);
	}
	
	// 삭제
	public void deleteReply(ReplyVO replyVO) {
		sqlSession.insert("reply.deleteReply", replyVO);
	}
	
	// 댓글 전체 삭제
	public void deleteAllReply(HashMap<String, String> map) {
		sqlSession.selectOne("reply.deleteAllReply", map);
	}
}
