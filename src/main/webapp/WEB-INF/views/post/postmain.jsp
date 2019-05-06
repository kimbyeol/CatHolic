<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
 table {
    width: 100%;
    border-top: 1px solid #ccced1;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #ccced1;
    padding: 7px;
  }
</style>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="js/moment-with-locales.js"></script>
<script src ="js/moment-timezone.min.js" ></script >
<script type="text/javascript">
$(document).ready(function(){
 window.resizeTo(500,700);
 $('#senderbtn').trigger("click");
 $.ajax({
	url:"Allpostdelete.post",
	type:"GET",
	success:function(){
		
	},
	error:function(req){
		alert(req.status);
	}
 });
});



function detail(po_id,flag){
	location='post.detail?po_id='+po_id+'&flag='+flag;
}


function sender(){
	var nick="${login_info.nickname}";
	
	
	$.ajax({
		url:"senderlist.post",
		type:"GET",
		dataType: "json",
		data:{sender:nick },
		success:function(dat){
			if(dat.length==0){
				$('#result').html('<div style="margin:20px 0 10px 0; border-top:1px solid;padding:20px 100px;">보낸메세지가 없습니다</div>');
				return;
			}
			var tag="<table width='80%'><tr style='background-color:lightcoral;'><td>받는사람</td><td>제목</td><td>전송일</td><tr>";
			$.each(dat,function(idx,item){
				var flag="0";
				var date=item['writedate'];
				tag+="<tr><td>"+item['receiver']+"</td><td><a onclick='detail("+item['po_id']+","+flag+")'>"+item['title']+"</a></td><td>"+moment(date).locale('ko').format('YYYY MMMM Do, a h:mm')+"</td></tr>"
				
			});
							
			
			
			
			tag+='</table>'
			$('#result').html(tag);
		},
		error:function(req){
			alert(req.status);
		}
		
	});
}
function receiver(){
	var nick="${login_info.nickname}";
	
	
	$.ajax({
		url:"receiverlist.post",
		type:"GET",
		dataType: "json",
		data:{receiver:nick },
		success:function(dat){
			if(dat.length==0){
				$('#result').html('<div style="margin:20px 0 10px 0; border-top:1px solid;padding:20px 100px;">받은메세지가 없습니다</div>');
				return;
			}
			var tag="<table width='80%'><tr style='background-color:skyblue;'><td>보낸사람</td><td>제목</td><td>수신일</td><tr>";
			$.each(dat,function(idx,item){
				var flag="1";
				var date=item['writedate'];
				tag+="<tr><td>"+item['sender']+"</td><td><a onclick='detail("+item['po_id']+","+flag+")'>"+item['title']+"</a></td><td>"+moment(date).locale('ko').format('YYYY MMMM Do, a h:mm')+"</td></tr>"
				
			});
							
			
			
			
			tag+='</table>'
			$('#result').html(tag);
		},
		error:function(req){
			alert(req.status);
		}
		
	});
}
</script>
</head>
<body>

<h3>쪽지함</h3>
<a class="btn-fill" id="senderbtn" onclick="sender()">보낸메세지</a> <a class="btn-fill" id="reseibtn" onclick="receiver()">받은메세지</a>
<div id="result" style="margin-top: 20px; margin-bottom: 10px;">
</div>

<input type="button" class="btn-fill" value="쪽지쓰기" onclick="location='postinsert'">
</body>
</html>