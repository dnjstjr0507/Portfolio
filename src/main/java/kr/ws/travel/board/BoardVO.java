package kr.ws.travel.board;

import java.util.Date;
import java.util.List;

import kr.ws.travel.file.FilesVO;
import lombok.Data;

@Data
public class BoardVO {

	private int ab_idx;
	private String mb_id;
	private String mb_nickname;
	private String ab_subject;
	private String ab_content;
	private Date ab_datetime;
	private Date ab_updatetime;
	private int ab_hit;
	private String ab_ip;
	
	private String bt_table;
	private List<FilesVO> list;
}
