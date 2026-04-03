<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>리뷰 작성</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/review/reviewWrite.css">
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <c:choose>
        <c:when test="${empty reviewTarget}">
            <script>
                alert("리뷰 작성 대상 정보가 없습니다.");
                location.href = "${pageContext.request.contextPath}/mypage/purchase";
            </script>
        </c:when>

        <c:otherwise>
            <div class="review-write-page">
                <div class="review-write-wrap">

                    <h2 class="review-page-title">리뷰 작성</h2>

                    <form action="${pageContext.request.contextPath}/review/insert"
                          method="post"
                          enctype="multipart/form-data"
                          id="reviewForm">

                        <input type="hidden" name="detailId" value="${reviewTarget.detailId}">
                        <input type="hidden" name="productId" value="${reviewTarget.productId}">
                        <input type="hidden" name="reviewRating" id="reviewRating" value="0">

                        <!-- 상품 정보 -->
                        <div class="review-product-box">
                            <div class="review-product-image">
                                <c:choose>
                                    <c:when test="${not empty reviewTarget.productPhoto1}">
                                        <img src="${pageContext.request.contextPath}${reviewTarget.productPhoto1}"
                                             alt="${reviewTarget.productName}">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="no-image">이미지 없음</div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="review-product-info">
                                <div class="product-name">${reviewTarget.productName}</div>
                                <div class="product-meta">
                                    <span>${reviewTarget.categoryName}</span>
                                    <span>${reviewTarget.petType}</span>
                                    <span>${reviewTarget.ageGroup}</span>
                                </div>
                            </div>
                        </div>

                        <!-- 별점 -->
                        <div class="review-section">
                            <div class="review-label">별점</div>
                            <div class="review-content-box">
                                <div class="star-rating-wrap">
                                    <div class="star-rating" id="starRating">
                                        <span class="star" data-value="1">★</span>
                                        <span class="star" data-value="2">★</span>
                                        <span class="star" data-value="3">★</span>
                                        <span class="star" data-value="4">★</span>
                                        <span class="star" data-value="5">★</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 상세리뷰 -->
                        <div class="review-section">
                            <div class="review-label">상세리뷰</div>
                            <div class="review-content-box">
                                <textarea name="reviewContent"
                                          id="reviewContent"
                                          class="review-textarea"
                                          maxlength="1000"
                                          placeholder="다른 고객에게 도움이 되도록 상품에 대한 솔직한 후기를 작성해주세요."></textarea>
                                <div class="text-count">
                                    <span id="contentCount">0</span> / 1000
                                </div>
                            </div>
                        </div>

                        <!-- 사진첨부 -->
                        <div class="review-section">
                            <div class="review-label">사진첨부</div>
                            <div class="review-content-box">
                                <div class="file-upload-row">
                                    <label for="uploadFiles" class="file-upload-btn">사진 첨부하기</label>
                                    <input type="file"
                                           id="uploadFiles"
                                           name="uploadFiles"
                                           multiple
                                           accept=".jpg,.jpeg,.png,.gif">
                                    <span class="file-count"><span id="fileCount">0</span> / 3</span>
                                </div>

                                <div class="file-guide">
                                    사진은 최대 3장까지 첨부 가능합니다. (JPG, JPEG, PNG, GIF)
                                </div>

                                <ul class="file-name-list" id="fileNameList"></ul>
                            </div>
                        </div>

                        <div class="review-btn-area">
                            <button type="button" class="cancel-btn" onclick="history.back()">취소하기</button>
                            <button type="submit" class="submit-btn">등록하기</button>
                        </div>
                    </form>
                </div>
            </div>
        </c:otherwise>
    </c:choose>

    <script>
        document.addEventListener("DOMContentLoaded", function() {

            const stars = document.querySelectorAll(".star");
            const reviewRatingInput = document.getElementById("reviewRating");

            const reviewContent = document.getElementById("reviewContent");
            const contentCount = document.getElementById("contentCount");

            const uploadFiles = document.getElementById("uploadFiles");
            const fileCount = document.getElementById("fileCount");
            const fileNameList = document.getElementById("fileNameList");

            const reviewForm = document.getElementById("reviewForm");

            if (!reviewForm) {
                return;
            }

            stars.forEach(function(별) {
                star.addEventListener("click", function() {
                    const value = Number(this.dataset.value);
                    reviewRatingInput.value = value;

                    stars.forEach(function(s, index) {
                        if (index < value) {
                            s.classList.add("active");
                        } else {
                            s.classList.remove("active");
                        }
                    });
                });
            });

            if (reviewContent) {
                reviewContent.addEventListener("input", function() {
                    contentCount.textContent = this.value.length;
                });
            }

            if (uploadFiles) {
                uploadFiles.addEventListener("change", function() {
                    const files = Array.from(this.files);

                    if (files.length > 3) {
                        alert("사진은 최대 3장까지 첨부할 수 있습니다.");
                        this.value = "";
                        fileCount.textContent = 0;
                        fileNameList.innerHTML = "";
                        return;
                    }

                    fileCount.textContent = files.length;
                    fileNameList.innerHTML = "";

                    files.forEach(function(file) {
                        const li = document.createElement("li");
                        li.textContent = file.name;
                        fileNameList.appendChild(li);
                    });
                });
            }

            reviewForm.addEventListener("submit", function(e) {
                if (Number(reviewRatingInput.value) < 1) {
                    alert("별점을 선택해주세요.");
                    e.preventDefault();
                    return;
                }

                if (reviewContent.value.trim().length < 5) {
                    alert("상세리뷰를 5자 이상 입력해주세요.");
                    e.preventDefault();
                    return;
                }
            });
        });
    </script>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>