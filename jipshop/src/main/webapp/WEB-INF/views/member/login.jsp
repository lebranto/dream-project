<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
          <!-- Login Form Card -->
          <div class="div">
            <!-- Username Input -->
            <div class="frame-5">
              <label for="username" class="sr-only">아이디</label>
              <input
                id="username"
                class="text-wrapper-6"
                type="text"
                name="username"
                placeholder="아이디"
                autocomplete="username"
                aria-label="아이디"
              />
            </div>
            <!-- Password Input -->
            <div class="frame-4">
              <label for="password" class="sr-only">비밀번호</label>
              <input
                id="password"
                class="text-wrapper-6"
                type="password"
                name="password"
                placeholder="비밀번호"
                autocomplete="current-password"
                aria-label="비밀번호"
              />
            </div>
            <!-- Login Button -->
            <div class="frame-2">
              <button type="submit" class="text-wrapper-2">로그인</button>
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
              <a href="#" class="text-wrapper-4">회원가입</a>
              <label>|</label>
              <a href="#" class="text-wrapper-5">아이디 · 비밀번호 찾기</a>
            </nav>
          </div>
        </section>
      </main>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

  </body>
</html>