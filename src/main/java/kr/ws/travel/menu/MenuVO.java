package kr.ws.travel.menu;

import java.util.List;

import lombok.Data;

@Data
public class MenuVO {

	private int menu_id;
	private int menu_code;
	private int menu_sub;
	private String menu_name;
	private String bt_table;
	private String menu_type;
	private String menulist_type;
	private int menu_use;
	
	private List<MenuVO> sublist;
	
}
