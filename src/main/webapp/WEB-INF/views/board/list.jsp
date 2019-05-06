<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>

#board_image{
margin: 0 auto;
width: 65%;
overflow: hidden;
height: 550px;
overflow: scroll;

overflow: auto;
}
#bo_image{
	border: 1px solid #cccccc;
	margin:10px 10px 10px 10px;
	width: 250px;
	height: 250px;
	float: left;
}

</style>
<body>
<c:if test="${gesi eq '0' }">
<h3 style="font-size:35px; margin-top: 40px; margin-bottom: 40px;" >전체 게시판 </h3>
</c:if>
<c:if test="${gesi eq '1' }">
<h3 style="font-size:35px; margin-top: 40px; margin-bottom: 40px;" >자유게시판 </h3>
</c:if>
<c:if test="${gesi eq '2' }">
<h3 style="font-size:35px; margin-top: 40px; margin-bottom: 40px;" >집사들의 모임 </h3>
</c:if>
<c:if test="${gesi eq '3' }">
<h3 style="font-size:35px; margin-top: 40px; margin-bottom: 40px;" >나눔의 행복 </h3>
</c:if>
<c:if test="${gesi eq '4' }">
<h3 style="font-size:35px; margin-top: 40px; margin-bottom: 40px;" >묻고 답해요 </h3>
</c:if>


<form method="post" action="list.bo" id="list">
<input type="hidden" name="curPage"/>
<p id="list-top">

<!-- 로그인된 경우만 글쓰기버튼이 보이게 -->
<c:if test="${!empty login_info && gesi != 0 }">
<div class="right" style="width: 80%; r">
<a onclick="location='new.bo?classfy=${cl}'"  class="btn-fill" >글쓰기</a>
</div>
</c:if>
</p>
</form>

<div id="board_image">

<c:forEach items="${vo}" var="vo">
	<a onclick="location='detail.bo?bo_id=${vo.bo_id}'">
	<div id="bo_image" style="border-radius: 30px" >
		<img src="<c:url value='/'/>${vo.imagepath}" style="width:250px; height:190px; margin:0 auto; border-top-left-radius: 30px; border-top-right-radius: 30px;"/>
		${vo.title}<br/>
		<div style="height: 10px;">
		<div style="overflow: hidden; text-overflow: ellipsis;  white-space: nowrap; width: 130px; margin-left: 5px; float: left; margin-left: 40px; ">${vo.content}</div>
		<div> ${vo.nickname }</div></div><br/>
		<div style="font-size: 10px; float: right; margin-right: 20px;"><fmt:formatDate value="${vo.writedate }" pattern="yy/MM/dd"/></div>
	</div></a>
</c:forEach>
</div><br>
<div>
</div>

</body>
</html>