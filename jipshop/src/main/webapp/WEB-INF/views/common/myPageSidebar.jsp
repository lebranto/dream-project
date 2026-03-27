<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>마이페이지 사이드바</title>

<style>

/* ===== 전체 배경 ===== */
body {
    background:#0;
}

/* ===== 사이드바 ===== */
.mypage-sidebar {
    width:220px;
    background:#ddd;
    padding:20px 10px;
}

/* 타이틀 박스 */
.menu-box {
    background:#E3C08D;
    text-align:center;
    padding:10px;
    margin:20px 0 10px;
    font-weight:bold;
    border-radius:3px;
}

/* 메뉴 리스트 */
.menu-list {
    text-align:center;
}

.menu-list li {
    margin:8px 0;
}

/* 링크 */
.menu-list a {
    display:block;
    padding:5px 0;
    font-size:14px;
    transition:0.2s;
}

/* hover 효과 */
.menu-list a:hover {
    color:#ff8c00;
    font-weight:bold;
}

/* 선택된 메뉴 */
.active {
    color:#ff8c00;
    font-weight:bold;
}

</style>
</head>

<body>

<aside class="mypage-sidebar">

    <!-- MY 쇼핑 -->
    <div class="menu-box">my 쇼핑</div>
    <ul class="menu-list">
        <li><a href="#">구매 내역 보기</a></li>
        <li><a href="#">최근 본 상품</a></li>
        <li><a href="${pageContext.request.contextPath}/orders/favorites">찜리스트</a></li>
    </ul>

    <!-- 문의 -->
    <div class="menu-box">문의</div>
    <ul class="menu-list">
        <li><a href="#">문의 내역</a></li>
    </ul>

    <!-- 회원 정보 -->
    <div class="menu-box">회원 정보</div>
    <ul class="menu-list">
        <li><a href="#">회원 정보 수정</a></li>
        <li><a href="#">반려동물 정보 수정</a></li>
        <li><a href="#">회원 탈퇴</a></li>
    </ul>

    <!-- 고객센터 -->
    <div class="menu-box">고객센터</div>
    <ul class="menu-list">
        <li><a href="#" class="active">1:1 문의</a></li>
        <li><a href="${pageContext.request.contextPath}/orders/FAQ">FAQ</a></li>
    </ul>

</aside>

</body>
</html>