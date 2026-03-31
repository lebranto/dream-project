<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고양이 사료 상세페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/catFeedDetail.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<c:set var="product" value="${param.product}" />
<c:set var="loginUser" value="${sessionScope.loginUser}" />

<div class="feed-detail-page">

    <div class="feed-detail-top">

        <div class="feed-image-box">
            <c:choose>
                <c:when test="${product eq '1'}">
                    <img src="${pageContext.request.contextPath}/resources/img/사료보양대첩.png" alt="보양대첩 파우치 사료" class="feed-detail-image">
                </c:when>
                <c:when test="${product eq '2'}">
                    <img src="${pageContext.request.contextPath}/resources/img/캔보양대첩.png" alt="보양대첩 캔 사료" class="feed-detail-image">
                </c:when>
                <c:when test="${product eq '3'}">
                    <img src="${pageContext.request.contextPath}/resources/img/catFeed1.png" alt="캣츠랑 비타플러스" class="feed-detail-image">
                </c:when>
                <c:when test="${product eq '4'}">
                    <img src="${pageContext.request.contextPath}/resources/img/catFeed2.png" alt="캣츠랑 리브레" class="feed-detail-image">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/resources/img/사료보양대첩.png" alt="고양이 사료" class="feed-detail-image">
                </c:otherwise>
            </c:choose>
        </div>

        <div class="feed-info-box">
            <c:choose>
                <c:when test="${product eq '1'}">
                    <h2 class="feed-title">보양대첩 파우치</h2>
                    <p class="feed-price">25,000원</p>
                    <p class="feed-desc">
                        영양 밸런스를 고려한 촉촉한 파우치 타입 고양이 사료입니다.<br>
                        기호성이 뛰어나고 부드럽게 급여할 수 있습니다.
                    </p>
                </c:when>

                <c:when test="${product eq '2'}">
                    <h2 class="feed-title">보양대첩 캔</h2>
                    <p class="feed-price">25,000원</p>
                    <p class="feed-desc">
                        부드러운 캔 타입으로 맛있게 급여할 수 있는 고양이용 습식 사료입니다.<br>
                        수분감이 풍부하고 기호성이 좋은 제품입니다.
                    </p>
                </c:when>

                <c:when test="${product eq '3'}">
                    <h2 class="feed-title">캣츠랑 비타플러스</h2>
                    <p class="feed-price">25,000원</p>
                    <p class="feed-desc">
                        건강한 일상 식사를 위해 영양 설계를 더한 고양이 건식 사료입니다.<br>
                        균형 잡힌 성분으로 매일 부담 없이 급여할 수 있습니다.
                    </p>
                </c:when>

                <c:when test="${product eq '4'}">
                    <h2 class="feed-title">캣츠랑 리브레</h2>
                    <p class="feed-price">25,000원</p>
                    <p class="feed-desc">
                        부드러운 밸런스와 풍부한 영양을 담은 고양이 건식 사료입니다.<br>
                        데일리 급여용으로 활용하기 좋은 제품입니다.
                    </p>
                </c:when>

                <c:otherwise>
                    <h2 class="feed-title">고양이 사료</h2>
                    <p class="feed-price">25,000원</p>
                    <p class="feed-desc">고양이를 위한 균형 잡힌 사료입니다.</p>
                </c:otherwise>
            </c:choose>

            <div class="feed-btn-group">
                <button type="button" class="main-action-btn">장바구니</button>
                <button type="button" class="main-action-btn">구매하기</button>
            </div>
        </div>
    </div>

    <div class="feed-tab-wrap">
        <button type="button" class="feed-tab-btn active" onclick="toggleSection('detailInfo', this)">상세보기</button>
        <button type="button" class="feed-tab-btn" onclick="toggleSection('reviewInfo', this)">리뷰작성</button>
    </div>

    <div id="detailInfo" class="feed-content-box" style="display:block;">
        <div class="feed-detail-content-image-wrap">
            <c:choose>
                <c:when test="${product eq '1'}">
                    <img src="${pageContext.request.contextPath}/resources/img/보양대첩파우치디테일.png" alt="보양대첩 파우치 상세정보" class="feed-detail-content-image">
                </c:when>
                <c:when test="${product eq '2'}">
                    <img src="${pageContext.request.contextPath}/resources/img/보양대첩캔디테일.png" alt="보양대첩 캔 상세정보" class="feed-detail-content-image">
                </c:when>
                <c:when test="${product eq '3'}">
                    <img src="${pageContext.request.contextPath}/resources/img/catFeedDetail1.png" alt="캣츠랑 비타플러스 상세정보" class="feed-detail-content-image">
                </c:when>
                <c:when test="${product eq '4'}">
                    <img src="${pageContext.request.contextPath}/resources/img/catFeedDetail2.png" alt="캣츠랑 리브레 상세정보" class="feed-detail-content-image">
                </c:when>
                <c:otherwise>
                    <p>상세정보가 준비 중입니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

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
                <form action="${pageContext.request.contextPath}/cat/review/insert" 
                      method="post" 
                      onsubmit="return checkLoginAndSubmit();">
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