<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강아지 미용용품 상세페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/dogGroomDetail.css">
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
                    <img src="${pageContext.request.contextPath}/resources/img/dogshampoo1.png" alt="강아지 오트 샴푸">
                </c:when>
                <c:when test="${product eq '2'}">
                    <img src="${pageContext.request.contextPath}/resources/img/dogshampoo2.png" alt="강아지 발레리안 샴푸">
                </c:when>
                <c:when test="${product eq '3'}">
                    <img src="${pageContext.request.contextPath}/resources/img/dogpaste.png" alt="강아지 덴탈 치약">
                </c:when>
                <c:when test="${product eq '4'}">
                    <img src="${pageContext.request.contextPath}/resources/img/dogbrush.png" alt="강아지 소프트 칫솔">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/resources/img/dogshampoo1.png" alt="강아지 미용용품">
                </c:otherwise>
            </c:choose>
        </div>

        <div class="product-info-area">
            <c:choose>
                <c:when test="${product eq '1'}">
                    <h1 class="product-title">강아지 오트 샴푸</h1>
                    <div class="product-price">25,000원</div>
                    <p class="product-desc">
                        피부와 털 관리를 도와주는 순한 강아지 미용용품 샴푸입니다.<br>
                        부드러운 세정과 산뜻한 사용감을 느낄 수 있는 제품입니다.
                    </p>
                </c:when>

                <c:when test="${product eq '2'}">
                    <h1 class="product-title">강아지 발레리안 샴푸</h1>
                    <div class="product-price">25,000원</div>
                    <p class="product-desc">
                        은은한 향과 함께 깔끔한 세정을 도와주는 강아지 샴푸입니다.<br>
                        매일 산뜻하게 사용할 수 있는 강아지 전용 미용용품입니다.
                    </p>
                </c:when>

                <c:when test="${product eq '3'}">
                    <h1 class="product-title">강아지 덴탈 치약</h1>
                    <div class="product-price">25,000원</div>
                    <p class="product-desc">
                        입 냄새 관리와 구강 청결에 도움을 주는 강아지 전용 치약입니다.<br>
                        반려견의 치아 관리에 부담 없이 사용할 수 있는 데일리 덴탈 케어 상품입니다.
                    </p>
                </c:when>

                <c:when test="${product eq '4'}">
                    <h1 class="product-title">강아지 소프트 칫솔</h1>
                    <div class="product-price">25,000원</div>
                    <p class="product-desc">
                        반려견의 치아와 잇몸을 부드럽게 관리할 수 있는 강아지 전용 칫솔입니다.<br>
                        부드러운 브러시로 매일 부담 없이 사용할 수 있는 덴탈 케어 상품입니다.
                    </p>
                </c:when>

                <c:otherwise>
                    <h1 class="product-title">강아지 미용용품</h1>
                    <div class="product-price">25,000원</div>
                    <p class="product-desc">강아지를 위한 미용/구강 케어 상품입니다.</p>
                </c:otherwise>
            </c:choose>

            <div class="product-button-group">
                <button type="button" class="cart-btn">장바구니</button>
                <button type="button" class="buy-btn">구매하기</button>
            </div>
        </div>
    </div>

    <div class="detail-tab-wrap">
        <button type="button" class="detail-tab-btn active" onclick="toggleSection('detailInfo', this)">상세보기</button>
        <button type="button" class="detail-tab-btn" onclick="toggleSection('reviewInfo', this)">리뷰작성</button>
    </div>

    <div id="detailInfo" class="detail-content-box" style="display:block;">
        <c:choose>
            <c:when test="${product eq '1'}">
                <img src="${pageContext.request.contextPath}/resources/img/dogshampooDetail1.png" alt="강아지 오트 샴푸 상세정보">
            </c:when>
            <c:when test="${product eq '2'}">
                <img src="${pageContext.request.contextPath}/resources/img/dogshampooDetail2.png" alt="강아지 발레리안 샴푸 상세정보">
            </c:when>
            <c:when test="${product eq '3'}">
                <img src="${pageContext.request.contextPath}/resources/img/dogpasteDetail.png" alt="강아지 덴탈 치약 상세정보">
            </c:when>
            <c:when test="${product eq '4'}">
                <img src="${pageContext.request.contextPath}/resources/img/dogbrushDetail.png" alt="강아지 소프트 칫솔 상세정보">
            </c:when>
            <c:otherwise>
                <p>상품 상세정보가 준비 중입니다.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <div id="reviewInfo" class="detail-content-box">
        <div class="review-area-box">

            <div class="review-list-wrap">
                <div class="review-item">
                    <div class="review-main-text">▶ 배송이 아주 빨랐습니다!</div>
                    <div class="review-meta">강진솔 | 2026-03-24</div>

                    <div class="review-help-area">
                        <button type="button" class="review-help-btn" onclick="checkLoginAndLike(this)">도움돼요</button>
                        <button type="button" class="review-like-btn" onclick="checkLoginAndLike(this)">👍</button>
                        <span class="review-like-count">0</span>
                    </div>
                </div>

                <div class="review-item">
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