<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고양이 외출용품 상세페이지</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/catOutdoorDetail.css">

</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<c:set var="product" value="${param.product}" />
<c:set var="loginUser" value="${sessionScope.loginUser}" />

<div class="outdoor-detail-page">

    <!-- 상품 상단 -->
    <div class="outdoor-detail-top">

        <div class="outdoor-image-box">
            <c:choose>
                <c:when test="${product eq '1'}">
                    <img src="${pageContext.request.contextPath}/resources/img/catkennel1.png" class="outdoor-detail-image">
                </c:when>
                <c:when test="${product eq '2'}">
                    <img src="${pageContext.request.contextPath}/resources/img/catkennel2.png" class="outdoor-detail-image">
                </c:when>
            </c:choose>
        </div>

        <div class="outdoor-info-box">
            <c:choose>
                <c:when test="${product eq '1'}">
                    <h2 class="outdoor-title">펫모드 스카이켄넬 미니 050</h2>
                    <p class="outdoor-price">25,000원</p>
                    <p class="outdoor-desc">
                        편안하고 안정감 있는 이동을 도와주는 고양이 외출용 켄넬입니다.<br>
                        이동 시 반려묘를 안전하게 보호할 수 있는 제품입니다.
                    </p>
                </c:when>

                <c:when test="${product eq '2'}">
                    <h2 class="outdoor-title">패리스독 얼반 원형 돔캐리어</h2>
                    <p class="outdoor-price">25,000원</p>
                    <p class="outdoor-desc">
                        외출 시 반려묘를 안전하고 편안하게 이동할 수 있는 캐리어입니다.<br>
                        실용적인 구조와 편안한 공간감을 제공하는 제품입니다.
                    </p>
                </c:when>
            </c:choose>

            <div class="outdoor-btn-group">
                <button type="button" class="main-action-btn">장바구니</button>
                <button type="button" class="main-action-btn">구매하기</button>
            </div>
        </div>

    </div>

    <!-- 탭 -->
    <div class="outdoor-tab-wrap">
        <button class="outdoor-tab-btn active" onclick="toggleSection('detailInfo', this)">상세보기</button>
        <button class="outdoor-tab-btn" onclick="toggleSection('reviewInfo', this)">리뷰작성</button>
    </div>

    <!-- 상세 -->
    <div id="detailInfo" class="outdoor-content-box" style="display:block;">
        <div class="outdoor-detail-content-image-wrap">
            <c:choose>
                <c:when test="${product eq '1'}">
                    <img src="${pageContext.request.contextPath}/resources/img/catkennelDetail1.png" class="outdoor-detail-content-image">
                </c:when>
                <c:when test="${product eq '2'}">
                    <img src="${pageContext.request.contextPath}/resources/img/catkennelDetail2.png" class="outdoor-detail-content-image">
                </c:when>
            </c:choose>
        </div>
    </div>

    <!-- 리뷰 -->
    <div id="reviewInfo" class="outdoor-content-box">

        <div class="review-area-box">

            <div class="review-list-wrap">

                <div class="review-item review-bg-1">
                    <div class="review-main-text">▶ 배송이 아주 빨랐습니다!</div>
                    <div class="review-meta">강진솔 | 2026-03-24</div>

                    <div class="review-help-area">
                        <button class="review-help-btn" onclick="checkLoginAndLike(this)">도움돼요</button>
                        <button class="review-like-btn" onclick="checkLoginAndLike(this)">👍</button>
                        <span class="review-like-count">0</span>
                    </div>
                </div>

                <div class="review-item review-bg-2">
                    <div class="review-main-text">▶ 우리 아이가 좋아해요!</div>
                    <div class="review-meta">강진솔 | 2026-03-24</div>

                    <div class="review-help-area">
                        <button class="review-help-btn" onclick="checkLoginAndLike(this)">도움돼요</button>
                        <button class="review-like-btn" onclick="checkLoginAndLike(this)">👍</button>
                        <span class="review-like-count">0</span>
                    </div>
                </div>

                <div class="review-page-num">1</div>
            </div>

            <div class="review-write-wrap">
                <form onsubmit="return checkLoginAndSubmit();">
                    <div class="review-input-box">
                        <textarea class="review-textarea" placeholder="리뷰를 작성해주세요."></textarea>
                    </div>

                    <div class="review-submit-area">
                        <button class="review-submit-btn">리뷰등록</button>
                    </div>
                </form>
            </div>

        </div>

    </div>

</div>

<script>

const isLogin = ${loginUser != null ? 'true' : 'false'};

function toggleSection(id, btn) {
    document.getElementById("detailInfo").style.display = "none";
    document.getElementById("reviewInfo").style.display = "none";

    document.querySelectorAll(".outdoor-tab-btn").forEach(b => b.classList.remove("active"));

    document.getElementById(id).style.display = "block";
    btn.classList.add("active");
}

function checkLoginAndSubmit() {
    if (!isLogin) {
        alert("로그인 후 이용 가능합니다.");
        return false;
    }
    return true;
}

function checkLoginAndLike(btn) {
    if (!isLogin) {
        alert("로그인 후 이용 가능합니다.");
        return;
    }

    const item = btn.closest(".review-item");
    const count = item.querySelector(".review-like-count");

    let num = parseInt(count.innerText);

    if (item.classList.contains("liked")) {
        item.classList.remove("liked");
        count.innerText = num - 1;
    } else {
        item.classList.add("liked");
        count.innerText = num + 1;
    }
}

</script>

</body>
</html>