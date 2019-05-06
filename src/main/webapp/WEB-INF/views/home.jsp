<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>home</title>
<!-- 	<link rel="stylesheet" href="resources/css/common.css">
	<link rel="stylesheet" href="resources/css/unit.css"> -->
<!-- 	<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script> -->
<style type="text/css">
.slot_list{
	width: 400px; 
	height: 200px; 
	text-align: left;
	display: inline-block;
	margin: 10px;
	vertical-align: middle;
}
.slot_title{
	border-bottom: 2px solid #424242;
	padding-bottom: 5px;
	font-size: 1.5em;
	color: orange;
}
.boardlist{
	width: 100%;
	border-color: #fff;
}

.ic_location{
	background: url("img/home_ic_location.png") center no-repeat;
	float: right;
	display: inline-block;
	text-indent: -99999px;
	width: 32px;
	height: 32px;
}
.weather_info{
	text-align: center;
	line-height: 26px;
}
.main_pointer:hover{
	text-decoration: underline;
}
</style>
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/gsap/2.0.2/TweenMax.min.js"></script>
<script src="resources/js/controller.js"></script>
</head>
<script src ="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> 
<body style="margin-bottom: 150dp;">
	<!-- 슬라이더 뷰 -->
	<img alt="" src="">
	<div class="slide" style="margin-top: 8px">
		<button class="prev" type="button" style="color: #696969;">
			<img alt="" src="resources/img/left-arrow (1).png" />
		</button>
		<ul>
			<li><img alt="" src="resources/img/cat_slide3.jpg"></li>
			<li><img alt="" src="resources/img/cat_slide2.jpg"></li>
			<li><img alt="" src="resources/img/cat_slide4.jpg"></li>
			<li><img alt="" src="resources/img/cat_slide1.jpg"></li>
			<!-- <li><img alt="" src="resources/img/cat_5.jpg"></li> -->
		</ul>
		<button class="next" type="button">
			<img alt="" src="resources/img/right-arrow (1).png" />
		</button>

	</div>
	<div class="main_board_slot" style="margin: 0 auto; margin-top: 20px;">
		<!--  공지사항 게시판 간략히 보기 -->
		<div class="slot_list">
			<div class="slot_title">
			<a onclick="location='list.no'">공지사항</a>
			</div>
			<table class="boardlist" border="1" style="line-height: 30px">
				
				<tr style="background: #e6e6e6;">
					<th width="15%">분류</th>
					<th width="60%">제목</th>
					<th>날짜</th>
				</tr>
				
				<c:if test="${!empty fino }">
				<c:forEach items="${fino }" var="no">
				<tr>
					<td>공지글</td>
					<td class="main_pointer" style="cursor: pointer;" onclick="location='detail.no?no_id='+${no.no_id}">${no.title }</td>
					<td>${no.datestring }</td>
				</tr>
				</c:forEach>
				</c:if>
				
				
			</table>
		</div>
		<div class="slot_list">
			<div class="slot_title">
				<a onclick="location='list.bo'">인기글</a>
			</div>
			<table class="boardlist" border="1" style="line-height: 30px">
				<tr style="background: #e6e6e6;">
					<th width="25%">분류</th>
					<th width="50%">제목</th>
					<th>날짜</th>
				</tr>
				<c:if test="${!empty fibo }">
				<c:forEach items="${fibo }" var="bo">
				<tr>
					<td><c:if test="${bo.classfy eq '1'}">자유게시판</c:if><c:if test="${bo.classfy eq '2'}">집사들의 모임</c:if><c:if test="${bo.classfy eq '3'}">나눔의행복</c:if><c:if test="${bo.classfy eq '4'}">묻고답해요</c:if></td>
					<td class="main_pointer" style="cursor: pointer;" onclick="location='detail.bo?bo_id='+${bo.bo_id}">${bo.title }</td>
					<td>${bo.datestring }</td>
				</tr>
				</c:forEach>
				</c:if>
					
			</table>
		</div>
		<div class="slot_list">
			<div class="slot_title">
				<a>날씨</a>
				<a class="ic_location" onclick="popupOpen('/CatHolic/weather.wd');">위치</a>
			</div>
			<p id="prev_text" style="text-align: center;">위치를 먼저 지정해주세요!</p>
			<div class="city" align="center"></div>
			<table id="weather_tbl" style="width: 100%; display: none;" border ="1">
				<tr align="center" style="background-color: orange;">
					<td>날씨</td>
					<td>온도</td>
					<td>대기</td>			
				</tr>			
				<tr align="center">
					<td>
					<img id=sky src="resources/img/love_cat.jpg"/>
					</td>
					<td>
					<img id=tem src="resources/img/sad_cat.jpg"/>
					</td>
					<td>
					<img id=dust src="resources/img/happy_cat.jpg"/>
					</td>
				</tr>		
				<tr>
					<td colspan="3">
					<div class="weather_info">
						<div style="font-size: 1.1em;">상세정보</div>
						<div class="all"></div>
						<div class="wall"></div>
					</div>
					</td>		
				</tr>
			</table>		
		</div>
	</div>
<script type="text/javascript">
	function popupOpen(url){
		var popOption = "width=800, height=600, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
		
		window.open(url,"",popOption);
	}
	
	function getWeather(lat, lon){

		$.ajax({
			type:"GET",
			url:"https://api2.sktelecom.com/weather/current/hourly?version=1&appKey=3fa8ab39-4233-45b0-9486-a13926133f0b",
			data:{lat:lat,lon:lon},	
			async:false,
			header:{
				"Accept":"application/json",
				"Content-Type":"application/json; charset=UTF-8"
				},
				
				success:function(getweather){
					var sky = getweather.weather.hourly["0"].sky.name;
					var temptc = getweather.weather.hourly["0"].temperature.tc;
					var tempmin = getweather.weather.hourly["0"].temperature.tmin;
					city = getweather.weather.hourly["0"].grid.city;
 					var skycode = getweather.weather.hourly["0"].sky.code.toString(); 
 										
					temptc = Math.floor(temptc);
					tempmin = Math.floor(tempmin);
					
					$("#prev_text").css("display","none");
					$("#weather_tbl").css("display","table");
					img(temptc);
					imgsky(skycode);
					
					$('.wall').html('현재온도:'+temptc+" ℃" +'&nbsp;'+'||'+'&nbsp;'+'최저온도:'+tempmin+ " ℃" +'&nbsp;'+'||'+'&nbsp;'+'하늘상태:'+sky);
					$('.city').html('현재 위치:'+'&nbsp;'+city);
					$('.city').css({'font-size':'1.2em', 'margin':'10px'});
						
					$.post("/CatHolic/api2Action.wd", {city : city}, function(ret){
						var jsonData = JSON.parse(ret);
						
						var dust10 = jsonData.list["0"].pm10Value;
						var dust25 = jsonData.list["0"].pm25Value;
						var ozon = jsonData.list["0"].o3Value;
						
					img(dust);
					
						$('.all').html('미세먼지:'+dust10 +'㎍/㎥'+'&nbsp;'+'||'+'&nbsp;'+'초미세먼지:'+dust25 +'㎍/㎥'+'&nbsp;'+'||'+'&nbsp;'+'오존:'+ ozon);
					});
				},
				error:function(req){
					alert('위치 정보가 없습니다!');
				}
		});
		function img(temptc){
			var weather = document.getElementById('tem');
			if(temptc >=30 && temptc <=32){
				$("#tem").attr("src", "resources/img/love_cat.jpg");
			}else if((temptc >27 && temptc <29) || (temp >32 && temp <=33)){
				$("#tem").attr("src", "resources/img/happy_cat.jpg");
			}else{
				$("#tem").attr("src", "resources/img/happy_cat.jpg");
			}		
		}
		
		function img(dust10){
			
			var dust = document.getElementById('dust');
			if(dust10 >=31 && dust10 <=80){
				$("#dust").attr("src", "resources/img/happy_cat.jpg");
			}else if(dust10 >=0 && dust10<=30){
				$("#dust").attr("src", "resources/img/love_cat.jpg");
			}else{
				$("#dust").attr("src", "resources/img/sad_cat.jpg");
			}		
		}
		
		function imgsky(skycode){
		
		var sky = document.getElementById('sky');
		if(skycode == "SKY_O01" || skycode == "SKY_O02"){
			$("#sky").attr("src", "resources/img/love_cat.jpg");
		}else if(skycode == "SKY_O04" || skycode == "SKY_O07"){
			$("#sky").attr("src", "resources/img/happy_cat.jpg");
		}else{
			$("#sky").attr("src", "resources/img/sad_cat.jpg");
		}		 
		
		}

	}
</script>
</body>
</html>
