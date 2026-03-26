<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강아지 장난감 상세페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/dogToyDetail.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<c:set var="product" value="${param.product}" />
<c:set var="loginUser" value="${sessionScope.loginUser}" />

<div class="detail-container">

    <div class="product-top">
        <div class="product-image-area">
            <c:choose>
                <c:when test="${product eq '1'}">
                    <img src="${pageContext.request.contextPath}/resources/img/dogtoy1.png" alt="하트볼 장난감">
                </c:when>
                <c:when test="${product eq '2'}">
                    <img src="${pageContext.request.contextPath}/resources/img/dogtoy2.png" alt="프리스비 장난감">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/resources/img/dogtoy1.png" alt="강아지 장난감">
                </c:otherwise>
            </c:choose>
        </div>

        <div class="product-info-area">
            <c:choose>
                <c:when test="${product eq '1'}">
                    <h1 class="product-title">하트볼 장난감</h1>
                    <div class="product-price">25,000원</div>
                    <p class="product-desc">
                        반려견의 흥미를 유도하며 즐겁게 놀 수 있는 공 장난감입니다.<br>
                        부드러운 촉감과 귀여운 디자인으로 편안하게 사용할 수 있는 제품입니다.
                    </p>
                </c:when>

                <c:when test="${product eq '2'}">
                    <h1 class="product-title">프리스비 장난감</h1>
                    <div class="product-price">25,000원</div>
                    <p class="product-desc">
                        던지고 물어오며 활동적으로 놀 수 있는 반려견 장난감입니다.<br>
                        야외 놀이와 실내 놀이 모두 활용할 수 있는 가벼운 제품입니다.
                    </p>
                </c:when>

                <c:otherwise>
                    <h1 class="product-title">강아지 장난감</h1>
                    <div class="product-price">25,000원</div>
                    <p class="product-desc">반려견이 즐겁게 놀 수 있는 장난감입니다.</p>
                </c:otherwise>
            </c:choose>

            <div class="product-button-group">
                <button type="button" class="cart-btn">장바구니</button>
                <button type="button" class="buy-btn">구매하기</button>
            </div>
        </div>
    </div>

    <div class="detail-tab-wrap">
        <button type="button" class="detail-tab-btn" onclick="toggleSection('detailInfo', this)">상세보기</button>
        <button type="button" class="detail-tab-btn" onclick="toggleSection('reviewInfo', this)">리뷰작성</button>
    </div>

    <!-- 상세보기 -->
    <div id="detailInfo" class="detail-content-box">
        <div class="detail-image-wrap">
            <c:choose>
                <c:when test="${product eq '1'}">
                    <img src="${pageContext.request.contextPath}/resources/img/dogtoyDetail1.png" alt="하트볼 장난감 상세정보">
                </c:when>
                <c:when test="${product eq '2'}">
                    <img src="${pageContext.request.contextPath}/resources/img/dogtoyDetail2.png" alt="프리스비 장난감 상세정보">
                </c:when>
                <c:otherwise>
                    <p>상품 상세정보가 준비 중입니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- 리뷰작성 -->
    <div id="reviewInfo" class="detail-content-box">
        <div class="review-area-box">

            <div class="review-list-wrap">

                <div class="review-item review-bg-1">
                    <div class="review-main-text">▶ 배송이 아주 빨랐습니다!</div>
                    <div class="review-meta">강진솔 | 2026-03-24</div>

                    <div class="review-help-area">
                        <button type="button" class="review-help-btn" onclick="checkLoginAndLike(this)">도움돼요</button>
                        <button type="button" class="review-like-btn" onclick="checkLoginAndLike(this)">👍</button>
                        <span class="review-like-count">0</span>
                    </div>
                </div>

                <div class="review-item review-bg-2">
                    <div class="review-main-text">▶ 우리 아이가 잘 가지고 놀아요!</div>
                    <div class="review-meta">강진솔 | 2026-03-24</div>

                    <div class="review-help-area">
                        <button type="button" class="review-help-btn" onclick="checkLoginAndLike(this)">도움돼요</button>
                        <button type="button" class="review-like-btn" onclick="checkLoginAndLike(this)">👍</button>
                        <span class="review-like-count">0</span>
                    </div>
                </div>

                <div class="review-page-num">1</div>
            </div>

            <div class="review-write-wrap">
                <form action="${pageContext.request.contextPath}/dog/review/insert" method="post" onsubmit="return checkLoginAndSubmit();">
                    <input type="hidden" name="product" value="${product}">

                    <div class="review-input-box">
                        <textarea name="reviewContent" class="review-textarea" placeholder="리뷰를 작성해주세요."></textarea>
                    </div>

                    <div class="review-submit-area">
                        <button type="submit" class="review-submit-btn">리뷰등록</button>
                    </div>
                </form>
            </div>

        </div>
    </div>

</div>

<script>
    const isLogin = ${loginUser != null ? 'true' : 'false'};

    function toggleSection(sectionId, clickedBtn) {
        const detailBox = document.getElementById("detailInfo");
        const reviewBox = document.getElementById("reviewInfo");
        const buttons = document.querySelectorAll(".detail-tab-btn");

        buttons.forEach(function(btn) {
            btn.classList.remove("active");
        });

        detailBox.style.display = "none";
        reviewBox.style.display = "none";

        if (sectionId === "detailInfo") {
            detailBox.style.display = "block";
            clickedBtn.classList.add("active");
        }

        if (sectionId === "reviewInfo") {
            reviewBox.style.display = "block";
            clickedBtn.classList.add("active");
        }
    }

    function checkLoginAndSubmit() {
        if (!isLogin) {
            alert("로그인 후 리뷰를 작성할 수 있습니다.");
            return false;
        }

        const reviewText = document.querySelector(".review-textarea").value.trim();

        if (reviewText === "") {
            alert("리뷰 내용을 입력해주세요.");
            return false;
        }

        return true;
    }

    function checkLoginAndLike(clickedElement) {
        if (!isLogin) {
            alert("로그인 후 좋아요를 누를 수 있습니다.");
            return;
        }

        const reviewItem = clickedElement.closest(".review-item");
        const helpBtn = reviewItem.querySelector(".review-help-btn");
        const likeBtn = reviewItem.querySelector(".review-like-btn");
        const likeCount = reviewItem.querySelector(".review-like-count");

        let currentCount = parseInt(likeCount.innerText);

        if (reviewItem.classList.contains("liked")) {
            reviewItem.classList.remove("liked");
            helpBtn.classList.remove("active");
            likeBtn.classList.remove("active");
            likeCount.innerText = currentCount - 1;
        } else {
            reviewItem.classList.add("liked");
            helpBtn.classList.add("active");
            likeBtn.classList.add("active");
            likeCount.innerText = currentCount + 1;
        }
    }

    window.onload = function() {
        const firstBtn = document.querySelector(".detail-tab-btn");
        if (firstBtn) {
            toggleSection("detailInfo", firstBtn);
        }
    };
</script>

</body>
</html>