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
</head>
<body>
	<form action="tableupdate" method="post">
	<div class="card-header">
	<span>그룹 추가</span>
		<input type="submit" value="수정" style="float: right;">
        </div>
		<div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead align="center">
                    <tr>
				      <th>테이블명</th>
				      <th>그룹</th>
				      <th>게시판 제목</th>
				    </tr>
				  </thead>
				  <tbody>
				  	<tr align="center">
				  		<td><input type="text" name="bt_table" value="${vo.bt_table }" required="required" readonly="readonly"></td>
						<td><input type="text" name="gb_subject" value="${vo.gb_subject }" readonly="readonly"></td>
						<td><input type="text" name="bt_subject" value="${vo.bt_subject }"></td>
				  	</tr>
				  </tbody>
			   </table>
			</div>
        </div>
</form>
</body>
</html>