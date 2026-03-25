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
        <button type="button" class="feed-tab-btn" onclick="toggleSection('detailInfo', this)">상세정보</button>
        <button type="button" class="feed-tab-btn" onclick="toggleSection('deliveryInfo', this)">배송안내</button>
    </div>

    <div id="detailInfo" class="feed-content-box">
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

    <div id="deliveryInfo" class="feed-content-box">
        <h3>배송안내</h3>
        <p>
            - 평균 배송기간 2~3일<br>
            - 3만원 이상 구매 시 무료배송<br>
            - 제주/도서산간 지역은 추가 배송비가 발생할 수 있습니다.
        </p>
    </div>

</div>

<script>
    function toggleSection(sectionId, clickedBtn) {
        const detailBox = document.getElementById("detailInfo");
        const deliveryBox = document.getElementById("deliveryInfo");
        const buttons = document.querySelectorAll(".feed-tab-btn");

        buttons.forEach(function(btn) {
            btn.classList.remove("active");
        });

        if (sectionId === "detailInfo") {
            if (detailBox.style.display === "block") {
                detailBox.style.display = "none";
                clickedBtn.classList.remove("active");
            } else {
                detailBox.style.display = "block";
                deliveryBox.style.display = "none";
                clickedBtn.classList.add("active");
            }
        }

        if (sectionId === "deliveryInfo") {
            if (deliveryBox.style.display === "block") {
                deliveryBox.style.display = "none";
                clickedBtn.classList.remove("active");
            } else {
                deliveryBox.style.display = "block";
                detailBox.style.display = "none";
                clickedBtn.classList.add("active");
            }
        }
    }
</script>

</body>
</html>