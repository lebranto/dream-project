<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta charset="UTF-8" />
  <title>회원가입 완료 — 집사상점</title>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      background-color: #f5f0e8;
      font-family: 'Noto Sans KR', 'Malgun Gothic', sans-serif;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    .container {
      width: 1440px;
      min-height: 640px;
      margin: 0 auto;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 60px 20px;
      flex: 1;
    }

    /* ── 완료 카드 ── */
    .complete-card {
      background: #fffdf8;
      border: 1px solid #ddd5c0;
      border-radius: 16px;
      box-shadow: 0 8px 32px rgba(90,62,27,0.10);
      padding: 52px 48px 44px;
      text-align: center;
      width: 100%;
      max-width: 460px;
      animation: fadeUp 0.5s ease both;
    }

    /* ── 체크 아이콘 ── */
    .complete-icon {
      width: 72px;
      height: 72px;
      background: linear-gradient(135deg, #f0c84a, #d4a843);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 24px;
      box-shadow: 0 4px 16px rgba(212,168,67,0.35);
      animation: popIn 0.5s cubic-bezier(0.34,1.56,0.64,1) 0.2s both;
    }

    .complete-icon svg {
      width: 36px;
      height: 36px;
      stroke: #5a3e1b;
      stroke-width: 3;
      fill: none;
      stroke-linecap: round;
      stroke-linejoin: round;
    }

    /* 체크 그리기 애니메이션 */
    .check-path {
      stroke-dasharray: 50;
      stroke-dashoffset: 50;
      animation: drawCheck 0.4s ease 0.5s forwards;
    }

    /* ── 타이틀 ── */
    .complete-title {
      font-size: 22px;
      font-weight: 700;
      color: #3a2e22;
      margin-bottom: 10px;
      letter-spacing: -0.3px;
    }

    .complete-subtitle {
      font-size: 14px;
      color: #7a6e62;
      line-height: 1.7;
      margin-bottom: 32px;
    }

    .complete-subtitle strong {
      color: #7a5530;
      font-weight: 700;
    }

    /* ── 구분선 ── */
    .divider {
      height: 1px;
      background: linear-gradient(to right, transparent, #ddd5c0, transparent);
      margin-bottom: 28px;
    }

    /* ── 버튼 그룹 ── */
    .btn-group {
      display: flex;
      gap: 12px;
    }

    .btn-login {
      flex: 1;
      height: 50px;
      background: linear-gradient(135deg, #f0c84a, #d4a843);
      color: #5a3e1b;
      font-size: 15px;
      font-weight: 700;
      font-family: inherit;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      box-shadow: 0 3px 12px rgba(212,168,67,0.3);
      transition: box-shadow 0.2s, transform 0.15s;
      position: relative;
      overflow: hidden;
      text-decoration: none;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .btn-login::after {
      content: '';
      position: absolute;
      inset: 0;
      background: linear-gradient(135deg, rgba(255,255,255,0.2), transparent);
      pointer-events: none;
    }

    .btn-login:hover {
      box-shadow: 0 5px 18px rgba(212,168,67,0.4);
      transform: translateY(-1px);
    }

    .btn-home {
      flex: 1;
      height: 50px;
      background: #fff;
      color: #7a5530;
      font-size: 15px;
      font-weight: 600;
      font-family: inherit;
      border: 1.5px solid #d4a843;
      border-radius: 8px;
      cursor: pointer;
      transition: background 0.15s;
      text-decoration: none;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .btn-home:hover { background: #fffbf0; }

    /* ── Animations ── */
    @keyframes fadeUp {
      from { opacity: 0; transform: translateY(16px); }
      to   { opacity: 1; transform: translateY(0); }
    }

    @keyframes popIn {
      from { opacity: 0; transform: scale(0.5); }
      to   { opacity: 1; transform: scale(1); }
    }

    @keyframes drawCheck {
      to { stroke-dashoffset: 0; }
    }
  </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container">
  <div class="complete-card">

    <!-- 체크 아이콘 -->
    <div class="complete-icon">
      <svg viewBox="0 0 24 24">
        <polyline class="check-path" points="4,12 9,17 20,6"/>
      </svg>
    </div>

    <!-- 타이틀 -->
    <h1 class="complete-title">회원가입 완료!</h1>
    <p class="complete-subtitle">
      집사상점 회원이 되신 것을 환영합니다 🐾<br>
      지금 바로 로그인하고<br>
      <strong>우리 아이를 위한 특별한 쇼핑</strong>을 시작해보세요!
    </p>

    <div class="divider"></div>

    <!-- 버튼 -->
    <div class="btn-group">
      <a href="${pageContext.request.contextPath}/member/login" class="btn-login">로그인</a>
      <a href="${pageContext.request.contextPath}/" class="btn-home">홈으로 이동</a>
    </div>

  </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
