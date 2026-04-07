<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<c:url var="allPetUrl" value="/product/list">
    <c:param name="keyword" value="${keyword}" />
    <c:param name="sort" value="${sort}" />
</c:url>

<c:url var="dogUrl" value="/product/list">
    <c:param name="keyword" value="${keyword}" />
    <c:param name="petType" value="강아지" />
    <c:param name="categoryName" value="${categoryName}" />
    <c:param name="sort" value="${sort}" />
</c:url>

<c:url var="catUrl" value="/product/list">
    <c:param name="keyword" value="${keyword}" />
    <c:param name="petType" value="고양이" />
    <c:param name="categoryName" value="${categoryName}" />
    <c:param name="sort" value="${sort}" />
</c:url>

<c:url var="categoryFeedUrl" value="/product/list">
    <c:param name="keyword" value="${keyword}" />
    <c:param name="petType" value="${petType}" />
    <c:param name="categoryName" value="사료" />
    <c:param name="sort" value="${sort}" />
</c:url>

<c:url var="categoryToyUrl" value="/product/list">
    <c:param name="keyword" value="${keyword}" />
    <c:param name="petType" value="${petType}" />
    <c:param name="categoryName" value="장난감" />
    <c:param name="sort" value="${sort}" />
</c:url>

<c:url var="categoryOutdoorUrl" value="/product/list">
    <c:param name="keyword" value="${keyword}" />
    <c:param name="petType" value="${petType}" />
    <c:param name="categoryName" value="외출용품" />
    <c:param name="sort" value="${sort}" />
</c:url>

<c:url var="categoryBeautyUrl" value="/product/list">
    <c:param name="keyword" value="${keyword}" />
    <c:param name="petType" value="${petType}" />
    <c:param name="categoryName" value="미용용품" />
    <c:param name="sort" value="${sort}" />
</c:url>

<c:url var="sortLowUrl" value="/product/list">
    <c:param name="keyword" value="${keyword}" />
    <c:param name="petType" value="${petType}" />
    <c:param name="categoryName" value="${categoryName}" />
    <c:param name="sort" value="lowPrice" />
</c:url>

<c:url var="sortHighUrl" value="/product/list">
    <c:param name="keyword" value="${keyword}" />
    <c:param name="petType" value="${petType}" />
    <c:param name="categoryName" value="${categoryName}" />
    <c:param name="sort" value="highPrice" />
</c:url>

<c:url var="sortReadUrl" value="/product/list">
    <c:param name="keyword" value="${keyword}" />
    <c:param name="petType" value="${petType}" />
    <c:param name="categoryName" value="${categoryName}" />
    <c:param name="sort" value="readCount" />
</c:url>

<c:url var="sortLatestUrl" value="/product/list">
    <c:param name="keyword" value="${keyword}" />
    <c:param name="petType" value="${petType}" />
    <c:param name="categoryName" value="${categoryName}" />
    <c:param name="sort" value="latest" />
</c:url>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상품 목록 - 집사상점</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/productList.css">

    <style>
    .wish-icon {
        position: absolute;
        top: 20px;
        right: 20px;
        width: 40px;
        height: 40px;
        cursor: pointer;
        z-index: 10;
        transition: transform 0.2s;
    }

    .wish-icon:hover {
        transform: scale(1.2);
    }

    .product-image-box {
        position: relative;
    }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<main class="product-list-page">
    <div class="product-list-wrap">

        <section class="hero-section">
            <div class="hero-text">
                <h1>
                    <c:choose>
                        <c:when test="${not empty keyword}">
                            '${keyword}' 검색결과
                        </c:when>
                        <c:when test="${not empty petType}">
                            ${petType}
                        </c:when>
                        <c:otherwise>
                            전체 상품
                        </c:otherwise>
                    </c:choose>
                </h1>
                <p>
                    <c:choose>
                        <c:when test="${not empty keyword}">
                            여기가 '${keyword}'로 검색한 상품입니다.
                        </c:when>
                        <c:otherwise>
                            우리 아이를 위한 맞춤 상품을 골라보세요
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
        </section>

        <section class="pet-tab-section">
            <c:if test="${not empty keyword}">
                <a href="${allPetUrl}"
                   class="pet-tab ${empty petType ? 'active' : ''}">
                    전체
                </a>
            </c:if>

            <a href="${dogUrl}"
               class="pet-tab ${petType eq '강아지' ? 'active' : ''}">
                강아지
            </a>

            <a href="${catUrl}"
               class="pet-tab ${petType eq '고양이' ? 'active' : ''}">
                고양이
            </a>
        </section>

        <section class="category-tab-section">
            <a href="${categoryFeedUrl}"
               class="category-tab ${categoryName eq '사료' ? 'active' : ''}">
                사료
            </a>

            <a href="${categoryToyUrl}"
               class="category-tab ${categoryName eq '장난감' ? 'active' : ''}">
                장난감
            </a>

            <a href="${categoryOutdoorUrl}"
               class="category-tab ${categoryName eq '외출용품' ? 'active' : ''}">
                외출용품
            </a>

            <a href="${categoryBeautyUrl}"
               class="category-tab ${categoryName eq '미용용품' ? 'active' : ''}">
                미용용품
            </a>
        </section>

        <section class="list-top-bar">
            <div class="count-box">
                총 <strong>${listCount}</strong>개의 상품
            </div>

            <div class="sort-box">
                <a href="${sortLowUrl}"
                   class="sort-btn ${sort eq 'lowPrice' ? 'active' : ''}">
                    낮은 가격순
                </a>

                <a href="${sortHighUrl}"
                   class="sort-btn ${sort eq 'highPrice' ? 'active' : ''}">
                    높은 가격순
                </a>

                <a href="${sortReadUrl}"
                   class="sort-btn ${sort eq 'readCount' ? 'active' : ''}">
                    조회순
                </a>

                <a href="${sortLatestUrl}"
                   class="sort-btn ${sort eq 'latest' ? 'active' : ''}">
                    최신순
                </a>
            </div>
        </section>

        <section class="product-grid">
            <c:choose>
                <c:when test="${not empty productList}">
                    <c:forEach var="p" items="${productList}">
                        <div class="product-card">

                            <a href="${pageContext.request.contextPath}/product/detail?productId=${p.productId}" 
                            class="product-link"
                            data-product-id="${p.productId}">
                                <div class="product-image-box">
                                    <img class="wish-icon"
                                         src="${pageContext.request.contextPath}/resources/images/empty-heart.png"
                                         data-id="${p.productId}"
                                         data-name="${p.productName}"
                                         data-price="${p.productPrice}"
                                         data-photo="${p.productPhoto1}">
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
                                    <form action="${pageContext.request.contextPath}/orders/orderNew" method="get" class="inline-form">
                                        <input type="hidden" name="productId" value="${p.productId}">
                                        <input type="hidden" name="qty" value="1">
                                        <button type="submit" class="buy-btn">바로구매</button>
                                    </form>

                                    <form action="${pageContext.request.contextPath}/cartList/add" method="post" class="inline-form">
                                        <input type="hidden" name="productId" value="${p.productId}">
                                        <input type="hidden" name="productName" value="${p.productName}">
                                        <input type="hidden" name="productPrice" value="${p.productPrice}">
                                        <input type="hidden" name="productPhoto" value="${p.productPhoto1}">
                                        <input type="hidden" name="qty" value="1">
                                        <button type="button" class="cart-btn">장바구니</button>
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
            <c:if test="${pi.currentPage > 1}">
                <c:url var="prevPageUrl" value="/product/list">
                    <c:param name="currentPage" value="${pi.currentPage - 1}" />
                    <c:param name="petType" value="${petType}" />
                    <c:param name="categoryName" value="${categoryName}" />
                    <c:param name="sort" value="${sort}" />
                    <c:param name="keyword" value="${keyword}" />
                </c:url>
                <a href="${prevPageUrl}">&lt;</a>
            </c:if>

            <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
                <c:url var="pageUrl" value="/product/list">
                    <c:param name="currentPage" value="${p}" />
                    <c:param name="petType" value="${petType}" />
                    <c:param name="categoryName" value="${categoryName}" />
                    <c:param name="sort" value="${sort}" />
                    <c:param name="keyword" value="${keyword}" />
                </c:url>

                <c:choose>
                    <c:when test="${p == pi.currentPage}">
                        <a href="${pageUrl}" class="active">${p}</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageUrl}">${p}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${pi.currentPage < pi.maxPage}">
                <c:url var="nextPageUrl" value="/product/list">
                    <c:param name="currentPage" value="${pi.currentPage + 1}" />
                    <c:param name="petType" value="${petType}" />
                    <c:param name="categoryName" value="${categoryName}" />
                    <c:param name="sort" value="${sort}" />
                    <c:param name="keyword" value="${keyword}" />
                </c:url>
                <a href="${nextPageUrl}">&gt;</a>
            </c:if>
        </div>
    </div>

</main>

<!-- ⭐ 위로 가기 버튼 -->
<button id="scrollTopBtn" onclick="window.scrollTo({top:0, behavior:'smooth'})"
    style="
        position: fixed;
        bottom: 40px;
        right: 40px;
        width: 50px;
        height: 50px;
        border-radius: 50%;
        border: none;
        background: #ffda79;
        font-size: 22px;
        cursor: pointer;
        box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        display: none;
        z-index: 999;
        transition: opacity 0.3s;
    ">
    ▲
</button>

<script>
document.querySelectorAll(".cart-btn").forEach(btn => {
    btn.addEventListener("click", function(e) {
        e.preventDefault();

        const form = this.closest("form");
        const formData = new FormData(form);

        fetch("${pageContext.request.contextPath}/cartList/addAjax", {
            method: "POST",
            body: formData
        })
        .then(res => res.text())
        .then(count => {
            alert("장바구니에 추가되었습니다");
            updateCartCountUI(parseInt(count));
        });
    });
});
</script>

<script>
document.querySelectorAll(".wish-icon").forEach(icon => {
    icon.addEventListener("click", function(e) {
        e.preventDefault();
        e.stopPropagation();

        const productId = this.dataset.id;
        const productName = this.dataset.name;
        const productPrice = this.dataset.price;
        const productPhoto = this.dataset.photo;

        fetch("${pageContext.request.contextPath}/wishList/toggle", {
            method:"POST",
            headers:{"Content-Type":"application/x-www-form-urlencoded"},
            body:
                "productId=" + productId +
                "&productName=" + encodeURIComponent(productName) +
                "&productPrice=" + productPrice +
                "&productPhoto=" + encodeURIComponent(productPhoto)
        })
        .then(res => res.text())
        .then(result => {
            if(result.trim() === "add"){
                this.src = "${pageContext.request.contextPath}/resources/images/heart.png";
                this.classList.add("active");
                animateHeart(this);
            } else {
                this.src = "${pageContext.request.contextPath}/resources/images/empty-heart.png";
                this.classList.remove("active");
                animateHeart(this);
            }
        });
    });
});

function animateHeart(el){
    el.style.transition = "transform 0.2s ease";
    el.style.transform = "scale(1.4)";
    setTimeout(() => {
        el.style.transform = "scale(1)";
    }, 200);
}
</script>

<script>
window.addEventListener("scroll", function() {
    const btn = document.getElementById("scrollTopBtn");
    if (window.scrollY > 300) {
        btn.style.display = "block";
    } else {
        btn.style.display = "none";
    }
});

//최근 본 상품
document.querySelectorAll('.product-link').forEach(link => {
link.addEventListener('click', function(e) {
    e.preventDefault();

    const productId = this.dataset.productId;
    const moveUrl = this.href;

    fetch('${pageContext.request.contextPath}/product/view/insert', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: 'productId=' + productId
    })
    .then(res => res.text())
    .then(result => {
        console.log("최근 본 상품 저장 결과:", result);
        location.href = moveUrl;
    })
    .catch(err => {
        console.error("최근 본 상품 저장 실패:", err);
        location.href = moveUrl;
    });
});
});




</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>