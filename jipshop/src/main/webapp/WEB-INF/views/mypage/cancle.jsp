<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>취소 확인 페이지</title>

 <c:set var="contextPath" value="${pageContext.request.contextPath}" />
 <link rel="stylesheet" href="${contextPath}/resources/css/mypage/cancle.css">


</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
  <div class="page">
    <!-- 왼쪽 메뉴 -->
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


    <!-- 오른쪽 본문 -->
    <main class="content">
      <div class="title-box">마이페이지</div>

      <div class="cancel-box">
        <div class="top-area">
          <div class="product-image">
            <img src="https://images.unsplash.com/photo-1561037404-61cd46aa615b?auto=format&fit=crop&w=400&q=80" alt="상품 이미지">
          </div>

          <div class="top-text">
            ${orderList.productName}을 구매 취소하시겠습니까?
          </div>
        </div>

        <div class="notice-text">
제작사의 사정에 따라 취소 금액이 늦게 들어올 수 있으며
한번 취소된 상품은 다시 되돌릴 수 없습니다.

취소를 원하시면 비밀번호 입력과 확인을 눌러주십시오
        </div>
      </div>
       <form action="${contextPath}/mypage/cancle" method="post" onsubmit="return validateForm();">
       <input type="hidden" name="orderId" value="${orderList.orderId}">

      <div class="bottom-area">
        <button class="label-box" type="button">비밀번호</button>
        <input type="password" name="userPwd" id="passwordInput" class="password-input" placeholder="비밀번호 입력칸">
        <button class="confirm-btn" type="submit">확인</button>
      </div>
    </form>
    </main>
  </div>
  <jsp:include page="/WEB-INF/views/common/footer.jsp" />

  <script>
    function checkPassword() {
      const password = document.getElementById("passwordInput").value.trim();

      if (password === "") {
        alert("비밀번호를 입력해주세요.");
        return;
      }

      alert("취소가 완료되었습니다.");
    }
  </script>
</body>
</html>