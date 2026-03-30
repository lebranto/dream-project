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
 <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700&display=swap" rel="stylesheet">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberEnrollForm.css">
 
 <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
 <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
   <aside class="sidebar">
      <jsp:include page="/WEB-INF/views/common/myPageSidebar.jsp" />
  </aside>

    <div class="content-wrap">
        <main class="content">
        
        <form action="${contextPath}/mypage/updatePet" method="post" enctype="multipart/form-data">
        
              <div class="reg-pet-card">
                <div class="reg-pet-form-title">애완동물 정보</div>
                <!-- 어느 애완 동물의 사진을 바꿀지 구분하기 위해 넣은것 -->
                <input type="hidden" name="petNo" value="${pet.petNo}">

                <!-- 사진 등록 -->
				<label class="reg-file-label" for="petPhoto" id="fileLabel">
				  📁&nbsp; <span id="fileNameText">사진 파일 올리기</span>
				  <input id="petPhoto" type="file" accept="image/*" style="display:none;" name="petPhotoFile" 
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
         	 <button type="submit" class=updateBtn onclick="checkUpdate()">수정하기</button>
        
        </form>
        
          <c:if test="${not empty errorMsg}">
    			<div class="error-msg">${errorMsg}</div>
		  </c:if>
			
        
          
        </main>
    </div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>

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
    alert('주소 검색 버튼을 눌러 도로명 주소를 선택해주세요.');
    return false;
  }
}

/* ── 정보 수정 유효 검사 ── */
function checkUpdate() {
const email           = document.getElementById('email').value.trim();
const memberName      = document.getElementById('memberName').value.trim();
const zipCode         = document.getElementById('zipCode').value.trim();
const streetAdr       = document.getElementById('streetAdr').value.trim();
const detailAdr       = document.getElementById('detailAdr').value.trim();
const phone           = document.getElementById('phone').value.trim();



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


//주소 — 우편번호 & 도로명 주소
if (zipCode === '' || streetAdr === '') {
alert('주소 검색 버튼을 눌러 주소를 입력해주세요.');
return;
}

//상세 주소
if (detailAdr === '') {
  alert('상세 주소를 입력해주세요.');
  document.getElementById('detailAdr').focus();
  return;
}

//모든 검사 통과 → address 합산 후 폼 제출
const fullAddress = zipCode + ' ' + streetAdr + ' ' + detailAdr;
document.getElementById('address').value = fullAddress;


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


}





</script>

</html>