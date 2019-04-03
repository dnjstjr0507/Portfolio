<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<meta charset="UTF-8">
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
<a href="index/join">회원가입</a>
<a href="index/signin">로그인</a>
<a href="index/updateMember">회원정보 수정</a>
<a href="index/deleteOk">회원정보 삭제</a>
<a href="index/findid">아이디 찾기</a>
<a href="index/findpw">비밀번호 찾기</a>
<a href="admin/intercept">회원 차단하기</a>
<a href="admin/tablelist">테이블생성 리스트</a>


</body>
</html>
 