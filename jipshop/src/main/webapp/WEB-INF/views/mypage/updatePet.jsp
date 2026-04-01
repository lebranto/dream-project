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
                  <input class="reg-input" type="date" name="petAge" />
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

function updateFileName(input) {
    const fileNameText = document.getElementById('fileNameText');
    if (input.files && input.files.length > 0) {
        fileNameText.textContent = input.files[0].name;
    } else {
        fileNameText.textContent = '사진 파일 올리기';
    }
}


</script>

</html>