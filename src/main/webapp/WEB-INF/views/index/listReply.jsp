<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
	<script type="text/javascript">
	function Reply(reply,updatereply,content)
	{
		if($('#'+reply).css('display') == "none")
		{
			if($('#'+updatereply).show()){
				$('#'+updatereply).hide();
				$('#'+content).css('display','');
			}
			$('#'+reply).show();
		}
		else
		{
			$('#'+reply).hide();		
		}
	}
	
	function update(updatereply,reply,content)
	{ 
		if($('#'+updatereply).css('display') == "none")
		{
			if($('#'+reply).show()){
				$('#'+reply).hide();
			}
			$('#'+updatereply).show();	
			$('#'+content).css('display','none');
		}
		else
		{
			$('#'+updatereply).hide();		
			$('#'+content).css('display','');
		}
	}
	</script>
<html>
<style>
.offset-md-1
{
margin: 1%; 
max-width: 100%;
padding-top:1%; 
border-top: 1px solid;
margin-left: 7%;
}

</style>
<body>
	<c:if test="${pagingReply.totalCount==0}">
		<div class="col-sm-12" id="replylist" align="center">
			<strong>댓글이 없습니다.</strong>
		</div>
	</c:if>
	<c:if test="${pagingReply.totalCount>0}">
		<c:if test="${not empty pagingReply.lists }">
			<c:set var="no" value="${pagingReply.totalCount - (pagingReply.currentPage-1) * pagingReply.pageSize }"/>
			<c:forEach var="replyvo" items="${pagingReply.lists }" varStatus="vs">
				<div class="<c:if test="${replyvo.ar_lev eq 1}">col-sm-12</c:if><c:if test="${replyvo.ar_lev eq 2}">col-md-11 offset-md-1</c:if>" style="<c:if test="${replyvo.ar_lev eq 1 and vs.count eq 1 }">margin: 1%; max-width: 98%</c:if><c:if test="${replyvo.ar_lev eq 1 and vs.count gt 1 }">margin: 1%; max-width: 98%; padding-top:1%; border-top: 1px solid;</c:if>">
						<c:out value="${replyvo.mb_nickname }"/>
						<fmt:formatDate value="${replyvo.ar_datetime }" pattern="yy.MM.dd HH:mm"/>
						<c:if test="${sessionScope.vo ne nell}">
						<span style="float: right;">
							<c:if test="${replyvo.ar_lev eq 1 }">
								<input type="button" value="답글" onclick="Reply('replycontent_div${replyvo.ar_idx}','updatecontent_div${replyvo.ar_idx }','ar_content${replyvo.ar_idx }')">
							</c:if>
						<c:if test="${sessionScope.vo.mb_id eq replyvo.mb_id}">
							<input type="button" value="수정" onclick="update('updatecontent_div${replyvo.ar_idx }', 'replycontent_div${replyvo.ar_idx}','ar_content${replyvo.ar_idx }')">
							<input type="button" value="삭제" onclick="deleteReply('${sessionScope.vo.mb_id}','${replyvo.ar_idx}','${replyvo.ab_idx}','${bt_table}','${p }','${s }','${b }');">
						</c:if>
						</span>
						</c:if>
						<div style="margin-top: 1%;" id="ar_content${replyvo.ar_idx }"> 
			 				<c:set var="r" value="${replyvo.ar_content }"/>
							<c:set var="r" value='${fn:replace(r, "<", "&lt;") }'/>				
							<c:set var="r" value='${fn:replace(r, newLine, br) }'/>		
							${r }
				 		</div>
				 		<div id="updatecontent_div${replyvo.ar_idx }" style="display:none; padding-top:1%; ">
				 			<div>
							<form id="replyupdatecontent${replyvo.ar_idx}" style="padding: 0px; height:100%; width: calc(100% - 100px);">
								<input type="hidden" name="bt_table" value="${bt_table }">
								<input type="hidden" name="ab_idx" value="${replyvo.ab_idx }">
								<input type="hidden" name="ar_idx" value="${replyvo.ar_idx }">
								<input type="hidden" name="ar_parents" value="1">
								<input type="hidden" name="ar_lev" value="2">
								<input type="hidden" name="mb_id" value="${sessionScope.vo.mb_id }">
								<input type="hidden" name="mb_nickname" value="${sessionScope.vo.mb_nickname }">
								<input type="hidden" name="ar_ip" value="${pageContext.request.remoteAddr }">
				    			<textarea name="ar_content" id="ar_updatecontent${replyvo.ar_idx}" style="width:100%; height:70%; resize: none;" placeholder="내용을 입력하세요.">${replyvo.ar_content }</textarea>
				  			</form>
				  			</div>
				  			<div>
				   				<input type="button" onclick="updateReply('replyupdatecontent${replyvo.ar_idx}' ,'ar_updatecontent${replyvo.ar_idx}' , '수정', '${bt_table }','${replyvo.ab_idx }','${p }','${s }','${b }')" value="수정" >
							</div>
						</div>
			    		<div class="justify-content-center" style="display:none; max-width: 98%; padding-top:1%; border-top: 1px solid;" id="replycontent_div${replyvo.ar_idx}" >
							<div class="col-4" style=" display: inline-block;max-width: 100%;">
								<div>
									<form id="replycontent${replyvo.ar_idx}" style="padding: 0px; height:100%; width: calc(100% - 100px);">
										<input type="hidden" name="bt_table" value="${bt_table }">
										<input type="hidden" name="ab_idx" value="${replyvo.ab_idx }">
										<input type="hidden" name="ar_parents" value="${replyvo.ar_idx}">
										<input type="hidden" name="ar_lev" value="2">
										<input type="hidden" name="mb_id" value="${sessionScope.vo.mb_id }">
										<input type="hidden" name="mb_nickname" value="${sessionScope.vo.mb_nickname }">
										<input type="hidden" name="ar_ip" value="${pageContext.request.remoteAddr }">
						    			<textarea name="ar_content" id="ar_recontent${replyvo.ar_idx}" style="width:100%; height:70%; resize: none;" placeholder="내용을 입력하세요."></textarea>
						  			</form>
						  			<div>
						   				<input type="button" onclick="writeReply('replycontent${replyvo.ar_idx}' ,'ar_recontent${replyvo.ar_idx}' , '답글','${bt_table }','${replyvo.ab_idx }','${p }','${s }','${b }')" value="답글" >
									</div>
								</div>
			      			</div>			      			
					   	</div>
				</div>
			</c:forEach>
		</c:if>
	</c:if>
	<div class="container" >
	<nav aria-label="Page navigation example" style="margin-top: 50px; width: auto;">
		 <ul class="pagination justify-content-center">
			 <c:if test="${pagingReply.startPage>1 }">
			 	  <li class="page-item">
			 	  	<input type="button" class="page-link" onclick="getReplyList('${bt_table }','${ab_idx }','${pagingreply.startpage-1 }','${pagingreply.pagesize }','${pagingreply.blocksize }')" value="이전">
			 	  </li>  
			 </c:if>
			 <c:if test="${pagingReply.totalCount>0 }">
			 	<c:forEach var="i" begin="${pagingReply.startPage}" end="${pagingReply.endPage }">
			 		<c:if test="${i == pagingReply.currentPage }">
			 		 <li class="page-item">
			 		 <span class="page-link">${i }</span>
			 		 </li>  
			 		</c:if>
			 		<c:if test="${i!=pagingReply.currentPage }">
						 <li class="page-item">
						 	<input type="button" class="page-link" onclick="getReplyList('${bt_table }','${ab_idx }','${i }','${pagingReply.pageSize }','${pagingReply.blockSize }')" value="${i }">
						 	</li>  
			 		</c:if>
			 	</c:forEach>
			 </c:if>
			 <c:if test="${pagingReply.endPage<pagingReply.totalPage }">
			 	<li class="page-item">
			 		<input type="button" class="page-link" onclick="getReplyList('${bt_table }','${ab_idx }','${pagingReply.endPage+1 }','${pagingReply.pageSize }','${pagingReply.blockSize }')" value="다음">
			 	</li> 
			 </c:if>
		</ul>
	</nav>
	</div>
</body>
</html>