package com.hanul.CatHolic;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import board.dto.BoardCommentDTO;
import board.service.BoardService;
import member.dto.MemberDTO;

@Controller
public class BoardCommentController {
	
@Autowired private BoardService service;
	
	//댓글삭제처리 요청
	@ResponseBody @RequestMapping("/board/comment/delete/{comm_id}")
	public void comment_delete(@PathVariable int comm_id) {
		//선택한 댓글을 DB에서 삭제한 후
		service.comment_delete(comm_id);
		//호출된 함수로 돌아간다.
	}
	
	
	//댓글변경처리 요청
	@ResponseBody @RequestMapping(value="/board/comment/update",
			produces="application/text; charset=utf-8")
	public String comment_update(@RequestBody BoardCommentDTO dto) {
		return service.comment_update(dto) ? "성공" : "실패";
	}
	
	
	//댓글목록조회처리 요청
	@RequestMapping("/board/comment/{p_id}")
	public String comment_list(Model model, @PathVariable int p_id) {
		//원글 pid 에 대한 댓글들을 DB에서 조회한 후
		model.addAttribute("list", service.comment_list(p_id) );
		model.addAttribute("lf", "\n");
		model.addAttribute("crlf", "\r\n");		
		//ajax통신한 화면에 출력한다.
		return "board/comment/list";
	}
	
	//댓글저장처리 요청
		@ResponseBody @RequestMapping("/board/comment/insert")
		public boolean insert(@RequestParam String content,
					@RequestParam int p_id, HttpSession ss) {
			//원글인 pid에 대한 댓글 content 를 DB에 저장한 후
			HashMap<String, Object> map 
					= new HashMap<String, Object>();
			map.put("content", content);
			map.put("p_id", p_id);
			map.put("writer",
					((MemberDTO)ss.getAttribute("login_info"))
							.getNickname());
			return service.insert(map);
		}
	}

