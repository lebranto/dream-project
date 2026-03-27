<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비밀번호 확인</title>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
 <link rel="stylesheet" href="${contextPath}/resources/css/mypage/updatemembercheck.css">

</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
   <aside class="sidebar">
   <jsp:include page="/WEB-INF/views/common/myPageSidebar.jsp" />
  </aside>

    <div class="content-wrap">
        <main class="content">
            <div class="page-title">마이페이지</div>
            <div class="sub-title">반려동물 정보 수정</div>

            <form action="${contextPath}/mypage/checkPet" method="post">
                <input type="hidden" name="target" value="${param.target}">

                <div class="pwd-check-wrap">
                    <div class="label-box">비밀번호</div>
                    <input type="password" name="userPwd" class="pwd-input" placeholder="비밀번호 입력칸" required>
                    <button type="submit" class="confirm-btn">확인</button>
                </div>
            </form>

           <c:if test="${not empty errorMsg}">
    			<div class="error-msg">${errorMsg}</div>
		   </c:if>
			
        </main>
    </div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>