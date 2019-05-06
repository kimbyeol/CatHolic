<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript"></script>
<style type="text/css">
#pettable{
	width: 93%;
	border: 0px;
}
.gender_ch{
	width: 15px;
	height: 15px;
	margin-top: 5px;
}
</style>
<script type="text/javascript">
function readURL(input) {
	 
    if (input.files && input.files[0]) {
        var reader = new FileReader();
 
        reader.onload = function (e) {
            $('#pet_reimg').attr('src', e.target.result);
        }
 
        reader.readAsDataURL(input.files[0]);
    }
}
	
</script>
</head>
<body>
<form action="insert_webpet" method="post" enctype="multipart/form-data" id="pet_in">
<div class="mypet_info_box">
<div style="float: left; width: 150px; height: 190px; margin: 5px;">
<img id="pet_reimg" src="img/mypet_default.PNG" style="width: 140px; height: 140px; margin: 4px;" /><input type="file" name="petimg" value="사진올리기" onchange="readURL(this)">
</div>
<div style="float: left; width: 210px; height: 190px; margin: 5px;">
<table width="90%" id="pettable">
<tr><td width="30px">이름</td><td><input type="text" id="petna" name="petname" style="width: 150px; height:20px; margin-top: 5px;"/></td></tr>
<tr><td width="30px">생일</td><td><input type="text" id="petbir" name="pet_birth" style="width: 150px; height:20px; margin-top: 5px;"/></td></tr>
<tr><td width="30px">품종</td><td><input type="text" id="petspe" name="species" style="width: 150px; height:20px;margin-top: 5px;"/></td></tr>
<!-- <tr><td width="30px">성별</td><td><input type="text" id="petse" name="gender" style="width: 150px; height:20px;margin-top: 5px;"/></td></tr> -->
<tr><td width="30px">성별</td><td style="text-align: left;" ><input type="radio" id="petse" name="gender" class="gender_ch" value="수컷"/>수컷
								 <input type="radio" name="gender" class="gender_ch" value="암컷"/>암컷</td></tr>

 

</table>
</div>
</div>
<div class="btn_box" style="">
<a class="btn-fill" style="margin-top: 10px;" onclick="if(confirm('등록하시겠습니까?')){$('#pet_in').submit()}">등록</a> <a class="btn-fill" style="margin-top: 10px;" onclick="fade_map()">취소</a>
</div>
</form>

</body>
</html>