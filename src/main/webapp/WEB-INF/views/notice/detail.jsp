<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html>
<html>
<head>
 	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
#notice_detail{
	height: 600px;
}
.notice_table{
	width: 50%;
}
.notice_table td{
	padding: 10px;
	font-size: 17px;
}
</style>
</head>
<body>


<h1 style="margin-top: 60px; margin-bottom: 50px;">공지글안내</h1>
<div id="notice_detail">
<table class="notice_table" border="1">
<tr style="font-size: 20px; height: 40px;  "><th style="width:15%; background-color: #e1e3e8;">제목</th>
	<td colspan="3" class="left">${vo.title }</td></tr>
<tr style="font-size: 20px; height: 40px;  "><th style="background-color: #e1e3e8;">작성자</th><td class="left" >${vo.writer }</td>
	<th style="width:15%; background-color: #e1e3e8;">작성일자</th><td style="width:30%;"><fmt:formatDate value="${vo.writedate }" pattern="yyyy년 MM월  dd일 HH시 mm분"/></td>

</tr>
<tr style="font-size: 20px; height: 40px;  "><th style="background-color: #e1e3e8; height:70px; ">내용</th>
	<td class="left" colspan="3">${fn: replace(vo.content, crlf, '<br>') }</td></tr>

</table><br>

<!-- 관리자로 로그인한 경우만 수정,삭제 가능 -->
<c:if test="${login_info.admin eq 'Y' }">
<a class="btn-fill" onclick="location='modify.no?no_id=${vo.no_id}'">수정</a>
<a class="btn-fill" 
	onclick="if( confirm('정말 삭제??') ){ location='delete.no?no_id=${vo.no_id}' }">삭제</a>
</c:if>

<a class="btn-fill" onclick="$('#detail').submit()">목록으로</a>
<form method="post" id="detail" action="list.no">
<input type="hidden" name="curPage" value="${page.curPage }"/>
</form>
</div>
</body>
</html>