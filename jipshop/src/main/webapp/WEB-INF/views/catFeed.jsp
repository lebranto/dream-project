<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고양이 - 사료</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/catFeed.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="cat-page">

    <section class="category-header">
        <h2>
            <a href="${pageContext.request.contextPath}/cat/feed" class="category-title-link">고양이</a>
        </h2>

        <div class="sub-category-box">
            <a href="${pageContext.request.contextPath}/cat/feed" class="sub-category active">사료</a>
            <a href="${pageContext.request.contextPath}/cat/toy" class="sub-category">장난감</a>
            <a href="${pageContext.request.contextPath}/cat/outdoor" class="sub-category">외출용품</a>
            <a href="${pageContext.request.contextPath}/cat/groom" class="sub-category">미용용품</a>
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
                <img src="${pageContext.request.contextPath}/resources/img/사료보양대첩.png" alt="보양대첩 파우치" class="product-image">
            </div>

            <div class="product-info">
                <p class="product-name">보양대첩 파우치</p>
                <p class="product-desc">촉촉한 식감과 영양 밸런스를 담은 고양이용 파우치 사료</p>
                <p class="product-price">25,000 원</p>

                <div class="product-bottom">
                    <a href="${pageContext.request.contextPath}/cat/feed/detail?product=1" class="cart-btn">바로가기</a>
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
                <img src="${pageContext.request.contextPath}/resources/img/캔보양대첩.png" alt="보양대첩 캔" class="product-image">
            </div>

            <div class="product-info">
                <p class="product-name">보양대첩 캔</p>
                <p class="product-desc">부드러운 캔 타입으로 맛있게 급여할 수 있는 고양이용 습식 사료</p>
                <p class="product-price">25,000 원</p>

                <div class="product-bottom">
                    <a href="${pageContext.request.contextPath}/cat/feed/detail?product=2" class="cart-btn">바로가기</a>
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
                <img src="${pageContext.request.contextPath}/resources/img/catFeed1.png" alt="캣츠랑 비타플러스" class="product-image">
            </div>

            <div class="product-info">
                <p class="product-name">캣츠랑 비타플러스</p>
                <p class="product-desc">영양 설계를 더한 데일리 고양이 건식 사료</p>
                <p class="product-price">25,000 원</p>

                <div class="product-bottom">
                    <a href="${pageContext.request.contextPath}/cat/feed/detail?product=3" class="cart-btn">바로가기</a>
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
                <img src="${pageContext.request.contextPath}/resources/img/catFeed2.png" alt="캣츠랑 리브레" class="product-image">
            </div>

            <div class="product-info">
                <p class="product-name">캣츠랑 리브레</p>
                <p class="product-desc">부드러운 밸런스와 풍부한 영양을 담은 고양이 사료</p>
                <p class="product-price">25,000 원</p>

                <div class="product-bottom">
                    <a href="${pageContext.request.contextPath}/cat/feed/detail?product=4" class="cart-btn">바로가기</a>
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