package kr.ws.travel.history;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class HistoryDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	// 저장
	public void insertHistory(String mb_id, String hs_ip) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("mb_id", mb_id);
		map.put("hs_ip", hs_ip);
		sqlSession.insert("history.inserthistory", map);
	}
	
	// 전부 가져오기
	public List<HistoryVO> historyByAll(String mb_id){
		return sqlSession.selectList("history.historyByAll", mb_id);
	}
	
	// 카운트 가져오기
	public int historyCount(String mb_id) {
		return sqlSession.selectOne("history.historyCount", mb_id);
	}
	
	
}
