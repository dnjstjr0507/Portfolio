<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
</head>
<body>
<div class="container" style="margin-top: 3%; width: 30%;" >
	<form action="findpwOk" method="post">
		<div class="form-group">
  				<label class="col-form-label" for="inputDefault">아이디</label>
  				<input name="mb_id" id="mb_id" class="form-control" type="text" required="required">
		</div>
		<div class="form-group">
  				<label class="col-form-label" for="inputDefault">이메일</label>
				<input name="mb_email" id="mb_email" class="form-control" type="text" required="required">
		</div>
		<div class="form-group" align="right">
   			<input type="submit" class="btn btn-success" value="비밀번호 찾기" >
  		</div>
	</form>
</div>
</body>
</html>