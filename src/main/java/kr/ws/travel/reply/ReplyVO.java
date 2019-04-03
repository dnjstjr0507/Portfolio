package kr.ws.travel.reply;

import java.util.Date;
import lombok.Data;

@Data
public class ReplyVO {
	
	private int ar_idx;
	private int ab_idx;
	private int ar_parents;
	private int ar_lev;
	private String mb_id;
	private String mb_nickname;
	private String ar_content;
	private String ar_ip;
	private Date ar_datetime;
	private Date ar_updatetime;
	
	private String bt_table;
}
