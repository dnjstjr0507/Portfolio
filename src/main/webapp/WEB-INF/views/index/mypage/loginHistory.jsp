<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 기록</title>
</head>
<body>
<div class="container" style="margin-top: 5%;">
	<div class="row">
	<table class="table table-hover" style="text-align: center; border: 1px solid #dddddd;">
		<thead class="thead-dark">
		    <tr style="width: 100%" align="center">
		      <th>로그인 시간</th>
		      <th>IP</th>
		    </tr>
	    </thead>
	    <tbody>
			<c:if test="${paging.totalCount==0}">
				<tr class="table-light">
					<td colspan="2" align="center">
						<strong>등록된 글이 없습니다.</strong>
					</td>
				</tr>
			</c:if>
			<c:if test="${paging.totalCount>0}">
				<c:if test="${not empty paging.lists }">
					<c:set var="no" value="${paging.totalCount - (paging.currentPage-1) * paging.pageSize }"/>
						<c:forEach var="vo" items="${paging.lists }" varStatus="vs">
							<tr class="table-light" align="center">
		      					<td><fmt:formatDate value="${vo.hs_login }" pattern="yyyy/MM/dd HH:mm"/> </td>
								<td>${vo.hs_ip }</td>
							</tr>
						</c:forEach>
				</c:if>
			</c:if>
	    </tbody>
	</table>
	</div> 
	<div style="float: right;">
		<c:if test="${not empty sessionScope.vo}">
			<a href="mypage"><input type="button" class="btn btn-info" value="돌아가기"></a>
		</c:if>
	</div>
	<nav aria-label="Page navigation example" style="margin-top: 50px; width: auto;">
		 <ul class="pagination justify-content-center">
			 <%-- 이전 --%>
			 <c:if test="${paging.startPage>1 }">
			 	  <li class="page-item disabled">
			 	  	<a class="page-link" onclick="post_to_url('loginHistory', {'mb_id':'${sessionScope.vo.mb_id }','p':'${paging.startPage-1 }','s':'${paging.pageSize }','b':'${paging.blockSize }'});">이전</a>
			 	  </li>  
			 </c:if>
			 <%-- 페이지 번호 목록 --%>
			 <c:if test="${paging.totalCount>0 }">
			 	<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage }">
			 		<c:if test="${i==paging.currentPage }">
			 		 <li class="page-item"><a class="page-link">${i }</a></li>  
			 		</c:if>
			 		<c:if test="${i!=paging.currentPage }">
						 <li class="page-item">
						 	<a class="page-link" onclick="post_to_url('loginHistory', {'mb_id':'${sessionScope.vo.mb_id }','p':'${i }','s':'${paging.pageSize }','b':'${paging.blockSize }'});">${i }</a>
						 	</li>  
			 		</c:if>
			 	</c:forEach>
			 </c:if>
			 <%-- 다음 --%>
			 <c:if test="${paging.endPage<paging.totalPage }">
			 	<li class="page-item">
			 		<a class="page-link" onclick="post_to_url('loginHistory', {'mb_id':'${sessionScope.vo.mb_id }','p':'${paging.endPage+1 }','s':'${paging.pageSize }','b':'${paging.blockSize }'});">다음</a>
			 	</li> 
			 </c:if>
		</ul>
	</nav>
</div>
</body>
</html>