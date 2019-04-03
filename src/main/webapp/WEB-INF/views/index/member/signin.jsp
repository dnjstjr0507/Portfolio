<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
  <meta charset="utf-8" />
  <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath }/resources/assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath }/resources/assets/img/favicon.png">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <title>로그인</title>
  <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
  <!--     Fonts and icons     -->
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
  <link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
  <!-- CSS Files -->
  <link href="${pageContext.request.contextPath }/resources/assets/css/now-ui-kit.css?v=1.2.0" rel="stylesheet" />
  <!-- CSS Just for demo purpose, don't include it in your project -->
  <link href="${pageContext.request.contextPath }/resources/assets/demo/demo.css" rel="stylesheet" />
  <script type="text/javascript">

  </script>
</head>

<body class="login-page sidebar-collapse" id="body">
  <!-- End Navbar -->
	<div class="page-header clear-filter" filter-color="orange">
		<div class="page-header-image" style="background-image:url(${pageContext.request.contextPath }/resources/assets/img/login.jpg)"></div>
			<div class="content">
				<div class="container">
					<div class="col-md-4 ml-auto mr-auto">
						<div class="card card-login card-plain">
	<form method="post" action="signinOK">
		<div class="card-body">
			<div class="input-group no-border input-lg">
				<input type="hidden" name="hs_ip" value="${pageContext.request.remoteAddr }">
				<input type="text" name="mb_id" id="mb_id" class="form-control" placeholder="아이디" value="admin">
			</div>
			<div class="input-group no-border input-lg">
				<input type="password" name="mb_password" id="password" class="form-control" placeholder="비밀번호" value="123456789">
			</div>
		</div>
		<div class="card-footer text-center">
			<input type="submit" class="btn btn-primary btn-round btn-lg btn-block" value="로그인">
			<div class="pull-left">
				<h6>
					<a href="join" class="link">회원가입</a>
				</h6>
			</div>
			<div class="pull-right">
				<h6>
					<a href="findid" class="link">아이디</a>/<a href="findpw">비밀번호 찾기</a>
				</h6>
			</div>
		</div>
	</form>
						</div>
					</div>
				</div>
			</div>
    <footer class="footer">
      <div class="container">
        <nav>
          <ul>
            <li>
              <a href="https://www.creative-tim.com">
                Creative Tim
              </a>
            </li>
            <li>
              <a href="http://presentation.creative-tim.com">
                About Us
              </a>
            </li>
            <li>
              <a href="http://blog.creative-tim.com">
                Blog
              </a>
            </li>
          </ul>
        </nav>
        <div class="copyright" id="copyright">
          &copy;
          <script>
            document.getElementById('copyright').appendChild(document.createTextNode(new Date().getFullYear()))
          </script>, Designed by
          <a href="https://www.invisionapp.com" target="_blank">Invision</a>. Coded by
          <a href="https://www.creative-tim.com" target="_blank">Creative Tim</a>.
        </div>
      </div>
    </footer>
  </div>
  <div>
	<c:if test="${not empty result and result==1 }">
		<script type="text/javascript">
			alert('존재하지 않는 아이디 입니다.')		
		</script>
	</c:if>
	<c:if test="${not empty result and result==2 }">
		<script type="text/javascript">
			alert('아이디 또는 비밀번호를 확인하세요.')		
		</script>
	</c:if>
	<c:if test="${not empty result and result==3 }">
		<script type="text/javascript">
			alert('이메일인증이되지 않은 아이디 입니다.')		
		</script>
	</c:if>
	<c:if test="${not empty result and result==4 }">
		<script type="text/javascript">
			alert('탈퇴한 아이디 입니다.')		
		</script>
	</c:if>
	<c:if test="${not empty result and result==5 }">
		<script type="text/javascript">
			alert('로그인성공')		
		</script>
	</c:if>
	<c:if test="${not empty resultMessage and resultMessage==1 }">
		<script type="text/javascript">
			alert('비밀번호가 변경되었습니다. \n다시 로그인 해주세요.')		
		</script>
	</c:if>
   </div>
  <!--   Core JS Files   -->
  <script src="${pageContext.request.contextPath }/resources/assets/js/core/bootstrap.min.js" type="text/javascript"></script>
  <!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
  <script src="${pageContext.request.contextPath }/resources/assets/js/plugins/bootstrap-switch.js"></script>
  <!--  Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
  <script src="${pageContext.request.contextPath }/resources/assets/js/plugins/nouislider.min.js" type="text/javascript"></script>
  <!--  Plugin for the DatePicker, full documentation here: https://github.com/uxsolutions/bootstrap-datepicker -->
  <script src="${pageContext.request.contextPath }/resources/assets/js/plugins/bootstrap-datepicker.js" type="text/javascript"></script>
  <!--  Google Maps Plugin    -->
  <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
  <!-- Control Center for Now Ui Kit: parallax effects, scripts for the example pages etc -->
  <script src="${pageContext.request.contextPath }/resources/assets/js/now-ui-kit.js?v=1.2.0" type="text/javascript"></script>
</body>
</html>