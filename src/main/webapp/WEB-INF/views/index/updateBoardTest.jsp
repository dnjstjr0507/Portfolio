<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
function a(formName){
   var f = document.getElementById(formName);
   f.action="updatelev";
   f.submit();
}
function b(formName){
   var f = document.getElementById(formName);
   f.action="deletelev";
   f.submit();
}
function c(formNameD){
   var f = document.getElementById(formNameD);
   f.action="updatedep";
   f.submit();
}
function d(formNameD){
   var f = document.getElementById(formNameD);
   f.action="deletedep";
   f.submit();
}
function e(formNameS){
   var f = document.getElementById(formNameS);
   f.action="updatest";
   f.submit();
}
function f(formNameS){
   var f = document.getElementById(formNameS);
   f.action="deletest";
   f.submit();
}
function g(formNameH){
   var f = document.getElementById(formNameH);
   f.action="updateh";
   f.submit();
}
function h(formNameH){
   var f = document.getElementById(formNameH);
   f.action="deleteh";
   f.submit();
}
function i(formNameDu){
   var f = document.getElementById(formNameDu);
   f.action="updatedu";
   f.submit();
}
function j(formNameDu){
   var f = document.getElementById(formNameDu);
   f.action="deletedu";
   f.submit();
}

</script>
<title>추가하는 곳</title>
</head>
<body>
   <form action="insertldOk">
      <table>
      
      
         <tr>
            <td>
               <div class="form-row" align="right">   
                  <div class="subtitle" align="right"  style="width: 50%">
                     <input type="text" class="form-control" name="lev"  placeholder="직급등록" style=" float: left: ;" >
                  </div>
                  &nbsp;&nbsp;<div align="right">
                     <input type="submit" class="btn btn-primary"   value="추가" style="float: left;">
                  </div>   
               </div>
            </td>
         </tr>
      </table>
   </form>
   <hr>   
   <c:if test="${empty Llist }">
      등록된정보가 없습니다.
   </c:if>
   
   <c:if test="${not empty Llist }">
   
      <c:forEach var="vo" items="${Llist }" varStatus="vs">
         <form name="formName${vs.count }" id="formName${vs.count }" method="post">
            <input type="hidden" id="idx" name="idx" value="${vo.idx}">

               <div class="form-row" align="right">   
                  <div class="subtitle" align="right"  style="width: 10%">
                     <input type="text" class="form-control"  id="lev" name="lev" value="${vo.lev}"  placeholder="직책등록" style=" float: left: ;" >
                  </div>
                  &nbsp;&nbsp;<div align="right">
                                 <input type="button" value="수정"  class="btn btn-success" onclick="a('formName${vs.count}');">
                                 <input type="button" value="삭제"  class="btn btn-danger" onclick="b('formName${vs.count}');">
                  </div>   
               </div>
            <br>
         </form>
      </c:forEach>
   </c:if>
   <hr>
   
   
   
</body>
</html>

