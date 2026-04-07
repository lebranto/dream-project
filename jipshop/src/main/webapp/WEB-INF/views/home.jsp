<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/mainslide.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/footer.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/main3.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/sidebar.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- 메인 배너 슬라이드 -->
<section class="main-banner-wrap">
    <div class="main-banner" id="mainBanner">
        <div class="banner-track" id="bannerTrack">

            <div class="banner-slide">
                <a href="${pageContext.request.contextPath}/product/list?categoryName=사료" class="banner-link">
                    <img src="${pageContext.request.contextPath}/resources/images/banner/강지고양이.png">
                    <div class="banner-overlay">
                        <span class="badge">BEST</span>
                        <p>인기 사료와 간식을 한눈에 만나보세요</p>
                    </div>
                </a>
            </div>

            <div class="banner-slide">
                <a href="${pageContext.request.contextPath}/product/list?petType=강아지&categoryName=사료" class="banner-link">
                    <img src="${pageContext.request.contextPath}/resources/images/banner/KakaoTalk_20260318_120256309_01.png">
                    <div class="banner-overlay">
                        <span class="badge">LIVING</span>
                        <p>생활용품과 위생용품도 편리하게 쇼핑</p>
                    </div>
                </a>
            </div>

<div class="banner-slide">
    <a href="${pageContext.request.contextPath}/product/detail?productId=17" class="banner-link">
        <img src="${pageContext.request.contextPath}/resources/images/banner/KakaoTalk_20260318_120256309_02.png" alt="배너3">
        <div class="banner-overlay">
            <span class="badge">CARE</span>
            <p>칫솔 · 위생용품 · 데일리 케어 추천</p>
        </div>
    </a>
</div>

<div class="banner-slide">
    <a href="${pageContext.request.contextPath}/product/detail?productId=11" class="banner-link">
        <img src="${pageContext.request.contextPath}/resources/images/banner/KakaoTalk_20260318_120256309_03.png" alt="배너4">
        <div class="banner-overlay">
            <span class="badge">CAT</span>
            <p>체질을 생각한 고양이 맞춤 상품</p>
        </div>
    </a>
</div>
        </div>
        <button type="button" class="banner-btn banner-prev" id="prevBtn">&#10094;</button>
        <button type="button" class="banner-btn banner-next" id="nextBtn">&#10095;</button>
        <div class="banner-dots" id="bannerDots">
            <button type="button" class="banner-dot active"></button>
            <button type="button" class="banner-dot"></button>
            <button type="button" class="banner-dot"></button>
            <button type="button" class="banner-dot"></button>
        </div>
        <div class="banner-counter">
            <span id="currentNum">1</span> / <span id="totalNum">4</span>
        </div>
    </div>
</section>

<div class="wrap">
  <div class="inner">

    <!-- ══ 추천상품 ══ -->
    <section class="recommend-section" id="recommend-section">
      <h2 class="section-title">추천상품</h2>
      <div class="recommend-content">

        <!-- 왼쪽: 상품 4개 -->
        <div class="recommend-left" id="recommendProducts">
          <!-- Ajax로 채워짐 -->
        </div>

        <!-- 오른쪽: 탭 버튼 + 이미지 -->
        <div class="recommend-right">
          <div class="category-buttons">
            <button class="active" data-tab="dog">강아지</button>
            <button data-tab="cat">고양이</button>
            <button data-tab="recommend">추천템</button>
          </div>
          <div class="pet-image">
            <img id="recommendPetImg"
                 src="${contextPath}/resources/img/dog_default.png"
                 alt="펫 이미지" />
          </div>
        </div>

      </div>
    </section>

    <!-- ══ 신상품 ══ -->
    <section class="product-section">
      <h2 class="section-title">신상품</h2>
      <div class="product-grid">
        <c:forEach items="${newProducts}" var="p">
        	<div class="product-card">
			 	<a href="${contextPath}/product/detail?productId=${p.productId}" 
			 	class="product-link"
			 	data-product-id="${p.productId}">
					<img src="${contextPath}${p.productPhoto1}" alt="${p.productName}"
				         onerror="this.src='${contextPath}/resources/img/no_image.png'" />
				    <div class="product-name">${p.productName}</div>
				    <div class="price"><fmt:formatNumber value="${p.productPrice}" pattern="#,###"/>원</div>
			  	</a>
			  <div class="badge">NEW</div>
			  <div class="cart"
     			data-id="${p.productId}"
     			data-name="${p.productName}"
     			data-price="${p.productPrice}"
     			data-photo="${p.productPhoto1}">
    			🛒
			</div>
			</div>
        </c:forEach>
      </div>
    </section>

    <!-- ══ 장바구니 꿀템 ══ -->
    <section class="product-section">
      <h2 class="section-title">장바구니 꿀템 상품</h2>
      <div class="product-grid">
        <c:forEach items="${honeyProducts}" var="p">
          <div class="product-card">
		 	<a href="${contextPath}/product/detail?productId=${p.productId}" 
		 	   class="product-link"
		 	   data-product-id="${p.productId}">
				<img src="${contextPath}${p.productPhoto1}" alt="${p.productName}"
			         onerror="this.src='${contextPath}/resources/img/no_image.png'" />
			    <div class="product-name">${p.productName}</div>
			    <div class="price"><fmt:formatNumber value="${p.productPrice}" pattern="#,###"/>원</div>
		  	</a>
		    <div class="badge">NEW</div>
		    <div class="cart"
     			data-id="${p.productId}"
     			data-name="${p.productName}"
     			data-price="${p.productPrice}"
     			data-photo="${p.productPhoto1}">
    			🛒
			</div>
		  </div>
        </c:forEach>
      </div>
    </section>
     <nav class="view-2" aria-label="사이드 메뉴">
         <div class="frame-19">
         	<a href="${contextPath }/community/main">
           	<div class="rectangle-7"></div>
            <span class="text-wrapper-14">커뮤니티</span>
            <div class="group-11" aria-hidden="true">
              <div class="ellipse-3"></div>
              <div class="ellipse-4"></div>
              <div class="ellipse-5"></div>
              <div class="ellipse-6"></div>
            </div>
           </a>
         </div>
         <div class="frame-20">
           <a href="${contextPath }/mypage/purchase">
           	<div class="rectangle-7"></div>
            <span class="text-wrapper-14">마이페이지</span>
            <div class="group-11" aria-hidden="true">
              <div class="ellipse-3"></div>
              <div class="ellipse-4"></div>
              <div class="ellipse-5"></div>
              <div class="ellipse-6"></div>
            </div>
      	</a>
         </div>
         <div class="frame-20">
           <a href="${contextPath }/orders/cartList">
           	<div class="rectangle-7"></div>
            <span class="text-wrapper-14">장바구니</span>
            <div class="group-11" aria-hidden="true">
              <div class="ellipse-3"></div>
              <div class="ellipse-4"></div>
              <div class="ellipse-5"></div>
              <div class="ellipse-6"></div>
            </div>
      	</a>
         </div>
         <div class="frame-20">
           <a href="${contextPath }/product/inquiryList">
           	<div class="rectangle-7"></div>
            <span class="text-wrapper-14">고객센터</span>
            <div class="group-11" aria-hidden="true">
              <div class="ellipse-3"></div>
              <div class="ellipse-4"></div>
              <div class="ellipse-5"></div>
              <div class="ellipse-6"></div>
            </div>
      	   </a>
         </div>
           <div class="frame-20" onclick="scrollToTop()"style="cursor: pointer;">
           <div class="rectangle-7"></div>
           <span class="text-wrapper-14">위로</span>
           <div class="group-11" aria-hidden="true">
             <div class="ellipse-3"></div>
             <div class="ellipse-4"></div>
             <div class="ellipse-5"></div>
             <div class="ellipse-6"></div>
           </div>
         </div>
       </nav>
  </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
  const ctx = '${contextPath}';

  /* ── 배너 슬라이드 ── */
  const bannerTrack = document.getElementById("bannerTrack");
  const slides      = document.querySelectorAll(".banner-slide");
  const dots        = document.querySelectorAll(".banner-dot");
  const currentNum  = document.getElementById("currentNum");
  const totalNum    = document.getElementById("totalNum");
  let currentIndex  = 0;

  totalNum.textContent = slides.length;

  function updateSlide(index) {
    bannerTrack.style.transform = "translateX(-" + (index * 20) + "%)";
    dots.forEach(d => d.classList.remove("active"));
    dots[index].classList.add("active");
    currentNum.textContent = index + 1;
    currentIndex = index;
  }

  document.getElementById("nextBtn").addEventListener("click", function() {
    updateSlide((currentIndex + 1) % slides.length);
  });
  document.getElementById("prevBtn").addEventListener("click", function() {
    updateSlide((currentIndex - 1 + slides.length) % slides.length);
  });
  dots.forEach(function(dot, index) {
    dot.addEventListener("click", function() { updateSlide(index); });
  });

  /* ── 추천상품 탭 Ajax ── */
  function loadRecommend(tab) {
    $.ajax({
      url  : ctx + '/main/recommend',
      type : 'GET',
      data : { tab: tab },
      success: function(res) {
        // 상품 카드 렌더링
        let html = '';
        if (res.products && res.products.length > 0) {
          res.products.forEach(function(p) {
            const price = p.productPrice.toLocaleString();
            html += '<div class="product-card">';
            html += '  <a href="' + ctx + '/product/detail?productId=' + p.productId + '" class="product-link">';
            html += '    <img src="' + ctx + p.productPhoto1 + '" alt="' + p.productName + '" onerror="this.src=\'' + ctx + '/resources/img/no_image.png\'">';
            html += '    <div class="product-name">' + p.productName + '</div>';
            html += '    <div class="price">' + price + '원</div>';
            html += '  </a>';
            html += '  <div class="badge">BEST</div>';
            html += '  <div class="cart" '
                + 'data-id="' + p.productId + '" '
                + 'data-name="' + p.productName + '" '
                + 'data-price="' + p.productPrice + '" '
                + 'data-photo="' + p.productPhoto1 + '">🛒</div>';
            html += '</div>';
          });
        } else {
          html = '<div class="no-product">상품이 없습니다.</div>';
        }
        document.getElementById('recommendProducts').innerHTML = html;

     // 이미지 변경
        const img = document.getElementById('recommendPetImg');
        if (res.petPhoto) {
          // 회원 펫 사진 있으면 → 회원 펫 사진
          img.src = ctx + res.petPhoto;
        } else if (tab === 'recommend') {
          // 추천템 탭이고 펫 사진 없으면 → 추천템 전용 기본 이미지
          img.src = ctx + '/resources/images/pet/dog/mainDC.png';
        } else if (res.imgType === 'cat') {
          img.src = ctx + '/resources/images/pet/cat/mainCat.png';
        } else {
          img.src = ctx + '/resources/images/pet/dog/mainDog.png';
        }
        img.onerror = function() {
          this.src = ctx + (res.imgType === 'cat'
            ? '/resources/images/pet/cat/mainCat.png'
            : '/resources/images/pet/dog/mainDog.png');
        };
      }
    });
  }

  // 탭 버튼 클릭
  document.querySelectorAll('.category-buttons button').forEach(function(btn) {
    btn.addEventListener('click', function() {
      document.querySelectorAll('.category-buttons button').forEach(b => b.classList.remove('active'));
      this.classList.add('active');
      loadRecommend(this.dataset.tab);
    });
  });

  // 페이지 로드 시 강아지 탭 기본 로드
  loadRecommend('dog');

  function scrollToTop() {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }
  
  // 최근 본 뷰
  document.addEventListener('click', function(e) {
    const link = e.target.closest('.product-link');
    if (!link) return;

    const productId = link.dataset.productId;
    if (!productId) return;

    e.preventDefault();

    const moveUrl = link.href;

    fetch('${contextPath}/product/view/insert', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: 'productId=' + encodeURIComponent(productId)
    })
    .then(() => {
        location.href = moveUrl;
    })
    .catch(() => {
        location.href = moveUrl;
    });
});

//===============================
//⭐ 장바구니 담기
//===============================
document.addEventListener("click", function(e){

   const cartBtn = e.target.closest(".cart");
   if(!cartBtn) return;

   const productId = cartBtn.dataset.id;
   const productName = cartBtn.dataset.name;
   const productPrice = cartBtn.dataset.price;
   const productPhoto = cartBtn.dataset.photo;

   fetch("${pageContext.request.contextPath}/cartList/addAjax", {
	    method:"POST",
	    headers:{"Content-Type":"application/x-www-form-urlencoded"},
	    body:
	        "productId=" + productId +
	        "&qty=1"
	})
	.then(res => res.text())
	.then(result => {

	    console.log("서버 응답:", result);

	    if(result == -1){
	        alert("로그인 후 이용해주세요");
	        
	     // ⭐⭐⭐ 헤더 장바구니에 숫자 반영
	        document.getElementById("cartCount").innerText = result;
	        
	        location.href = "${pageContext.request.contextPath}/member/login";
	        return;
	    }

	    alert("장바구니에 담겼습니다 🛒 (담긴 상품종류 총 개수: " + result + ")");
	});

});
</script>

</body>
</html>
