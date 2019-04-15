<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><sitemesh:write property='title'/></title>
<link rel="stylesheet" href="https://getbootstrap.com/docs/4.2/dist/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/comm.js"></script>
<sitemesh:write property='head'/>
</head>
<body>
	<div class="bodysit">
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	  <div class="container" >
	    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample07" aria-controls="navbarsExample07" aria-expanded="true" aria-label="Toggle navigation">
	      <span class="navbar-toggler-icon"></span>
	    </button>
	
	    <div class="navbar-collapse collapse show" id="navbarsExample07">
	      <ul class="navbar-nav mr-auto">
	        <li class="nav-item active">
	          <a class="nav-link" href="${pageContext.request.contextPath }/">Home</a>
	        </li>
	        <c:if test="${empty mlist }">
	        	&nbsp;&nbsp; 
	        </c:if>
	        <c:if test="${not empty mlist }">
			<c:forEach var="list" items="${mlist }">
				<div class="dropdown">
				<c:if test="${fn:length(list) ne 1 and not empty list }">
					<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						${list[0].menu_name }
					</a>
					<c:if test="${not empty list[0] }">
					<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
						<c:forEach var="vo" begin="1" items="${list }" end="${fn:length(list)-1 }">
							<a class="dropdown-item" onclick="post_to_url('listBoard', {'bt_table':'${vo.bt_table }'});">${vo.menu_name }</a>
						</c:forEach>
					</div>
					</c:if>
				</c:if>
				</div>
				<c:if test="${fn:length(list) eq 1 }">
					<c:if test="${empty list[0].bt_table }">
						<li class="nav-item active">
						</li>					
					</c:if>
					<c:if test="${not empty list[0].bt_table }">
						<li class="nav-item active">
							<a class="nav-link" onclick="post_to_url('listBoard', {'bt_table':'${list[0].bt_table }'});">${list[0].menu_name }</a>
						</li>					
					</c:if>
				</c:if>
			</c:forEach>
			</c:if>
        </ul>
        <ul class="navbar-nav navbar-right">
	        <c:if test="${empty sessionScope.vo}">
	       	 <li>
	        	<a class="nav-link" href="signin">로그인</a>
	       	 </li>
	       	 </c:if>
			 <c:if test="${not empty sessionScope.vo}">
			 	<c:if test="${not empty sessionScope.vo and sessionScope.vo.mb_lev eq 99 }">
			 		<a class="nav-link" href="${pageContext.request.contextPath }/admin/listGroup">관리자페이지</a>
			 	</c:if>
			 	<a class="nav-link" href="mypage">마이페이지</a>
			 	<a class="nav-link" href="logout">로그아웃</a>
	       	 </c:if>
		</ul>
		</div>
	  </div>
	</nav>
		<sitemesh:write property='body'/>
	</div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
	
</body>
</html>
