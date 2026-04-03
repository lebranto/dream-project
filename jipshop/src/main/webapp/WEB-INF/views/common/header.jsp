<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/header.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

<style>
/* 카트 뱃지 추가 */
.cart-icon-wrapper {
    position: relative;
    display: inline-block;
}

.cart-count-badge {
    position: absolute;
    top: -5px;
    right: -8px;

    min-width: 18px;
    height: 18px;
    padding: 0 5px;

    background: orange;
    color: white;
    font-size: 12px;
    font-weight: bold;

    display: flex;
    align-items: center;
    justify-content: center;

    border-radius: 999px;

    transition: transform 0.2s ease;
}

/* ⭐ 팡 튀는 효과 */
.cart-count-badge.pop {
    animation: popAnim 0.3s ease;
}

@keyframes popAnim {
    0%   { transform: scale(1); }
    50%  { transform: scale(1.4); }
    100% { transform: scale(1); }
}
</style>

<c:set var="contextPath" value="${pageContext.request.contextPath}" scope="application" />

<header class="site-header">
    <!-- 상단 유틸 메뉴 -->
    <div class="top-bar">
        <div class="top-bar-inner">
            <div class="top-menu">
              <sec:authorize access="isAnonymous()">
                 <a href="${contextPath}/member/login">로그인</a>
                 <a href="${contextPath}/security/insert">회원가입</a>
                 <a href="${contextPath}/mypage/purchase">마이페이지</a>
                 <a href="${contextPath}/product/inquiryList">문의</a>
              </sec:authorize>
             <sec:authorize access="isAuthenticated()">
                <label><sec:authentication property="principal.memberName"/>님 환영합니다.</label>
                <a href="${contextPath}/mypage/purchase">마이페이지</a>
                <a href="${contextPath}/product/inquiryList">문의</a>
                <form:form method="post" action="${contextPath}/member/logout" style="display: inline;">
                    <button type="submit" class="border-0 bg-transparent text-secondary p-0 ml-2">로그아웃</button>
                </form:form>
             </sec:authorize>
             <sec:authorize access="hasRole('ROLE_ADMIN')">
                    <a href="${contextPath}/admin/dashboard">관리자페이지</a>
                </sec:authorize>
            </div>
        </div>
    </div>

    <!-- 로고 / 검색+아이콘 -->
    <div class="header-middle">
        <div class="header-middle-inner">
            <!-- 로고 (왼쪽 끝) -->
            <div class="logo-area">
                <a href="${pageContext.request.contextPath}">
                    <img src="${pageContext.request.contextPath}/resources/images/logo.png">
                </a>
            </div>

            <!-- 검색창 + 하트 + 장바구니 묶음 (오른쪽 끝) -->
            <div class="search-icon-group">
                <div class="search-area">
                    <form action="${pageContext.request.contextPath}/product/list" method="get"
                          style="display:flex; align-items:center; width:100%; height:100%; margin:0;">
                        <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어를 입력하세요">
                        <button type="submit">
                            <i class="bi bi-search"></i>
                        </button>
                    </form>
                </div>
                <div class="icon-area">
                    <a href="${pageContext.request.contextPath}/orders/wishList"><i class="bi bi-heart"></i></a>
                    <a href="${pageContext.request.contextPath}/orders/cartList" class="cart-icon-wrapper">
                        <img src="${pageContext.request.contextPath}/resources/img/장바구니.png" alt="장바구니">
                        <span id="cartCount" class="cart-count-badge">${cartCount}</span>
                    </a>

                </div>
            </div>

        </div>
    </div>

    <nav class="main-nav">
        <div class="nav-inner">
            <div class="all-menu">
               <a href="${contextPath}/product/list" class="nav-link all-menu-btn">
                    <span class="menu-circle">☰</span>
                    <span>전체 메뉴</span>
                </a>
                <div class="allmenu-dropdown">
                    <div class="allmenu-wrap">
                        <div class="allmenu-box">
                            <div class="allmenu-title">강아지</div>
                            <a href="${contextPath}/product/list?petType=강아지&categoryName=사료">사료</a>
                            <a href="${contextPath}/product/list?petType=강아지&categoryName=장난감">장난감</a>
                            <a href="${contextPath}/product/list?petType=강아지&categoryName=외출용품">외출용품</a>
                            <a href="${contextPath}/product/list?petType=강아지&categoryName=미용용품">미용용품</a>
                        </div>
                        <div class="allmenu-box">
                            <div class="allmenu-title">고양이</div>
                            <a href="${contextPath}/product/list?petType=고양이&categoryName=사료">사료</a>
                            <a href="${contextPath}/product/list?petType=고양이&categoryName=장난감">장난감</a>
                            <a href="${contextPath}/product/list?petType=고양이&categoryName=외출용품">외출용품</a>
                            <a href="${contextPath}/product/list?petType=고양이&categoryName=미용용품">미용용품</a>
                        </div>
                    </div>
                </div>
            </div>

            <ul class="main-menu">
                <li class="menu-item has-sub">
                    <a href="javascript:void(0);" class="nav-link">강아지</a>
                    <div class="small-dropdown">
                        <a href="${contextPath}/product/list?petType=강아지&categoryName=사료">사료</a>
                        <a href="${contextPath}/product/list?petType=강아지&categoryName=장난감">장난감</a>
                        <a href="${contextPath}/product/list?petType=강아지&categoryName=외출용품">외출용품</a>
                        <a href="${contextPath}/product/list?petType=강아지&categoryName=미용용품">미용용품</a>
                    </div>
                </li>
                <li class="menu-item has-sub">
                    <a href="javascript:void(0);" class="nav-link">고양이</a>
                    <div class="small-dropdown">
                        <a href="${contextPath}/product/list?petType=고양이&categoryName=사료">사료</a>
                        <a href="${contextPath}/product/list?petType=고양이&categoryName=장난감">장난감</a>
                        <a href="${contextPath}/product/list?petType=고양이&categoryName=외출용품">외출용품</a>
                        <a href="${contextPath}/product/list?petType=고양이&categoryName=미용용품">미용용품</a>
                    </div>
                </li>
                <li class="menu-item">
  					  <a href="${pageContext.request.contextPath}/#recommend-section"
 							  class="nav-link"  id="recommendLink">추천</a>
				</li>
                <li class="menu-item">
                    <a href="${pageContext.request.contextPath}/community/main" class="nav-link">커뮤니티</a>
                </li>
            </ul>
        </div>
    </nav>

</header>

<!-- ⭐ 장바구니 숫자 관리 -->
<script>
function updateCartCountUI(count) {
    const badge = document.querySelector(".cart-count-badge");

    if (!badge) return;

    let display = count > 99 ? "99+" : count;

    if (count > 0) {
        badge.style.display = "flex";
        badge.innerText = display;

        // 애니메이션
        badge.classList.remove("pop");
        void badge.offsetWidth;
        badge.classList.add("pop");

    } else {
        badge.style.display = "none";
    }
}

function smoothScrollTo(targetY, duration = 600) {
    const startY = window.scrollY;
    const diff = targetY - startY;
    let start;

    function step(timestamp) {
        if (!start) start = timestamp;
        const time = timestamp - start;
        const percent = Math.min(time / duration, 1);

        // easeOut (부드럽게 감속)
        const ease = 1 - Math.pow(1 - percent, 3);

        window.scrollTo(0, startY + diff * ease);

        if (time < duration) {
            requestAnimationFrame(step);
        }
    }

    requestAnimationFrame(step);
}

document.getElementById("recommendLink")?.addEventListener("click", function(e) {

    const el = document.getElementById("recommend-section");

    if (el) {
        e.preventDefault();
        smoothScrollTo(el.offsetTop, 700); // 속도 조절 가능
    }
});
</script>