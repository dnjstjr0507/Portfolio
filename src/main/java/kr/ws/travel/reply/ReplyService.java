package kr.ws.travel.reply;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ws.travel.paging.Paging;

@Service
public class ReplyService {

	@Autowired
	private ReplyDAO replyDAO;
	
	// 전체 구하기
	public Paging<ReplyVO> selectAll(String bt_table, int ab_idx,int currentPage, int pageSize, int blockSize) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("bt_table", bt_table);
		map.put("ab_idx", ab_idx+"");
		Paging<ReplyVO> paging = null;
		int totalCount = replyDAO.selectCount(map);
		paging = new Paging<ReplyVO>(totalCount, currentPage, pageSize, blockSize);
		if(totalCount>0) {
			HashMap<String, String> map2 = new HashMap<String, String>();
			map2.put("startNo", paging.getStartNo()+"");
			map2.put("endNo", paging.getEndNo()+"");
			map2.put("bt_table", bt_table);
			map2.put("ab_idx", ab_idx+"");
			List<ReplyVO> list = replyDAO.selectAll(map2);
			paging.setLists(list);
		}
		return paging;
	}
	
	// 갯수 구하기
	public int selectCount(String bt_table, int ab_idx) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("bt_table", bt_table);
		map.put("ab_idx", ab_idx);
		 return replyDAO.selectCount(map);
	}
	
	// 저장
	public void insertReply(ReplyVO replyVO) {
		replyDAO.insertReply(replyVO);
	}
	
	// 수정
	public void updateReply(ReplyVO replyVO) {
		replyDAO.updateReply(replyVO);
	}

	// 삭제
	public void deleteReply(ReplyVO replyVO) {
		replyDAO.deleteReply(replyVO);
	}
	
	// 댓글 전체 삭제
	public void deleteAllReply(String bt_table, int ab_idx) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("bt_table", bt_table);
		map.put("ab_idx", ab_idx+"");
		replyDAO.deleteAllReply(map);
	}
	
	
}
