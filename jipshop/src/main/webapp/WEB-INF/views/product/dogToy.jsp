<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강아지 장난감</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/dogToy.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="page-wrap">

    <h1 class="page-title">강아지</h1>

    <div class="category-box">
        <a href="${pageContext.request.contextPath}/dog/feed" class="category-item">사료</a>
        <a href="${pageContext.request.contextPath}/dog/toy" class="category-item active">장난감</a>
        <a href="${pageContext.request.contextPath}/dog/outdoor" class="category-item">외출용품</a>
        <a href="${pageContext.request.contextPath}/dog/groom" class="category-item">미용용품</a>
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
                <img src="${pageContext.request.contextPath}/resources/img/dogtoy1.png" alt="하트볼 장난감">
            </div>

            <div class="product-info">
                <h2 class="product-name">하트볼 장난감</h2>
                <p class="product-desc">반려견의 흥미를 유도하며 즐겁게 놀 수 있는 공 장난감</p>
                <div class="product-price">25,000 원</div>

                <a href="${pageContext.request.contextPath}/dog/toy/detail?product=1" class="detail-btn">바로가기</a>
            </div>
        </div>

        <!-- 상품 2 -->
        <div class="product-card">
            <div class="wish-icon">♡</div>

            <div class="product-image-box">
                <img src="${pageContext.request.contextPath}/resources/img/dogtoy2.png" alt="프리스비 장난감">
            </div>

            <div class="product-info">
                <h2 class="product-name">프리스비 장난감</h2>
                <p class="product-desc">던지고 물어오며 활동적으로 놀 수 있는 반려견 장난감</p>
                <div class="product-price">25,000 원</div>

                <a href="${pageContext.request.contextPath}/dog/toy/detail?product=2" class="detail-btn">바로가기</a>
            </div>
        </div>

    </div>

</div>

</body>
</html>