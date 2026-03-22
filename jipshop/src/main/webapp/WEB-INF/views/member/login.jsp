<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta charset="utf-8" />
    <title>로그인</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/login.css">
  </head>
  <body>
  <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container">
      <main class="content">
        <section class="frame">

          <!-- Page Title -->
          <header class="div-wrapper">
            <h1 class="text-wrapper">로그인</h1>
          </header>

          <!-- 로그인 성공 후 메시지 (회원가입 성공 알림 등) -->
          <c:if test="${not empty alertMsg}">
            <script>alert('${alertMsg}');</script>
          </c:if>

          <!-- Login Form Card -->
          <form:form id="loginForm" cssClass="div"
                     action="${pageContext.request.contextPath}/member/login"
                     method="post">

              <!-- Username Input -->
              <div class="frame-5">
                <label for="memberId" class="sr-only">아이디</label>
                <input
                  id="memberId"
                  class="text-wrapper-6"
                  type="text"
                  name="memberId"
                  placeholder="아이디"
                  autocomplete="username"
                  aria-label="아이디"
                />
              </div>

              <!-- Password Input -->
              <div class="frame-4">
                <label for="memberPwd" class="sr-only">비밀번호</label>
                <input
                  id="memberPwd"
                  class="text-wrapper-6"
                  type="password"
                  name="memberPwd"
                  placeholder="비밀번호"
                  autocomplete="current-password"
                  aria-label="비밀번호"
                />
              </div>

              <!-- Login Button -->
              <div class="frame-2">
                <button type="button" class="text-wrapper-2" onclick="checkLogin()">로그인</button>
              </div>

              <!-- Remember Me Checkbox -->
              <div class="group-wrapper">
                <div class="group">
                  <input id="remember-me" class="rectangle" type="checkbox" name="remember" aria-label="로그인상태유지" />
                  <label for="remember-me" class="text-wrapper-3">로그인상태유지</label>
                </div>
              </div>

              <!-- Footer Links -->
              <nav class="frame-3" aria-label="계정 관련 링크">
                <a href="${pageContext.request.contextPath}/member/insert" class="text-wrapper-4">회원가입</a>
                <label>|</label>
                <a href="#" class="text-wrapper-5">아이디 · 비밀번호 찾기</a>
              </nav>

          </form:form>

        </section>
      </main>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script>
      function checkLogin() {
        const memberId  = document.getElementById('memberId').value.trim();
        const memberPwd = document.getElementById('memberPwd').value.trim();

        if (memberId === '') {
          alert('아이디를 입력해주세요.');
          document.getElementById('memberId').focus();
          return;
        }

        if (memberPwd === '') {
          alert('비밀번호를 입력해주세요.');
          document.getElementById('memberPwd').focus();
          return;
        }

        document.getElementById('loginForm').submit();
      }

      // 엔터키로도 로그인 가능
      document.addEventListener('keydown', function(e) {
        if (e.key === 'Enter') checkLogin();
      });
    </script>

  </body>
</html>
