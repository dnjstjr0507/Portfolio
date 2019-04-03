package kr.ws.travel.file;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ws.travel.board.BoardDAO;

@Service
public class FilesService {

	@Autowired
	private FilesDAO filesDAO;
	
	@Autowired
	private BoardDAO boardDAO;
	
	// 갯수 가져오기
	public int selectCount(String bt_table, int ab_idx) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("bt_table", bt_table);
		map.put("ab_idx", ab_idx+"");
		return filesDAO.selectCount(map);
	}
	
	// 전체 가져오기
	public List<FilesVO> selectRefAll(String bt_table, int ab_idx){
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("bt_table", bt_table);
		map.put("ab_idx", ab_idx+"");
		return filesDAO.selectRefAll(map);
	}
	
	// 저장하기
	public void insertFiles(FilesVO filesVO) {
		filesDAO.insertFiles(filesVO);
	}
	
	// 게시글 삭제시 파일전부삭제
	public void deleteFileAll(String bt_table, int ab_idx) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("bt_table", bt_table);
		map.put("ab_idx", ab_idx+"");
		filesDAO.deleteFileAll(map);
	}
	
}
