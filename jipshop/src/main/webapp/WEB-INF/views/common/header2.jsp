<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header2.css">

<header class="site-header">

</head>
<body>

    <header>
        <div class="top-bar">
            <div class="inner">
                <nav class="util-menu">
                    <a href="#">로그인</a>
                    <a href="#">회원가입</a>
                    <a href="#">마이페이지</a>
                    <a href="#">문의</a>
                </nav>
            </div>
        </div>
        <div class="main-header inner">
            <h1 class="logo"><img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="집사상점"></h1>
            <div class="search-box">
                <input type="text">
                <button type="button" class="btn-search">
    <img src="${pageContext.request.contextPath}/resources/images/search_icon.png" alt="검색">
</button>
            </div>
            <div class="right-icons">
            <div class="cart-icon"><img src="${pageContext.request.contextPath}/resources/images/cart-icon.png" alt="장바구니"></div>
            <div class="favorite-icon"><img src="${pageContext.request.contextPath}/resources/images/favorite.png" alt="찜리스트"></div>
            </div>
        </div>
        <nav class="gnb">
            <div class="inner">
                <div class="menu-container">
                <button class="all-menu"><img src="${pageContext.request.contextPath}/resources/images/menu_icon.png" alt="메뉴">전체 메뉴</button>

<!-- 
	<div class="dropdown-menu" id="dropdownMenu">
        <div class="menu-column">
            <h3>강아지</h3>
            <ul>
                <li><a href="#">사료</a></li>
                <li><a href="#">장난감</a></li>
                <li><a href="#">외출용품</a></li>
                <li><a href="#">미용용품</a></li>
            </ul>
        </div>
        <div class="menu-column">
            <h3>고양이</h3>
            <ul>
                <li><a href="#">사료</a></li>
                <li><a href="#">장난감</a></li>
                <li><a href="#">외출용품</a></li>
                <li><a href="#">미용용품</a></li>
            </ul>
        </div>
    </div>
-->

                </div>

                <ul class="nav-list">
                    <li><a href="#">강아지</a></li>
                    <li><a href="#">고양이</a></li>
                    <li><a href="#">추천</a></li>
                    <li><a href="#">커뮤니티</a></li>
                </ul>
            </div>
        </nav>
    </header>

</body>
</html>