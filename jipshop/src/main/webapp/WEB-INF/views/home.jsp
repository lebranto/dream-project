<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
   <title>Home</title>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- 메인페이지 첫번쨰 슬라이스 상단  -->
<section>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>

<style>
    *{
        margin:0;
        padding:0;
        box-sizing:border-box;
    }

    body{
        font-family: 'Malgun Gothic', sans-serif;
    }

    .main-banner-wrap{
        width:100%;
        background:#f8f6ef;
    }

    .main-banner{
        position:relative;
        width:100%;
        max-width:1700px;
        height:650px;
        margin:0 auto;
        overflow:hidden;
    }


    .banner-track{
        display:flex;
        width:500%;
        height:100%;
        transition:transform 0.6s ease-in-out;
    }

    .banner-slide{
        width:20%;
        height:100%;
        flex-shrink:0;
        position:relative;
    }

    .banner-slide img{
        width:100%;
        height:100%;
        object-fit:cover;
        display:block;
    }

.banner-overlay{
    position:absolute;
    left:80px;
    top:155px;
    transform:none;
}

    .banner-overlay .badge{
        display:inline-block;
        padding:8px 14px;
        border-radius:20px;
        background:#d81b60;
        color:#fff;
        font-size:14px;
        font-weight:bold;
        margin-bottom:16px;
    }

    .banner-overlay h2{
        font-size:42px;
        font-weight:800;
        line-height:1.25;
        margin-bottom:14px;
    }

    .banner-overlay p{
        font-size:18px;
        color:#555;
    }

    .banner-btn{
        position:absolute;
        top:50%;
        transform:translateY(-50%);
        z-index:10;
        width:46px;
        height:46px;
        border:none;
        border-radius:50%;
        background:rgba(0,0,0,0.35);
        color:#fff;
        font-size:24px;
        cursor:pointer;
        display:flex;
        align-items:center;
        justify-content:center;
    }

    .banner-btn:hover{
        background:rgba(0,0,0,0.55);
    }

    .banner-prev{
        left:20px;
    }

    .banner-next{
        right:20px;
    }

    .banner-dots{
        position:absolute;
        left:50%;
        bottom:24px;
        transform:translateX(-50%);
        display:flex;
        gap:10px;
        z-index:10;
    }

    .banner-dot{
        width:12px;
        height:12px;
        border-radius:50%;
        border:none;
        background:rgba(255,255,255,0.65);
        cursor:pointer;
        transition:all 0.3s;
    }

    .banner-dot.active{
        width:28px;
        border-radius:20px;
        background:#f0c419;
    }

    .banner-counter{
        position:absolute;
        right:24px;
        bottom:20px;
        z-index:10;
        padding:8px 14px;
        border-radius:18px;
        background:rgba(0,0,0,0.45);
        color:#fff;
        font-size:14px;
    }

    @media (max-width:1024px){
        .main-banner{
            height:420px;
        }

        .banner-overlay{
            left:40px;
        }

        .banner-overlay h2{
            font-size:32px;
        }

        .banner-overlay p{
            font-size:16px;
        }
    }

    @media (max-width:768px){
        .main-banner{
            height:320px;
        }

        .banner-overlay{
            left:24px;
        }

        .banner-overlay .badge{
            font-size:12px;
            padding:6px 10px;
            margin-bottom:10px;
        }

        .banner-overlay h2{
            font-size:24px;
            margin-bottom:8px;
        }

        .banner-overlay p{
            font-size:14px;
        }

        .banner-btn{
            width:38px;
            height:38px;
            font-size:20px;
        }
    }
</style>
</head>
<body>

    <!-- 메인 배너 슬라이드 -->
    <section class="main-banner-wrap">
        <div class="main-banner" id="mainBanner">

            <div class="banner-track" id="bannerTrack">

                <div class="banner-slide">
                    <img src="${contextPath}/resources/images/banner/banner1.png" alt="배너1">
                    <div class="banner-overlay">
                        <span class="badge">BEST</span>
                        <p>인기 사료와 간식을 한눈에 만나보세요</p>
                    </div>
                </div>


                <div class="banner-slide">
                    <img src="${contextPath}/resources/images/banner/banner3.png" alt="배너2">
                    <div class="banner-overlay">
                        <span class="badge">LIVING</span>
                        <p>생활용품과 위생용품도 편리하게 쇼핑</p>
                    </div>
                </div>

                <div class="banner-slide">
                    <img src="${contextPath}/resources/images/banner/banner4.png" alt="배너3">
                    <div class="banner-overlay">
                        <span class="badge">CARE</span>
                        <p>칫솔 · 위생용품 · 데일리 케어 추천</p>
                    </div>
                </div>

                <div class="banner-slide">
                    <img src="${contextPath}/resources/images/banner/banner5.png" alt="배너4">
                    <div class="banner-overlay">
                        <span class="badge">CAT</span>
                        <p>기호성과 영양을 함께 고려한 추천 상품</p>
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

</body>
</html>
</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
