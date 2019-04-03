<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>회원정보 수정</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	
	var pwvar = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,16}$/; // 비밀번호가 적합지 검사할 정규
	var idvar = /^[a-zA-Z0-9]{5,20}$/; // 아이디가 적합한지 검사할 정규식
	var email = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/; // 이메일이 적합한지 검사할 정규식
	var namevar = /([^가-힣\x20a-zA-Z])/i; 

	$(function (){
		;
	});
	
	
	$(function(){
		
		$('#pw').keyup(function(){
			if(!pwvar.test($('#pw').val())){
				$('span[name=pwMsg]').text('');
				$('span[name=pwMsg]').html("8~16자 한개의 영문 대문자와 소문자, 숫자, 특수문자를 사용하세요.");
				$('span[name=pwMsg]').css('color','red');
			}else{
				$('span[name=pwMsg]').text('');
				$('span[name=pwMsg]').html("사용가능한 비밀번호 입니다.");
				$('span[name=pwMsg]').css('color','green');
			}
		});
		
		$('#chpw').keyup(function(){
			if($('#pw').val()!=$('#chpw').val()){
				$('span[name=pwChMsg]').text('');
				$('span[name=pwChMsg]').html("비밀번호를 확인해주세요.");
				$('span[name=pwChMsg]').css('color','red');
			}else{
				$('span[name=pwChMsg]').text('');
				$('span[name=pwChMsg]').html("비밀번호가 일치합니다.");
				$('span[name=pwChMsg]').css('color','green');
	  		}
		}); //#chpass.keyup
		
		$('#email').keyup(function(){
			if(!email.test($('#email').val())){
				$('span[name=emailMsg]').text('');
				$('span[name=emailMsg]').html('이메일 주소를 다시 확인해주세요.');
				$('span[name=emailMsg]').css('color','red');
			}else{
				$('span[name=emailMsg]').text('');
				$('span[name=emailMsg]').html('');
			}
		});
		
		$('#name').keyup(function(){
			if(!namevar.test($('#name').val())){
				$('span[name=nameMsg]').text('');
				$('span[name=nameMsg]').html('한글 영문만 입력 가능합니다.');
				$('span[name=nameMsg]').css('color','red');
			}else{
				$('span[name=nameMsg]').text('')
				$('span[name=nameMsg]').html('');
			}
		});
	 });
	function passwordCK(){
		if($('#ajax_pw').val().length>=8){
			$.ajax({
				url : "passwordChek",
				data : "mb_password=" + $("#ajax_pw").val() ,
				success : function(data){
					if(data=='1' || data==1){
						// 성공
						$('#ajax_pw').attr('class','form-control is-valid');
					}else{
						$('#ajax_pw').attr('class','form-control is-invalid');
						$('#successCk').attr('class','form-group has-danger');
						$('#labelCk').attr('for','inputDanger1');
					}
				} //success
			}); // ajax
		}else{
			$('#ajax_pw').attr('class','form-control is-invalid');
			$('#successCk').attr('class','form-group has-danger');
			$('#labelCk').attr('for','inputDanger1');
		}
	}
	function FormCheck(){
		if($('#ajax_pw').attr('class')!='form-control is-valid'){
			alert('현재 비밀번호가 일치하지 않습니다.');
			return false;
		}
	}

</script>
</head>
<body>
	<div class="container" style="margin-top: 3%; width: 30%;" >
		<form method="post" action="updateMemberOk" onsubmit="return FormCheck();">
			<fmt:parseDate value="${nikupdatetime }" pattern="yyyy-MM-dd"/>
			<fmt:parseDate value="${sysdate }" pattern="yyyy-MM-dd"/>
			<div class="form-group">
			    <label class="control-label" for="inputDefault">아이디</label>
			    <input class="form-control" id="id" type="text" name="mb_id" value="${vo.mb_id }" required="required" readonly="readonly" maxlength="20">
			</div>
			<div class="form-group" id="successCk">
  				<label class="col-form-label" for="inputSuccess1" id="labelCk">비밀번호</label>
				<input type="password" class="form-control" name="mb_password" id="ajax_pw" placeholder="Password" required="required" maxlength="20" onkeyup="passwordCK()" />
				<span name="mb_pwMsg" color=""></span>
			</div>
			<div class="form-group">
  				<label class="col-form-label" for="inputDefault">이메일</label>
				<input type="text" name="mb_email" class="form-control" id="email" value="${vo.mb_email }" required="required" readonly="readonly" maxlength="50" />
				<span name="mb_emailMsg" color=""></span>
			</div>
			<div class="form-group">
			    <label class="control-label" for="disabledInput">이름</label>
				<input name="mb_name"  class="form-control" id="name" value="${vo.mb_name }" type="text" required="required" />
			</div>
			<div class="form-group">
  				<label class="col-form-label" for="inputDefault">닉네임</label>
				<input name="mb_nickname" class="form-control" id="nickname" value="${vo.mb_nickname }" type="text" required="required" maxlength="10"/>
				<span name="mb_pwMsg" color=""></span>
			</div>
			<div class="form-group">
				<span>생년월일</span>
				  <div class="input-group mb-3" align="center">
					<input type="text" name="mb_yy" class="form-control" id="yy" value="${vo.mb_yy }" required="required" maxlength="4"> 
				    <select class="form-control" name="mb_mm" id="mm" aria-label="월">
			 			<option value="${vo.mb_mm}">${vo.mb_mm}</option>
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
					<input type="text" name="mb_dd" class="form-control" id="dd" value="${vo.mb_dd }" required="required" maxlength="2">
				</div>
			</div>
			<div class="form-group" align="right">
				<c:if test="${not empty sessionScope.vo}">
					<input type="submit" class="btn btn-success" value="수정" />
					<a href="mypage"><input type="button" class="btn btn-info" value="돌아가기"></a>
				</c:if>
			</div>
		</form>
	</div>
		<c:if test="${updateTime gt 7 }">
		<script type="text/javascript">
			document.getElementById('nickname').readOnly = true
		</script>
	</c:if>
</body>
</html>