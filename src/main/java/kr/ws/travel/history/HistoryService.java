package kr.ws.travel.history;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ws.travel.paging.Paging;

@Service
public class HistoryService {

	@Autowired
	private HistoryDAO historyDAO;
	
	// 저장
	public void insertHistory(String mb_id, String hs_ip) {
		historyDAO.insertHistory(mb_id, hs_ip);
	}
	
	// 전체 가져오기
	public Paging<HistoryVO> historyByAll(String mb_id, int currentPage, int pageSize, int blockSize){
		Paging<HistoryVO> paging = null;
		int totalCount = historyDAO.historyCount(mb_id);
		paging = new Paging<HistoryVO>(totalCount, currentPage, pageSize, blockSize);
		if(totalCount>0) {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("startNo", paging.getStartNo()+"");
			map.put("endNo", paging.getEndNo()+"");
			map.put("mb_id", mb_id);
			List<HistoryVO> list = historyDAO.historyByAll(mb_id);
			paging.setLists(list);
			
		}
		return paging;
	}
	
}
