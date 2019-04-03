<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>회원가입</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	
	var pwvar = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,16}$/; // 비밀번호가 적합지 검사할 정규
	var idvar = /^[0-9a-z]+$/; // 아이디가 적합한지 검사할 정규식
	var emailvar = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/; // 이메일이 적합한지 검사할 정규식
	var namevar = /^[가-힣a-zA-Z]+$/;
	var nicknamevar = /[0-9]|[a-z]|[A-Z]|[가-힣]/;
	
	$(function (){
		;
	});
	
	function plszero()
	{
		if(parseInt($("#dd").val()) < 10){
			$("#dd").val("0"+parseInt($("#dd").val()));
		}
	}
		
	$(function(){
		$('#pw').keyup(function(){
			if(!pwvar.test($('#pw').val())){
				$('#pwMsg').html("8~16자 한개의 특수문자를 넣어야 사용가능 합니다.").css('color','red');
			}else{
				$('#pwMsg').html("사용가능한 비밀번호 입니다.").css('color','green');
			}
		});
		
		$('#chpw').keyup(function(){
			if($('#pw').val()!=$('#chpw').val()){
				$('#pwChMsg').html("비밀번호를 확인해주세요.").css('color','red');
			}else{
				$('#pwChMsg').html("비밀번호가 일치합니다.").css('color','green');
	  		}
		}); //#chpass.keyup
		
		$('#name').keyup(function(){
			if(!namevar.test($('#name').val())){
				$('#nameMsg').html('한글 영문만 입력 가능합니다.').css('color','red');
			}else{
				$('#nameMsg').html('');
			}
		});
		
		
	 });
		
	function userIdCheck(){
		var value = $('#mb_id').val();
		if(idvar.test(value)){
			if(value.length>=5){
				$.ajax({
						url : "getOneId",
						data : "mb_id="+value,
						success : function(data){
							if(data=='0' || data==0){
								$('#idMsg').html('멋진 아이디네요!').css('color','green');
							}else{
								$('#idMsg').html('이미 사용중이거나 탈퇴한 아이디입니다.').css('color','red');
							}
						} //success
					}); // ajax
			}else{
				$('#idMsg').html('');	
			}
		}else{
			$('#idMsg').html('특수문자는 사용할 수 없습니다.').css('color','red');
		}
		
	};
		
	function userEmailCheck(){
		var email = $('#mb_email').val();
		if(emailvar.test(email)){
			if(email.length>=10){
				$.ajax({
						url : "getOneEmail", 
						data : "mb_email="+email, 
						success : function(data){
							if(data=='0' || data==0){
								$('#emailMsg').html('사용가능한 이메일 입니다.').css('color','green');
							}else{
								$('#emailMsg').html('이미 가입한 이메일 입니다.').css('color','red');
							}
						} //success
					}); // ajax
			}else{
				$('#emailMsg').html('');	
			}
		}else{
			$('#emailMsg').html('이메일 주소를 다시 확인해주세요').css('color','red');
		return false;
		}
	};
	
	function userNickNameCheck(){
		var nickname = $('#nickname').val();
		if(nicknamevar.test(nickname)){
			if(nickname.length>=3){
				// 여기에서 AJax를 호출한다.
				$.ajax({
						url : "getOneNickname", 
						data : "mb_nickname="+nickname, 
						success : function(data){
							if(data=='0' || data==0){
								// 아이디 특수문자 검사 추가해야
								$('#nicknameMsg').html('사용가능한 닉네 입니다.').css('color','green');
							}else{
								$('#nicknameMsg').html('중복닉네임 입니다.').css('color','red');							
							}
						} //success
					}); // ajax
			}else{
				$('#nicknameMsg').html('닉네임은 3글자 이상 가능합니다.');	
			}
		}else{
			$('#nicknameMsg').html('닉네임을 확인해주세요').css('color','red');
		}
	};


	
	function FormCheck(){
		if(!idvar.test($('#mb_id').val())){
			alert('아이디를 확인해주세요.');
			$('#mb_id').val('');
			$('#mb_id').focus();
			return false;
		}else if(!pwvar.test($('#pw').val())){
			alert('비밀번호를 확인해주세요.');
			$('#pw').val('');
			$('#pw').focus();
			return false;
		}else if($('#pw').val()!=$('#chpw').val()){
			alert('비밀번호가 다릅니다.');
			$('#chpw').val('');
			$('#chpw').focus();
			return false;
		}else if(!namevar.test($('#name').val())){
			alert('이름을 확인해주세요.');
			$('#name').val('');
			$('#name').focus();
			return false;
		}else if(!emailvar.test($('#mb_email').val())){
			alert('이메일을 확인해주세요.');
			$('#mb_email').focus();
			return false;
		}else if(!nicknamevar.test($('#nickname').val())){
			alert('닉네임을 확인해주세요.');
			$('#nickname').focus();
			return false;
		}
	};
	
</script>
</head>
<body>
<div class="container" style="margin-top: 3%; width: 30%;" >
	<form method="post" action="joinOK" class="form-horizontal" onsubmit="return FormCheck();">
	  	<div class="form-group">
  				<label class="col-form-label" for="inputDefault">아이디</label>
    			<input type="text"  name="mb_id" id="mb_id" placeholder="아이디" class="form-control" required="required" onkeyup="userIdCheck()" maxlength="20"/>
    			<span id="idMsg"></span>
		</div>
	  	<div class="form-group">
  				<label class="col-form-label" for="inputDefault">비밀번호</label>
    			<input name="mb_password" class="form-control" id="pw" placeholder="Password" type="password" required="required" maxlength="20" />
				<span id="pwMsg" ></span>
		</div>
	  	<div class="form-group">
  				<label class="col-form-label" for="inputDefault">비밀번호 확인</label>
    			<input name="password2" id="chpw" class="form-control" placeholder="Password" type="password" required="required" maxlength="20"/>
				<span id="pwChMsg"></span>
		</div>
	  	<div class="form-group">
  				<label class="col-form-label" for="inputDefault">이메일</label>
    			<input name="mb_email" id="mb_email"  class="form-control" placeholder="email" type="text" onkeyup="userEmailCheck()" required="required" maxlength="50" />
				<span id="emailMsg"></span>
		</div>
	  	<div class="form-group">
  				<label class="col-form-label" for="inputDefault">이름</label>
   				<input name="mb_name" id="name" class="form-control" placeholder="name" type="text" required="required" />
				<span id="nameMsg"></span>
		</div>
	  	<div class="form-group">
  				<label class="col-form-label" for="inputDefault">닉네임</label>
   				<input name="mb_nickname" id="nickname" class="form-control"  placeholder="Nikname" type="text" onkeyup="userNickNameCheck()" required="required" maxlength="10"/>
				<span id="nicknameMsg"></span>
		</div>
  		<div class="form-group">
				<span>생년월일</span>
				  <div class="input-group mb-3">
					<input type="text" name="mb_yy" class="form-control" id="yy" placeholder="년(4자)" aria-label="년(4자)" maxlength="4"> 
				    <select class="form-control" name="mb_mm" id="mm" aria-label="월">
						<option>월</option>
			 			<option value="01">1</option>
						<option value="02">2</option>
						<option value="03">3</option>
						<option value="04">4</option>
						<option value="05">5</option>
						<option value="06">6</option>
						<option value="07">7</option>
						<option value="08">8</option>
						<option value="09">9</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
					</select>
					<input type="text" name="mb_dd" class="form-control" id="dd" onblur="plszero()" placeholder="일" aria-label="일" maxlength="2">
				</div>
			</div>
  		<div class="form-group" align="right">
      			<input type="submit" class="btn btn-success" value="회원가입">
  		</div>
	</form>
</div>
</body>
</html>