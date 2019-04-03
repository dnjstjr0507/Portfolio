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
		$("#name").focus();		
		
	});
	
	function filedelete(file_idx){
		$('#file'+file_idx).css('display','none');
		$('<input type="hidden" name="file_idx" value="'+file_idx+'"><br>').appendTo("#fileBoxs");
	}
	
	$(function(){
		   var cnt = ${filecount};
		   var length = $("#files").length;
		   $("#fileAppend").click(function() {
		      if(cnt<4){
		         cnt++;
		         $('a').val = cnt;
		         $('<input type="file" name="files[' + cnt + '].file"><br>').appendTo("#fileBox");

		      }else{
		         alert('최대 5개까지만 가능합니다.');
		      }
		   });
		   $("#fileRemove").click(function() {
		      if(cnt<=${filecount}){
		         alert('최소 1개는 필요 합니다.');
		      }else{
		         $('#fileBox input').last().remove();
		         $('#fileBox br').last().remove();
		         cnt--;
		      }
		   });
		});
	
	// 폼의 내용을 지우고 커서를 이름입력하는 곳으로 이동
	function formReset(){
		$("#subject").val("");
		$("#content").val("");
	}
	// 폼의 내용의 유효성을 검사하는 함수
	function formCheck(){
		var subject = $("#subject").val();
		if(subject==null || subject.trim().length==0){
			alert('제목은 반드시 입력해야 합니다.');
			$("#subject").focus();
			return false;
		}
		var content = $("#content").val();
		if(content==null || content.trim().length==0){
			alert('내용은 반드시 입력해야 합니다.');
			$("#content").focus();
			return false;
		}
		return true;		
	}
	
	function deletefile(){
		
	}
</script>
</head>
<body>
<div class="container" style="margin-top: 3%;">
	<form action="updateSuccess" method="post" onsubmit="return formCheck();" id="myForm" enctype="multipart/form-data">
			유노? ${file_idx}
			<input type="hidden" name="p" value="${p }">
			<input type="hidden" name="s" value="${s }">
			<input type="hidden" name="b" value="${b }">
			<input type="hidden" name="m" value="0">
			<input type="hidden" name="mb_id" value="${updateVO.mb_id }">
			<input type="hidden" name="ab_idx" value="${updateVO.ab_idx }">
			<input type="hidden" name="bt_table" value="${bt_table }">
		<h1 align="center">수정</h1>
		<div class="form-group">
			<label for="exampleInputEmail1">제목</label>
			<input type="text" name="ab_subject" id="subject" value="${updateVO.ab_subject }" style="width: 100%;">
		   </div>
		   <div class="form-group">
			<label for="exampleInputEmail1">첨부파일</label><input type="button" id="fileAppend" value="+"> <input type="button" id="fileRemove" value="-">
			<div id="fileBox">
				<input type="file" name="files[0].file"><br>
			</div>
			<c:if test="${not empty fileslist }">
			<label for="exampleInputEmail1">첨부파일 목록</label>
			<div id="fileBoxs">
				<c:forEach var="file" items="${fileslist }" varStatus="var">
					<div id="file${file.file_idx }">
						${var.count }
						<c:out value="${file.file_original }">${file.file_original }</c:out>
						<a onclick="filedelete(${file.file_idx})">삭제</a><br>
					</div>
				</c:forEach>
			</div>
		</c:if>
    </div>
	<div class="form-group">
		<label for="exampleTextarea">내용</label>
		<textarea name="ab_content" style="width: 100%; padding-bottom:30%; resize:none;" id="content" maxlength="2000"> ${updateVO.ab_content }</textarea>	
	</div>
	<div class="form-group" align="right">					
		<input type="submit" value="수정하기">					
		<input type="button" value="다시쓰기" onclick="formReset();">					
		<input type="button" value="돌아가기" onclick="post_to_url('viewBoard', {'bt_table':'${bt_table }','ab_idx':'${updateVO.ab_idx }','p':'${p }','s':'${s }','b':'${b }'});">	
	</div>	
					
	</form>
	
</div>	
</body>
</html>