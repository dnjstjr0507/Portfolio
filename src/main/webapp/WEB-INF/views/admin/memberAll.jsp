<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/comm.js"></script>
<style type="text/css">
	.fixed{
		position: fixed;
	}
</style>
</head>
<body>
	<div class="card mb-3">
		<div class="card-header">
		<i class="fas fa-table"></i>
       	  회원 관리 
       	  </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead align="center">
                    <tr>
                      <th>아이디</th>
                      <th>이메일</th>
                      <th>이름</th>
                      <th>닉네임</th>
                      <th>권한</th>
                      <th>생년월일</th>
                      <th>가입일</th>
                      <th>관리</th>
                    </tr>
                </thead>
	            <tbody align="center">
				<c:if test="${empty membervo }">
					<tr>
						<td colspan="8">
							회원이 없습니다
						</td>
					</tr>
				</c:if>
				<c:if test="${not empty membervo }">
					<c:forEach var="vo1" items="${membervo }">
					<tr>
						<td><c:out value="${vo1.mb_id }"/></td>
						<td><c:out value="${vo1.mb_email }"/></td>
						<td><c:out value="${vo1.mb_name }"/></td>
						<td><c:out value="${vo1.mb_nickname }"/></td>
						<td><c:out value="${vo1.mb_lev }"/></td>
						<td><c:out value="${vo1.mb_yy } 년 ${vo1.mb_mm }월 ${vo1.mb_dd }일"/></td>
						<td><fmt:formatDate value='${vo1.mb_joindate }' pattern='yyyy.MM.dd HH:mm'/></td>
						<td><input type="submit" onclick="post_to_url('intercept', {'mb_id':'${vo1.mb_id}'});" value="차단"></td>
					</tr>
					</c:forEach>
				</c:if>
				</tbody>
                </table>
				</div>
			</div>
	</div>
</body>
</html>