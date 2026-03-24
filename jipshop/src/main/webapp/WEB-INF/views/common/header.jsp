<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">

<header class="site-header">

    <div class="top-bar">
        <div class="top-menu">
            <a href="#">로그인</a>
            <a href="#">회원가입</a>
            <a href="#">마이페이지</a>
            <a href="${pageContext.request.contextPath}/inquiry/list">문의</a>
        </div>
    </div>

    <div class="header-middle">
        <div class="logo-area">
            <a href="${pageContext.request.contextPath}/">
                <img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="로고" width="60">
            </a>
        </div>

        <div class="search-area">
            <input type="text" placeholder="검색어를 입력하세요">
            <button type="button">
                <img src="${pageContext.request.contextPath}/resources/img/search_icon.png" alt="검색">
            </button>
        </div>

        <div class="icon-area">
            <a href="#">
                <img src="${pageContext.request.contextPath}/resources/img/장바구니.png" alt="장바구니">
            </a>
        </div>
    </div>

    <nav class="main-nav">
        <div class="nav-inner">

            <div class="all-menu">
                <a href="javascript:void(0);" class="nav-link all-menu-btn">
                    <span class="menu-circle">☰</span>
                    <span>전체 메뉴</span>
                </a>

                <div class="allmenu-dropdown">
                    <div class="allmenu-wrap">

                        <div class="allmenu-box">
                            <div class="allmenu-title">강아지</div>
                            <a href="${pageContext.request.contextPath}/dog/feed">사료</a>
                            <a href="${pageContext.request.contextPath}/dog/toy">장난감</a>
                            <a href="${pageContext.request.contextPath}/dog/outdoor">외출용품</a>
                            <a href="${pageContext.request.contextPath}/dog/groom">미용용품</a>
                        </div>

                        <div class="allmenu-box">
                            <div class="allmenu-title">고양이</div>
                            <a href="${pageContext.request.contextPath}/cat/feed">사료</a>
                            <a href="${pageContext.request.contextPath}/cat/toy">장난감</a>
                            <a href="${pageContext.request.contextPath}/cat/outdoor">외출용품</a>
                            <a href="${pageContext.request.contextPath}/cat/groom">미용용품</a>
                        </div>

                    </div>
                </div>
            </div>

            <ul class="main-menu">
                <li class="menu-item has-sub">
                    <a href="javascript:void(0);" class="nav-link">강아지</a>
                    <div class="small-dropdown">
                        <a href="${pageContext.request.contextPath}/dog/feed">사료</a>
                        <a href="${pageContext.request.contextPath}/dog/toy">장난감</a>
                        <a href="${pageContext.request.contextPath}/dog/outdoor">외출용품</a>
                        <a href="${pageContext.request.contextPath}/dog/groom">미용용품</a>
                    </div>
                </li>

                <li class="menu-item has-sub">
                    <a href="javascript:void(0);" class="nav-link">고양이</a>
                    <div class="small-dropdown">
                        <a href="${pageContext.request.contextPath}/cat/feed">사료</a>
                        <a href="${pageContext.request.contextPath}/cat/toy">장난감</a>
                        <a href="${pageContext.request.contextPath}/cat/outdoor">외출용품</a>
                        <a href="${pageContext.request.contextPath}/cat/groom">미용용품</a>
                    </div>
                </li>

                <li class="menu-item">
                    <a href="#" class="nav-link">추천</a>
                </li>

                <li class="menu-item">
                    <a href="#" class="nav-link">커뮤니티</a>
                </li>
            </ul>

        </div>
    </nav>

</header>