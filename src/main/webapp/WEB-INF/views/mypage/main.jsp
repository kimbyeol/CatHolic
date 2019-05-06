<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<style type="text/css">

.mypage_info{
	width: 100%;
	text-align: center;
	overflow: hidden;
	margin: 0 auto;
	margin-top: 30px;
}

.my_box, .my_content{
	width: 570px;
	height: 650px;
/* 	border: 1px solid #e6e6e6; */
	float: left;
	margin-bottom: 150px;
}

.mypage_info h2{
	border-bottom: 2px solid #424242;
	text-align: left;
	padding-left: 20px;
	margin: 0;
	margin-top: 20px;
}
.my_info{
	height: 250px;
}
.my_cat_info{
	height: 300px;
}
.boardlist{
	width: 100%;
	border-color: #fff;
}
th{
	font-size: large;
}
.m-img, .p-img{
	display: block;
	width: 120px;
	height: 110px;
	border: 1px solid #e6e6e6;
	margin-bottom: 10px;
}
.m-info_box, .p-info_box{
	padding: 30px 25px;
	margin: 10px 5px;
}

.p-info_box{
	display:inline-block;
	border: 1px solid #e6e6e6;
	width: 122px;
	height: 180px;
	overflow: hidden;
}
.p-img{
	
}
.m-img{
	background: url("img/myprofile_default.png") center no-repeat;
	float: left;
}
.span{
	font-size: large;
	text-align: left;
	margin-top: 18px
}
.title{
	font-size: x-large; 
	margin: 0 20px;
}
#mypetpop{
position: absolute;
width:380px;
height: 250px;
left:50%;
top: 50%;
display:none;
transform:translate(-50%,-50%);
border: 1px solid #adadad;
z-index: 99999;
background-color: white;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	$('#mypetpop').hide();
	$('#mypetpop').load('petinsert');
});
function show_petin(){
	$('#mypetpop').css('display','block');
	$('#pop_background').css('display','block');
	$('#mypetpop,#pop_background').show(550);
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/moment-with-locales.js"></script>
<script src ="js/moment-timezone.min.js" ></script >
</head>
<body style="margin: 0 auto; width: 1210px;">
<h1 style="margin-top: 50px;">마이페이지</h1>
<div class="mypage_info" style="float:left;">
	<div class="my_box" style="margin-right: 70px;">
		<div class="my_info">
			<h2>내 정보</h2>
			<div class="m-info_box">
				<div class="m-img"></div>
				<div class="span">
					<span class="title" >아이디</span>
					<span class="m-id">${login_info.userid }</span><br/>
					<span class="title" >별명</span>
					<span class="m-name" style="margin-left: 20px">${login_info.nickname }</span><br/>
					<span class="title" >이메일</span>
					<span class="m-email">${login_info.mail }</span>			
				</div>
			</div>
		</div>
			<a class="btn-fill" onclick="location='info_change'">내정보 수정</a>
			<div class="my_cat_info">
				<h2>나의 반려묘</h2>
				<div class="p-info_list" style="overflow: hidden;">
					<!-- 반려묘를 등록하지 않은경우 -->
					<c:if test="${empty petmy }">
					<div class="p-info_box" id="p_info_none" style="display:block; float: left;"><!-- 반려묘등록시 display:none; -->
						<div style="font-size: 1.3em; padding-top: 60px">반려묘를<br/>
							 등록해보세요!
						</div>
					</div>
					</c:if>
					<c:if test="${!empty petmy }">
						<c:forEach items="${petmy }" var="pet">
							<div class="p-info_box" id="p_info_list1" style="display: block; float: left;">
							<div class="p-img"><c:if test="${!empty pet.imagepath }"><img src="<c:url value='/'/>${pet.imagepath }" style="width: 122px;height: 112px;"/></c:if><c:if test="${empty pet.imagepath }"><img src="img/mypet_default.PNG" style="width: 122px;height: 112px;"/></c:if></div>
							<div class="p-name" style="font-size: large;">${pet.petname }</div>
							<span class="p-sp">${pet.species }</span>
							<span class="p-gender">| ${pet.gender }</span>
							<div class="p-birth">${pet.datestring }</div>
						   </div>
						</c:forEach>
					</c:if>
					<!-- 
					반려묘2번째
					<div class="p-info_box" id="p_info_list2" style="display: none;">
						<div class="p-img"></div>
						<div class="p-name" style="font-size: large;">나비</div>
						<span class="p-sp">한국고양이</span>
						<span class="p-gender">| 수컷</span>
						<div class="p-birth">생일 2018.5.26</div>	
					</div>
					반려묘3번째
					<div class="p-info_box" id="p_info_list3" style="display: none;">
						<div class="p-img"></div>
						<div class="p-name" style="font-size: large;">초코</div>
						<span class="p-sp">샴</span>
						<span class="p-gender">| 암컷</span>
						<div class="p-birth">생일 2018.3.13</div>	
					</div> -->
				</div>
		</div>
			<a class="btn-fill" onclick="show_petin()">반려묘 추가등록</a>
	</div>	
	<div class="my_content">
		<h2 >나의 게시글 </h2>
		<table class="boardlist" border="1" style="line-height: 30px">
			<tr style="background: #e6e6e6;">
				<th>분류</th>
				<th width="65%">제목</th>
				<th width="20%">날짜</th>
			</tr>
			<c:forEach items="${mybo }" var="bo">
			<tr>
				
				<td style="width: 17%"><c:if test="${bo.classfy eq '1'}">자유게시판</c:if><c:if test="${bo.classfy eq '2'}">집사들의 모임</c:if><c:if test="${bo.classfy eq '3'}">나눔의행복</c:if><c:if test="${bo.classfy eq '4'}">묻고답해요</c:if></td>
				<td style="cursor: pointer; text-align: left; padding-left: 10px;" onclick="location='detail.bo?bo_id='+${bo.bo_id}">${bo.title }</td>
				<td>${bo.datestring }</td>
			</tr>			
			</c:forEach>
		</table>
	</div>
	<div id="mypetpop"></div>
</div>
</body>
</html>