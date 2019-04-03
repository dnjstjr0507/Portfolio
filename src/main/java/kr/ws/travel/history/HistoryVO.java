package kr.ws.travel.history;

import java.util.Date;

import javax.xml.bind.annotation.XmlRootElement;

import lombok.Data;

@Data
@XmlRootElement
public class HistoryVO {
	private int hs_idx;
	private String mb_id;
	private Date hs_login;
	private String hs_ip;
}
