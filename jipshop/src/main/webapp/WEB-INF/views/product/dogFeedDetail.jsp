<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강아지 사료 상세페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/dogFeedDetail.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<c:set var="product" value="${param.product}" />
<c:set var="loginUser" value="${sessionScope.loginUser}" />

<div class="feed-detail-page">

    <!-- 상품 상단 -->
    <div class="feed-detail-top">

        <div class="feed-image-box">
            <c:choose>
                <c:when test="${product eq '1'}">
                    <img src="${pageContext.request.contextPath}/resources/img/dogSnack.png" alt="시저 강아지캔" class="feed-detail-image">
                </c:when>
                <c:when test="${product eq '2'}">
                    <img src="${pageContext.request.contextPath}/resources/img/dogSenior.png" alt="오리젠 시니어" class="feed-detail-image">
                </c:when>
                <c:when test="${product eq '3'}">
                    <img src="${pageContext.request.contextPath}/resources/img/dogAdult.png" alt="뉴트리나 어덜트" class="feed-detail-image">
                </c:when>
                <c:when test="${product eq '4'}">
                    <img src="${pageContext.request.contextPath}/resources/img/dogPuppy.png" alt="뉴트리나 퍼피" class="feed-detail-image">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/resources/img/dogSnack.png" alt="강아지 사료" class="feed-detail-image">
                </c:otherwise>
            </c:choose>
        </div>

        <div class="feed-info-box">
            <c:choose>
                <c:when test="${product eq '1'}">
                    <h2 class="feed-title">시저 강아지캔</h2>
                    <p class="feed-price">25,000원</p>
                    <p class="feed-desc">
                        풍부한 맛과 부드러운 식감을 담은 강아지용 습식 사료입니다.<br>
                        기호성이 뛰어나 맛있게 급여할 수 있는 제품입니다.
                    </p>
                </c:when>

                <c:when test="${product eq '2'}">
                    <h2 class="feed-title">오리젠 시니어</h2>
                    <p class="feed-price">25,000원</p>
                    <p class="feed-desc">
                        노령견의 건강한 식단 관리를 위한 프리미엄 사료입니다.<br>
                        균형 잡힌 영양 설계로 활력 유지에 도움을 줄 수 있습니다.
                    </p>
                </c:when>

                <c:when test="${product eq '3'}">
                    <h2 class="feed-title">뉴트리나 어덜트</h2>
                    <p class="feed-price">25,000원</p>
                    <p class="feed-desc">
                        성견을 위한 균형 잡힌 영양과 건강 관리를 돕는 강아지 사료입니다.<br>
                        매일 부담 없이 급여하기 좋은 제품입니다.
                    </p>
                </c:when>

                <c:when test="${product eq '4'}">
                    <h2 class="feed-title">뉴트리나 퍼피</h2>
                    <p class="feed-price">25,000원</p>
                    <p class="feed-desc">
                        성장기 강아지에게 필요한 영양을 담은 퍼피 전용 사료입니다.<br>
                        부드러운 밸런스와 풍부한 영양을 갖춘 제품입니다.
                    </p>
                </c:when>

                <c:otherwise>
                    <h2 class="feed-title">강아지 사료</h2>
                    <p class="feed-price">25,000원</p>
                    <p class="feed-desc">강아지를 위한 균형 잡힌 사료입니다.</p>
                </c:otherwise>
            </c:choose>

            <div class="feed-btn-group">
                <button type="button" class="main-action-btn">장바구니</button>
                <button type="button" class="main-action-btn">구매하기</button>
            </div>
        </div>
    </div>

    <!-- 탭 버튼 -->
    <div class="feed-tab-wrap">
        <button type="button" class="feed-tab-btn" onclick="toggleSection('detailInfo', this)">상세보기</button>
        <button type="button" class="feed-tab-btn" onclick="toggleSection('reviewInfo', this)">리뷰작성</button>
    </div>

    <!-- 상세보기 -->
    <div id="detailInfo" class="feed-content-box">
        <div class="feed-detail-content-image-wrap">
            <c:choose>
                <c:when test="${product eq '1'}">
                    <img src="${pageContext.request.contextPath}/resources/img/강아지캔디테일.png" alt="시저 강아지캔 상세정보" class="feed-detail-content-image">
                </c:when>
                <c:when test="${product eq '2'}">
                    <img src="${pageContext.request.contextPath}/resources/img/시니어사료디테일.png" alt="오리젠 시니어 상세정보" class="feed-detail-content-image">
                </c:when>
                <c:when test="${product eq '3'}">
                    <img src="${pageContext.request.contextPath}/resources/img/어덜트사료디테일.png" alt="뉴트리나 어덜트 상세정보" class="feed-detail-content-image">
                </c:when>
                <c:when test="${product eq '4'}">
                    <img src="${pageContext.request.contextPath}/resources/img/퍼피사료디테일.png" alt="뉴트리나 퍼피 상세정보" class="feed-detail-content-image">
                </c:when>
                <c:otherwise>
                    <p>상품 상세 이미지가 준비 중입니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- 리뷰작성 -->
    <div id="reviewInfo" class="feed-content-box">
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
                    <div class="review-main-text">▶ 우리 아이가 좋아해요!</div>
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
        const buttons = document.querySelectorAll(".feed-tab-btn");

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
        const likeBtn = reviewItem.querySelector(".review-like-btn");
        const likeCount = reviewItem.querySelector(".review-like-count");

        let currentCount = parseInt(likeCount.innerText);

        if (reviewItem.classList.contains("liked")) {
            reviewItem.classList.remove("liked");
            likeCount.innerText = currentCount - 1;
        } else {
            reviewItem.classList.add("liked");
            likeCount.innerText = currentCount + 1;
        }
    }
</script>

</body>
</html>