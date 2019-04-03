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
</head>
<body>
	<div id="menu_frm" class="new_win">
    <h1>메뉴 추가</h1>
	<form method="post"  id="test">
    <div class="new_win_desc">
        <label>대상선택</label>
        <select id="me_type" name="me_type" onchange="$('#test').submit();">
            <option value="">선택</option>
            		<c:if test="${menu_type ne 'small' }">
            	<option value="gblist">게시판그룹</option>
            		</c:if>
	            	<c:if test="${menu_type eq 'big' or menu_type eq 'small' }">
	           	<option value="btlist">게시판</option>
    	        	</c:if>
        </select>
    </div>
    <input type="hidden" name="menu_type" value="${menu_type }">
    <c:if test="${not empty code }">
    	<input type="hidden" name="code" value="${code }">
    </c:if>
    </form>
    
    <div id="menu_result">
		<c:if test="${me_type=='gblist'}">
				<div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead align="center">
                    <tr>
				      <th>그룹 제목</th>
				      <th>선택</th>
				    </tr>
				  </thead>
				  <tbody>
				  		<c:if test="${empty gblist }">
					  		<tr>
				  				<td colspan="2" align="center">그룹이 없습니다.</td>
				  			</tr>
				  		</c:if>
				  		<c:if test="${not empty gblist }">
							<c:forEach var="list" items="${gblist }">
								<tr align="center">
									<td>${list.gb_subject }</td>
									<td>
										<c:if test="${menu_type eq 'big' or menu_type ne 'small' }">
											<input type="button" value="선택" onclick="post_to_url('insertmenusuccess', {'menu_code':'${menu_code+1}','menu_sub':'0','menu_name':'${list.gb_subject }','bt_table':'','menu_type':'${menu_type }','menulist_type':'group','menu_use':'1'});">
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</c:if>
				  </tbody>
			   </table>
			  </div>
             </div>
		</c:if>
		<c:if test="${me_type=='btlist'}">
			<div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead align="center">
                    <tr>
				      <th>게시판 제목</th>
				      <th>선택</th>
				    </tr>
				  </thead>
				  <tbody>
				  	<c:if test="${empty btlist }">
				  		<tr>
				  			<td colspan="2" align="center">게시판이 없습니다.</td>
				  		</tr>
				  	</c:if>
				  	<c:if test="${not empty btlist }">
						<c:forEach var="list" items="${btlist }">
							<tr align="center">
								<td>${list.bt_subject }</td>
								<td>
								<c:if test="${menu_type eq 'small' }">
									<input type="button" value="선택" onclick="post_to_url('insertmenusuccess', {'menu_code':'${code}','menu_sub':'${code2 }','menu_name':'${list.bt_subject }','bt_table':'${list.bt_table }','menu_type':'${menu_type }','menulist_type':'board','menu_use':'1'});">
								</c:if>
								<c:if test="${menu_type eq 'big' }">
								 	<input type="button" value="선택" onclick="post_to_url('insertmenusuccess', {'menu_code':'${menu_code+1}','menu_sub':'0','menu_name':'${list.bt_subject }','bt_table':'${list.bt_table }','menu_type':'${menu_type }','menulist_type':'board','menu_use':'1'});">
								 </c:if>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				  </tbody>
			   </table>
			  </div>
             </div>
		</c:if>
    </div>
</div>
</body>
</html>