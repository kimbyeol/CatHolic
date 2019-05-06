<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>Insert title here</title>
<style type="text/css">
ul li{
	list-style: none;
	text-align: left;
}

.text{

	text-align: center;

	font-size: .8em;

	padding: 10px;

	border-bottom: 1px solid #d6d5d2;

}

.join_box{

	width: 250px;

	line-height:35px;

	margin: 0 auto;

	margin-top: 30px;

}

.join_button{

	margin-top: 20px;

}

.join_button input{

	width: 254px;

	height: 30px;

	margin-bottom: 5px;

	background-color: #6c6a68;

	border: 1px;
	
	color: #fff;

}

input[type=button]{

	width: 254px;

	height: 30px;

	line-height:30px;

	background-color: #6c6a68;

	border: 1px;
	
	color: #fff;

}

 

input{

	width:250px;

	height: 30px;

}

 

.reverse{

	color:pink;

	cursor:pointer;

	}

.succ{

	color: green;

	font-size: .8em;

}

.fail, #id_ck{

	color:red;

	font-size: .8em;

}

</style>

<script type="text/javascript">
$('input[type="button"], input[type="reset"], input[type="submit"]').css('cursor','pointer');
</script>
<script type="text/javascript">
function check_idm(){
	var id=$('#id').val();
	$.ajax({
		url:'check.memid',
		type:'POST',
		data:{userid:id},
		success:function(dat){
			if(dat=='succ'){
				alert('이미 존재하는 아이디입니다!');
			}else{
				alert('사용할 수 있는 아이디입니다!');
				$('#ck_id').val('1');
			}
			
		},
		error:function(req){
			alert(req.status);
		}
	});
}
function check_nic(){
	var nick=$('#nickname').val();
	$.ajax({
		url:'check.mem',
		data:{nickname:nick},
		type:'POST',
		success:function(dae){
			if(dae=='succ'){
				alert('이미 존재하는 닉네임입니다!');
				
			}else{
				alert('사용할 수있는 닉네임입니다.');
				$('#ck_nic').val('1');
			}
		},
		error:function(req){
			alert(req.status);
		}
		
	});
}
function join(){
	if($('#ck_id').val()!='1'){
		alert('아이디 중복확인을 해주세요');
		return;
	}else if($('#ck_nic').val()!='1'){
		alert('닉네임 중복확인을 해주세요');
		return;
	}else{
		$('#join_form').submit();
// 		alert('회원가입완료!')
// 		location.reload();
	}
}
/* function check_pw(){
	if($('#pw1').length<6){
		$('#fail_pw').css('display','block');
		$('#fail_pw').html('비밀번호를 6글자이상 입력해주세요');
		
	}else{
		
		$('#fail_pw').css('display','none');
		$('#succ_pw').css('display','block');
		$('#succ_pw').html('사용할수있는 비밀번호입니다.');
	}
} */
function check_repw(){
	if($('#pw2').val()==$('#pw1').val()){
		$('#fail').css('display','none');
		$('#succ').css('display','block');
		
	}else{
		$('#succ').css('display','none');
		$('#fail').css('display','block');
	}
}
</script>

</head>

<body>
	<h1 style="text-align: center;	font-size: 2em;	color: #5b5957;">JOIN</h1>
	<input type="hidden" value="0" id="ck_id"/>
	<input type="hidden" value="0" id="ck_nic"/>
	
	<div class="text">

	회원정보를 입력해주세요.<br/>

	</div>

	<form id="join_form" action="insert.mem" method="post" >

	<div class="join_box">

		<ul>
		<li>ID</li>

		<li><input type="text" id="id" required="required" 

			placeholder="ID를 입력해 주세요 (6~20자리)" maxlength="20" name="userid"/></li>

		<li><input style="margin-top: 10px" id="check_id" type="button" value="ID 중복확인" onclick="check_idm()"/></li>
		<li>닉네임</li>
		<li><input type="text" id="nickname" required="required" 

			placeholder="닉네임를 입력해 주세요 (6~20자리)" maxlength="20" name="nickname"/></li>

		<li><input style="margin-top: 10px" id="nickname_check" type="button" value="닉네임 중복확인" onclick="check_nic()"/></li>

		<li>비밀번호</li>

		<li><input type="password" id="pw1" required="required" 

			placeholder="비밀번호를 입력해 주세요 (6~20자리)" maxlength="20" name="pwd" /></li>
		<li><div class="succ" id="succ_pw" style="display: none;">*비밀번호가 일치합니다</div></li>
		<li><div class="fail" id="fail_pw" style="display: none;">*사용할수있는 비밀번호입니다.</div></li>
		<li>비밀번호 확인</li>

		<li><input type="password" id="pw2" required="required" 

			placeholder="비밀번호를 다시 한번 입력해 주세요" maxlength="20" onkeyup="check_repw()"/></li>

		<li><div class="succ" id="succ" style="display: none;">*비밀번호가 일치합니다</div></li>

		<li><div class="fail" id="fail" style="display: none;">*비밀번호가 일치하지 않습니다</div></li>

		

		<li>이메일</li>

		<li><input type="text" id="email" required="required" 

			placeholder="이메일을 입력해 주세요" name="mail"/></li>

		</ul>
			<div class="join_button">

				<input type="reset" id="reset" value="RESET" /><br/>

				<input type="button" id="sub" value="JOIN" onclick="join()"/><br/>

			</div>

		</div>

</form>
		
</body>
</html>