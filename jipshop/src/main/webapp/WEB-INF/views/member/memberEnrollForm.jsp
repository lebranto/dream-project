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
        <form:form id="registerForm"
		    action="${pageContext.request.contextPath}/security/insert?${_csrf.parameterName}=${_csrf.token}"
		    method="post" enctype="multipart/form-data">
        	
        <div class="reg-card">

          <!-- 아이디 + 중복체크 -->
          <div class="reg-id-row">
            <input class="reg-input" type="text" id="memberId" placeholder="아이디" name="memberId" autocomplete="off" />
            <button type="button" class="reg-btn-check" onclick="idCheck()">아이디<br>중복체크</button>
          </div>

          <!-- 비밀번호 -->
          <input class="reg-input" type="password" id="memberPwd" placeholder="비밀번호" name="memberPwd" autocomplete="new-password" />

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
            <input class="reg-input" type="text" id="memberName" placeholder="이름을(를) 입력하세요." name="memberName" />
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
              <button type="button" class="reg-btn-verify" id="btnSendSms" onclick="sendSms()">인증</button>
            </div>
            <div class="reg-phone-row">
              <div style="flex:1; position:relative;">
                <input class="reg-input" type="text" id="verifyCode" placeholder="인증번호 6자리" name="verifyCode" style="margin-bottom:0; width:100%;" />
                <span id="smsTimer" style="position:absolute; right:12px; top:50%; transform:translateY(-50%); font-size:13px; color:#e05555; display:none;"></span>
              </div>
              <button type="button" class="reg-btn-verify" id="btnVerifySms" onclick="verifySms()">확인</button>
            </div>
            <input type="hidden" id="phoneVerified" name="phoneVerified" value="N" />
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
				<label class="reg-file-label" for="petPhoto" id="fileLabel">
				  📁&nbsp; <span id="fileNameText">사진 파일 올리기</span>
				  <input id="petPhoto" type="file" accept="image/*" style="display:none;" name="petPhoto" 
				         onchange="updateFileName(this)" />
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
        </form:form>

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

  /* ── 회원가입 유효성 검사 ── */
  function checkRegist() {
    const memberId        = document.getElementById('memberId').value.trim();
    const memberPwd       = document.getElementById('memberPwd').value.trim();
    const passwordConfirm = document.getElementById('passwordConfirm').value.trim();
    const email           = document.getElementById('email').value.trim();
    const memberName      = document.getElementById('memberName').value.trim();
    const zipCode         = document.getElementById('zipCode').value.trim();
    const streetAdr       = document.getElementById('streetAdr').value.trim();
    const detailAdr       = document.getElementById('detailAdr').value.trim();
    const phone           = document.getElementById('phone').value.trim();

    // 아이디
    if (memberId === '') {
      alert('아이디를 입력해주세요.');
      document.getElementById('memberId').focus();
      return;
    }
    const idRegex = /^[a-zA-Z0-9_]+$/;
    if (!idRegex.test(memberId)) {
      alert('아이디는 영문자, 숫자, 언더바(_)만 사용 가능합니다.');
      document.getElementById('memberId').focus();
      return;
    }

    // 비밀번호
    if (memberPwd === '') {
      alert('비밀번호를 입력해주세요.');
      document.getElementById('memberPwd').focus();
      return;
    }

    // 비밀번호 형식 (8자 이상, 대소문자+숫자+특수문자)
    const pwRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]).{8,}$/;
    if (!pwRegex.test(memberPwd)) {
      alert('비밀번호는 8자리 이상의 대소문자, 숫자, 특수문자를 포함해야 합니다.');
      document.getElementById('memberPwd').focus();
      return;
    }

    // 비밀번호 확인
    if (passwordConfirm === '') {
      alert('비밀번호 확인을 입력해주세요.');
      document.getElementById('passwordConfirm').focus();
      return;
    }
    if (memberPwd !== passwordConfirm) {
      alert('비밀번호가 일치하지 않습니다.');
      document.getElementById('passwordConfirm').focus();
      return;
    }

    // 이메일
    if (email === '') {
      alert('이메일을 입력해주세요.');
      document.getElementById('email').focus();
      return;
    }
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      alert('이메일 형식이 올바르지 않습니다. (예: example@email.com)');
      document.getElementById('email').focus();
      return;
    }

    // 이름
    if (memberName === '') {
      alert('이름을 입력해주세요.');
      document.getElementById('memberName').focus();
      return;
    }

    // 주소 — 우편번호 & 도로명 주소
    if (zipCode === '' || streetAdr === '') {
      alert('주소 검색 버튼을 눌러 주소를 입력해주세요.');
      return;
    }

    // 상세 주소
    if (detailAdr === '') {
      alert('상세 주소를 입력해주세요.');
      document.getElementById('detailAdr').focus();
      return;
    }

    // 전화번호
    if (phone === '') {
      alert('전화번호를 입력해주세요.');
      document.getElementById('phone').focus();
      return;
    }

    // 전화번호 형식 (010-0000-0000 또는 01000000000)
    const phoneRegex = /^01[016789]-?\d{3,4}-?\d{4}$/;
    if (!phoneRegex.test(phone)) {
      alert('전화번호 형식이 올바르지 않습니다. (예: 010-1234-5678)');
      document.getElementById('phone').focus();
      return;
    }

    // 전화번호 인증 여부 확인
    if (document.getElementById('phoneVerified').value !== 'Y') {
      alert('전화번호 인증을 완료해주세요.');
      document.getElementById('phone').focus();
      return;
    }

    // 모든 검사 통과 → address 합산 후 폼 제출
    const fullAddress = zipCode + ' ' + streetAdr + ' ' + detailAdr;
    document.getElementById('address').value = fullAddress;
    document.getElementById('registerForm').submit();
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

  /* ── SMS 인증번호 발송 ── */
  let smsTimerInterval = null;

  function sendSms() {
    const phone = document.getElementById('phone').value.trim();

    if (phone === '') {
      alert('전화번호를 입력해주세요.');
      document.getElementById('phone').focus();
      return;
    }

    const phoneRegex = /^01[016789]-?\d{3,4}-?\d{4}$/;
    if (!phoneRegex.test(phone)) {
      alert('전화번호 형식이 올바르지 않습니다. (예: 010-1234-5678)');
      document.getElementById('phone').focus();
      return;
    }

    $.ajax({
      url  : "${pageContext.request.contextPath}/sms/send",
      type : "POST",
      data : { phone : phone },
      success : function(result) {
        if (result.success) {
          alert(result.message);
          // 인증 완료 초기화
          document.getElementById('phoneVerified').value = 'N';
          document.getElementById('verifyCode').value = '';
          // 3분 타이머 시작
          startSmsTimer(180);
          // 버튼 비활성화 (재발송 방지)
          document.getElementById('btnSendSms').disabled = true;
          document.getElementById('btnSendSms').textContent = '재발송';
          setTimeout(function() {
            document.getElementById('btnSendSms').disabled = false;
          }, 30000); // 30초 후 재발송 가능
        } else {
          alert(result.message);
        }
      },
      error : function() {
        alert('SMS 발송 중 오류가 발생했습니다.');
      }
    });
  }

  /* ── SMS 인증번호 확인 ── */
  function verifySms() {
    const code = document.getElementById('verifyCode').value.trim();

    if (code === '') {
      alert('인증번호를 입력해주세요.');
      document.getElementById('verifyCode').focus();
      return;
    }

    $.ajax({
      url  : "${pageContext.request.contextPath}/sms/verify",
      type : "POST",
      data : { code : code },
      success : function(result) {
        if (result.success) {
          alert(result.message);
          // 인증 완료 처리
          document.getElementById('phoneVerified').value = 'Y';
          // 타이머 중지
          clearInterval(smsTimerInterval);
          document.getElementById('smsTimer').style.display = 'none';
          // 버튼 비활성화
          document.getElementById('btnVerifySms').disabled = true;
          document.getElementById('btnSendSms').disabled   = true;
          document.getElementById('verifyCode').readOnly   = true;
        } else {
          alert(result.message);
          document.getElementById('verifyCode').value = '';
          document.getElementById('verifyCode').focus();
        }
      },
      error : function() {
        alert('인증 확인 중 오류가 발생했습니다.');
      }
    });
  }

  /* ── 3분 카운트다운 타이머 ── */
  function startSmsTimer(seconds) {
    clearInterval(smsTimerInterval);
    const timerEl = document.getElementById('smsTimer');
    timerEl.style.display = 'inline';

    let remaining = seconds;
    timerEl.textContent = formatTime(remaining);

    smsTimerInterval = setInterval(function() {
      remaining--;
      timerEl.textContent = formatTime(remaining);

      if (remaining <= 0) {
        clearInterval(smsTimerInterval);
        timerEl.textContent = '만료';
        timerEl.style.color = '#aaa';
        document.getElementById('btnSendSms').disabled  = false;
        document.getElementById('btnSendSms').textContent = '재발송';
      }
    }, 1000);
  }

  function formatTime(sec) {
    const m = String(Math.floor(sec / 60)).padStart(2, '0');
    const s = String(sec % 60).padStart(2, '0');
    return m + ':' + s;
  }
  
  /* ── 파일 선택 시 파일명 표시 ── */
  function updateFileName(input) {
    const fileName = input.files[0] ? input.files[0].name : '사진 파일 올리기';
    document.getElementById('fileNameText').textContent = fileName;
  }

</script>
</body>
</html>
