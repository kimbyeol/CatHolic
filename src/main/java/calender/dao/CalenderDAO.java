package calender.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import calender.dto.CalenderDTO;

public interface CalenderDAO {
	String s_insert(CalenderDTO dto);
	String s_delete(String s_id);
	String s_update(CalenderDTO dto);
	List<CalenderDTO> s_list(CalenderDTO eo);
	CalenderDTO s_modify(String s_id);
	List<CalenderDTO> s_list_all(String s_name);
	List<CalenderDTO> select_title(String s_name);
	String ws_delete(int s_id);
}
