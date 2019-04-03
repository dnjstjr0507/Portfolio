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
<script type="text/javascript">
</script>
</head>
<body>
<div class="card mb-3">
		<div class="card-header">
		<i class="fas fa-table"></i>
         메뉴 <a href="javascript:void(0);" onclick="post_to_url('menuwrite', {'menu_type':'big'});" style="float: right;"><input type="button" value="메뉴 추가"></a>
         </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead align="center">
                    <tr>
                      <th>메뉴 이름</th>
                      <th>메뉴 사용</th>
                      <th>관리</th>
                    </tr>
                </thead>
                <tbody align="center">
					<c:if test="${empty list }">
						<tr>	
							<td colspan="8" align="center">
							<p>등록된 메뉴가 없습니다.</p>
							</td>
						</tr>
					</c:if>
					<c:if test="${not empty list }">
						<c:forEach var="menu" items="${list }">
							<tr>
								<td>
								<input type="hidden" value="${menu.menu_code }" >
								<input type="hidden" value="${menu.menu_sub }">
								<input type="hidden" value="${menu.menu_id }" name="menu_id">
								<c:if test="${menu.menu_type eq 'small' }">
									<img alt="smalltype" src="${pageContext.request.contextPath }/resources/img/arrow_right.png">
								</c:if>
								<c:out value="${menu.menu_name }"/></td>
								<td><c:if test="${menu.menu_use  eq 1}">사용함</c:if>
								<c:if test="${menu.menu_use  eq 0}">사용안함</c:if></td>
								<td>
								<c:if test="${menu.menu_type eq 'big' and menu.menulist_type eq 'group'}">
									<a href="javascript:void(0);" onclick="post_to_url('menuwrite', {'menu_type':'small','code':'${menu.menu_code}'});"><input type="button" value="추가"></a>
								</c:if>
								<input type="button" value="수정" onclick="post_to_url('menuview', {'menu_id':'${menu.menu_id }'});">
								<input type="button" value="삭제" onclick="post_to_url('deleteMenu',{'menu_id':'${menu.menu_id}'})">
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<tr>
					</tr>
			   	</tbody>
                </table>
				</div>
			</div>
	</div>
</body>
</html>