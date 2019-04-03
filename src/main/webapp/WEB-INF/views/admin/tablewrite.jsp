<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유 게시판</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/comm.js"></script>
<script type="text/javascript">
	$(function(){
		$("#name").focus();		
		
	});

	function optionCk(){
		var gb_subject = $('#gb_subject').val();
				$.ajax({
						url : "selectidx", 
						data : "gb_subject="+gb_subject, 
						success : function(data){
							if(data==null || data == 'empty')
								{
								$('input[name=gb_idx]').val(0);
								}
							else{
								$('input[name=gb_idx]').val(data);
							}
						} //success
					}); // ajax
	};
</script>
<style type="text/css">
	table {	width: 900px; margin: auto; padding: 5px; border: none; } 
    .title { font-size: 18pt; text-align: center; border: none;padding: 5px; }
    th { padding: 5px; background-color: silver; border: 1px solid gray;}
    td { padding: 5px; border: 1px solid gray;}
    /*
    tr:hover {  background-color: #ffff99;  }
    */
    a, a:hover{
		color: #000000;
		text-decoration: none;
	}
</style>
</head>
<body>
	<form action="writeOk" method="post">
		<table class="table">
			<tr>
				<td colspan="3" class="title">게시판 추가</td>
			</tr>
			<tr>
				<th style="background-color: #eeeeee; text-align: center">테이블</th>
				<th style="background-color: #eeeeee; text-align: center">그룹</th>
				<th style="background-color: #eeeeee; text-align: center">게시판이름</th>
			</tr>
			<tr>
				<td width="35%" align="center"><input type="text" name="bt_table" id="bt_table" size="25" required="required"></td>
				<td width="35%" align="center">
				<c:if test="${empty list }">
					<select name="gb_subject">
						<option value="">선택</option>
					</select>
				</c:if>
				<c:if test="${not empty list }">
					<select id="gb_subject" name="gb_subject" onchange="optionCk();">
						<option value="empty">선택</option>
						<c:forEach var="i" items="${list }">
							<option value="${i.gb_subject}">${i.gb_subject }</option>
						</c:forEach>
					</select>
				</c:if>
					<input type="hidden" name="gb_idx" value="0">
				</td>
				<td align="center"><input type="text" name="bt_subject" id="bt_subject" size="25" required="required"></td>
			</tr>
			<tr>
				<td colspan="3" align="right" style="border: none;">
					<input type="submit" value="저장하기">					
					<input type="button" value="다시쓰기" onclick="formReset();">					
					<input type="button" value="돌아가기" onclick="history.back(-1)">					
				</td>
			</tr>
		</table>
	</form>
</body>
</html>