package notice.service;

import java.util.List;

import board.dto.BoardDTO;
import notice.dto.NoticeDTO;
import notice.dto.NoticePage;

public interface NoticeService {
	String Notice_insert(NoticeDTO dto);
	String Notice_delete(int no_id);
	List<NoticeDTO> Notice_list();
	String Notice_update(NoticeDTO dto);
	NoticeDTO Notice_modify(int no_id);
	List<NoticeDTO> Notice_list_Main(); //메인화면에 나오는 공지사항 게시판 
	
	//Web
	List<NoticeDTO> list();
	NoticePage list(NoticePage page);
	String insert(NoticeDTO dto);
	String delete(int no_id);
	String update(NoticeDTO dto);
	NoticeDTO select(int no_id);
	List<NoticeDTO> fivelist();
	List<BoardDTO> fiveboard();
	
}
