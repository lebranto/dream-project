<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta charset="UTF-8" />
  <title>회원가입 — 집사상점</title>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberEnrollForm.css">
  <!-- 다음 주소 API -->
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- 페이지 배경 래퍼 (body 스타일 대신) -->
<div class="register-page-wrap">
  <div class="register-wrap">
    <div class="register-content">
      <div class="register-inner">

        <!-- 타이틀 -->
        <div class="reg-title-area">
          <h1 class="reg-title">회원가입</h1>
        </div>

        <!-- 메인 폼 카드 -->
        <form name="registerForm" id="registerForm" action="/member/insert" method="post">
        <div class="reg-card">

          <!-- 아이디 + 중복체크 -->
          <div class="reg-id-row">
            <input class="reg-input" type="text" id="memberId" placeholder="아이디" name="memberId" autocomplete="off" />
            <button type="button" class="reg-btn-check" onclick="idCheck()">아이디<br>중복체크</button>
          </div>

          <!-- 비밀번호 -->
          <input class="reg-input" type="password" id="password" placeholder="비밀번호" name="password" autocomplete="new-password" />

          <!-- 비밀번호 확인 -->
          <input class="reg-input" type="password" id="passwordConfirm" placeholder="비밀번호 확인" name="passwordConfirm" />
          <p class="reg-pw-hint">8자리 이상의 대소문자, 숫자, 특수문자를 사용해주세요</p>

          <!-- 이메일 -->
          <div class="reg-field-group">
            <div class="reg-field-label">이메일 <span class="reg-required-dot"></span></div>
            <input class="reg-input" type="email" id="email" placeholder="이메일을 입력하세요." name="email" autocomplete="email" />
          </div>

          <!-- 이름 -->
          <div class="reg-field-group">
            <div class="reg-field-label">이름 <span class="reg-required-dot"></span></div>
            <input class="reg-input" type="text" id="name" placeholder="이름을(를) 입력하세요." name="name" />
          </div>

          <!-- 주소 (다음 주소 API) -->
          <div class="reg-field-group">
            <div class="reg-field-label">주소 <span class="reg-required-dot"></span></div>
            <!-- 우편번호 + 검색 버튼 -->
            <div class="reg-id-row" style="margin-bottom:8px;">
              <input class="reg-input" type="text" id="zipCode" name="zipCode"
                     placeholder="우편번호" readonly style="margin-bottom:0; cursor:pointer;"
                     onclick="sample4_execDaumPostcode()" />
              <button type="button" class="reg-btn-check" style="white-space:nowrap; line-height:1.6;"
                      onclick="sample4_execDaumPostcode()">주소 검색</button>
            </div>
            <!-- 도로명 주소 -->
            <input class="reg-input" type="text" id="streetAdr" name="streetAdr"
                   placeholder="도로명 주소" readonly style="margin-bottom:8px; cursor:default;" />
            <!-- 상세 주소 -->
            <input class="reg-input" type="text" id="detailAdr" name="detailAdr"
                   placeholder="상세 주소를 입력하세요." style="margin-bottom:0;"
                   onclick="addrCheck()" />
            <!-- 최종 합산 주소 (VO의 address 필드로 전송) -->
            <input type="hidden" id="address" name="address" />
          </div>

          <!-- 전화번호 -->
          <div class="reg-field-group">
            <div class="reg-field-label">전화번호 <span class="reg-required-dot"></span></div>
            <div class="reg-phone-row">
              <input class="reg-input" type="tel" id="phone" placeholder="전화번호를 입력하세요 (010-1234-5678)" name="phone" />
              <button type="button" class="reg-btn-verify">인증</button>
            </div>
            <div class="reg-phone-row">
              <input class="reg-input" type="text" id="verifyCode" placeholder="인증번호" name="verifyCode" />
              <button type="button" class="reg-btn-verify">확인</button>
            </div>
          </div>

          <!-- 구분선 -->
          <div class="reg-divider"></div>

          <!-- 애완동물 등록 토글 -->
          <div>
            <p class="reg-pet-section-title">애완동물 등록 (선택사항)</p>
            <button type="button" class="reg-btn-pet-toggle" id="petToggleBtn">
              <span class="reg-toggle-icon">+</span>
              애완동물 등록하기
            </button>

            <!-- 슬라이드 다운 패널 -->
            <div class="reg-pet-panel" id="petPanel">
              <div class="reg-pet-card">
                <div class="reg-pet-form-title">애완동물 정보</div>

                <!-- 사진 등록 -->
                <label class="reg-file-label" for="petPhoto">
                  📁&nbsp; 사진 파일 올리기
                  <input id="petPhoto" type="file" accept="image/*" style="display:none;" name="petPhoto" />
                </label>

                <!-- 동물 종류 -->
                <div class="reg-pet-type-row">
                  <span class="reg-row-label">동물 종류</span>
                  <div class="reg-radio-group">
                    <label><input type="radio" name="petType" value="dog" checked /> 개</label>
                    <label><input type="radio" name="petType" value="cat" /> 고양이</label>
                  </div>
                </div>

                <!-- 이름 -->
                <div class="reg-pet-input-row">
                  <span class="reg-row-label">이름</span>
                  <input class="reg-input" type="text" name="petName" placeholder="이름" />
                </div>

                <!-- 생년월일 (DB: DATE → yyyy-MM-dd) -->
                <div class="reg-pet-input-row">
                  <span class="reg-row-label">생년월일</span>
                  <input class="reg-input" type="date" name="petBirth" />
                </div>

                <!-- 몸무게 -->
                <div class="reg-pet-input-row">
                  <span class="reg-row-label">몸무게</span>
                  <input class="reg-input" type="number" name="petWeight" step="0.1" min="0" placeholder="kg" />
                </div>

              </div>
            </div>
            <!-- 슬라이드 패널 끝 -->
          </div>

        </div>
        <!-- 메인 폼 카드 끝 -->

        <!-- 가입하기 버튼 -->
        <div class="reg-submit-wrap">
          <button type="button" class="reg-btn-submit" onclick="checkRegist()">가입하기</button>
        </div>
        </form>

      </div>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
  /* ── 애완동물 토글 ── */
  const toggleBtn = document.getElementById('petToggleBtn');
  const petPanel  = document.getElementById('petPanel');

  toggleBtn.addEventListener('click', () => {
    const isOpen = petPanel.classList.toggle('open');
    toggleBtn.classList.toggle('open', isOpen);
  });

  /* ── 다음 주소 API ── */
  function sample4_execDaumPostcode() {
    new daum.Postcode({
      oncomplete: function(data) {
        // 도로명 주소 우선, 없으면 지번 주소
        var roadAddr = data.roadAddress || data.jibunAddress;
        document.getElementById('zipCode').value   = data.zonecode;
        document.getElementById('streetAdr').value = roadAddr;
        // 상세주소로 포커스 이동
        document.getElementById('detailAdr').focus();
      }
    }).open();
  }

  /* ── 상세주소 입력 전 도로명 주소 선택 여부 확인 ── */
  function addrCheck() {
    if (document.getElementById('streetAdr').value === '') {
      alert('주소 검색 버튼을 눌러 도로명 주소를 먼저 선택해주세요.');
      return false;
    }
  }

  /* ── 아이디 중복체크 ── */
  function idCheck() {
    const memberId = document.getElementById('memberId').value.trim();

    if (memberId === '') {
      alert('아이디를 입력해주세요.');
      document.getElementById('memberId').focus();
      return;
    }

    $.ajax({
      url  : "${pageContext.request.contextPath}/member/idCheck",
      type : "GET",
      data : { memberId : memberId },
      success : function(result) {
        if (result == 1) {
          alert('이미 사용중인 아이디입니다.');
          document.getElementById('memberId').value = '';
          document.getElementById('memberId').focus();
        } else {
          alert('사용 가능한 아이디입니다.');
        }
      },
      error : function(xhr, status, error) {
        alert('서버 통신 중 오류가 발생했습니다.');
        console.error(status, error);
      }
    });
  }
</script>
</body>
</html>
