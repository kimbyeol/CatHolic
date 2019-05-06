<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDGOVgSZuqIfEJJnu96TsMSHd8UZP-p9uM&callback=iniMap"></script>
<style type="text/css">
#map {height: 500px;
width: 900px;
	
}
#si_content{
width: 250px;
height: 20px;
}
#sitter_btn{
padding: 2px 10px;

}




</style>
<script type="text/javascript">

function sendletter(receiver){
	var info="${login_info.nickname}"
	if(info!=""){
	window.open("postinsert?receiver="+receiver, "쪽지보내기", "width=300, height=300, toolbar=no, menubar=no, scrollbars=no, resizable=no,left=200,top=150");
	}else{
		alert('로그인하셔야 이용할수있습니다.');
	}
}
function deletemarker(num,nick){
	var curinfo="${login_info.nickname}";
	if(curinfo==nick){
		if(confirm('삭제하시겠습니까?')){
		$.ajax({
			data:{si_id:num},
			url:"delete.sitter",
			type:"post",
			success:function(data){
				if(data=="true"){
					location.reload();
				}
			},
			error:function(req){
				alert(req.status);
			}
		});
		}
	}else{
		alert('동일한 집사만 삭제할수있습니다');
	}
}
function sendsitter(){
	var logininfo="${login_info.nickname}";
	if(logininfo!=""){
		if($('#lati').val()=="" && $('#longi').val()==""){
			alert('위치를 선택해 주세요');
			return;
		}else if($('#si_content').val()==""){
			alert('내용을 입력해주세요');
		}else{
			$('#insertsitter').submit();
		}
			
    }else{
		alert('가입된 집사님만 이용가능 합니다');
	}
}


</script>
</head>
<body>
<div id="sitter_add">
<h3>Sitter 등록하기</h3>
<p style="font-size: 7px;">※간단한 내용 가능시간 연락처를 적어 주세요</p>
<p style="font-size: 7px;">※지도에 위치를 클릭하시고 등록하기를 눌러주세요</p>
<p style="font-size: 7px;">※본인이 등록한 것은 붉은색 다른사람은 파란색으로 표시됩니다.</p>
<br/>
<form action="insert.petsiiter" method="POST" id="insertsitter">
<input type="hidden" id="nickname" name="nickname" value="${login_info.nickname }">
<input type="text" id="si_content" name="content" width="150px"  /><input type="button" id="sitter_btn" style="width: 100px; margin-left: 5px; vertical-align: middle;" onclick="sendsitter()" value="등록하기"/>
<input type="hidden" id="lati" name="lati" value="">
<input type="hidden" id="longi" name="longi" value="">
</form>
</div>
<h3 style="text-align: center;">펫시터들</h3>
<div id="mapdiv" >
	<div id="map" style="margin: 0 auto;"></div>
</div>
<script type="text/javascript">
function iniMap(){
	var Latitude;
	var Longitude;
	var markers;
	var mapProp={center:{lat:35.153535,lng:126.887924},
	zoom:14,mapTypeId:google.maps.MapTypeId.ROADMAP		
	};
	var map=new google.maps.Map(document.getElementById('map'),mapProp);
	  
	google.maps.event.addListener(map, 'click', function(event){
		  var clickedLocation = new google.maps.LatLng(event.latLng.lat(),event.latLng.lng());
		  if(markers != null) markers.setMap(null);
		  markers=new google.maps.Marker({
			  animation: google.maps.Animation.DROP,
				position:clickedLocation,
				map:map
		  });
		  $('#lati').val(event.latLng.lat());
		  $('#longi').val(event.latLng.lng());
	  });
	var myIcon = new google.maps.MarkerImage("img/pet_Mymarker.png", null, null, null, new google.maps.Size(30,30));
	var sitIcon = new google.maps.MarkerImage("img/pet_bluemarker2.png", null, null, null, new google.maps.Size(30,30));
	var nick="${login_info.nickname}";
	$.ajax({
		url:"list.petsitter",
		dataType:"json",
		async:false,
		success:function(data){
			$.each(data, function(idx, item){
				var lat=item['lati']*1;
				var longi=item['longi']*1;
				var location = new google.maps.LatLng(lat,longi);
				if(item['nickname']==nick){
				var maker = new google.maps.Marker({
					position:location,
					map:map,
					icon:myIcon,
					title:'집사 '+item['nickname']+'님의 아지트',
				});
				}else if(item['nickname']!=nick){
					var maker = new google.maps.Marker({
						position:location,
						map:map,
						icon:sitIcon,
						title:'집사 '+item['nickname']+'님의 아지트',
					});
				}
				var s_nickname=item['nickname'];
				var markerInfoWindow = new google.maps.InfoWindow();
				var strContent = '<div id="win_content" style="width:170px; height: 100%; border-radius: 5px; text-align: left;">' + 
		         '<div id="win_con">' + 
		          '<a class="sitter" style="text-decoration: none;font-weight: bold;">'+item["nickname"]+' 집사</a> <a onclick="sendletter(\''+s_nickname+'\')" class="letter_sitter" style="position: absolute;"><img alt="편지" src="img/letter.png"/></a><a style="position: absolute;margin-left: 19px;" onclick="deletemarker('+item["si_id"]+',\''+item["nickname"]+'\')"><img alt="삭제" src="img/trash.png"></a><br>' + item["content"]+'</div>' + 
		         '<div id="Link">' + 
		        '</div>'; 
				markerInfoWindow = new google.maps.InfoWindow({ 
				     content: strContent, 
				     position: location, 
				     maxWidth:600 
				}); 

				// add click event for marker to show info window 
				google.maps.event.addListener(maker, 'click', function() { 
				    markerInfoWindow.open(map, this); 
				}); 
			}); 
		},
		error:function(req){
			alert(req.status);
		}
	});
	
}
</script>



</body>
</html>