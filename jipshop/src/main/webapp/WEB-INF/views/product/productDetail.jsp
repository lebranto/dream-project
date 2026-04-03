<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>${product.productName} - 집사상권</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/productDetail.css">
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <c:if test="${not empty alertMsg}">
        <script>
            alert("${alertMsg}");
        </script>
        <c:remove var="alertMsg" scope="session"/>
    </c:if>

    <main class="product-detail-page">
        <div class="product-detail-wrap">

            <!-- 상품 정보 -->
            <section class="product-top-section" id="productInfoSection">

                <!-- 왼쪽 대표 이미지 -->
                <div class="product-main-image-box">
                    <c:choose>
                        <c:when test="${not empty product.productPhoto1}">
                            <img src="${pageContext.request.contextPath}${product.productPhoto1}"
                                 alt="${product.productName}">
                        </c:when>
                        <c:otherwise>
                            <div class="no-image">이미지 없음</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- 오른쪽 상품 정보 -->
                <div class="product-info-box">
                    <div class="product-badge-area">
                        <span class="badge">${product.categoryName}</span>
                        <span class="badge">${product.petType}</span>
                        <span class="badge">${product.ageGroup}</span>
                    </div>

                    <h1 class="product-name">${product.productName}</h1>

                    <div class="product-brand-row">
                        <span class="label">브랜드</span>
                        <span class="value">${product.companyName}</span>
                    </div>

                    <div class="product-brand-row">
                        <span class="label">상품번호</span>
                        <span class="value">${product.productId}</span>
                    </div>

                    <div class="product-brand-row">
                        <span class="label">재고</span>
                        <span class="value">
                            <c:choose>
                                <c:when test="${product.productStock > 0}">
                                    ${product.productStock}개
                                </c:when>
                                <c:otherwise>
                                    품절
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>

                    <div class="product-price-box">
                        <span class="price-label">판매가</span>
                        <span class="price-value">
                            <fmt:formatNumber value="${product.productPrice}" pattern="#,###"/>원
                        </span>
                    </div>

                    <div class="product-desc-short">
                        우리 아이를 위한 상품 상세 정보를 확인해보세요.
                    </div>

                    <!-- 구매하기 -->
                    <form action="${pageContext.request.contextPath}/orders/orderNew" method="Get" class="buy-form">
                        <input type="hidden" name="productId" value="${product.productId}">

                        <div class="qty-row">
                            <label for="qty">수량</label>
                            <input type="number"
                                   id="qty"
                                   name="qty"
                                   value="1"
                                   min="1"
                                   max="${product.productStock > 0 ? product.productStock : 1}">
                        </div>

                        <div class="total-row">
                            <span>총 상품금액</span>
                            <strong id="totalPrice"
                                    data-price="${product.productPrice}">
                                <fmt:formatNumber value="${product.productPrice}" pattern="#,###"/>원
                            </strong>
                        </div>

                        <div class="btn-area">
                            <button type="submit" class="buy-btn"
                                <c:if test="${product.productStock <= 0}">disabled</c:if>>
                                구매하기
                            </button>
                        </div>
                    </form>

                    <!-- 장바구니 -->
                    <form action="${pageContext.request.contextPath}/cartList/addAjax" method="post" class="cart-form">
    
    <input type="hidden" name="productId" value="${product.productId}">
    <input type="hidden" name="productName" value="${product.productName}">
    <input type="hidden" name="productPrice" value="${product.productPrice}">
    <input type="hidden" name="productPhoto" value="${product.productPhoto1}">
    
    <input type="hidden" name="qty" id="cartQty" value="1">

    <div class="btn-area second-btn-area">
        <button type="button" class="cart-btn"
            <c:if test="${product.productStock <= 0}">disabled</c:if>>
            장바구니
        </button>
    </div>
</form>
                </div>
            </section>

            <!-- sticky 탭 메뉴 -->
            <nav class="product-tab-nav" id="productTabNav">
                <a href="#productInfoSection" class="tab-link">상품정보</a>
                <a href="#detailInfoSection" class="tab-link">상세정보</a>
                <a href="#reviewListSection" class="tab-link">리뷰목록</a>
                <a href="${pageContext.request.contextPath}/review/write/check?productId=${product.productId}"
                   class="tab-link review-write-link">리뷰작성</a>
            </nav>

            <!-- 상세 설명 -->
            <section class="product-detail-section section-anchor" id="detailInfoSection">
                <div class="section-title">상품 상세 정보</div>

                <c:if test="${not empty product.productPhoto2}">
                    <div class="detail-image-box">
                        <img src="${pageContext.request.contextPath}${product.productPhoto2}"
                             alt="${product.productName}">
                    </div>
                </c:if>

                <div class="detail-text-box">
                    <c:out value="${product.productDetail}" escapeXml="false"/>
                </div>
            </section>

            <!-- 리뷰 목록 -->
            <section class="product-review-section section-anchor" id="reviewListSection">
                <div class="review-header">
                    <div class="section-title">리뷰 목록</div>
                    <a href="${pageContext.request.contextPath}/review/write/check?productId=${product.productId}"
                       class="review-write-btn">
                        리뷰작성
                    </a>
                </div>

                <div class="review-summary-box">
                    총 <strong>${reviewCount}</strong>개의 리뷰가 있습니다.
                </div>

                <div class="review-empty-box">
                    등록된 리뷰가 없습니다.
                </div>
            </section>

            <!-- 배송안내 -->
            <section class="product-info-section section-anchor" id="deliveryInfoSection">
                <div class="section-title">배송안내</div>
                <div class="info-content">
                    - 배송 기간은 결제 완료 후 평균 2~5일 소요됩니다.<br>
                    - 도서산간 지역은 배송이 지연될 수 있습니다.<br>
                    - 재고 상황에 따라 일부 상품은 배송이 늦어질 수 있습니다.
                </div>
            </section>

            <!-- 교환 반품 -->
            <section class="product-info-section">
                <div class="section-title">교환 및 반품 안내</div>
                <div class="info-content">
                    - 상품 수령 후 7일 이내 교환/반품 신청이 가능합니다.<br>
                    - 단순 변심에 의한 반품은 왕복 배송비가 발생할 수 있습니다.<br>
                    - 상품 훼손 및 사용 흔적이 있는 경우 교환/반품이 제한될 수 있습니다.
                </div>
            </section>

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
        document.addEventListener("DOMContentLoaded", function() {
            const qtyInput = document.getElementById("qty");
            const totalPriceEl = document.getElementById("totalPrice");
            const cartQty = document.getElementById("cartQty");
            const tabLinks = document.querySelectorAll(".tab-link[href^='#']");

            if (qtyInput && totalPriceEl) {
                const price = Number(totalPriceEl.dataset.price || 0);

                function updateTotal() {
                    let qty = Number(qtyInput.value || 1);

                    if (qty < 1) {
                        qty = 1;
                        qtyInput.value = 1;
                    }

                    const total = price * qty;
                    totalPriceEl.innerText = total.toLocaleString() + "원";

                    if (cartQty) {
                        cartQty.value = qty;
                    }
                }

                qtyInput.addEventListener("input", updateTotal);
                updateTotal();
            }

            tabLinks.forEach(function(link) {
                link.addEventListener("click", function(e) {
                    e.preventDefault();

                    const targetId = this.getAttribute("href");
                    const target = document.querySelector(targetId);

                    if (target) {
                        const navHeight = document.getElementById("productTabNav").offsetHeight;
                        const targetTop = target.getBoundingClientRect().top + window.pageYOffset - navHeight - 20;

                        window.scrollTo({
                            top: targetTop,
                            behavior: "smooth"
                        });
                    }
                });
            });
        });
        
     // =========== 추가 ===========
     // ⭐ 상품 상세 장바구니 AJAX
     document.querySelector(".cart-btn").addEventListener("click", function() {

         const form = document.querySelector(".cart-form");
         const formData = new FormData(form);

         fetch(form.action, {
             method: "POST",
             body: formData
         })
         .then(res => res.text())
         .then(count => {

             alert("장바구니에 추가되었습니다");

             console.log("카트 개수:", count);

             // ⭐ 헤더 숫자 반영
             updateCartCountUI(parseInt(count));
         })
         .catch(err => {
             console.error(err);
         });
     });
	
  	// 위로 가기 버튼 표시/숨김
     window.addEventListener("scroll", function() {
         const btn = document.getElementById("scrollTopBtn");
         if (window.scrollY > 300) {
             btn.style.display = "block";
         } else {
             btn.style.display = "none";
         }
     });
    </script>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>