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
	function deleteCheck(idx){
		if(confirm('삭제 하시겠습니까 ?')){
			post_to_url('deleteGroupOK', {'gb_idx':idx});
		}
	}
</script>
</head>
<body>
<div class="card mb-3">
		<div class="card-header">
		<i class="fas fa-table"></i>
       	  그룹 관리 <a href="javascript:void(0);" onclick="post_to_url('addGroup', {});" style="float: right;"><input type="button" value="그룹 추가"></a> 
       	  </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead align="center">
                    <tr>
                      <th>그룹 이름</th>
				      <th>그룹 제목</th>
				      <th>관리</th>
                    </tr>
                </thead>
	            <tbody align="center">
				<c:if test="${empty list }">
					<tr>
						<td colspan="3" align="center">
							그룹이 없습니다.
						</td>
					</tr>
				</c:if>
				<c:if test="${not empty list }">
				<c:forEach var="vo" items="${list }">
				<tr>
					<td><c:out value="${vo.gb_id }"/></td>
					<td><c:out value="${vo.gb_subject }"/></td>
					<td>
					<input type="button" value="수정" onclick="post_to_url('updateGroup', {'gb_idx':'${vo.gb_idx }'});">
					<input type="button" value="삭제" onclick="deleteCheck(${vo.gb_idx})"></td>
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