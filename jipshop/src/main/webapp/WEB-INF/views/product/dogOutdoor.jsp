<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강아지 - 외출용품</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/dogOutdoor.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="dog-page">

    <section class="category-header">
        <h2>강아지</h2>

        <div class="sub-category-box">
            <a href="${pageContext.request.contextPath}/dog/feed" class="sub-category">사료</a>
            <a href="${pageContext.request.contextPath}/dog/toy" class="sub-category">장난감</a>
            <a href="${pageContext.request.contextPath}/dog/outdoor" class="sub-category active">외출용품</a>
            <a href="${pageContext.request.contextPath}/dog/groom" class="sub-category">미용용품</a>
        </div>
    </section>

    <section class="product-top">
        <p class="product-count">상품 4개</p>

        <div class="sort-wrap">
            <button type="button" class="sort-btn">낮은가격</button>
            <button type="button" class="sort-btn">높은 가격</button>
            <button type="button" class="sort-btn">조회순</button>
            <button type="button" class="sort-btn">최신순</button>
        </div>
    </section>

    <section class="product-list">

        <!-- 상품 1 -->
        <div class="product-card">
            <button type="button" class="wish-btn" aria-label="찜하기">
                <span class="heart-outline">♡</span>
                <span class="heart-fill">♥</span>
            </button>

            <div class="product-image-wrap">
                <img src="${pageContext.request.contextPath}/resources/img/목줄라지.png" alt="컬러 웨빙 목줄 라지" class="product-image">
            </div>

            <div class="product-info">
                <p class="product-name">컬러 웨빙 목줄 라지</p>
                <p class="product-desc">대형견에게 편안한 착용감을 제공하는 외출용 웨빙 목줄</p>
                <p class="product-price">25,000 원</p>

                <div class="product-bottom">
                    <a href="${pageContext.request.contextPath}/dog/outdoor/detail?product=1" class="cart-btn">바로가기</a>
                    <span class="cart-icon">🛒</span>
                </div>
            </div>
        </div>

        <!-- 상품 2 -->
        <div class="product-card">
            <button type="button" class="wish-btn" aria-label="찜하기">
                <span class="heart-outline">♡</span>
                <span class="heart-fill">♥</span>
            </button>

            <div class="product-image-wrap">
                <img src="${pageContext.request.contextPath}/resources/img/목줄미디움.png" alt="컬러 웨빙 목줄 미디움" class="product-image">
            </div>

            <div class="product-info">
                <p class="product-name">컬러 웨빙 목줄 미디움</p>
                <p class="product-desc">중형견에게 안정적인 착용감을 제공하는 웨빙 목줄</p>
                <p class="product-price">25,000 원</p>

                <div class="product-bottom">
                    <a href="${pageContext.request.contextPath}/dog/outdoor/detail?product=2" class="cart-btn">바로가기</a>
                    <span class="cart-icon">🛒</span>
                </div>
            </div>
        </div>

        <!-- 상품 3 -->
        <div class="product-card">
            <button type="button" class="wish-btn" aria-label="찜하기">
                <span class="heart-outline">♡</span>
                <span class="heart-fill">♥</span>
            </button>

            <div class="product-image-wrap">
                <img src="${pageContext.request.contextPath}/resources/img/목줄스몰.png" alt="컬러 웨빙 목줄 스몰" class="product-image">
            </div>

            <div class="product-info">
                <p class="product-name">컬러 웨빙 목줄 스몰</p>
                <p class="product-desc">소형견에게 가볍고 편안한 착용감을 주는 컬러 목줄</p>
                <p class="product-price">25,000 원</p>

                <div class="product-bottom">
                    <a href="${pageContext.request.contextPath}/dog/outdoor/detail?product=3" class="cart-btn">바로가기</a>
                    <span class="cart-icon">🛒</span>
                </div>
            </div>
        </div>

        <!-- 상품 4 -->
        <div class="product-card">
            <button type="button" class="wish-btn" aria-label="찜하기">
                <span class="heart-outline">♡</span>
                <span class="heart-fill">♥</span>
            </button>

            <div class="product-image-wrap">
                <img src="${pageContext.request.contextPath}/resources/img/led.png" alt="젤리곰 LED 블링커" class="product-image">
            </div>

            <div class="product-info">
                <p class="product-name">젤리곰 LED 블링커</p>
                <p class="product-desc">야간 산책 시 시인성을 높여주는 LED 안전 외출용품</p>
                <p class="product-price">25,000 원</p>

                <div class="product-bottom">
                    <a href="${pageContext.request.contextPath}/dog/outdoor/detail?product=4" class="cart-btn">바로가기</a>
                    <span class="cart-icon">🛒</span>
                </div>
            </div>
        </div>

    </section>

    <section class="pagination">
        <button class="page-arrow">&lt;</button>
        <a href="#" class="page-num active">1</a>
        <a href="#" class="page-num">2</a>
        <a href="#" class="page-num">3</a>
        <a href="#" class="page-num">4</a>
        <a href="#" class="page-num">5</a>
        <button class="page-arrow">&gt;</button>
    </section>

</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const wishButtons = document.querySelectorAll(".wish-btn");

    wishButtons.forEach(function (button) {
        button.addEventListener("click", function () {
            button.classList.toggle("active");
        });
    });
});
</script>

</body>
</html>