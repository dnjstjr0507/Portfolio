<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container" style="margin-top: 3%;">
	<div class="jumbotron">
  		<h5 class="display-4" style="margin-bottom: 10%;">아이디 조회 결과</h5>
  		<c:if test="${not empty mb_id and mb_lev ge 0}">
  			<p class="lead">회원님의 찾으시는 아이디 입니다.</p>
			 	<hr class="my-4">
 			<p align="center" style="font-size: 2.5rem;"><c:out value="${mb_id }"/></p>
 		</c:if>
		<c:if test="${empty mb_id}">
			<hr class="my-4">
			<p class="lead" align="center">일치하는 정보가 없습니다.</p>
		</c:if>
	  	<c:if test="${not empty mb_id and mb_lev le -1}">
	  		<hr class="my-4">
			<p class="lead" align="center">조회하신 아이디는 회원탈퇴한 아이디 입니다.</p>
		</c:if>
	</div>
</div>
</body>
</html>