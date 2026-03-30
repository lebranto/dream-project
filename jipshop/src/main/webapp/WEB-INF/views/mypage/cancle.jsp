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
    <jsp:include page="/WEB-INF/views/common/myPageSidebar.jsp" />
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

취소를 원하시면 비밀번호 입력과 취소 사유를 적으시고 확인을 눌러주세요.
        </div>     
      </div>
       <form action="${contextPath}/mypage/cancle" method="post" onsubmit="return validateForm();">
       <input type="hidden" name="orderId" value="${orderList.orderId}">
      
      
     <div class="form-area">
  <div class="form-row">
    <button class="label-box" type="button">비밀번호</button>
    <input type="password"
           name="userPwd"
           id="passwordInput"
           class="password-input"
           placeholder="비밀번호를 입력해주세요">
  </div>

  <div class="form-row">
    <button class="label-box" type="button">취소 사유</button>
    <textarea name="cancelReason"
              id="cancelReason"
              class="reason-input"
              placeholder="취소 사유를 입력해주세요"></textarea>
  </div>

  <div class="btn-row">
    <button class="confirm-btn" type="submit">확인</button>
  </div>
</div>
    </form>
    </main>
  </div>
  <jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script>
function validateForm() {
  const pwd = document.getElementById("passwordInput").value.trim();
  const reason = document.getElementById("cancelReason").value.trim();

  if (pwd === "") {
    alert("비밀번호를 입력해주세요.");
    return false;
  }

  if (reason === "") {
    alert("취소 사유를 입력해주세요.");
    return false;
  }

  return true;
}
</script>


</body>
</html>