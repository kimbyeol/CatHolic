package notice.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import board.dto.BoardDTO;
import notice.dao.NoticeDAO;
import notice.dto.NoticeDTO;
import notice.dto.NoticePage;

@Service
public class NoticeServiceImpl implements NoticeService {
	@Autowired NoticeDAO dao;

	@Override
	public String Notice_insert(NoticeDTO dto) {
		// TODO Auto-generated method stub
		return dao.Notice_insert(dto);
	}

	@Override
	public String Notice_delete(int no_id) {
		// TODO Auto-generated method stub
		return dao.Notice_delete(no_id);
	}

	@Override
	public List<NoticeDTO> Notice_list() {
		// TODO Auto-generated method stub
		return dao.Notice_list();
	}

	@Override
	public String Notice_update(NoticeDTO dto) {
		// TODO Auto-generated method stub
		return dao.Notice_update(dto);
	}

	@Override
	public NoticeDTO Notice_modify(int no_id) {
		// TODO Auto-generated method stub
		return dao.Notice_modify(no_id);
	}
	
	
	//web
	
	@Override
	public List<NoticeDTO> list() {
		// TODO Auto-generated method stub
		return dao.list();
	}

	@Override
	public NoticePage list(NoticePage page) {
		// TODO Auto-generated method stub
		return dao.list(page);
	}

	@Override
	public String insert(NoticeDTO dto) {
		// TODO Auto-generated method stub
		return dao.insert(dto);
	}

	@Override
	public String delete(int no_id) {
		// TODO Auto-generated method stub
		return dao.delete(no_id);
	}

	@Override
	public String update(NoticeDTO dto) {
		// TODO Auto-generated method stub
		return dao.update(dto);
	}

	@Override
	public NoticeDTO select(int no_id) {
		// TODO Auto-generated method stub
		return dao.select(no_id);
	}

	@Override
	public List<NoticeDTO> Notice_list_Main() {
		// TODO Auto-generated method stub
		return dao.Notice_list_Main();
	}

	@Override
	public List<NoticeDTO> fivelist() {
		// TODO Auto-generated method stub
		return dao.fivelist();
	}

	@Override
	public List<BoardDTO> fiveboard() {
		// TODO Auto-generated method stub
		return dao.fiveboard();
	}
	
	
	
}
