<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고양이 - 장난감</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/catToy.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="cat-page">

    <section class="category-header">
        <h2>
            <a href="${pageContext.request.contextPath}/cat/feed" class="category-title-link">고양이</a>
        </h2>

        <div class="sub-category-box">
            <a href="${pageContext.request.contextPath}/cat/feed" class="sub-category">사료</a>
            <a href="${pageContext.request.contextPath}/cat/toy" class="sub-category active">장난감</a>
            <a href="${pageContext.request.contextPath}/cat/outdoor" class="sub-category">외출용품</a>
            <a href="${pageContext.request.contextPath}/cat/groom" class="sub-category">미용용품</a>
        </div>
    </section>

    <section class="product-top">
        <p class="product-count">상품 2개</p>

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
                <img src="${pageContext.request.contextPath}/resources/img/cattoy1.png" alt="고양이 깃털 장난감" class="product-image">
            </div>

            <div class="product-info">
                <p class="product-name">고양이 깃털 장난감</p>
                <p class="product-desc">호기심을 자극하며 활동적인 놀이를 도와주는 고양이 장난감</p>
                <p class="product-price">25,000 원</p>

                <div class="product-bottom">
                    <a href="${pageContext.request.contextPath}/cat/toy/detail?product=1" class="cart-btn">바로가기</a>
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
                <img src="${pageContext.request.contextPath}/resources/img/cattoy2.png" alt="아보카도 캣닢볼" class="product-image">
            </div>

            <div class="product-info">
                <p class="product-name">아보카도 캣닢볼</p>
                <p class="product-desc">캣닢의 향으로 흥미를 유도해 혼자서도 즐길 수 있는 장난감</p>
                <p class="product-price">25,000 원</p>

                <div class="product-bottom">
                    <a href="${pageContext.request.contextPath}/cat/toy/detail?product=2" class="cart-btn">바로가기</a>
                    <span class="cart-icon">🛒</span>
                </div>
            </div>
        </div>

    </section>

</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const wishButtons = document.querySelectorAll(".wish-btn");

    wishButtons.forEach(function (button) {
        button.addEventListener("click", function (e) {
            e.preventDefault();
            e.stopPropagation();
            button.classList.toggle("active");
        });
    });
});
</script>

</body>
</html>