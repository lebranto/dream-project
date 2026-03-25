<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강아지 - 사료</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/dogFeed.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="dog-page">

    <section class="category-header">
        <h2>강아지</h2>

        <div class="sub-category-box">
            <a href="${pageContext.request.contextPath}/dog/feed" class="sub-category active">사료</a>
            <a href="${pageContext.request.contextPath}/dog/toy" class="sub-category">장난감</a>
            <a href="#" class="sub-category">외출용품</a>
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
                <img src="${pageContext.request.contextPath}/resources/img/dogSnack.png" alt="시저 쇠고기와 닭고기" class="product-image">
            </div>

            <div class="product-info">
                <p class="product-name">시저 강아지캔</p>
                <p class="product-desc">부드럽고 풍부한 맛으로 즐길 수 있는 강아지용 습식 사료</p>
                <p class="product-price">25,000 원</p>

                <div class="product-bottom">
                    <a href="${pageContext.request.contextPath}/dog/feed/detail?product=1" class="cart-btn">바로가기</a>
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
                <img src="${pageContext.request.contextPath}/resources/img/dogSenior.png" alt="오리젠 시니어" class="product-image">
            </div>

            <div class="product-info">
                <p class="product-name">오리젠 시니어</p>
                <p class="product-desc">노령견을 위한 영양 설계를 담은 프리미엄 강아지 사료</p>
                <p class="product-price">25,000 원</p>

                <div class="product-bottom">
                    <a href="${pageContext.request.contextPath}/dog/feed/detail?product=2" class="cart-btn">바로가기</a>
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
                <img src="${pageContext.request.contextPath}/resources/img/dogAdult.png" alt="뉴트리나 어덜트" class="product-image">
            </div>

            <div class="product-info">
                <p class="product-name">뉴트리나 어덜트</p>
                <p class="product-desc">성견을 위한 균형 잡힌 영양과 건강 관리를 돕는 사료</p>
                <p class="product-price">25,000 원</p>

                <div class="product-bottom">
                    <a href="${pageContext.request.contextPath}/dog/feed/detail?product=3" class="cart-btn">바로가기</a>
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
                <img src="${pageContext.request.contextPath}/resources/img/dogPuppy.png" alt="뉴트리나 퍼피" class="product-image">
            </div>

            <div class="product-info">
                <p class="product-name">뉴트리나 퍼피</p>
                <p class="product-desc">성장기 강아지를 위한 부드럽고 영양 가득한 퍼피 전용 사료</p>
                <p class="product-price">25,000 원</p>

                <div class="product-bottom">
                    <a href="${pageContext.request.contextPath}/dog/feed/detail?product=4" class="cart-btn">바로가기</a>
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