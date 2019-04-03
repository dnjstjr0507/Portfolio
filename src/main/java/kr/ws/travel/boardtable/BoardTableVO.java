package kr.ws.travel.boardtable;

import javax.xml.bind.annotation.XmlRootElement;

import lombok.Data;

@XmlRootElement
@Data
public class BoardTableVO {
	
	private int bt_idx;
	private String bt_table;
	private int gb_idx;
	private String gb_subject; 
	private String bt_subject;
}
