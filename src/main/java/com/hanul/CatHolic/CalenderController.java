package com.hanul.CatHolic;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.annotation.JacksonInject.Value;
import com.google.gson.Gson;

import calender.dto.CalenderDTO;
import calender.service.CalenderService;

@Controller
public class CalenderController {
	@Autowired CalenderService service;
	Gson gson= new Gson();
	//캘린더생성
	Calendar cal = Calendar.getInstance();
	
	//일정삭제처리
	@ResponseBody
	@RequestMapping("/calendar/main/sc_delete")
	public String sc_delete(@RequestParam int sc_id) {
		return service.ws_delete(sc_id);
	}
	
	//일정수정처리
	@ResponseBody
	@RequestMapping(value = "/calendar/main/sc_update",
					produces = "application/text; charset=utf-8")
	public String sc_update(@RequestParam String sc_title, @RequestParam String sc_content,
							@RequestParam int sc_id) {	
		CalenderDTO dto = new CalenderDTO();
		dto.setS_title(sc_title);
		dto.setS_content(sc_content);
		dto.setS_id(sc_id);
		return service.s_update(dto);
	}
	
	
	//일정등록처리
	@ResponseBody
	@RequestMapping("/calendar/main/sc_insert")
	public String sc_insert(@RequestParam String sc_name, @RequestParam String sc_content,
						@RequestParam String sc_title, @RequestParam String sc_date) {
		CalenderDTO dto = new CalenderDTO();
		dto.setS_name(sc_name);	
		dto.setS_date(java.sql.Date.valueOf(sc_date));
		dto.setS_content(sc_content);
		dto.setS_title(sc_title);
		return service.s_insert(dto);
	}
	
	//오늘날짜세팅
	@ResponseBody
	@RequestMapping(value = "/calendar/main/cur_cal",
					produces = "application/text; charset=utf-8")
	public String cur_cal() {
		Calendar today = Calendar.getInstance();
		int ch_year = today.get(Calendar.YEAR);
		int ch_month = today.get(Calendar.MONTH);
		cal.set(ch_year, ch_month, 1);
		return "";
	}
	//이전달세팅
	@ResponseBody
	@RequestMapping(value = "/calendar/main/prev_cal",
					produces = "application/text; charset=utf-8")
	public String prev_cal() {
		int ch_year = cal.get(Calendar.YEAR);
		int ch_month = cal.get(Calendar.MONTH)-1;
		cal.set(ch_year, ch_month, 1);
		return "";
	}
	//다음달세팅
	@ResponseBody
	@RequestMapping(value = "/calendar/main/next_cal",
	produces = "application/text; charset=utf-8")
	public String next_cal() {
		int ch_year = cal.get(Calendar.YEAR);
		int ch_month = cal.get(Calendar.MONTH)+1;
		cal.set(ch_year, ch_month, 1);
		return "";
	}
	
	//캘린더 메인화면	
	@RequestMapping("/main.cal")
	public String main(Model model, @RequestParam String s_name) {
		int year = cal.get(Calendar.YEAR);	//년도
		int month = cal.get(Calendar.MONTH);//월(0부터시작)
		int date = cal.get(Calendar.DATE);	//날짜
		cal.set(year, month, 1);
		int startDay = cal.getMinimum(Calendar.DATE);	//월 시작 날짜
		int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH); //월 마지막날짜
		int start = cal.get(Calendar.DAY_OF_WEEK);	//월 시작요일
		
		//날짜형식 포맷
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");			
		//오늘날짜가져오기위해 객체 새로생성
		Calendar today = Calendar.getInstance();
		String todayDate = sdf.format(today.getTime());
	
		List<CalenderDTO> vo=service.select_title(s_name);
		if(vo.size() != 0) {
			for(int i=0;i<vo.size();i++) {
				vo.get(i).setS_datestring(sdf.format(vo.get(i).getS_date()));
				vo.get(i).setS_content(vo.get(i).getS_content().replaceAll("\n", "<br>"));
			}
		}
		
		//view로 넘기는 값 
		model.addAttribute("vo", vo);			
		model.addAttribute("todayDate", todayDate);
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("startDay", startDay);
		model.addAttribute("endDay", endDay);
		model.addAttribute("start", start);
		
		//페이지요청
		return "calendar/main";
	}
	
	@RequestMapping("/minsert.cal")
	public @ResponseBody String insert(CalenderDTO eo,@RequestBody Map<String,String> map) {
		//�ȵ���̵忡�� �޾ƿ� Map DTO�� ���
		eo.setS_name(map.get("s_name").toString());
		eo.setS_title(map.get("s_title").toString());
		eo.setS_content(map.get("s_content").toString());
		 Date date = null;
		try {
			date = (Date) new SimpleDateFormat("yyyy-MM-dd",Locale.KOREA).parse(map.get("s_date").toString());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		eo.setS_date(date);
		System.out.println("232323");
		//�ȵ���̵�� ���� ���� map����
		HashMap<String, String> map2 = new HashMap<String, String>();
		map2.put("succ", service.s_insert(eo)); //��� "succ":"succ" �Ǵ� "succ":"fail" ����

        //json �������� ��ȯ �� String ������ ��ȯ
         String io=gson.toJson(map2);
         System.out.println(io);
		return io; 
	}
	
	
	@ResponseBody
	@RequestMapping("/mdelete.cal")
	public String delete(@RequestParam String s_id) {
		HashMap<String, String> map= new HashMap<String, String>();
		map.put("succ", service.s_delete(s_id));
		
		String FF= gson.toJson(map);
		return FF;
	}
	@ResponseBody
	@RequestMapping("/mupdate.cal")
	public String update(CalenderDTO dto,@RequestBody HashMap<String, String> map) {
		dto.setS_id(Integer.parseInt(map.get("s_id").toString()));
		dto.setS_title(map.get("s_title").toString());
		dto.setS_content(map.get("s_content").toString());
		HashMap<String, String> map2=new HashMap<String, String>();
		map2.put("succ", service.s_update(dto));
		String RR=gson.toJson(map2);
		return RR;
	}
	@ResponseBody
	@RequestMapping("/mmodify.cal")
	public String modify(CalenderDTO dto, @RequestParam String s_id) throws ParseException {
		System.out.println(s_id);
		dto=service.s_modify(s_id);
		Date dateSt = new SimpleDateFormat("E MMM dd HH:mm:ss z yyyy",Locale.ENGLISH).parse(dto.getS_date().toString());
		String st2 = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA).format(dateSt);

		
		dto.setS_date(null);
		dto.setS_datestring(st2);
		String RR=gson.toJson(dto);
		System.out.println(RR);
		return RR;
	}
	@ResponseBody
	@RequestMapping("/mlist.cal")
	public String s_list(CalenderDTO eo,@RequestBody HashMap<String, String> map) throws ParseException {
				//s_name�Ķ���ͷ� ��� �޾ƿ� Listȭ �Ѱ� json ���� String���� ����
		System.out.println("����ɴϴ�");
		eo.setS_name(map.get("s_name").toString());
		
		Date date = null;
		date = (Date) new SimpleDateFormat("yyyy-MM-dd").parse(map.get("s_date").toString());
		
		eo.setS_date(date);
		ArrayList<CalenderDTO> dto = (ArrayList<CalenderDTO>) service.s_list(eo);
		if(dto.size()==0) {
			dto=null;
		}else {
		for(int i=0;i<dto.size();i++) {
		Date dateSt = new SimpleDateFormat("E MMM dd HH:mm:ss z yyyy",Locale.ENGLISH).parse(dto.get(i).getS_date().toString());
		String st2 = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA).format(dateSt);
		dto.get(i).setS_date(null);
		dto.get(i).setS_datestring(st2);
		}
		}
		String FF=gson.toJson(dto);
		
		System.out.println("�߰�");
		return FF;
	}
	@ResponseBody
	@RequestMapping("/mlist_all.cal")
	public String s_list_all(@RequestParam String s_name) throws ParseException {
		
		ArrayList<CalenderDTO> vo=(ArrayList<CalenderDTO>) service.s_list_all(s_name);
		for(int i=0;i<vo.size();i++) {
			Date dateSt = new SimpleDateFormat("E MMM dd HH:mm:ss z yyyy",Locale.ENGLISH).parse(vo.get(i).getS_date().toString());
			String st2 = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA).format(dateSt);
			vo.get(i).setS_date(null);
			vo.get(i).setS_datestring(st2);
			}
		String FF=gson.toJson(vo);
		System.out.println(vo.get(0).getS_date());
		return FF;
	}

}
