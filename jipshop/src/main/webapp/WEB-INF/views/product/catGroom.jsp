<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고양이 미용용품</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/catGroom.css">
</head>
<body>

<div class="page-wrap">

    <h1 class="page-title">고양이</h1>

    <div class="category-box">
        <a href="#" class="category-item">사료</a>
        <a href="#" class="category-item">장난감</a>
        <a href="#" class="category-item">외출용품</a>
        <a href="${pageContext.request.contextPath}/cat/groom" class="category-item active">미용용품</a>
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
                <img src="${pageContext.request.contextPath}/resources/img/catshampoo1.png" alt="이눔 아워스 캣샴푸">
            </div>

            <div class="product-info">
                <h2 class="product-name">이눔 아워스 캣샴푸</h2>
                <p class="product-desc">피부와 털 관리를 도와주는 순한 고양이 미용용품 샴푸</p>
                <div class="product-price">25,000 원</div>

                <a href="${pageContext.request.contextPath}/cat/groom/detail?product=1" class="detail-btn">바로가기</a>
            </div>
        </div>

        <!-- 상품 2 -->
        <div class="product-card">
            <div class="wish-icon">♡</div>

            <div class="product-image-box">
                <img src="${pageContext.request.contextPath}/resources/img/catshampoo2.png" alt="펫룸 버블 샴푸">
            </div>

            <div class="product-info">
                <h2 class="product-name">펫룸 버블 샴푸</h2>
                <p class="product-desc">풍성한 거품으로 깔끔한 세정을 도와주는 고양이 샴푸</p>
                <div class="product-price">25,000 원</div>

                <a href="${pageContext.request.contextPath}/cat/groom/detail?product=2" class="detail-btn">바로가기</a>
            </div>
        </div>

        <!-- 상품 3 -->
        <div class="product-card">
            <div class="wish-icon">♡</div>

            <div class="product-image-box">
                <img src="${pageContext.request.contextPath}/resources/img/catpaste.png" alt="페디슨 덴탈케어 치약">
            </div>

            <div class="product-info">
                <h2 class="product-name">페디슨 덴탈케어 치약</h2>
                <p class="product-desc">반려묘 구강 관리를 도와주는 맞춤형 양치 솔루션 치약</p>
                <div class="product-price">25,000 원</div>

                <a href="${pageContext.request.contextPath}/cat/groom/detail?product=3" class="detail-btn">바로가기</a>
            </div>
        </div>

        <!-- 상품 4 -->
        <div class="product-card">
            <div class="wish-icon">♡</div>

            <div class="product-image-box">
                <img src="${pageContext.request.contextPath}/resources/img/catbrush.png" alt="펫룸 딥포인트 칫솔">
            </div>

            <div class="product-info">
                <h2 class="product-name">펫룸 딥포인트 칫솔</h2>
                <p class="product-desc">세밀한 구강 케어를 도와주는 고양이 전용 미용용품 칫솔</p>
                <div class="product-price">25,000 원</div>

                <a href="${pageContext.request.contextPath}/cat/groom/detail?product=4" class="detail-btn">바로가기</a>
            </div>
        </div>

    </div>

</div>

</body>
</html>