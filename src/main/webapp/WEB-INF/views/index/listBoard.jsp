<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유 게시판</title>
<script type="text/javascript">
	$(function(){
	});
</script>
</head>
<body>
<div class="container" style="margin-top: 3%;">
	<div align="right">
		<span>${paging.pageInfo }</span>
	</div>
	<div class="row">
		<table class="table table-hover" style="text-align: center; border: 1px solid #dddddd;">
			<thead class="thead-dark">
				<tr>
					<th scope="col">번호</th>
					<th width="65%">제목</th>
					<th scope="col">이름</th>
					<th scope="col">날짜</th>
					<th scope="col">조회수</th>
				</tr>
			</thead>
		<tbody>
			<c:if test="${paging.totalCount==0}">
				<tr>
					<td colspan="5">
						<strong>등록된 글이 없습니다.</strong>
					</td>
			</tr>
			</c:if>
			<c:if test="${paging.totalCount>0}">
				<c:if test="${not empty paging.lists }">
					<c:set var="no" value="${paging.totalCount - (paging.currentPage-1) * paging.pageSize }"/>
						<c:forEach var="vo" items="${paging.lists }" varStatus="vs">
							<tr>
								<td scope="row">${no-vs.count+1 }</td>
								<td align="left">
					 				<span style="cursor: pointer;" onclick="post_to_url('viewBoard', {'bt_table':'${bt_table }','ab_idx':'${vo.ab_idx }','p':'${paging.currentPage }','s':'${paging.pageSize }','b':'${paging.blockSize }','m':'1'});">
						 				<c:out value="${vo.ab_subject }"/><span id="countReplyresult"></span>
									</span>
								</td>
								<td scope="row">${vo.mb_nickname }</td>
								<td scope="row"><fmt:formatDate value="${vo.ab_datetime }" pattern="yy.MM.dd"/></td>
								<td scope="row">${vo.ab_hit }</td>
							</tr>
						</c:forEach>
				</c:if>
			</c:if>
		</tbody>
	</table>
	</div>
	<div style="float: right;">
		<c:if test="${not empty sessionScope.vo}">
			<input type="button" value="글쓰기"  onclick="post_to_url('writeBoard', {'bt_table':'${bt_table }','p':'${paging.currentPage }','s':'${paging.pageSize }','b':'${paging.blockSize }'});">
		</c:if>
	</div>
	<nav aria-label="Page navigation example" style="margin-top: 50px; width: auto;">
		 <ul class="pagination justify-content-center">
			 <%-- 이전 --%>
			 <c:if test="${paging.startPage>1 }">
			 	  <li class="page-item">
			 	  	<a class="page-link" onclick="post_to_url('listBoard', {'bt_table':'${bt_table }','p':'${paging.startPage-1 }','s':'${paging.pageSize }','b':'${paging.blockSize }'});">이전</a>
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
						 	<a class="page-link" onclick="post_to_url('listBoard', {'bt_table':'${bt_table }','p':'${i }','s':'${paging.pageSize }','b':'${paging.blockSize }'});">${i }</a>
						 	</li>  
			 		</c:if>
			 	</c:forEach>
			 </c:if>
			 <%-- 다음 --%>
			 <c:if test="${paging.endPage<paging.totalPage }">
			 	<li class="page-item">
			 		<a class="page-link" onclick="post_to_url('listBoard', {'bt_table':'${bt_table }','p':'${paging.endPage+1 }','s':'${paging.pageSize }','b':'${paging.blockSize }'});">다음</a>
			 	</li> 
			 </c:if>
		</ul>
	</nav>
</div>
</body>
</html>