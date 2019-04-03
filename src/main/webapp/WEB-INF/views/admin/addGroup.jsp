<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그룹 추가</title>
</head>
<body>
<form action="insertGroup" method="post">
	<div class="card-header">
	<span>그룹 추가</span>
		<input type="submit" value="저장" style="float: right;">
        </div>
		<div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead align="center">
                    <tr>
				      <th>그룹 아이디</th>
				      <th>그룹 제목</th>
				    </tr>
				  </thead>
				  <tbody>
				  	<tr align="center">
				  		<td><input name="gb_id" id="" type="text" required="required"></td> 
						<td><input name="gb_subject" id="" type="text" required="required"></td>
				  	</tr>
				  </tbody>
			   </table>
			</div>
        </div>
</form>
</body>
</html>