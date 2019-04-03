package kr.ws.travel.board;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;

import kr.ws.travel.file.FileBucket;
import kr.ws.travel.file.FilesDAO;
import kr.ws.travel.file.FilesService;
import kr.ws.travel.file.FilesVO;
import kr.ws.travel.file.MultiFileBucket;
import kr.ws.travel.paging.Paging;

@Service
public class BoardService {
	
	@Autowired
	private BoardDAO boardDAO;
	
	@Autowired
	private FilesDAO filesDAO;
	
	// 1개 가져오기
	public BoardVO selectGetOn(String bt_table, int ab_idx, int mode) {
		BoardVO vo = null;
		vo = boardDAO.selectGetOn(bt_table, ab_idx);
		if(vo!=null) {
			if(mode==1) {
				boardDAO.hitupdate(bt_table, ab_idx);
				vo.setAb_hit(vo.getAb_hit()+1);
			}
			
		}
		return vo;
	}
	
	// maxidx 가져오기
	public int selectMaxidx(String bt_table) {
		return boardDAO.selectMaxidx(bt_table);
	}
	
	// 전체 가져오기
	public Paging<BoardVO> selectAll(String bt_table,int currentPage, int pageSize, int blockSize){
		Paging<BoardVO> paging = null;
		int totalCount = boardDAO.selectCount(bt_table);
		paging = new Paging<BoardVO>(totalCount, currentPage, pageSize, blockSize);
		if(totalCount>0) {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("startNo", paging.getStartNo()+"");
			map.put("endNo", paging.getEndNo()+"");
			map.put("bt_table", bt_table);
			List<BoardVO> list = boardDAO.selectAll(map);
			paging.setLists(list);
		}
		return paging;
	}
	
	// 저장
	public void insertBoard(BoardVO boardVO, MultiFileBucket multiFileBucket, HttpServletRequest request) throws IOException {
		boardDAO.insertBoard(boardVO);
		int idx = boardDAO.selectMaxidx(boardVO.getBt_table());
		if(multiFileBucket!=null) {
			for(FileBucket bucket : multiFileBucket.getFiles()) {
				if(bucket!=null) {
					FilesVO vo = new FilesVO();
					String file_original = bucket.getFile().getOriginalFilename();
					
					String makeFileName =System.nanoTime() + "_" + new Random().nextInt(1000);
					String file_subfile = request.getRealPath("/upload/") + makeFileName;
					if(file_original!=null && file_original.trim().length()>0) {
						FileCopyUtils.copy(bucket.getFile().getBytes(), new File(file_subfile));
						vo.setAb_idx(idx);
						vo.setBt_table(boardVO.getBt_table());
						vo.setFile_original(file_original);
						vo.setFile_subfile(makeFileName);
						filesDAO.insertFiles(vo);
					}
				}
			}
		}else {
			;
		}
	}
	
	// 수정
	public void updateBoard(String bt_table, String ab_subject, String ab_content, String mb_id, int ab_idx,Integer file_idx, MultiFileBucket multiFileBucket, HttpServletRequest request) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("bt_table", bt_table);
		map.put("ab_subject", ab_subject);
		map.put("ab_content", ab_content);
		map.put("mb_id", mb_id);
		map.put("ab_idx", ab_idx+"");
		boardDAO.updateBoard(map);
		if(file_idx!=null) {
			System.out.println("============================");
			System.out.println("idx=" + file_idx);
			System.out.println("============================");
			
			String subfilename = filesDAO.selectSubfilename(bt_table, file_idx);
			String saveFile = request.getRealPath("/upload/") + subfilename;
			filesDAO.deleteFile(bt_table, file_idx);
			File file = new File(saveFile);
			if(file.exists()==true){
				file.delete();
			}
		}else {
			;
		}
        if(multiFileBucket.getFiles()!=null) {
           for(FileBucket bucket : multiFileBucket.getFiles()){
              if(multiFileBucket.getFiles().get(0).getFile().getOriginalFilename().trim().length()>0) {
                 FilesVO vo = new FilesVO();
                 String file_original = bucket.getFile().getOriginalFilename();
                 String makeFileName = System.nanoTime()+"_"+new Random().nextInt(1000);
                 String saveFile = request.getRealPath("/upload/") + makeFileName;
                  // 파일 형식을 비교하여 원하는 데이터만 업로드 가능하게 할 수 있다.
                 if(file_original!=null && file_original.trim().length()>0) {
                    try {
                       FileCopyUtils.copy(bucket.getFile().getBytes(), new File(saveFile));
                    } catch (IOException e) {
                    	
                    }
                    vo.setAb_idx(ab_idx);
                    vo.setBt_table(bt_table);
                    vo.setFile_original(file_original);
                    vo.setFile_subfile(makeFileName);
                    filesDAO.insertFiles(vo);
                 }
              }
           }
        }else {
           ;
        }         
	}
	
	// 삭제
	public void deleteBoard(String bt_table, String mb_id, int ab_idx) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("bt_table", bt_table);
		map.put("mb_id", mb_id);
		map.put("ab_idx", ab_idx+"");
		boardDAO.deleteBoard(map);
	}
}
