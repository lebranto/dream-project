<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고양이 외출용품</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/catOutdoor.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="page-wrap">

    <h1 class="page-title">고양이</h1>

    <div class="category-box">
        <a href="${pageContext.request.contextPath}/cat/feed" class="category-item">사료</a>
        <a href="${pageContext.request.contextPath}/cat/toy" class="category-item">장난감</a>
        <a href="${pageContext.request.contextPath}/cat/outdoor" class="category-item active">외출용품</a>
        <a href="${pageContext.request.contextPath}/cat/groom" class="category-item">미용용품</a>
    </div>

    <div class="product-count">상품 2개</div>

    <div class="sort-box">
        <button type="button" class="sort-btn">낮은가격</button>
        <button type="button" class="sort-btn">높은 가격</button>
        <button type="button" class="sort-btn">조회순</button>
        <button type="button" class="sort-btn">최신순</button>
    </div>

    <div class="product-list">

        <!-- 상품 1 -->
        <div class="product-card">
            <div class="wish-icon">♡</div>

            <div class="product-image-box">
                <img src="${pageContext.request.contextPath}/resources/img/catkennel1.png" alt="펫모드 스카이켄넬 미니 050">
            </div>

            <div class="product-info">
                <h2 class="product-name">펫모드 스카이켄넬 미니 050</h2>
                <p class="product-desc">편안하고 안정감 있는 이동을 도와주는 고양이 외출용 켄넬</p>
                <div class="product-price">25,000 원</div>

                <a href="${pageContext.request.contextPath}/cat/outdoor/detail?product=1" class="detail-btn">바로가기</a>
            </div>
        </div>

        <!-- 상품 2 -->
        <div class="product-card">
            <div class="wish-icon">♡</div>

            <div class="product-image-box">
                <img src="${pageContext.request.contextPath}/resources/img/catkennel2.png" alt="패리스독 얼반 원형 돔캐리어">
            </div>

            <div class="product-info">
                <h2 class="product-name">패리스독 얼반 원형 돔캐리어</h2>
                <p class="product-desc">외출 시 반려묘를 안전하고 편안하게 이동할 수 있는 캐리어</p>
                <div class="product-price">25,000 원</div>

                <a href="${pageContext.request.contextPath}/cat/outdoor/detail?product=2" class="detail-btn">바로가기</a>
            </div>
        </div>

    </div>

</div>

</body>
</html>