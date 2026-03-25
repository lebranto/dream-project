<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강아지 외출용품</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/dogOutdoor.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="page-wrap">

    <h1 class="page-title">강아지</h1>

    <div class="category-box">
        <a href="#" class="category-item">사료</a>
        <a href="#" class="category-item">장난감</a>
        <a href="${pageContext.request.contextPath}/dog/outdoor" class="category-item active">외출용품</a>
        <a href="${pageContext.request.contextPath}/dog/groom" class="category-item">미용용품</a>
    </div>

    <div class="product-count">상품 4개</div>

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
                <img src="${pageContext.request.contextPath}/resources/img/목줄라지.png" alt="컬러 웨빙 목줄 라지">
            </div>
            <div class="product-info">
                <h2 class="product-name">컬러 웨빙 목줄 라지</h2>
                <p class="product-desc">대형견에게 편안한 착용감을 제공하는 컬러 웨빙 목줄</p>
                <div class="product-price">25,000 원</div>
                <a href="${pageContext.request.contextPath}/dog/outdoor/detail" class="detail-btn">바로가기</a>
            </div>
        </div>

        <!-- 상품 2 -->
        <div class="product-card">
            <div class="wish-icon">♡</div>
            <div class="product-image-box">
                <img src="${pageContext.request.contextPath}/resources/img/목줄미디움.png" alt="컬러 웨빙 목줄 미디움">
            </div>
            <div class="product-info">
                <h2 class="product-name">컬러 웨빙 목줄 미디움</h2>
                <p class="product-desc">중형견에게 안정적인 착용감을 제공하는 웨빙 목줄</p>
                <div class="product-price">25,000 원</div>
                <a href="${pageContext.request.contextPath}/dog/outdoor/detail2" class="detail-btn">바로가기</a>
            </div>
        </div>

        <!-- 상품 3 -->
        <div class="product-card">
            <div class="wish-icon">♡</div>
            <div class="product-image-box">
                <img src="${pageContext.request.contextPath}/resources/img/목줄스몰.png" alt="컬러 웨빙 목줄 스몰">
            </div>
            <div class="product-info">
                <h2 class="product-name">컬러 웨빙 목줄 스몰</h2>
                <p class="product-desc">소형견에게 가볍고 편안한 착용감을 주는 컬러 목줄</p>
                <div class="product-price">25,000 원</div>
                <a href="${pageContext.request.contextPath}/dog/outdoor/detail3" class="detail-btn">바로가기</a>
            </div>
        </div>

        <!-- 상품 4 -->
        <div class="product-card">
            <div class="wish-icon">♡</div>
            <div class="product-image-box">
                <img src="${pageContext.request.contextPath}/resources/img/led.png" alt="젤리곰 LED 블링커">
            </div>
            <div class="product-info">
                <h2 class="product-name">젤리곰 LED 블링커</h2>
                <p class="product-desc">야간 산책 시 시인성을 높여주는 LED 안전 외출용품</p>
                <div class="product-price">25,000 원</div>
                <a href="${pageContext.request.contextPath}/dog/outdoor/detail4" class="detail-btn">바로가기</a>
            </div>
        </div>

    </div>

</div>

</body>
</html>