package board.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import board.dao.BoardDAO;
import board.dto.BoardCommentDTO;
import board.dto.BoardDTO;
import board.dto.BoardPage;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired BoardDAO dao;
	
	
	@Override
	public List<BoardDTO> board_list() {
		return dao.board_list();
	}


	@Override
	public String board_insert(BoardDTO dto) {
		// TODO Auto-generated method stub
		return dao.board_insert(dto);
	}

	@Override
	public String board_update(BoardDTO dto) {
		// TODO Auto-generated method stub
		return dao.board_update(dto);
	}

	@Override
	public String board_delete(int bo_id) {
		// TODO Auto-generated method stub
		return dao.board_delete(bo_id);
	}

	@Override
	public BoardDTO board_modify(int bo_id) {
		// TODO Auto-generated method stub
		return dao.board_modify(bo_id);
	}

	
	
	@Override
	public String board_comment_insert(BoardCommentDTO dto) {
		// TODO Auto-generated method stub
		return dao.board_comment_insert(dto);
	}

	@Override
	public String board_comment_delete(int comm_id) {
		// TODO Auto-generated method stub
		return dao.board_comment_delete(comm_id);
	}

	@Override
	public String board_comment_update(BoardCommentDTO dto) {
		// TODO Auto-generated method stub
		return dao.board_comment_update(dto);
	}

	@Override
	public List<BoardCommentDTO> board_comment_list(int p_id) {
		// TODO Auto-generated method stub
		return dao.board_comment_list(p_id);
	}

	@Override
	public void read_board(int bo_id) {
		dao.read_board(bo_id);
		
	}

	@Override
	public List<BoardDTO> board_list_class(int classfy) {
		// TODO Auto-generated method stub
		return dao.board_list_class(classfy);
	}
	@Override
	public List<BoardDTO> board_list_pop() {
		// TODO Auto-generated method stub
		return dao.board_list_pop();
	}
	


	
	
	//Web
	
		@Override
		public List<BoardDTO> list() {
			// TODO Auto-generated method stub
			return dao.board_list();
		}


		@Override
		public BoardDTO select(int bo_id) {
			// TODO Auto-generated method stub
			return dao.select(bo_id);
		}


		@Override
		public boolean insert(BoardDTO dto) {
			// TODO Auto-generated method stub
			return dao.insert(dto);
		}


		@Override
		public boolean update(BoardDTO dto) {
			// TODO Auto-generated method stub
			return dao.update(dto);
		}


		@Override
		public boolean delete(int bo_id) {
			// TODO Auto-generated method stub
			return dao.delete(bo_id);
		}


		@Override
		public void read(int bo_id) {
			dao.read(bo_id);
		}


		@Override
		public List<BoardCommentDTO> comment_list(int p_id) {
			// TODO Auto-generated method stub
			return dao.comment_list(p_id);
		}


		@Override
		public BoardCommentDTO comment_select(int bo_id) {
			// TODO Auto-generated method stub
			return null;
		}


		@Override
		public boolean comment_update(BoardCommentDTO dto) {
			// TODO Auto-generated method stub
			return dao.comment_update(dto);
		}


		@Override
		public boolean comment_delete(int comm_id) {
			// TODO Auto-generated method stub
			return dao.comment_delete(comm_id);
		}


		@Override
		public boolean insert(HashMap<String, Object> map) {
			// TODO Auto-generated method stub
			return dao.insert(map);
		}


		@Override
		public List<BoardDTO> weblist(int classfy) {
			// TODO Auto-generated method stub
			return dao.weblist(classfy);
		}
		
		
		
}
