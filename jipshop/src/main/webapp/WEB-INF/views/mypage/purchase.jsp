<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>마이페이지 구매내역</title>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

	

  <link rel="stylesheet" href="${contextPath}/resources/css/mypage/purchase.css"> 
 <!--  <link rel="stylesheet" href="/resources/css/mypage/purchase.css"> -->

</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
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

  <div class="content-wrap">
    <main class="content">
      <div class="page-title">마이페이지</div>

      <div class="purchase-summary">
        ${loginUser.userName} 님의 구매 내역
      </div>

      <form action="${contextPath}/mypage/purchase" method="get">
        <div class="filter-row">
          <button class="period-btn" type="submit" name="period" value="7">1주일</button>
          <button class="period-btn" type="submit" name="period" value="30">1개월</button>
          <button class="period-btn" type="submit" name="period" value="90">3개월</button>
          <button class="period-btn" type="submit" name="period" value="180">6개월</button>

          <div class="date-group">
            <input type="date" class="date-input" name="startDate" value="${param.startDate}">
            <span>~</span>
            <input type="date" class="date-input" name="endDate" value="${param.endDate}">
            <button class="search-btn" type="submit">조회</button>
          </div>
        </div>
      </form>

         <div class="table-header">
        <div>상품명/가격</div>
        <div>주문일</div>
        <div>주문 번호</div>
        <div>배송 상황</div>
        <div>구매 취소</div>
      </div>

      <c:choose>
        <c:when test="${empty orderlist}">
          <div class="empty-box">
            구매 한 내역이 없습니다.
          </div>
        </c:when>

        <c:otherwise>
          <div class="purchase-list">
            <c:forEach var="o" items="${orderlist}">
              <div class="purchase-card">
                <div class="product-cell">
                  <%-- <img class="product-thumb" src="${p.productImage}" alt="${p.productName}"> --%>
                  <div class="product-info">
                   <%--  <div class="product-name">${p.productName}</div> --%>
                    <div>${o.orderTotalPrice}원</div>
                  </div>
                </div>

                <div class="info-cell">${o.orderDate}</div>
                <div class="info-cell">${o.orderId}</div>

                <div class="info-cell">
                 <%--  ${o.deliveryStatus}thd d</div> --%>
                  <a href="#" class="status-badge">상세보기</a>
                </div>

                <div class="info-cell">
                     <button class="cancel-btn" type="submit">구매 취소</button>
                </div>
              </div>
            </c:forEach>
          </div>

          <div class="pagination">
            <c:if test="${pi.currentPage > 1}">
              <a class="page-arrow"
                 href="${contextPath}/mypage/purchase?cpage=${pi.currentPage - 1}&startDate=${param.startDate}&endDate=${param.endDate}">
                ◀
              </a>
            </c:if>

            <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
              <a class="page-btn ${p == pi.currentPage ? 'active' : ''}"
                 href="${contextPath}/mypage/purchase?cpage=${p}&startDate=${param.startDate}&endDate=${param.endDate}">
                ${p}
              </a>
            </c:forEach>

            <c:if test="${pi.currentPage < pi.maxPage}">
              <a class="page-arrow"
                 href="${contextPath}/mypage/purchase?cpage=${pi.currentPage + 1}&startDate=${param.startDate}&endDate=${param.endDate}">
                ▶
              </a>
            </c:if>
          </div>
        </c:otherwise>
      </c:choose>
    </main>
  </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>