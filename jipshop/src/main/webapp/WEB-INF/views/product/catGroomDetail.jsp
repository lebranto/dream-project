<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고양이 미용용품 상세페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/catGroomDetail.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<c:set var="product" value="${param.product}" />
<c:set var="loginUser" value="${sessionScope.loginUser}" />

<div class="groom-detail-page">

    <!-- 상품 상단 -->
    <div class="groom-detail-top">

        <div class="groom-image-box">
            <c:choose>
                <c:when test="${product eq '1'}">
                    <img src="${pageContext.request.contextPath}/resources/img/catshampoo1.png" alt="이눔 아워스 캣샴푸" class="groom-detail-image">
                </c:when>
                <c:when test="${product eq '2'}">
                    <img src="${pageContext.request.contextPath}/resources/img/catshampoo2.png" alt="펫룸 버블 샴푸" class="groom-detail-image">
                </c:when>
                <c:when test="${product eq '3'}">
                    <img src="${pageContext.request.contextPath}/resources/img/catpaste.png" alt="페디슨 덴탈케어 치약" class="groom-detail-image">
                </c:when>
                <c:when test="${product eq '4'}">
                    <img src="${pageContext.request.contextPath}/resources/img/catbrush.png" alt="펫룸 딥포인트 칫솔" class="groom-detail-image">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/resources/img/catshampoo1.png" alt="고양이 미용용품" class="groom-detail-image">
                </c:otherwise>
            </c:choose>
        </div>

        <div class="groom-info-box">
            <c:choose>
                <c:when test="${product eq '1'}">
                    <h2 class="groom-title">이눔 아워스 캣샴푸</h2>
                    <p class="groom-price">25,000원</p>
                    <p class="groom-desc">
                        피부와 털 관리를 도와주는 순한 고양이 미용용품 샴푸입니다.<br>
                        부드러운 세정과 산뜻한 사용감을 느낄 수 있는 제품입니다.
                    </p>
                </c:when>

                <c:when test="${product eq '2'}">
                    <h2 class="groom-title">펫룸 버블 샴푸</h2>
                    <p class="groom-price">25,000원</p>
                    <p class="groom-desc">
                        풍성한 거품으로 깔끔한 세정을 도와주는 고양이 미용용품 샴푸입니다.<br>
                        민감한 피부를 고려한 부드러운 사용감의 제품입니다.
                    </p>
                </c:when>

                <c:when test="${product eq '3'}">
                    <h2 class="groom-title">페디슨 덴탈케어 치약</h2>
                    <p class="groom-price">25,000원</p>
                    <p class="groom-desc">
                        반려묘를 위한 맞춤형 양치 솔루션 치약입니다.<br>
                        구강 청결과 치아 관리에 도움을 주는 미용용품입니다.
                    </p>
                </c:when>

                <c:when test="${product eq '4'}">
                    <h2 class="groom-title">펫룸 딥포인트 칫솔</h2>
                    <p class="groom-price">25,000원</p>
                    <p class="groom-desc">
                        세밀한 구강 케어를 도와주는 고양이 전용 미용용품 칫솔입니다.<br>
                        깊은 부분까지 꼼꼼하게 관리할 수 있도록 도와주는 제품입니다.
                    </p>
                </c:when>

                <c:otherwise>
                    <h2 class="groom-title">고양이 미용용품</h2>
                    <p class="groom-price">25,000원</p>
                    <p class="groom-desc">고양이를 위한 미용용품 상세페이지입니다.</p>
                </c:otherwise>
            </c:choose>

            <div class="groom-btn-group">
                <button type="button" class="main-action-btn">장바구니</button>
                <button type="button" class="main-action-btn">구매하기</button>
            </div>
        </div>
    </div>

    <!-- 탭 버튼 -->
    <div class="groom-tab-wrap">
        <button type="button" class="groom-tab-btn active" onclick="toggleSection('detailInfo', this)">상세보기</button>
        <button type="button" class="groom-tab-btn" onclick="toggleSection('reviewInfo', this)">리뷰작성</button>
    </div>

    <!-- 상세보기 -->
    <div id="detailInfo" class="groom-content-box" style="display:block;">
        <div class="groom-detail-content-image-wrap">
            <c:choose>
                <c:when test="${product eq '1'}">
                    <img src="${pageContext.request.contextPath}/resources/img/catshampooDetail1.png" alt="이눔 아워스 캣샴푸 상세정보" class="groom-detail-content-image">
                </c:when>
                <c:when test="${product eq '2'}">
                    <img src="${pageContext.request.contextPath}/resources/img/catshampooDetail2.png" alt="펫룸 버블 샴푸 상세정보" class="groom-detail-content-image">
                </c:when>
                <c:when test="${product eq '3'}">
                    <img src="${pageContext.request.contextPath}/resources/img/catpasteDetail.png" alt="페디슨 덴탈케어 치약 상세정보" class="groom-detail-content-image">
                </c:when>
                <c:when test="${product eq '4'}">
                    <img src="${pageContext.request.contextPath}/resources/img/catbrushDetail.png" alt="펫룸 딥포인트 칫솔 상세정보" class="groom-detail-content-image">
                </c:when>
                <c:otherwise>
                    <p>상세정보가 준비 중입니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- 리뷰작성 -->
    <div id="reviewInfo" class="groom-content-box">
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
                <form action="${pageContext.request.contextPath}/cat/groom/review/insert" method="post" onsubmit="return checkLoginAndSubmit();">
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
        const buttons = document.querySelectorAll(".groom-tab-btn");

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