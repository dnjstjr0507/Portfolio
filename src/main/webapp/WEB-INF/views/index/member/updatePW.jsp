<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="updatePWOk" method="post">
		<div>
			<input type="hidden" name="mb_id" value="${mb_id }">
			<input type="hidden" name="setkey" value="${setkey }">
			
			<label for="password">비밀번호</label>
			<input name="mb_password" id="pw" placeholder="Password" type="password" required="required" maxlength="20" />
			<span id="pwMsg" color=""></span>
		</div>
		<div>
			<label for="password">비밀번호 확인</label> <input name="password2"	id="chpw" placeholder="Password" type="password" required="required" maxlength="20" /> 
			<span id="pwChMsg" color=""></span>
		</div>
		<input type="submit" value="비밀번호 재설정">
	</form>
</body>
</html>