<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>집사생활</title>

<style>

body{
    margin:0;
    font-family: Arial, sans-serif;
}

/* 상단 로그인 메뉴 */
.top-bar{
    
    background:#e9c77b;
    height:35px;
    display:flex;
    justify-content:flex-end;
    align-items:center;
    padding-right:40px;
    font-size:14px;
    min-width: none;
}

.top-bar a{
    margin-left:20px;
    text-decoration:none;
    color:black;
}

/* 로고 + 검색 */
.header{
    background:#eeeeee;
    height:80px;
    display:flex;
    align-items:center;
    justify-content:space-between;
    padding:0 40px;
}

/* 로고 */
.logo{
    font-size:22px;
    font-weight:bold;
}

/* 검색창 */
.search-box{
    display:flex;
    align-items:center;
}

.search-box input{
    width:400px;
    height:35px;
    border-radius:20px;
    border:1px solid #999;
    padding-left:15px;
}

/* 장바구니 */
.cart{
    font-size:22px;
}

/* 메뉴 */
.menu{
    background:#e9c77b;
    height:50px;
    display:flex;
    align-items:center;
}

.menu-left{
    width:200px;
    display:flex;
    align-items:center;
    padding-left:30px;
}

.menu-right{
    flex:1;
    display:flex;
    justify-content:center;
}

.menu-right a{
    margin:0 40px;
    text-decoration:none;
    color:black;
    font-weight:bold;
}

</style>

</head>

<body>

<!-- 상단 로그인 메뉴 -->
<div class="top-bar">
    <a href="login.jsp">로그인</a>
    <a href="join.jsp">회원가입</a>
    <a href="mypage.jsp">마이페이지</a>
    <a href="qna.jsp">문의</a>
</div>

<!-- 로고 + 검색 -->
<div class="header">

    <div class="logo">
        <img herf="">
    </div>

    <div class="search-box">
        <input type="text" placeholder="검색어 입력">
    </div>

    <div class="cart">
        🛒
    </div>

</div>

<!-- 메뉴 -->
<div class="menu">

    <div class="menu-left">
        ☰ 전체 메뉴
    </div>

    <div class="menu-right">
        <a href="#">강아지</a>
        <a href="#">고양이</a>
        <a href="#">추천</a>
        <a href="#">커뮤니티</a>
    </div>

</div>

</body>
</html>