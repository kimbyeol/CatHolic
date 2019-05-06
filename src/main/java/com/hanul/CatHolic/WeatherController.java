package com.hanul.CatHolic;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class WeatherController {
	@RequestMapping("/weather.wd")
	public String weather() {
		return "weather/Weather";
	}
	
	@ResponseBody
	@RequestMapping(value="/api2Action.wd", method=RequestMethod.POST)
	public String api2Action(String city) {
        BufferedReader br = null;
        try{
        	//도시명 한글깨짐 방지 인코딩
        	String encodeCity = URLEncoder.encode(city, "UTF-8");
        	//문자열 URL
        	String urlstr = "http://openapi.airkorea.or.kr/"
        				+ "openapi/services/rest/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty?"
        				+ "pageNo=1&numOfRows=1&ServiceKey=zYuHMpCcleYbDXQ3TLd%2BAJfwFuvJpaDS5%2FD7LpZ%2BZ%2Bq4vhuu3SdfohzvZMbwA%2Bvcf8jbinxDSYvLspyYZcCWLg%3D%3D"
        				+ "&ver=1.3"
        				+ "&_returnType=json"
        				+ "&sidoName=" + encodeCity;
        	
        	//URL 객체 생성
            URL url = new URL(urlstr);
            //http 통신 객체 생성
            HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();
            //통신 타입 설정
            urlconnection.setRequestMethod("GET");
            //http 통신 결과값 스트림리더를 통해 버퍼에 저장
            br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(),"UTF-8"));
            //결과값을 담을 변수
            String result = "";
            //버퍼에서 한줄씩 읽은 결과를 담을 변수
            String line;
            //버퍼를 한줄씩 반복하며 읽어냄
            while((line = br.readLine()) != null) {
            	//버퍼에서 한줄씩 읽어낸 정보가 Null이 아니라면 결과값 변수에 저장 후 줄바꿈.
                result = result + line + "\n";
            }
            //결과값 반환
            return result;
        }catch(Exception e){
        	//오류가 생길경우 오류 메세지 출력
            System.out.println(e.getMessage());
        }
		
		return "";
	}
}
