package member.service;

import java.util.HashMap;
import java.util.List;

import board.dto.BoardDTO;
import member.dto.MemberDTO;
import pet.dto.PetDTO;

public interface MemberService {
	 boolean insert(MemberDTO dto);
	 MemberDTO select(MemberDTO dto);
	 int check(String userid);
	 List<MemberDTO> list_member();
	 int select2(MemberDTO dto);
	 String update(MemberDTO dto);
	 
	 //���κ�
	 MemberDTO login(HashMap<String,String> map);
	 MemberDTO check_me(String nickname);
	 MemberDTO check_memid(String userid);
	 String delete_mem(String userid);
	 String update_mem(MemberDTO dto);
	 
	 List<BoardDTO> list_userpop(String nickname);
	 List<PetDTO> list_mypet(String nickname);
}
