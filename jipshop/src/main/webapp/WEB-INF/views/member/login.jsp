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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/findModal.css">
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
                     action="${pageContext.request.contextPath}/member/loginProcess"
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
                <a href="${pageContext.request.contextPath}/security/insert" class="text-wrapper-4">회원가입</a>
                <label>|</label>
                <a href="#" class="text-wrapper-5" onclick="openFindModal(); return false;">아이디 · 비밀번호 찾기</a>
              </nav>

          </form:form>

        </section>
      </main>
    </div>
	<!-- ==================== 아이디/비밀번호 찾기 모달 ==================== -->
	<div class="modal-overlay" id="findModal">
	  <div class="modal-box">
	
	    <!-- 모달 헤더 -->
	    <div class="modal-header">
	      <h2 id="modalTitle">아이디 찾기</h2>
	      <button class="modal-close" onclick="closeFindModal()">×</button>
	    </div>
	
	    <!-- 탭 -->
	    <div class="modal-tabs">
	      <div class="modal-tab active" id="tabFindId" onclick="switchTab('findId')">아이디 찾기</div>
	      <div class="modal-tab" id="tabFindPwd" onclick="switchTab('findPwd')">비밀번호 찾기</div>
	    </div>
	
	    <div class="modal-body">
	
	      <!-- ══ 아이디 찾기 패널 ══ -->
	      <div class="modal-panel active" id="panelFindId">
	
	        <div id="findIdForm">
	          <p class="modal-hint">가입 시 등록한 이름과 휴대폰 번호로 찾을 수 있어요.</p>
	          <input class="modal-input" type="text" id="findIdName" placeholder="이름" />
	          <div class="modal-phone-row">
	            <input class="modal-input" type="tel" id="findIdPhone" placeholder="휴대폰 번호 (010-1234-5678)" />
	            <button class="modal-btn-verify" id="btnFindIdSend" onclick="sendFindIdSms()">인증</button>
	            <span class="modal-timer" id="findIdTimer"></span>
	          </div>
	          <div class="modal-phone-row">
	            <input class="modal-input" type="text" id="findIdCode" placeholder="인증번호 6자리" />
	            <button class="modal-btn-verify" id="btnFindIdVerify" onclick="verifyFindIdSms()">확인</button>
	          </div>
	          <button class="modal-btn-submit" onclick="findId()">아이디 찾기</button>
	        </div>
	
	        <!-- 결과 -->
	        <div class="modal-result" id="findIdResult">
	          <p class="result-title" id="findIdResultMsg"></p>
	          <div class="result-ids" id="findIdResultValue" style="display:none;"></div>
	          <button class="modal-btn-submit" onclick="goLogin()">로그인하기</button>
	          <button class="modal-btn-outline" onclick="resetFindId()">다시 찾기</button>
	        </div>
	
	      </div>
	      <!-- ══ 아이디 찾기 패널 끝 ══ -->
	
	      <!-- ══ 비밀번호 찾기 패널 ══ -->
	      <div class="modal-panel" id="panelFindPwd">
	
	        <div id="findPwdForm">
	          <p class="modal-hint">아이디와 가입 시 등록한 휴대폰 번호로 인증해주세요.</p>
	          <input class="modal-input" type="text" id="findPwdId" placeholder="아이디" />
	          <div class="modal-phone-row">
	            <input class="modal-input" type="tel" id="findPwdPhone" placeholder="휴대폰 번호 (010-1234-5678)" />
	            <button class="modal-btn-verify" id="btnFindPwdSend" onclick="sendFindPwdSms()">인증</button>
	            <span class="modal-timer" id="findPwdTimer"></span>
	          </div>
	          <div class="modal-phone-row">
	            <input class="modal-input" type="text" id="findPwdCode" placeholder="인증번호 6자리" />
	            <button class="modal-btn-verify" id="btnFindPwdVerify" onclick="verifyFindPwdSms()">확인</button>
	          </div>
	
	          <!-- 새 비밀번호 입력 (인증 완료 후 표시) -->
	          <div class="pwd-change-area" id="pwdChangeArea">
	            <input class="modal-input" type="password" id="newPwd"
	                   placeholder="새 비밀번호 (8자 이상, 대소문자+숫자+특수문자)" />
	            <input class="modal-input" type="password" id="newPwdConfirm"
	                   placeholder="새 비밀번호 확인" />
	            <button class="modal-btn-submit" onclick="changePwd()">비밀번호 변경</button>
	          </div>
	        </div>
	
	        <!-- 결과 -->
	        <div class="modal-result" id="findPwdResult">
	          <p class="result-title" id="findPwdResultMsg"></p>
	          <button class="modal-btn-submit" onclick="goLogin()">로그인하기</button>
	          <button class="modal-btn-outline" onclick="resetFindPwd()">다시 찾기</button>
	        </div>
	
	      </div>
	      <!-- ══ 비밀번호 찾기 패널 끝 ══ -->
	
	    </div>
	  </div>
	</div>
	<!-- ==================== 모달 끝 ==================== -->
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
      
      /* ── 모달 열기/닫기 ── */
      function openFindModal() {
        document.getElementById('findModal').classList.add('active');
        switchTab('findId');
      }

      function closeFindModal() {
        document.getElementById('findModal').classList.remove('active');
        resetFindId();
        resetFindPwd();
      }

      document.getElementById('findModal').addEventListener('click', function(e) {
        if (e.target === this) closeFindModal();
      });

      /* ── 탭 전환 ── */
      function switchTab(tab) {
        document.querySelectorAll('.modal-tab').forEach(t => t.classList.remove('active'));
        document.querySelectorAll('.modal-panel').forEach(p => p.classList.remove('active'));
        if (tab === 'findId') {
          document.getElementById('tabFindId').classList.add('active');
          document.getElementById('panelFindId').classList.add('active');
          document.getElementById('modalTitle').textContent = '아이디 찾기';
        } else {
          document.getElementById('tabFindPwd').classList.add('active');
          document.getElementById('panelFindPwd').classList.add('active');
          document.getElementById('modalTitle').textContent = '비밀번호 찾기';
        }
      }
    </script>

  </body>
</html>
