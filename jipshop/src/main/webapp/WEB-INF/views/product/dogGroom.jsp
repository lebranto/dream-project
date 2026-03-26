<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강아지 - 미용용품</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/dogGroom.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="dog-page">

    <section class="category-header">
        <h2>강아지</h2>

        <div class="sub-category-box">
            <a href="${pageContext.request.contextPath}/dog/feed" class="sub-category">사료</a>
            <a href="${pageContext.request.contextPath}/dog/toy" class="sub-category">장난감</a>
            <a href="${pageContext.request.contextPath}/dog/outdoor" class="sub-category">외출용품</a>
            <a href="${pageContext.request.contextPath}/dog/groom" class="sub-category active">미용용품</a>
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

        <div class="product-card">
            <button type="button" class="wish-btn" aria-label="찜하기">
                <span class="heart-outline">♡</span>
                <span class="heart-fill">♥</span>
            </button>

            <div class="product-image-wrap">
                <img src="${pageContext.request.contextPath}/resources/img/dogshampoo1.png" alt="강아지 오트 샴푸" class="product-image">
            </div>

            <div class="product-info">
                <p class="product-name">강아지 오트 샴푸</p>
                <p class="product-desc">피부와 털 관리를 도와주는 순한 강아지 미용용품 샴푸</p>
                <p class="product-price">25,000 원</p>

                <div class="product-bottom">
                    <a href="${pageContext.request.contextPath}/dog/groom/detail?product=1" class="cart-btn">바로가기</a>
                    <span class="cart-icon">🛒</span>
                </div>
            </div>
        </div>

        <div class="product-card">
            <button type="button" class="wish-btn" aria-label="찜하기">
                <span class="heart-outline">♡</span>
                <span class="heart-fill">♥</span>
            </button>

            <div class="product-image-wrap">
                <img src="${pageContext.request.contextPath}/resources/img/dogshampoo2.png" alt="강아지 발레리안 샴푸" class="product-image">
            </div>

            <div class="product-info">
                <p class="product-name">강아지 발레리안 샴푸</p>
                <p class="product-desc">은은한 향과 함께 깔끔한 세정을 도와주는 강아지 샴푸</p>
                <p class="product-price">25,000 원</p>

                <div class="product-bottom">
                    <a href="${pageContext.request.contextPath}/dog/groom/detail?product=2" class="cart-btn">바로가기</a>
                    <span class="cart-icon">🛒</span>
                </div>
            </div>
        </div>

        <div class="product-card">
            <button type="button" class="wish-btn" aria-label="찜하기">
                <span class="heart-outline">♡</span>
                <span class="heart-fill">♥</span>
            </button>

            <div class="product-image-wrap">
                <img src="${pageContext.request.contextPath}/resources/img/dogpaste.png" alt="강아지 덴탈 치약" class="product-image">
            </div>

            <div class="product-info">
                <p class="product-name">강아지 덴탈 치약</p>
                <p class="product-desc">입 냄새 관리와 구강 청결에 도움을 주는 강아지 전용 치약</p>
                <p class="product-price">25,000 원</p>

                <div class="product-bottom">
                    <a href="${pageContext.request.contextPath}/dog/groom/detail?product=3" class="cart-btn">바로가기</a>
                    <span class="cart-icon">🛒</span>
                </div>
            </div>
        </div>

        <div class="product-card">
            <button type="button" class="wish-btn" aria-label="찜하기">
                <span class="heart-outline">♡</span>
                <span class="heart-fill">♥</span>
            </button>

            <div class="product-image-wrap">
                <img src="${pageContext.request.contextPath}/resources/img/dogbrush.png" alt="강아지 소프트 칫솔" class="product-image">
            </div>

            <div class="product-info">
                <p class="product-name">강아지 소프트 칫솔</p>
                <p class="product-desc">반려견의 치아와 잇몸을 부드럽게 관리할 수 있는 강아지 전용 칫솔</p>
                <p class="product-price">25,000 원</p>

                <div class="product-bottom">
                    <a href="${pageContext.request.contextPath}/dog/groom/detail?product=4" class="cart-btn">바로가기</a>
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