<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>마이페이지 구매내역</title>

  <c:set var="contextPath" value="${pageContext.request.contextPath}" />
  <link rel="stylesheet" href="${contextPath}/resources/css/mypage/orderDetail.css">

</head>
<body>

  <jsp:include page="/WEB-INF/views/common/header.jsp" />
  
  

  <aside class="sidebar">
  
  <jsp:include page="/WEB-INF/views/common/myPageSidebar.jsp" />
    
  </aside>
  
  <div class="content-wrap">
  
  <div class="content-inner">

    <div class="mypage-title">
      마이페이지
    </div>

    <div class="order-box">

     
        <div class="order-item">

          <div class="order-top">
            <div class="order-img">
            	사진
              <%-- <img src="${contextPath}${order.photo1}" alt="상품이미지"> --%>
            </div>

            <div class="order-info">
            상품
              <%-- <div>${o.productName}</div> --%>
              <div>
                <%-- <fmt:formatNumber value="${order.price}" pattern="#,###"/> --%>0원
              </div>
              주문 번호
              <%-- <div>${o.orderId}</div> --%>
            </div>
          </div>

          <div class="order-status">
            <span>배송중</span>
            <span class="dot-group">● ● ● ● ●</span>
            <span>배송완료</span>
          </div>

          <div class="order-detail">
            <div>출발지 : 여기</div>
            <div>도착지 : 저기</div>
            <div>
              도착 예정일 : 2026-03-02
              <%-- <fmt:formatDate value="20260321" pattern="MM월 dd일 HH시"/> --%>
            </div>
          </div>

        </div>
     

    </div>

  </div>
  
  
  
  </div>

  <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>