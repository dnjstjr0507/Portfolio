package kr.ws.travel.groupboard;

import javax.xml.bind.annotation.XmlRootElement;

import lombok.Data;

@XmlRootElement
@Data
public class GroupBoardVO {
	
	private int gb_idx;
	private String gb_id;
	private String gb_subject;
}
