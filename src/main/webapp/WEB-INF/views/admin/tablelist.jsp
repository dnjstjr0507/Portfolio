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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/comm.js"></script>
<script type="text/javascript">
	$(function(){
		
	});
	
	function deleteCheck(idx){
		if(confirm('삭제 하시겠습니까 ?')){
			post_to_url('tabledelete',{'bt_idx': idx });
		}
	}
	function CheckAll() {
		$("[id^=ck]").prop("checked",$("#checkAll").is(":checked"));
	}

</script>
</head>
<body>
	<div class="card mb-3">
		<div class="card-header">
		<i class="fas fa-table"></i>
         게시판 관리 <a href="javascript:void(0);" onclick="post_to_url('tablewrite', {});" style="float: right;"><input type="button" value="게시판 추가"></a>
         </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead align="center">
                    <tr>
                      <th><input name="ch" type="checkbox" id="checkAll" onclick="CheckAll()"></th>
                      <th>테이블</th>
                      <th>그룹</th>
                      <th>게시판이름</th>
                      <th>관리</th>
                    </tr>
                </thead>
                <tbody align="center">
					<c:if test="${empty list }">
						<tr>	
							<td colspan="5" align="center">
							<p>등록된 게시판이 없습니다.</p>
							</td>
						</tr>
					</c:if>
					<c:if test="${not empty list }">
						<c:forEach var="vo" items="${list }" varStatus="vs">
						<tr>
							<td><input name="chk[]" type="checkbox" id="ck${vs.index }" value="${vo.bt_idx }"></td>
							<td><c:out value="${vo.bt_table}"/></td>
							<td><c:out value="${vo.gb_subject}"/></td>
							<td><c:out value="${vo.bt_subject}"/></td>
							<td>
							<input type="button" value="수정" onclick="post_to_url('tableview', {'bt_idx':'${vo.bt_idx }'});">
							<input type="button" value="삭제" onclick="deleteCheck(${vo.bt_idx})">
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