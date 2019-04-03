<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>
</head>
<body>
<div class="container" style="margin-top: 5%;">
  	<div class="row">
    	<div class="col">
			<div class="card bg-light mb-3">
			  <div class="card-header"><h4 class="card-title">회원정보</h4></div>
			  <div class="card-body">
			    <p class="card-text">회원정보를 수정하고 확인 할 수 있습니다.</p>
			   	<input type="button" value="수정" onclick="post_to_url('updateMember',{'mb_id':'${sessionScope.vo.mb_id}'})" style="float: right;">
			  </div>
			</div>
		</div>
    	<div class="col">
			<div class="card bg-light mb-3">
			  <div class="card-header"><h4 class="card-title">비밀번호 변경</h4></div>
			  <div class="card-body">
			    <p class="card-text">비밀번호를 변경 가능합니다.</p>
			   	<input type="button" value="수정" onclick="post_to_url('updatePassword',{'mb_id':'${sessionScope.vo.mb_id}'})" style="float: right;">
			  </div>
			</div>
		</div>
	<div class="w-100"></div>
		<div class="col">
			<div class="card bg-light mb-3">
			  <div class="card-header"><h4 class="card-title">로그인 기록</h4></div>
				<div class="card-body">
			    <p class="card-text">로그인 기록을 확인 할 수 있습니다.</p>
			   	<input type="button" value="보기" onclick="post_to_url('loginHistory',{'mb_id':'${sessionScope.vo.mb_id}'})" style="float: right;">
		  		</div>
			</div>
		</div>
		<div class="col">
			<div class="card bg-light mb-3">
			  <div class="card-header"><h4 class="card-title">회원 탈퇴</h4></div>
			  <div class="card-body">
			    <p class="card-text">회원탈퇴 할 수 있습니다.</p>
			   	<input type="button" value="수정" onclick="post_to_url('deleteMember',{'mb_id':'${sessionScope.vo.mb_id}'})" style="float: right;">
			  </div>
			</div>
		</div>
	</div>
	<c:if test="${not empty result and result==0 }">
		<script type="text/javascript">
			alert('현재 비밀번호가 일치하지 않습니다.')		
		</script>
	</c:if>
</div>
</body>
</html>