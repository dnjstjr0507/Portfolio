<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="GroupupdateOk" method="post">
	<div class="card-header">
	<span>그룹 추가</span>
		<input type="submit" value="수정" style="float: right;">
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
				  		<td>
				  		<input name="gb_idx" type="hidden" value="${groupBoardVO.gb_idx }">
						<input name="gb_id" type="text" value="${groupBoardVO.gb_id }"></td>
						<td><input name="gb_subject" type="text" value="${groupBoardVO.gb_subject }"></td>
				  	</tr>
				  </tbody>
			   </table>
			</div>
      </div>
</form>
</body>
</html>