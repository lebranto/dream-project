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
        
        <form action="${contextPath}/mypage/updateMember" method="post" onsubmit="return checkUpdate();">
        
         <div class="reg-field-group">
            <div class="reg-field-label">이메일 <span class="reg-required-dot"></span></div>
            <input class="reg-input" type="email" id="email" placeholder="이메일을 입력하세요." name="email" autocomplete="email" value="${memberEmail}" />
          </div>

          <!-- 이름 -->
          <div class="reg-field-group">
            <div class="reg-field-label">이름 <span class="reg-required-dot"></span></div>
            <input class="reg-input" type="text" id="memberName" placeholder="이름을(를) 입력하세요." name="memberName" value="${memberName}" />
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
              <input class="reg-input" type="tel" id="phone" placeholder="전화번호를 입력하세요 (010-1234-5678)" name="phone" value="${phone}"/>
            </div>
            <input type="hidden" id="phoneVerified" name="phoneVerified" value="N" />
          </div>
           <button type="submit" class="updateBtn">수정하기</button>
        </form>
        
          <c:if test="${not empty errorMsg}">
    			<div class="error-msg">${errorMsg}</div>
		  </c:if>
			
        	<c:if test="${not empty msg}">
  				<script>
    				alert("${msg}");
  				</script>
			</c:if>
          
        </main>
    </div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>

<script>

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

function checkUpdate() {
	  const email      = document.getElementById('email').value.trim();
	  const memberName = document.getElementById('memberName').value.trim();
	  const zipCode    = document.getElementById('zipCode').value.trim();
	  const streetAdr  = document.getElementById('streetAdr').value.trim();
	  const detailAdr  = document.getElementById('detailAdr').value.trim();
	  const phone      = document.getElementById('phone').value.trim();

	  if (email === '') {
	    alert('이메일을 입력해주세요.');
	    document.getElementById('email').focus();
	    return false;
	  }

	  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	  if (!emailRegex.test(email)) {
	    alert('이메일 형식이 올바르지 않습니다. (예: example@email.com)');
	    document.getElementById('email').focus();
	    return false;
	  }

	  if (memberName === '') {
	    alert('이름을 입력해주세요.');
	    document.getElementById('memberName').focus();
	    return false;
	  }

	  if (zipCode === '' || streetAdr === '') {
	    alert('주소 검색 버튼을 눌러 주소를 입력해주세요.');
	    return false;
	  }

	  if (detailAdr === '') {
	    alert('상세 주소를 입력해주세요.');
	    document.getElementById('detailAdr').focus();
	    return false;
	  }

	  if (phone === '') {
	    alert('전화번호를 입력해주세요.');
	    document.getElementById('phone').focus();
	    return false;
	  }

	  const phoneRegex = /^01[016789]-?\d{3,4}-?\d{4}$/;
	  if (!phoneRegex.test(phone)) {
	    alert('전화번호 형식이 올바르지 않습니다. (예: 010-1234-5678)');
	    document.getElementById('phone').focus();
	    return false;
	  }

	  const fullAddress = zipCode + ' ' + streetAdr + ' ' + detailAdr;
	  document.getElementById('address').value = fullAddress;

	  return true;
	}
	
</script>

</html>