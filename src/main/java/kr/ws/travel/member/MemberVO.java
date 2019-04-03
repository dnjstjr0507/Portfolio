package kr.ws.travel.member;

import java.util.Date;

import javax.xml.bind.annotation.XmlRootElement;

import lombok.Data;

@XmlRootElement
@Data
public class MemberVO {

	private int mb_idx;
	private String mb_id;
	private String mb_password;
	private String mb_email;
	private String mb_name;
	private String mb_nickname;
	private Date mb_nickupdate;
	private int mb_lev;
	private Date mb_levupdate;
	private String mb_yy;
	private String mb_mm;
	private String mb_dd;
	private Date mb_joindate;
	private Date mb_intercept_date;
	private String mb_key;
	private String setkey;
	
}
