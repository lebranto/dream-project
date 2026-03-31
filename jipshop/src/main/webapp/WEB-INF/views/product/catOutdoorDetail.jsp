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
                    <img src="${pageContext.request.contextPath}/resources/img/catkennel1.png" alt="펫모드 스카이켄넬 미니 050" class="outdoor-detail-image">
                </c:when>
                <c:when test="${product eq '2'}">
                    <img src="${pageContext.request.contextPath}/resources/img/catkennel2.png" alt="패리스독 얼반 원형 돔캐리어" class="outdoor-detail-image">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/resources/img/catkennel1.png" alt="고양이 외출용품" class="outdoor-detail-image">
                </c:otherwise>
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

                <c:otherwise>
                    <h2 class="outdoor-title">고양이 외출용품</h2>
                    <p class="outdoor-price">25,000원</p>
                    <p class="outdoor-desc">고양이를 위한 외출용품 상세페이지입니다.</p>
                </c:otherwise>
            </c:choose>

            <div class="outdoor-btn-group">
                <button type="button" class="main-action-btn">장바구니</button>
                <button type="button" class="main-action-btn">구매하기</button>
            </div>
        </div>

    </div>

    <!-- 탭 -->
    <div class="outdoor-tab-wrap">
        <button type="button" class="outdoor-tab-btn active" onclick="toggleSection('detailInfo', this)">상세보기</button>
        <button type="button" class="outdoor-tab-btn" onclick="toggleSection('reviewInfo', this)">리뷰작성</button>
    </div>

    <!-- 상세 -->
    <div id="detailInfo" class="outdoor-content-box" style="display:block;">
        <div class="outdoor-detail-content-image-wrap">
            <c:choose>
                <c:when test="${product eq '1'}">
                    <img src="${pageContext.request.contextPath}/resources/img/catkennelDetail1.png" alt="펫모드 스카이켄넬 미니 050 상세정보" class="outdoor-detail-content-image">
                </c:when>
                <c:when test="${product eq '2'}">
                    <img src="${pageContext.request.contextPath}/resources/img/catkennelDetail2.png" alt="패리스독 얼반 원형 돔캐리어 상세정보" class="outdoor-detail-content-image">
                </c:when>
                <c:otherwise>
                    <p>상세정보가 준비 중입니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- 리뷰작성 -->
    <div id="reviewInfo" class="outdoor-content-box">
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
                <form action="${pageContext.request.contextPath}/cat/outdoor/review/insert" method="post" onsubmit="return checkLoginAndSubmit();">
                    <input type="hidden" name="product" value="${product}">

                    <div class="review-input-box">
                        <textarea name="reviewContent" class="review-textarea" placeholder="리뷰를 작성해주세요."></textarea>

                        <div class="review-upload-box">
                            <div class="review-upload-left">
                                <label for="reviewImage" class="review-file-label">사진 첨부</label>
                                <input type="file" id="reviewImage" name="reviewImage" accept="image/*" onchange="previewReviewImage(event)">
                                <span class="review-file-guide">이미지 1장을 첨부할 수 있습니다.</span>
                            </div>

                            <div class="review-upload-preview" id="previewArea">
                                <img id="previewImg" src="" alt="리뷰 이미지 미리보기">
                                <button type="button" class="preview-remove-btn" onclick="removePreview()">삭제</button>
                            </div>
                        </div>
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
        const buttons = document.querySelectorAll(".outdoor-tab-btn");

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

    function previewReviewImage(event) {
        const file = event.target.files[0];
        const previewArea = document.getElementById("previewArea");
        const previewImg = document.getElementById("previewImg");

        if (!file) {
            previewArea.style.display = "none";
            previewImg.src = "";
            return;
        }

        const reader = new FileReader();
        reader.onload = function(e) {
            previewImg.src = e.target.result;
            previewArea.style.display = "flex";
        };
        reader.readAsDataURL(file);
    }

    function removePreview() {
        const fileInput = document.getElementById("reviewImage");
        const previewArea = document.getElementById("previewArea");
        const previewImg = document.getElementById("previewImg");

        fileInput.value = "";
        previewImg.src = "";
        previewArea.style.display = "none";
    }
</script>

</body>
</html>