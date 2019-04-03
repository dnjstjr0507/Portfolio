package kr.ws.travel.file;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class MultiFileBucket {
	
	List<FileBucket> files = new ArrayList<FileBucket>();
	
	
}
