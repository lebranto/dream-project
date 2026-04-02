<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상품 목록 - 집사상권</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/productList.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<main class="product-list-page">
    <div class="product-list-wrap">

        <!-- 상단 타이틀 -->
        <section class="hero-section">
            <div class="hero-text">
                <h1>${petType}</h1>
                <p>우리 아이를 위한 맞춤 상품을 골라보세요</p>
            </div>
        </section>

        <!-- 반려동물 탭 -->
        <section class="pet-tab-section">
            <a href="${pageContext.request.contextPath}/product/list?petType=강아지&categoryName=${categoryName}&sort=${sort}"
               class="pet-tab ${petType eq '강아지' ? 'active' : ''}">
                강아지
            </a>
            <a href="${pageContext.request.contextPath}/product/list?petType=고양이&categoryName=${categoryName}&sort=${sort}"
               class="pet-tab ${petType eq '고양이' ? 'active' : ''}">
                고양이
            </a>
        </section>

        <!-- 카테고리 탭 -->
        <section class="category-tab-section">
            <a href="${pageContext.request.contextPath}/product/list?petType=${petType}&categoryName=사료&sort=${sort}"
               class="category-tab ${categoryName eq '사료' ? 'active' : ''}">
                사료
            </a>
            <a href="${pageContext.request.contextPath}/product/list?petType=${petType}&categoryName=장난감&sort=${sort}"
               class="category-tab ${categoryName eq '장난감' ? 'active' : ''}">
                장난감
            </a>
            <a href="${pageContext.request.contextPath}/product/list?petType=${petType}&categoryName=외출용품&sort=${sort}"
               class="category-tab ${categoryName eq '외출용품' ? 'active' : ''}">
                외출용품
            </a>
            <a href="${pageContext.request.contextPath}/product/list?petType=${petType}&categoryName=미용용품&sort=${sort}"
               class="category-tab ${categoryName eq '미용용품' ? 'active' : ''}">
                미용용품
            </a>
        </section>

        <!-- 상단 정보 -->
        <section class="list-top-bar">
            <div class="count-box">
                총 <strong>${listCount}</strong>개의 상품
            </div>

            <div class="sort-box">
                <a href="${pageContext.request.contextPath}/product/list?petType=${petType}&categoryName=${categoryName}&sort=lowPrice"
                   class="sort-btn ${sort eq 'lowPrice' ? 'active' : ''}">
                    낮은 가격순
                </a>
                <a href="${pageContext.request.contextPath}/product/list?petType=${petType}&categoryName=${categoryName}&sort=highPrice"
                   class="sort-btn ${sort eq 'highPrice' ? 'active' : ''}">
                    높은 가격순
                </a>
                <a href="${pageContext.request.contextPath}/product/list?petType=${petType}&categoryName=${categoryName}&sort=readCount"
                   class="sort-btn ${sort eq 'readCount' ? 'active' : ''}">
                    조회순
                </a>
                <a href="${pageContext.request.contextPath}/product/list?petType=${petType}&categoryName=${categoryName}&sort=latest"
                   class="sort-btn ${sort eq 'latest' ? 'active' : ''}">
                    최신순
                </a>
            </div>
        </section>

        <!-- 상품 카드 목록 -->
        <section class="product-grid">
            <c:choose>
                <c:when test="${not empty productList}">
                    <c:forEach var="p" items="${productList}">
                        <div class="product-card">

                            <a href="${pageContext.request.contextPath}/product/detail?productId=${p.productId}" class="product-image-link">
                                <div class="product-image-box">
                                    <img src="${pageContext.request.contextPath}${p.productPhoto1}" alt="${p.productName}">
                                </div>
                            </a>

                            <div class="product-card-body">
                                <div class="product-card-top">
                                    <span class="brand-name">${p.companyName}</span>
                                    <span class="category-name">${p.categoryName}</span>
                                </div>

                                <a href="${pageContext.request.contextPath}/product/detail?productId=${p.productId}" class="product-name">
                                    ${p.productName}
                                </a>

                                <div class="product-sub-info">
                                    <span>${p.petType}</span>
                                    <span>${p.ageGroup}</span>
                                </div>

                                <div class="product-price">
                                    <fmt:formatNumber value="${p.productPrice}" pattern="#,###"/>원
                                </div>

                                <div class="product-btn-area">
                                    <form action="${pageContext.request.contextPath}/orders/orderNew" method="post" class="inline-form">
                                        <input type="hidden" name="productId" value="${p.productId}">
                                        <input type="hidden" name="qty" value="1">
                                        <button type="submit" class="buy-btn">바로구매</button>
                                    </form>

                                    <form action="${pageContext.request.contextPath}/product/cart" method="post" class="inline-form">
                                        <input type="hidden" name="productId" value="${p.productId}">
                                        <input type="hidden" name="qty" value="1">
                                        <button type="submit" class="cart-btn">장바구니</button>
                                    </form>
                                </div>
                            </div>

                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-box">
                        해당 조건의 상품이 없습니다.
                    </div>
                </c:otherwise>
            </c:choose>
        </section>
 <div class="pagination">

            <!-- 이전 -->
            <c:if test="${pi.currentPage > 1}">
                <a href="${pageContext.request.contextPath}/product/list?currentPage=${pi.currentPage - 1}&petType=${petType}&categoryName=${categoryName}&sort=${sort}">
                    &lt;
                </a>
            </c:if>

            <!-- 페이지 번호 -->
            <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
                <c:choose>
                    <c:when test="${p == pi.currentPage}">
                        <a href="${pageContext.request.contextPath}/product/list?currentPage=${p}&petType=${petType}&categoryName=${categoryName}&sort=${sort}" class="active">
                            ${p}
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/product/list?currentPage=${p}&petType=${petType}&categoryName=${categoryName}&sort=${sort}">
                            ${p}
                        </a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <!-- 다음 -->
            <c:if test="${pi.currentPage < pi.maxPage}">
                <a href="${pageContext.request.contextPath}/product/list?currentPage=${pi.currentPage + 1}&petType=${petType}&categoryName=${categoryName}&sort=${sort}">
                    &gt;
                </a>
            </c:if>

        </div>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>