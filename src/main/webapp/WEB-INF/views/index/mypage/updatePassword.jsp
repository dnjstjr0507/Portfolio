<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<script type="text/javascript">
	var pwvar = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,16}$/; // 비밀번호가 적합지 검사할 정규

	function passwordCK(){
		if($('#ajax_pw').val().length>=8){
			$.ajax({
				url : "passwordChek",
				data : "mb_password=" + $("#ajax_pw").val() ,
				success : function(data){
					if(data=='1' || data==1){
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
		if(!pwvar.test($('#mb_password').val())){
			alert('8~16자 한개의 특수문자를 넣어야 합니다.');
			return false;
		}
		if($('#mb_password').val()!=$('#PwequalCk').val()){
			alert('새비밀번호와 일치하지 않습니다.');
			return false;
		}
		
	 }
	
	$(function(){	
		$('#mb_password').keyup(function(){
			if(!pwvar.test($('#mb_password').val())){
				$('#mb_password').attr('class','form-control is-invalid');
				$('#pwMsg').html("8~16자 한개의 특수문자를 넣어야 사용가능 합니다.").css('color','red');
			}else{
				$('#mb_password').attr('class','form-control is-valid');
				if($('#ajax_pw').attr('class')!='form-control is-valid'){
					$('#pwMsg').html("현재비밀번호를 확인하세요.").css('color','red');
				}else{
					if($('#mb_password').val()!=$('#ajax_pw').val()){
						$('#pwMsg').html("사용가능한 비밀번호 입니다.").css('color','green');
					}else{
						$('#mb_password').attr('class','form-control is-invalid');
						$('#pwMsg').html("현재 비밀번호와 같습니다. ").css('color','red');
					}
				}	
			}
		});
		
		$('#PwequalCk').keyup(function(){
			if($('#mb_password').val()!=$('#PwequalCk').val()){
				$('#PwequalCk').attr('class','form-control is-invalid');
			}else{
				$('#PwequalCk').attr('class','form-control is-valid');
	  		}
		}); //#chpass.keyup
	});
	
</script> 
</head>
<body>
<div class="container" style="margin-top: 5%;">
	<div class="row">
		<div class="col-md-6 offset-md-3" style="border: 1px solid #dddddd; padding-left: 3%; padding-right: 3%; padding-top: 2%;">
			<fieldset>
				<legend>비밀번호 변경</legend>
					<form action="updatePasswordsuccess" method="post" onsubmit="return FormCheck();">
					<div class="form-group row">
						<div class="form-group has-success" style="width: 100%;" id="successCk">
								<label class="form-control-label" for="inputSuccess1" id="labelCk">현재 비밀번호</label>
								<input type="password" class="form-control" name="pwCk" id="ajax_pw" onkeyup="passwordCK()">
						</div>
						<div style="width: 100%;">
		 						<div class="form-group">
										<label for="exampleInputPassword1">새 비밀번호</label>
										<input type="password" name="mb_password" id="mb_password" class="form-control" maxlength="16">
										<span id="pwMsg" ></span>
		    					</div>
		 						<div class="form-group">
										<label for="exampleInputPassword1">새 비밀번호 확인</label>
										<input type="password" id="PwequalCk" class="form-control">
			    				</div>
			    				<div>
				    				<input type="submit" value="변경" style="float: right;">
				    			</div>
						</div>
	   				</div>
	    			</form>
			</fieldset>
		</div>
	</div>
</div>
</body>
</html>