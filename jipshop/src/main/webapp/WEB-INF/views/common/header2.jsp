<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>집사상점</title>

<style>

/* ===== 기본 ===== */
* { margin:0; padding:0; box-sizing:border-box; }
body { font-family:'Pretendard', sans-serif; }
ul { list-style:none; }
a { text-decoration:none; color:inherit; }

.inner { max-width:1100px; margin:0 auto; }

/* ===== 상단바 ===== */
.top-bar { background:#FFD780; padding:10px 0; }
.util-menu {
    display:flex;
    justify-content:flex-end;
    gap:30px;
}

/* ===== 헤더 ===== */
.main-header {
    display:flex;
    align-items:center;
    justify-content:space-between;
    padding:10px 0;
}

.logo img { width:160px; }

/* 검색 */
.search-box {
    display:flex;
    border:2px solid #333;
    border-radius:25px;
    padding:5px 15px;
    width:400px;
    background:#fff;
}
.search-box input { border:none; flex:1; outline:none; background:transparent;}

.btn-search { border:none; background:none; cursor:pointer; }
.btn-search img { width:20px; }

/* 아이콘 */
.right-icons { display:flex; gap:10px; }
.icon-circle {
    width:35px;
    height:35px;
    border-radius:50%;
    border:2px solid #000;
    display:flex;
    align-items:center;
    justify-content:center;
}
.icon-circle img { width:20px; }

/* ===== 메뉴 ===== */
.gnb { background:#FFD780; }
.gnb .inner {
    display:flex;
    align-items:center;
}

/* ===== 전체메뉴 ===== */
.menu-container { position:relative; }

.all-menu {
    display:flex;
    align-items:center;
    gap:10px;
    padding:15px 30px;
    font-size:20px;
    background:#F8E6C1;
    border:none;
    cursor:pointer;
}

.all-menu img {
    width:28px;
    height:28px;
    background:#D9D9D9;
    border-radius:50%;
    padding:5px;
    transition:transform 0.3s ease;
}

.all-menu img.rotate {
    transform:rotate(180deg);
}

/* ===== 드롭다운 ===== */
.dropdown-menu {
    position:absolute;
    top:100%;
    left:0;

    display:flex;
    align-items:flex-start;

    background:#FFF8E9;
    border-radius:12px;
    border:1px solid #eee;
    box-shadow:0 10px 25px rgba(0,0,0,0.15);

    padding:10px 0;
    z-index:999;

    opacity:0;
    transform:translateY(-10px);
    pointer-events:none;
    transition:all 0.25s ease;
}

.dropdown-menu.active {
    opacity:1;
    transform:translateY(0);
    pointer-events:auto;
}

/* 컬럼 */
.menu-column {
    min-width:177px;
    padding:0 10px;
    border-right:1px solid #eee;
}
.menu-column:last-child { border-right:none; }

.menu-column h3 {
    text-align:center;
    padding:10px;
    font-size:15px;
    background:#fff;
    border-radius:6px;
}

.menu-column ul { margin-top:5px; }

.menu-column li {
    text-align:center;
    padding:8px 0;
}

.dropdown-menu a:hover { color:orange; }

/* ===== 오른쪽 메뉴 ===== */
.nav-list {
    display:flex;
    gap:60px;
    margin-left:auto;
}

.nav-list li {
    position:relative;
    z-index:1000; /* ⭐ 추가 (기준 레이어 올림) */
}

.nav-list > li > a:hover { color:orange; }

.nav-list a {
    white-space:nowrap;
    font-size:18px;
}

/* ===== 오른쪽 드롭다운 ===== */
.nav-dropdown {
    position:absolute;
    top:100%;
    left:50%;
    transform:translateX(-50%) translateY(-10px);

    width:160px;
    background:#FFF8E9;
    border-radius:10px;
    border:1px solid #eee;
    box-shadow:0 8px 20px rgba(0,0,0,0.12);

    max-height:0;
    overflow:hidden;
    opacity:0;
    transition:all 0.3s ease;

    z-index:2000; /* ⭐ 추가 (바디 위로 올림 핵심) */
}

.nav-list li:hover .nav-dropdown {
    max-height:300px;
    opacity:1;
    transform:translateX(-50%) translateY(0);
}

.nav-dropdown li {
    padding:10px 0;
    text-align:center;
    border-bottom:1px solid #eee;
}
.nav-dropdown li:last-child { border-bottom:none; }

.nav-dropdown a:hover { color:orange; }

</style>
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
    <h1 class="logo">
        <img src="${pageContext.request.contextPath}/resources/images/logo.png">
    </h1>

    <div class="search-box">
        <input type="text" placeholder="검색어를 입력해 주세요.">
        <button class="btn-search">
            <img src="${pageContext.request.contextPath}/resources/images/search_icon.png">
        </button>
    </div>

    <div class="right-icons">
        <div class="icon-circle">
            <img src="${pageContext.request.contextPath}/resources/images/cart-icon.png">
        </div>
        <div class="icon-circle">
            <img src="${pageContext.request.contextPath}/resources/images/favorite.png">
        </div>
    </div>
</div>

<nav class="gnb">
<div class="inner">

    <!-- 전체메뉴 -->
    <div class="menu-container">
        <button class="all-menu" id="allMenuBtn">
            <img src="${pageContext.request.contextPath}/resources/images/menu_icon.png">
            전체 메뉴
        </button>

        <div class="dropdown-menu">
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
    </div>

    <!-- 오른쪽 메뉴 -->
    <ul class="nav-list">
        <li>
            <a href="#">강아지</a>
            <ul class="nav-dropdown">
                <li><a href="#">사료</a></li>
                <li><a href="#">장난감</a></li>
                <li><a href="#">외출용품</a></li>
                <li><a href="#">미용용품</a></li>
            </ul>
        </li>

        <li>
            <a href="#">고양이</a>
            <ul class="nav-dropdown">
                <li><a href="#">사료</a></li>
                <li><a href="#">장난감</a></li>
                <li><a href="#">외출용품</a></li>
                <li><a href="#">미용용품</a></li>
            </ul>
        </li>

        <li><a href="#">추천</a></li>
        <li><a href="#">커뮤니티</a></li>
    </ul>

</div>
</nav>

</header>

<script>
const btn = document.getElementById("allMenuBtn");
const menu = document.querySelector(".dropdown-menu");
const icon = btn.querySelector("img");

btn.addEventListener("click", function(e) {
    e.stopPropagation();

    menu.classList.toggle("active");

    if(menu.classList.contains("active")){
        icon.src = "${pageContext.request.contextPath}/resources/images/close_icon.png";
        icon.classList.add("rotate");
    } else {
        icon.src = "${pageContext.request.contextPath}/resources/images/menu_icon.png";
        icon.classList.remove("rotate");
    }
});

document.addEventListener("click", function() {
    menu.classList.remove("active");

    icon.src = "${pageContext.request.contextPath}/resources/images/menu_icon.png";
    icon.classList.remove("rotate");
});

menu.addEventListener("click", function(e) {
    e.stopPropagation();
});
</script>

</body>
</html>