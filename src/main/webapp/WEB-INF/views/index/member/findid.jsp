<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
</head>
<body>
<div class="container" style="margin-top: 3%; width: 30%;" >
	<form action="idin" method="post">
		<div class="form-group">
  				<label class="col-form-label" for="inputDefault">이름</label>
				<input name="mb_name" class="form-control" type="text" required="required">
		</div>
		<div class="form-group">
  				<label class="col-form-label" for="inputDefault">이메일</label>
				<input name="mb_email" class="form-control" type="text" required="required">
		</div>
		<div class="form-group" align="right">
   			<input type="submit" class="btn btn-success" value="아이디 찾기">
  		</div>
	</form>
</div>
</body>
</html>