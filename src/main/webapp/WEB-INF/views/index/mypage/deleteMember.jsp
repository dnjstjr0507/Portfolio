<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<script type="text/javascript">
	function deleteMember() {
		if(confirm('정말 삭제하시겠습니까 ? \n삭제하시면 복구가 불가능 합니다.')){
			post_to_url('deleteMemberOk',{'mb_id':'${vo.mb_id}'});
		}
	}
</script>
<style type="text/css">
	.float{
		float: right;
	}
</style>
</head>
<body>
<div class="container" style="margin-top: 5%;">
	<div class="row">
		<div class="col-md-6 offset-md-3" style="border: 1px solid #dddddd; padding-left: 3%; padding-right: 3%; padding-top: 2%;">
			<fieldset>
				<legend>회원 탈퇴</legend>
				<p>회원탈퇴를 하시면 정보를 복구 하실 수 없습니다.<br> 회원탈퇴를 원하시면 아래 회원탈퇴를 클릭하여 주세요.</p>
				<input type="button" class="btn btn-danger float" value="회원탈퇴" onclick="deleteMember()">
			</fieldset>
		</div>
	</div>
</div>
</body>
</html>