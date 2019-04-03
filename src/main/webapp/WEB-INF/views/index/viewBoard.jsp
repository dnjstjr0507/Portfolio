<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유 게시판</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/board/board.css" >
<style type="text/css">
	@media screen and (max-width: 575px) {
		.minrow
		{
			padding-left: 10px;
			padding-right: 10px;
			margin-left: 0px
		}
	}
</style>
<script type="text/javascript">
	// 글 삭제
	function deleteCheck(){
		if(confirm("삭제 하시면 복구 할 수 없습니다. \n정말 삭제 하시겠습니까 ?"))
		post_to_url('deleteBoard', {'bt_table':'${bt_table }','mb_id':'${WriteVO.mb_id }','ab_idx':'${WriteVO.ab_idx }','m':'0','p':'${p }','s':'${s }','b':'${b }'});
	}
    // 댓글 저장
	function writeReply(form , content , type,bt_table,ab_idx,p,s,b){
		if($('#'+content).val() == "")
		{
			alert(type + ' 내용을 입력해주세요.');
			return false;
		}
		
	    var replycontent = $("#"+form).serialize();
	    $.ajax({
	        type:'POST',
	        url : "writeReply",
	        data: replycontent,
	        success : function(data){
	        		getReplyList(bt_table,ab_idx,p,s,b);
	        		list();
	        		$("#replycontent").val("");
	                $("textarea[id='ar_content']").val("");
	        },
	        error:function(request,status,error){
	            alert("댓글 작성 에러가 발생하였습니다. \n관리자에게 문의해 주세요.");
	       }
	        
	    });
	}
	
	// 댓글 수정	 
	function updateReply(form , content , type,bt_table,ab_idx,p,s,b){
		if($('#'+content).val() == "")
		{
			alert(type + ' 내용을 입력해주세요.');
			return false;
		}
		
		var replyupdate = $("#"+form).serialize();
		$.ajax({
	        type:'POST',
	        url : "updateReply",
	        data: replyupdate,
	        success : function(data){
	            	getReplyList(bt_table,ab_idx,p,s,b);
	            	list();
	        },
	        error:function(){
	            alert("댓글 수정 에러가 발생하였습니다. \n관리자에게 문의해 주세요.");
	       }
	        
	    });
	}

	// 댓글 삭제
	function deleteReply(mb_id,ar_idx,ab_idx,bt_table,p,s,b){
		
		var deleteReply = {"mb_id":mb_id,"ar_idx":ar_idx,"ab_idx":ab_idx,"bt_table":bt_table}
		
		$.ajax({
	        type:'POST',
	        url : "deleteReply",
	        data: deleteReply,
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
	        success : function(data){
	        	getReplyList(bt_table,ab_idx,p,s,b);
	        	list();
	        },
	        error:function(){
	            alert("댓글 삭제 에러가 발생하였습니다. \n관리자에게 문의해 주세요.");
	       }
	        
	    });
	}
	
	/**
	 * 초기 페이지 로딩시 댓글 불러오기
	 */
	$(function test(){
	    

		bt_table =$('#${bt_table }_bt_table').val(); 
		ab_idx =$('#${bt_table }_ab_idx').val();
		p =$('#${bt_table }_p').val();
		s =$('#${bt_table }_s').val();
		b =$('#${bt_table }_b').val();
		getReplyList(bt_table,ab_idx,p,s,b);
		list();
	    
	});
	 // 댓글 갯수 가져오기
	function list(){
		var countReply = {"bt_table":"${bt_table}","ab_idx":'${WriteVO.ab_idx}'}

	    $.ajax({
	        type:'POST',
	        url : "countReply",
	        data: countReply,
	        success : function(data){
	            if(data != null){
					$("#countReplyresult").html(data+'개');
					$("#countReplyresult2").html(data+'개');
	            } 
	        },
	        error:function(){
	            alert("댓글 갯수 에러가 발생하였습니다. \n관리자에게 문의해 주세요.");
	       }
	        
	    });
	}
	/**
	 * 댓글 불러오기(Ajax)
	 */
	function getReplyList(bt_table,ab_idx,p,s,b){
		var paging = {"bt_table":bt_table,"ab_idx":ab_idx,"p":p,"s":s,"b":b}
	    $.ajax({
	        type:'POST',
	        url : "listReply",
	        data: paging,
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
	        success : function(data){
	            if(data != null){
	            	$("#refldiv").html(data); //div에 받아온 값을 넣는다.
	            	
	            	$('#${bt_table }_p').val(p); 
	        		$('#${bt_table }_s').val(s); 
	        		$('#${bt_table }_b').val(b); 
	            } 
	        },
	        error:function(){
	            alert("댓글 불러오는 과정에서 에러가 발생하였습니다. \n관리자에게 문의해 주세요.");
	       }
	        
	    });
	}
	
	
	
	 
</script>
</head>
<body>
	<form id="replydata" method="post">
    	<input type="hidden" name="bt_table" id="${bt_table }_bt_table" value="${bt_table }">
		<input type="hidden" name="ab_idx" id="${bt_table }_ab_idx" value="${WriteVO.ab_idx }">
	</form>
	<div class="container" style="border: 1px solid; padding: 2%; margin-top: 3%; margin-bottom: 3%;">
	<div class="row" style="height: 150px; width: auto;">
		<div class="col align-self-center">
			<h1 align="center"><span>${WriteVO.ab_subject }</span></h1>
		</div>
	</div>
	<div style="background-color: #F5F5F5; height: 40px;">
	<span>
		<i class="material-icons md-18">account_circle</i>
		<span><c:out value="${WriteVO.mb_nickname }"/></span>
	</span>
		&nbsp;
		<span>
		<i class="material-icons md-18">chat_bubble_outline</i>
			<span id="countReplyresult"></span>
		</span>
		&nbsp;
		<span>
			<i class="material-icons  md-18">visibility</i>
			<span>${WriteVO.ab_hit }회 </span>
		</span>
		&nbsp;
			<span style="float: right;">
			<i class="material-icons md-dark md-inactive">query_builder</i>
			<c:if test="${empty WriteVO.ab_updatetime }">
				<span><fmt:formatDate value="${WriteVO.ab_datetime }" pattern="yyyy.MM.dd HH:mm"/></span>
			</c:if>
			<c:if test="${not empty WriteVO.ab_updatetime }">
				<span>(수정)<fmt:formatDate value="${WriteVO.ab_updatetime }" pattern="yyyy.MM.dd HH:mm"/></span>
			</c:if>
		</span>
	</div>
	<c:if test="${not empty fileslist}">
	<div style="border: 1px solid;">
		<span>첨부파일 목록</span>
		<div>
			<c:forEach var="file" items="${fileslist }" varStatus="var">
			<c:if test="${not empty file}">
				${var.count }. ${file.file_original }
				<c:url value="down" var="url">
						<c:param name="o" value="${file.file_original }"/>	
						<c:param name="s" value="${file.file_subfile }"/>	
				</c:url>
					<a href="${url }">다운</a><br>
			</c:if>
			</c:forEach>
		</div>
	</div>
	</c:if>
	<div class="border border-white" style="min-height: 200px;">
			<c:set var="c" value="${WriteVO.ab_content }"/>				
			<c:set var="c" value='${fn:replace(c, "<", "&lt;") }'/>				
			<c:set var="c" value='${fn:replace(c, newLine, br) }'/>				
			${c }
	</div>
	<div style=" height: 50px;">
		<input type="hidden" name="WriteVO.ab_ip" value="${WriteVO.ab_ip }"> 
		<div class="col align-self-center" align="right">
			<c:if test="${sessionScope.vo.mb_id eq WriteVO.mb_id or sessionScope.vo.mb_id eq WriteVO.mb_id eq 'admin'}">
				<c:if test="${sessionScope.vo.mb_lev eq 1 or sessionScope.vo.mb_lev eq 99 }">
					<input type="button" value="수정하기" onclick="post_to_url('updateBoard', {'bt_table':'${bt_table }','ab_idx':'${WriteVO.ab_idx }','m':'0','p':'${p }','s':'${s }','b':'${b }'});">
					<input type="button" value="삭제하기" onclick="deleteCheck()">
				</c:if>					
			</c:if>
				<input type="button" value="목록" onclick="post_to_url('listBoard', {'bt_table':'${bt_table }','p':'${p }','s':'${s }','b':'${b }'});">				
		</div>
	</div>
	<div class="row minrow" style="margin: 1%; border: 1px;">
		<c:if test="${not empty sessionScope.vo}">
			<form id="replycontent" style="padding: 0px; height:100%; width: calc(100% - 100px);">
			<div>
				<input type="hidden" name="bt_table" value="${bt_table }">
				<input type="hidden" name="ab_idx" value="${WriteVO.ab_idx }">
				<input type="hidden" name="ar_parents" value="0">
				<input type="hidden" name="ar_lev" value="1">
				<input type="hidden" name="mb_id" value="${sessionScope.vo.mb_id }">
				<input type="hidden" name="mb_nickname" value="${sessionScope.vo.mb_nickname }">
    			<textarea name="ar_content" id="ar_content" style="width:100%; height:100%; resize: none;" placeholder="댓글을 입력하세요." required="required"></textarea>
  			</div>
  			</form>
  			<div style="padding: 0px;width: 20%;max-width: 100px;">
   				<input type="button" onclick="writeReply('replycontent' , 'ar_content' , '댓글','${bt_table }','${WriteVO.ab_idx }','${p }','${s }','${b }')" value="댓글저장" style="width:100%; height:100%;">
			</div>
    	</c:if>
    	<c:if test="${empty sessionScope.vo}">
    		<div style="width: 100%; height: 100%; margin-bottom: 3%; margin-top: 3%;" align="center">
    			로그인한 회원만 댓글 등록이 가능합니다.
    		</div>
    	</c:if>
	</div>
	<div style="width: 100%;">
		&nbsp;&nbsp;
		<i class="material-icons md-18">chat_bubble_outline</i>
		<span>댓글</span>: (<span id="countReplyresult2"></span>)
	</div>
	<input type="hidden" id="${bt_table }_p" value="1">
	<input type="hidden" id="${bt_table }_s" value="10">
	<input type="hidden" id="${bt_table }_b" value="10">
	<div class="row" id="refldiv" style="border:1px solid; margin-top:20px; min-height: 50px; margin: 1%; background-color: WhiteSmoke;" >
	
	</div>
</div>
</body>
</html>