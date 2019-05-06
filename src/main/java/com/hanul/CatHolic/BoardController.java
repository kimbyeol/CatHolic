package com.hanul.CatHolic;


import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import board.dto.BoardCommentDTO;
import board.dto.BoardDTO;
import board.service.BoardService;
import common.service.CommonService;
import member.dto.MemberDTO;

@Controller 
public class BoardController {
	@Autowired BoardService service;
	@Autowired CommonService comm;
	Gson gson= new Gson();
	@ResponseBody
	@RequestMapping("/app_insert")
	public String insert_test(@RequestPart(required=false) MultipartFile image, String title,String classfy,String nickname,String content,HttpSession session) {
		BoardDTO dto = new BoardDTO();
		dto.setClassfy(Integer.parseInt(classfy));
		dto.setContent(content);
		dto.setTitle(title);
		dto.setNickname(nickname);
		dto.setImagepath("");
		dto.setImagename("");
		
		if(image!=null) {
		System.out.println(image.getName());
		System.out.println(image.getSize());
		System.out.println(image.getOriginalFilename());
		if(image.getSize()>0) {
			dto.setImagepath(comm.upload("board", image, session));
			dto.setImagename(image.getOriginalFilename());
		}
		}
		System.out.println(classfy);
		System.out.println(title);
		service.board_insert(dto);
		
		//System.out.println(date.toString());
		System.out.println("옵니다테스트");
		return "String";
	}
	@ResponseBody
	@RequestMapping("/mlistpop.bo")
	public String pop_list() {
		Gson gson= new Gson();
		String DD;
		String realpath="http://115.23.6.9:80/CatHolic/resources";
		ArrayList<BoardDTO> dto = (ArrayList<BoardDTO>) service.board_list_pop();
		if(dto.size()==0) {
			
		}else {
		for(int i=0;i<dto.size();i++) {
		dto.get(i).setImagepath(realpath+dto.get(i).getImagepath());
		
		System.out.println(dto.get(i).getWritedate().toString());
		
		
		String st2 = new SimpleDateFormat("yyyy-MM-dd HH:mm", Locale.KOREA).format(dto.get(i).getWritedate());
		dto.get(i).setWritedate(null);
		dto.get(i).setDatestring(st2);
		}
		}
		 DD=gson.toJson(dto);
		return DD;
	}
	
	
	@ResponseBody
	@RequestMapping("/minsert.bo")
	public String insert(BoardDTO dto,@RequestBody BoardDTO vo) {
		dto=vo;
		service.board_insert(dto);
		
		return "";
	}
	@ResponseBody
	@RequestMapping("/mdelete.bo")
	public String delete(@RequestParam String bo_id) {
		System.out.println("아이야"+bo_id);
		return service.board_delete(Integer.parseInt(bo_id));
	}
	@ResponseBody
	@RequestMapping("/mupdate.bo")
	public String update(BoardDTO dto,@RequestBody BoardDTO vo) {
		dto=vo;
		service.board_update(dto);
		return "";
	}
	@ResponseBody
	@RequestMapping("/mlist.bo")
	public String list(@RequestParam String classfy) throws ParseException {
		Gson gson= new Gson();
		String DD;
		String realpath="http://115.23.6.9:80/CatHolic/resources";
		System.out.println("게시판들어옵니다");
		if(classfy.equals("0")) {
			ArrayList<BoardDTO> dto = (ArrayList<BoardDTO>) service.board_list();
			if(dto.size()==0) {
				
			}else {
			for(int i=0;i<dto.size();i++) {
			dto.get(i).setImagepath(realpath+dto.get(i).getImagepath());
			
			System.out.println(dto.get(i).getWritedate().toString());
			
			
			String st2 = new SimpleDateFormat("yyyy-MM-dd HH:mm", Locale.KOREA).format(dto.get(i).getWritedate());
			dto.get(i).setWritedate(null);
			dto.get(i).setDatestring(st2);
			}
			}
			 DD=gson.toJson(dto);
		}else {
			ArrayList<BoardDTO> dto = (ArrayList<BoardDTO>) service.board_list_class(Integer.parseInt(classfy));
			if(dto.size()==0) {
				
			}else {
			for(int i=0;i<dto.size();i++) {
			dto.get(i).setImagepath(realpath+dto.get(i).getImagepath());
			String st2 = new SimpleDateFormat("yyyy-MM-dd HH:mm", Locale.KOREA).format(dto.get(i).getWritedate());
			dto.get(i).setWritedate(null);
			dto.get(i).setDatestring(st2);
			}
			}
			 DD=gson.toJson(dto);
		}
		
		return DD;
	}
	@ResponseBody
	@RequestMapping("/mlist_class.bo")
	public String list_class(@RequestParam String classfy) {
		Gson gson= new Gson();
		String dd=gson.toJson(service.board_list_class(Integer.parseInt(classfy)));
		return dd;
	}
	@ResponseBody
	@RequestMapping("/mmodify.bo")
	public String modify(@RequestParam String bo_id,HttpSession session,HttpServletRequest aa) throws ParseException {
		System.out.println("이미지불러오기");
		service.read_board(Integer.parseInt(bo_id));
		Gson gson= new Gson();
		BoardDTO vo=service.board_modify(Integer.parseInt(bo_id));
		String realpath="http://115.23.6.9:80/CatHolic/resources";
		if(vo.getImagepath()!=null) {
		vo.setImagepath(realpath+vo.getImagepath());
		System.out.println(vo.getImagepath());}
		String st2 = new SimpleDateFormat("yyyy-MM-dd HH:mm", Locale.KOREA).format(vo.getWritedate());
		vo.setWritedate(null);
		vo.setDatestring(st2);
		String DD=gson.toJson(vo);
		return DD;
	}
	
	
	
	//댓글
	@ResponseBody
	@RequestMapping("/mcomm_insert.bo")
	public String comm_insert(BoardCommentDTO dto,@RequestBody BoardCommentDTO vo) {
		dto=vo;
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("succ",service.board_comment_insert(dto));
		String VV=gson.toJson(map);
		return VV;
	}
	@ResponseBody
	@RequestMapping("/mcomm_delete.bo")
	public String comm_delete(@RequestParam int comm_id) {
		
		
		return service.board_comment_delete(comm_id);
	}
	@ResponseBody
	@RequestMapping("/mcomm_update.bo")
	public String comm_update(BoardCommentDTO dto,@RequestBody BoardCommentDTO vo) {
		dto=vo;
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("succ",service.board_comment_update(dto));
		String VV=gson.toJson(map);
		return VV;
	}
	
	@ResponseBody
	@RequestMapping("/mcomm_list.bo")
	public String comm_list(@RequestParam String p_id) throws ParseException {
		ArrayList<BoardCommentDTO> ddd=(ArrayList<BoardCommentDTO>)service.board_comment_list(Integer.parseInt(p_id));
		if(ddd.size()!=0) {
		
			for(int i=0;i<ddd.size();i++) {
				String st2 = new SimpleDateFormat("yyyy-MM-dd HH:mm", Locale.KOREA).format(ddd.get(i).getWritedate());
				ddd.get(i).setDateString(st2);
			}
		}
		String VV=gson.toJson(ddd);
		System.out.println(VV);
		return VV;
	}
	
	//Web
	
	//게시판 목록 
	@RequestMapping("/list.bo")
	public String list(Model model, @RequestParam int classfy, BoardDTO dto) {
		
		model.addAttribute("cl",classfy);
		
		if(classfy==0) {
			model.addAttribute(	"vo",service.list());
			model.addAttribute("gesi","0");
			
		}else{
			model.addAttribute("vo",service.weblist(classfy));
			model.addAttribute("gesi",classfy);
		}
		//목록화면에 출력한다.
		
		
		return "board/list";
	}
	


	
	//게시판 신규화면 요청
		@RequestMapping("/new.bo")
		public String board(Model model, @RequestParam int classfy) {
			model.addAttribute("cl",classfy);
			
			
			return "board/new";
	}
	
	@Autowired CommonService common;
	
	//게시판 저장처리 요청
	@RequestMapping("/insert.bo")
	public String insert(BoardDTO vo, HttpSession session,@RequestParam int classfy,@RequestParam MultipartFile file) {
		//화면에서 입력한 정보를 DB에 저장한 후
		//userid 는 로그인한 사용자의 아이디
		vo.setNickname(((MemberDTO)session.getAttribute("login_info")).getNickname());
		vo.setClassfy(classfy);
		
		
		//첨부파일이 있는 경우의 처리
		vo.setImagename("");
		vo.setImagepath("");
		if( file.getSize()>0 ) {
			vo.setImagename(file.getOriginalFilename());
			vo.setImagepath( 
				common.upload("board", file, session) );
		}else if(file.getSize()==0) {
			vo.setImagepath("img/cat2.jpg");
		}
		
		//목록 화면으로 연결
				service.insert(vo);
		return "redirect:list.bo?classfy="+vo.getClassfy();
	}
	
	
	//상세정보화면 요청
	@RequestMapping("/detail.bo")
	public String detail(Model model, @RequestParam int bo_id ) {
		//선택한 글의 정보를 DB에서 조회해와
		service.read(bo_id);
		//상세화면에 출력: Model에 데이터를 담는다.
		model.addAttribute("vo",service.select(bo_id));
		model.addAttribute("crlf","\r\n");
		return "board/detail";
	}
	//삭제
	@RequestMapping("/delete.bo")
	public String delete(BoardDTO dto,@RequestParam int bo_id, HttpSession session) {
		
		//선택한 공지글을 DB에서 삭제한 후
		service.delete(bo_id);
		//목록화면으로 연결한다.
		return "redirect:list.bo?classfy="+dto.getClassfy();

	}
	//수정
	@RequestMapping("/update.bo")
	public String update(BoardDTO dto, HttpSession session){
		//화면에서 변경입력한 정보를 DB에 저장한 후
		service.update(dto);
		
		//상세화면으로 연결한다.
		return "redirect:detail.bo?bo_id="+dto.getBo_id();
	}
	@RequestMapping("/modify.bo")
	public String modify(Model model, @RequestParam int bo_id) {
		model.addAttribute("vo",service.select(bo_id));
		return "board/modify";
	}
	
	//첨부파일 다운로드처리
	@ResponseBody @RequestMapping("/download.bo")
	public File download(@RequestParam int bo_id,
					HttpSession session, HttpServletResponse res) {
		//다운로드할 첨부된 파일의 정보를 DB에서 조회해와
		BoardDTO dto = service.select(bo_id);

		//사용자의 로컬시스템에 서버의 파일을 다운로드한다.
		return common.download(dto.getImagepath(), dto.getImagename(),
							session, res);
	}
	
	
}