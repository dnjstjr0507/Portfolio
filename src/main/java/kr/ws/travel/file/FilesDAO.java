package kr.ws.travel.file;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FilesDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	// 갯수 가져오기
	public int selectCount(HashMap<String, String> map) {
		return sqlSession.selectOne("file.selectCount", map);
	}
	
	// 전부 가져오기
	public List<FilesVO> selectRefAll(HashMap<String, String> map){
		return sqlSession.selectList("file.selectRefAll", map);
	}
	
	// 저장파일명 가져오기
	public String selectSubfilename(String bt_table, Integer file_idx) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("bt_table", bt_table);
		map.put("file_idx", file_idx+"");
		return sqlSession.selectOne("file.selectSubfilename", map);
	}
	
	// 저장하기
	public void insertFiles(FilesVO filesVO) {
		sqlSession.insert("file.insertFile", filesVO);
	}
	
	// 전부 삭제하기
	public void deleteFileAll(HashMap<String, String> map) {
		sqlSession.delete("file.deleteFileAll", map);
	}
	// 삭제하기
	public void deleteFile(String bt_table,Integer file_idx) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("bt_table", bt_table);
		map.put("file_idx", file_idx+"");
		sqlSession.delete("file.deleteFile", map);
	}
	
}
