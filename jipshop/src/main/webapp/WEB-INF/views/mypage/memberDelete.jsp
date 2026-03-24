<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    String errorMsg = (String)request.getAttribute("errorMsg");
%>


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
   <div class="menu-group">
      <div class="menu-title">my 쇼핑</div>
      <ul class="menu-list">
        <a href="${contextPath}/mypage/purchase">구매 내역 보기</a><br>
        <a href="${contextPath}/mypage/recent">최근 본 상품</a>
      </ul>
    </div>

    <div class="menu-group">
      <div class="menu-title">문의</div>
      <ul class="menu-list">
        <a href="${contextPath}/mypage/inquiry">문의 내역</a>
      </ul>
    </div>

    <div class="menu-group">
      <div class="menu-title">회원 정보</div>
      <ul class="menu-list">
        <a href="${contextPath}/mypage/updateMemberCheck">회원 정보 수정</a><br>
        <a href="${contextPath}/mypage/updateMemberCheck">반려동물 정보 수정</a><br>
        <a href="${contextPath}/mypage/memberDelete">회원 탈퇴</a>
      </ul>
    </div>
    
     <div class="menu-group">
      <div class="menu-title">고객 센터</div>
      <ul class="menu-list">
        <a href="${contextPath}/mypage/purchase">1:1문의</a><br>
        <a href="${contextPath}/mypage/recent">FAQ</a><br>
      </ul>
    </div>
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
            
            <form class="check-form" action="${contextPath}/mypage/deleteMember" method="post" onsubmit="return confirmDelete();">
                <div class="label-box">비밀번호</div>
                <input type="password" name="userPwd" class="pwd-input" placeholder="비밀번호 입력칸" required>
                <button type="submit" class="confirm-btn">확인</button>
            </form>

            <% if(errorMsg != null) { %>
                <div class="error-msg"><%= errorMsg %></div>
            <% } %>
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