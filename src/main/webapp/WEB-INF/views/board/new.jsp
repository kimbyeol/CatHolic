<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
#board_new{
	height: 600px;
}
</style>
</head>
<body>


<h3 style="font-size: 25px; margin-top: 60px; margin-bottom: 50px;">게시판 글쓰기</h3>`
<div id="board_new">

<form method="post" action="insert.bo" enctype="multipart/form-data">
<input type="hidden" name="classfy" value="${cl}"/>
<table border="1" style="width: 40%;">
<tr><th style="background-color: #e1e3e8; font-size: 20px; height: 30px; width: 20%;">제목</th>
	<td><input class="need" style="width: 98.5%;" type="text" name="title"/></td>
</tr>	
<tr><th style="background-color: #e1e3e8; font-size: 20px; height: 30px;">작성자</th>
	<td class="left" style="padding-left: 20px; ">${login_info.nickname }</td>
</tr>	
<tr><th style="background-color: #e1e3e8; font-size: 20px; ;">내용</th>
	<td><textarea class="need" title="내용" style="width: 99%; height: 200px;" name="content"></textarea></td>
</tr>
<tr><th style="background-color: #e1e3e8; font-size: 20px; ;">첨부파일</th>
	<td class="left"><input type="file" name="file"/></td>
</tr>
</table><br>
<a onclick="if( necessary() ) { $('form').submit() }" class="btn-fill">저장</a>
<a onclick="history.back()" class="btn-empty">취소</a>
</form>
</div>
<script type="text/javascript" src="js/need_check.js"></script>

<!-- 
파일첨부:
1. form 태그의 전송방식: post
2. form 태그에 enc-type: multipart/form-data 를 지정해야만 한다.
-->

<script>
$(document).ready(function(){
	$("#profileImg").click(function(){
		$("#input_img").click() ;
		})			
	})

</script>


</body>
</html>