<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>

  <c:set var="contextPath" value="${pageContext.request.contextPath}" />
 <link rel="stylesheet" href="${contextPath}/resources/css/mypage/memberDelete.css"> 
<!--   <link rel="stylesheet" href="/resources/css/mypage/memberDelete.css"> -->
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
  <aside class="sidebar">
   <jsp:include page="/WEB-INF/views/common/myPageSidebar.jsp" />
  </aside>

    <div class="content-wrap">
        <main class="content">
            <div class="page-title">마이페이지</div>
            <div class="sub-title">회원 정보 탈퇴</div>
            <div class="alret">
            	회원을 탈퇴하시면 다시 사이트를 이용하실 수 없습니다. <br>
            	만약 다시 이용을 원하신다면 고객센터에 문의해주시기  <br>
            	바랍니다.
            </div>
            
            <form class="check-form" action="${contextPath}/mypage/memberDelete" method="post" onsubmit="return confirmDelete();">
                <div class="label-box">비밀번호</div>
                <input type="password" name="userPwd" class="pwd-input" placeholder="비밀번호 입력칸" required>
                <button type="submit" class="confirm-btn">확인</button>
            </form>

         <c:if test="${not empty errorMsg}">
                <div class="error-msg">${errorMsg}</div>
           </c:if> 
           
        </main>
    </div>
  <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script>
        function confirmDelete() {
            return confirm("정말로 삭제하시겠습니까?");
        }
    </script>
</body>
</html>