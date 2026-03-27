<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지슬라이드</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/mainslide.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/footer.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/main3.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/sidebar.css">
</head>
<body>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

   <!-- 메인페이지 첫번쨰 슬라이스 상단  --> 
    <section class="main-banner-wrap">
    
        <div class="main-banner" id="mainBanner">
   
            <div class="banner-track" id="bannerTrack">

                <div class="banner-slide">
                    <img src="${pageContext.request.contextPath}/resources/img/KakaoTalk_20260318_120256309.png" alt="배너1">
                    <div class="banner-overlay">
                        <span class="badge">BEST</span>
                        <p>인기 사료와 간식을 한눈에 만나보세요</p>
                    </div>
                </div>


                <div class="banner-slide">
                    <img src="${pageContext.request.contextPath}/resources/img/KakaoTalk_20260318_120256309_01.png" alt="배너2">
                    <div class="banner-overlay">
                        <span class="badge">LIVING</span>
                        <p>생활용품과 위생용품도 편리하게 쇼핑</p>
                    </div>
                </div>

                <div class="banner-slide">
                    <img src="${pageContext.request.contextPath}/resources/img/KakaoTalk_20260318_120256309_02.png" alt="배너3">
                    <div class="banner-overlay">
                        <span class="badge">CARE</span>
                        <p>칫솔 · 위생용품 · 데일리 케어 추천</p>
                    </div>
                </div>

                <div class="banner-slide">
                    <img src="${pageContext.request.contextPath}/resources/img/KakaoTalk_20260318_120256309_03.png" alt="배너4">
                    <div class="banner-overlay">
                        <span class="badge">CAT</span>
                        <p>체질을 생각한 고양이 맞춤 상품</p>
                    </div>
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

    <script>
        const banner = document.getElementById("mainBanner");
        const bannerTrack = document.getElementById("bannerTrack");
        const slides = document.querySelectorAll(".banner-slide");
        const dots = document.querySelectorAll(".banner-dot");
        const prevBtn = document.getElementById("prevBtn");
        const nextBtn = document.getElementById("nextBtn");
        const currentNum = document.getElementById("currentNum");
        const totalNum = document.getElementById("totalNum");

        let currentIndex = 0;
        let autoSlide;

        totalNum.textContent = slides.length;

        function updateSlide(index){
            bannerTrack.style.transform = "translateX(-" + (index * 20) + "%)";

            dots.forEach(function(dot){
                dot.classList.remove("active");
            });
            dots[index].classList.add("active");

            currentNum.textContent = index + 1;
            currentIndex = index;
        }

        function nextSlide(){
            let nextIndex = currentIndex + 1;
            if(nextIndex >= slides.length){
                nextIndex = 0;
            }
            updateSlide(nextIndex);
        }

        function prevSlide(){
            let prevIndex = currentIndex - 1;
            if(prevIndex < 0){
                prevIndex = slides.length - 1;
            }
            updateSlide(prevIndex);
        }


        

        nextBtn.addEventListener("click", function(){
            nextSlide();
        });

        prevBtn.addEventListener("click", function(){
            prevSlide();
        });

        dots.forEach(function(dot, index){
            dot.addEventListener("click", function(){
                updateSlide(index);
            });
        });
    </script>

  <div class="wrap">
   <div class="inner">
    <!-- 추천상품 -->
    <section class="recommend-section">
      <h2 class="section-title">추천상품</h2>

      <div class="recommend-content">
        <div class="recommend-left">
          <div class="product-card">
            <img src="https://via.placeholder.com/140x140" alt="상품" />
            <div class="product-name">바른먹거리 반려견 사료</div>
            <div class="price">19,800원</div>
            <div class="badge">BEST</div>
            <div class="cart">🛒</div>
          </div>

          <div class="product-card">
            <img src="https://via.placeholder.com/140x140" alt="상품" />
            <div class="product-name">바른먹거리 반려견 사료</div>
            <div class="price">19,800원</div>
            <div class="badge">BEST</div>
            <div class="cart">🛒</div>
          </div>

          <div class="product-card">
            <img src="https://via.placeholder.com/140x140" alt="상품" />
            <div class="product-name">바른먹거리 반려견 사료</div>
            <div class="price">19,800원</div>
            <div class="badge">BEST</div>
            <div class="cart">🛒</div>
          </div>

          <div class="product-card">
            <img src="https://via.placeholder.com/140x140" alt="상품" />
            <div class="product-name">바른먹거리 반려견 사료</div>
            <div class="price">19,800원</div>
            <div class="badge">BEST</div>
            <div class="cart">🛒</div>
          </div>
        </div>

        <div class="recommend-right">
          <div class="category-buttons">
            <button class="active">강아지</button>
            <button>고양이</button>
            <button>추천템</button>
          </div>

          <div class="pet-image">
            <img src="https://via.placeholder.com/260x260" alt="강아지 고양이 이미지" />
          </div>
        </div>
      </div>
    </section>

    <!-- 신상품 -->
    <section class="product-section">
      <h2 class="section-title">신상품</h2>
      <div class="product-grid">
        <div class="product-card">
          <img src="https://via.placeholder.com/120x120" alt="상품" />
          <div class="product-name">신상품 사료 1</div>
          <div class="price">19,800원</div>
          <div class="badge">NEW</div>
          <div class="cart">🛒</div>
        </div>
        <div class="product-card">
          <img src="https://via.placeholder.com/120x120" alt="상품" />
          <div class="product-name">신상품 사료 2</div>
          <div class="price">19,800원</div>
          <div class="badge">NEW</div>
          <div class="cart">🛒</div>
        </div>
        <div class="product-card">
          <img src="https://via.placeholder.com/120x120" alt="상품" />
          <div class="product-name">신상품 사료 3</div>
          <div class="price">19,800원</div>
          <div class="badge">NEW</div>
          <div class="cart">🛒</div>
        </div>
        <div class="product-card">
          <img src="https://via.placeholder.com/120x120" alt="상품" />
          <div class="product-name">신상품 사료 4</div>
          <div class="price">19,800원</div>
          <div class="badge">NEW</div>
          <div class="cart">🛒</div>
        </div>
        <div class="product-card">
          <img src="https://via.placeholder.com/120x120" alt="상품" />
          <div class="product-name">신상품 사료 5</div>
          <div class="price">19,800원</div>
          <div class="badge">NEW</div>
          <div class="cart">🛒</div>
        </div>
      </div>
    </section>

    <!-- 장바구니 꿀템 상품 -->
    <section class="product-section">
      <h2 class="section-title">장바구니 꿀템 상품</h2>
      <div class="product-grid">
        <div class="product-card">
          <img src="https://via.placeholder.com/120x120" alt="상품" />
          <div class="product-name">꿀템 상품 1</div>
          <div class="price">19,800원</div>
          <div class="badge">추천</div>
          <div class="cart">🛒</div>
        </div>
        <div class="product-card">
          <img src="https://via.placeholder.com/120x120" alt="상품" />
          <div class="product-name">꿀템 상품 2</div>
          <div class="price">19,800원</div>
          <div class="badge">추천</div>
          <div class="cart">🛒</div>
        </div>
        <div class="product-card">
          <img src="https://via.placeholder.com/120x120" alt="상품" />
          <div class="product-name">꿀템 상품 3</div>
          <div class="price">19,800원</div>
          <div class="badge">추천</div>
          <div class="cart">🛒</div>
        </div>
        <div class="product-card">
          <img src="https://via.placeholder.com/120x120" alt="상품" />
          <div class="product-name">꿀템 상품 4</div>
          <div class="price">19,800원</div>
          <div class="badge">추천</div>
          <div class="cart">🛒</div>
        </div>
        <div class="product-card">
          <img src="https://via.placeholder.com/120x120" alt="상품" />
          <div class="product-name">꿀템 상품 5</div>
          <div class="price">19,800원</div>
          <div class="badge">추천</div>
          <div class="cart">🛒</div>
        </div>
      </div>
    </section>
     <nav class="view-2" aria-label="사이드 메뉴">
          <div class="frame-19">
            <div class="rectangle-7"></div>
            <span class="text-wrapper-14">커뮤니티</span>
            <div class="group-11" aria-hidden="true">
              <div class="ellipse-3"></div>
              <div class="ellipse-4"></div>
              <div class="ellipse-5"></div>
              <div class="ellipse-6"></div>
            </div>
          </div>
          <div class="frame-20">
            <div class="rectangle-7"></div>
            <span class="text-wrapper-14">마이페이지</span>
            <div class="group-11" aria-hidden="true">
              <div class="ellipse-3"></div>
              <div class="ellipse-4"></div>
              <div class="ellipse-5"></div>
              <div class="ellipse-6"></div>
            </div>
          </div>
          <div class="frame-20">
            <div class="rectangle-7"></div>
            <span class="text-wrapper-14">장바구니</span>
            <div class="group-11" aria-hidden="true">
              <div class="ellipse-3"></div>
              <div class="ellipse-4"></div>
              <div class="ellipse-5"></div>
              <div class="ellipse-6"></div>
            </div>
          </div>
          <div class="frame-20">
            <div class="rectangle-7"></div>
            <span class="text-wrapper-14">고객센터</span>
            <div class="group-11" aria-hidden="true">
              <div class="ellipse-3"></div>
              <div class="ellipse-4"></div>
              <div class="ellipse-5"></div>
              <div class="ellipse-6"></div>
            </div>
          </div>
            <div class="frame-20">
            <div class="rectangle-7"></div>
            <span class="text-wrapper-14" onclick="scrollToTop()"style="cursor: pointer;">위로</span>
            <div class="group-11" aria-hidden="true">
              <div class="ellipse-3"></div>
              <div class="ellipse-4"></div>
              <div class="ellipse-5"></div>
              <div class="ellipse-6"></div>
            </div>
          </div>
        </nav>

  <script>
    function scrollToTop() {
      window.scrollTo({
        top: 0,
        behavior: "smooth"
      });
    }
  </script>

	</div>
  </div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
    
    

