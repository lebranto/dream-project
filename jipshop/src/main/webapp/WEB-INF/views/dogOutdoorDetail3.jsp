<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>컬러 웨빙 목줄 스몰 상세페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/dogOutdoorDetail.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="detail-container">

    <div class="product-top">
        <div class="product-image-area">
            <img src="${pageContext.request.contextPath}/resources/img/목줄스몰.png" alt="컬러 웨빙 목줄 스몰">
        </div>

        <div class="product-info-area">
            <h1 class="product-title">컬러 웨빙 목줄 스몰</h1>
            <div class="product-price">25,000원</div>

            <p class="product-desc">
                소형견에게 가볍고 편안한 착용감을 주는 외출용 웨빙 목줄입니다.<br>
                귀여운 디자인과 실용성을 함께 갖춘 제품입니다.
            </p>

            <div class="product-button-group">
                <button type="button" class="cart-btn">장바구니</button>
                <button type="button" class="buy-btn">구매하기</button>
            </div>
        </div>
    </div>

    <div class="detail-tab-wrap">
        <a href="#detailInfo" class="detail-tab-btn">상세정보</a>
        <a href="#deliveryInfo" class="detail-tab-btn">배송안내</a>
    </div>

    <div class="detail-view-wrap">
        <div id="detailInfo" class="detail-content-box">
            <h2>상세정보</h2>
            <img src="${pageContext.request.contextPath}/resources/img/목줄스몰디테일.png" alt="컬러 웨빙 목줄 스몰 상세정보">
        </div>

        <div id="deliveryInfo" class="detail-content-box">
            <h2>배송안내</h2>

            <div class="delivery-section">
                <h3>배송비</h3>
                <p>기본배송료는 <span class="point-text">3,000원</span> 입니다.</p>
                <p>(제주 4,000원 / 도서산간 7,000원 추가 배송비가 부과됩니다.)</p>
            </div>

            <div class="delivery-section">
                <h3>평균 배송일</h3>
                <p>본 상품의 평균 배송일은 <span class="point-text">2일</span>입니다.</p>
                <p>[배송예정일은 주문시점에 따라 차이가 발생할 수 있습니다.]</p>
            </div>

            <div class="delivery-section">
                <h3>교환 / 반품 안내</h3>
                <p>단순 변심에 의한 교환/반품은 수령 후 7일 이내 가능합니다.</p>
                <p>상품 훼손 및 사용 흔적이 있는 경우 교환/반품이 제한될 수 있습니다.</p>
            </div>
        </div>
    </div>

</div>

</body>
</html>