<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상품 목록 - 집사상점</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/productList.css">
    
    <style>
/* ⭐ 찜 하트 */
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
                                <!-- ⭐ 찜 버튼 -->
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
                                    <div class="product-btn-area">
    									<form action="${pageContext.request.contextPath}/orders/orderNew" method="get" class="inline-form">
       									 <input type="hidden" name="productId" value="${p.productId}">
        								<input type="hidden" name="qty" value="1">
        								<button type="submit" class="buy-btn">바로구매</button>
    									</form>
									</div>

                                    <form action="${pageContext.request.contextPath}/cartList/add" method="post" class="inline-form">
    									<input type="hidden" name="productId" value="${p.productId}">
    
    									<!-- ⭐ 추가 -->
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
        </div>
</main>

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

            console.log("카트개수:", count);

            updateCartCountUI(parseInt(count));
        });
    });

});
</script>

<script>
//===============================
//✅ 2. 찜 클릭 이벤트
//===============================
document.querySelectorAll(".wish-icon").forEach(icon => {

 icon.addEventListener("click", function(e){

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

             // ❤️ 찜 추가
             this.src = "${pageContext.request.contextPath}/resources/images/heart.png";
             this.classList.add("active");

             animateHeart(this);

         } else {

             // 🤍 찜 해제
             this.src = "${pageContext.request.contextPath}/resources/images/empty-heart.png";
             this.classList.remove("active");

             animateHeart(this);
         }

     });

 });

});


//===============================
//✅ 3. 하트 애니메이션
//===============================
function animateHeart(el){

 el.style.transition = "transform 0.2s ease";
 el.style.transform = "scale(1.4)";

 setTimeout(() => {
     el.style.transform = "scale(1)";
 }, 200);
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>