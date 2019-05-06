<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
#board_detail{
	height: 590px; 
	overflow: scroll;
	overflow: inherit;
	overflow: auto;
}

</style>
</head>
<body>


<c:if test="${vo.classfy eq '1' }">
<h3 style="font-size:25px; margin-top: 60px; margin-bottom: 50px;" >자유게시판</h3>
</c:if>
<c:if test="${vo.classfy eq '2' }">
<h3 style="font-size:25px; margin-top: 60px; margin-bottom: 50px;" >집사들의 모임</h3>
</c:if>
<c:if test="${vo.classfy eq '3' }">
<h3 style="font-size:25px; margin-top: 60px; margin-bottom: 50px;" >나눔의 행복</h3>
</c:if>
<c:if test="${vo.classfy eq '4' }">
<h3 style="font-size:25px; margin-top: 60px; margin-bottom: 50px;" >묻고 답해요</h3>
</c:if>





<div id="board_detail">
<table border="1" style="width: 40%; ">
<tr><th style="font-size: 20px; height: 40px; background-color: #e1e3e8;">제목</th>
	<td class="left" colspan="5" style="padding-left: 20px;">${vo.title }</td></tr>
<tr><th style="font-size: 20px; height: 40px; background-color: #e1e3e8;">작성자</th><td>${vo.nickname }</td>
	<th style="font-size: 20px; height: 40px; background-color: #e1e3e8;">작성일자</th><td style="width:15%;"><fmt:formatDate value="${vo.writedate }" pattern="yy/MM/dd"/></td>
	<th style="font-size: 20px; height: 40px; background-color: #e1e3e8;">조회수</th><td style="width:10%;">${vo.cnt }</td>
</tr>
<tr><th style="font-size: 20px; height: 70px; background-color: #e1e3e8; ">이미지</th>
	<td colspan="5"><img src="<c:url value='/'/>${vo.imagepath}" style="width: 180px; height: 180px; margin: 0 auto;"/></td>
</tr>
<tr><th style="font-size: 20px; height: 70px; background-color: #e1e3e8; ">내용</th>
	<td class="left" colspan="5" style="padding-left: 20px;"> ${fn: replace(vo.content, crlf, '<br>') }</td></tr> 
</table><br>

<!-- 글을 작성한 사용자만 수정,삭제 가능 -->
<c:if test="${login_info.nickname eq vo.nickname }"> 
<a class="btn-fill" onclick="location='modify.bo?bo_id=${vo.bo_id}'">수정</a>
<a class="btn-fill" 
	onclick="if( confirm('정말 삭제??') ){ location='delete.bo?bo_id=${vo.bo_id}'}">삭제</a>
</c:if>
 
<div style="margin-top: 40px; margin-bottom: 40px;">
<a class="btn-fill" onclick="location='list.bo?classfy=${vo.classfy}'" >목록으로</a>
<form method="post" id="detail" action="list.bo">
</form>
</div>


<div id="comment_regist" style="text-align: center; margin: 0 auto; width: 500px;">
<div class="left" style="width: 50%"><strong>댓글작성</strong></div>
<div class="right" style="width: 50%">
	<a onclick="go_comment_regist()" class="btn-fill-small">댓글등록</a> </div>
<textarea name="editor" style="width:494px; height:60px; margin-top: 5px;"></textarea>
</div><br>
<div style="width:500px; margin:0 auto; text-align:left" id="comment_list"></div>




<script type="text/javascript">
function go_comment_regist(){
	//로그인되어 있지 않으면 로그인하도록 유도
	if( ${empty login_info} ){
		alert('댓글을 등록하려면 로그인하세요!');
		return;
	}
	if( $.trim($('[name=editor]').val()) == '' ){
		alert('댓글을 입력하세요!');
		$('[name=editor]').focus();
		$('[name=editor]').val('');
		return;
	}
	//입력한 댓글을 저장하는 처리
	$.ajax({
		type: 'post',
		url: 'board/comment/insert',
		data: { content: $('[name=editor]').val(), p_id: ${vo.bo_id} },
		success: function(data){
			if( data ){
				alert('댓글이 등록되었습니다');
				comment_list();
			}else{
				alert('댓글 등록 실패!');
			}
		},
		error: function(req){
			alert(req.status);
		}
	});
}

//댓글목록조회
function comment_list(){
	$.ajax({
		url: 'board/comment/${vo.bo_id}',
		success:function(data){
			$('#comment_list').html(data);
			$('[name=editor]').val('');
		},
		error: function(req){
			alert( req.status );
		}
	});
}

$(function(){
	comment_list();
});
</script>





<style>
#comment_regist div {float: left;}
</style>
</div>
</body>
</html>