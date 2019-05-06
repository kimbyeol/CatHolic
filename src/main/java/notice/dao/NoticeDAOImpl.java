package notice.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import board.dto.BoardDTO;
import notice.dto.NoticeDTO;
import notice.dto.NoticePage;

@Repository
public class NoticeDAOImpl implements NoticeDAO {
	@Autowired SqlSession sql;

	@Override
	public String Notice_insert(NoticeDTO dto) {
		// TODO Auto-generated method stub
		return sql.insert("notice.mapper.insert",dto)>0? "succ":"fail:";
	}

	@Override
	public String Notice_delete(int no_id) {
		// TODO Auto-generated method stub
		return sql.delete("notice.mapper.delete",no_id)>0? "succ":"fail";
	}

	@Override
	public List<NoticeDTO> Notice_list() {
		// TODO Auto-generated method stub
		return sql.selectList("notice.mapper.allList");
	}

	@Override
	public String Notice_update(NoticeDTO dto) {
		// TODO Auto-generated method stub
		return sql.update("notice.mapper.update",dto)>0?"succ":"fail";
	}

	@Override
	public NoticeDTO Notice_modify(int no_id) {
		// TODO Auto-generated method stub
		return sql.selectOne("notice.mapper.selectone",no_id);
	}
	
	//web
	@Override
	public List<NoticeDTO> list() {
		// TODO Auto-generated method stub
		return sql.selectList("notice.mapper.List");
	}

	@Override
	public NoticePage list(NoticePage page) {
		page.setTotList((Integer)sql.selectOne("notice.mapper.total",page));
		List<NoticeDTO> list = sql.selectList("notice.mapper.List", page);
		page.setList(list);
		return page;
	}

	@Override
	public String insert(NoticeDTO dto) {
		// TODO Auto-generated method stub
		return sql.insert("notice.mapper.webinsert",dto)>0? "succ":"fail:";
	}

	@Override
	public String delete(int no_id) {
		// TODO Auto-generated method stub
		return sql.delete("notice.mapper.webdelete",no_id)>0? "succ":"fail";
	}

	@Override
	public String update(NoticeDTO dto) {
		// TODO Auto-generated method stub
		return sql.update("notice.mapper.webupdate",dto)>0?"succ":"fail";
	}

	@Override
	public NoticeDTO select(int no_id) {
		// TODO Auto-generated method stub
		return sql.selectOne("notice.mapper.webselect",no_id);
	}

	@Override
	public List<NoticeDTO> Notice_list_Main() {
		// TODO Auto-generated method stub
		return sql.selectList("notice.mapper.NoticeList_main");		
	}

	@Override
	public List<NoticeDTO> fivelist() {
		// TODO Auto-generated method stub
		return sql.selectList("notice.mapper.noticefive");
	}

	@Override
	public List<BoardDTO> fiveboard() {
		// TODO Auto-generated method stub
		return sql.selectList("board.mapper.boardfive");
	}
	
	
}
