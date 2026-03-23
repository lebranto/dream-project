<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>집사상점 - 찜리스트</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">

<style>

/* ===== 레이아웃 ===== */
.content-wrapper {
    max-width: 1100px;
    margin: 0 auto;
    padding: 40px 20px;
}

.mypage-container {
    display:flex;
    gap:40px;
    align-items:flex-start;
}

/* 사이드바 고정 */
.mypage-sidebar {
    width:220px;
    flex-shrink:0;
    position: sticky;
    top:100px;
}

.mypage-content { flex:1; }

/* ===== 체크박스 크게 ===== */
input[type="checkbox"] {
    width:20px;
    height:20px;
    cursor:pointer;
}

/* ===== 상단 ===== */
.mypage-banner {
    background:#fdf5e6;
    padding:20px;
    text-align:center;
    font-size:24px;
    font-weight:bold;
    margin-bottom:50px;
}

.page-title {
    font-size:28px;
    margin-bottom:25px;
}

/* ===== 리스트 ===== */
.list-header {
    background:#d9d9d9;
    padding:12px 20px;
    display:flex;
    align-items:center;
    margin-bottom:30px;
}

.header-chk { width:40px; }
.header-info { flex:1; text-align:center; }
.header-qty { width:150px; text-align:center; }

.wish-item {
    display:flex;
    align-items:center;
    gap:20px;
    margin-bottom:20px;
}

.item-card {
    flex:1;
    display:flex;
    align-items:center;
    border:1px solid #333;
    border-radius:20px;
    padding:20px;
    background:#fff;
}

.item-img {
    width:120px;
    margin-right:30px;
}

.item-details { flex:1; }

/* ===== 수량 ===== */
.quantity-control {
    display:flex;
    align-items:center;
    gap:5px;
}

.quantity-control input {
    width:40px;
    text-align:center;
}

.qty-btn-stack {
    display:flex;
    flex-direction:column;
    border:1px solid #999;
}

.qty-btn-stack button {
    width:18px;
    height:12px;
    font-size:8px;
    cursor:pointer;
    background:#fff;
    border:none;
}

/* ===== 버튼 ===== */
.item-btns {
    display:flex;
    flex-direction:column;
    gap:10px;
    margin-left:20px;
}

.btn-wish {
    padding:6px 15px;
    border:1px solid #999;
    background:#d9d9d9;
    cursor:pointer;
}

.btn-wish.white { background:#fff; }

/* 하단 */
.action-btns {
    display:flex;
    gap:10px;
    margin-top:20px;
}

.btn-action {
    padding:8px 15px;
    border:1px solid #999;
    background:#fff;
    cursor:pointer;
}

.cart-table input[type="checkbox"]{
    transform: scale(1.5);   /* 👈 체크 박스 크기 */
    cursor: pointer;
    accent-color: #666;   /* 👈 회색으로 변경 */
}

</style>
</head>

<body>

<jsp:include page="/WEB-INF/views/common/header2.jsp" />

<div class="content-wrapper">

<div class="mypage-container">

    <jsp:include page="/WEB-INF/views/common/myPageSidebar.jsp" />

    <div class="mypage-content">

        <div class="mypage-banner">마이페이지</div>

        <h2 class="page-title">찜리스트</h2>

        <div class="list-header">
            <div class="header-chk"><input type="checkbox"></div>
            <div class="header-info">상품/옵션 정보</div>
            <div class="header-qty">수량</div>
        </div>

        <!-- ===== 리스트 5개 ===== -->
        
        <c:forEach begin="1" end="5">
        <div class="wish-item">
            <input type="checkbox">

            <div class="item-card">
                <img src="${pageContext.request.contextPath}/resources/images/강아지.png" class="item-img">

                <div class="item-details">
                    <div>상품명 ${status.index}</div>
                    <div>가격</div>
                </div>

                <div class="quantity-control">
                    <span>수량</span>
                    <input type="text" value="1">

                    <div class="qty-btn-stack">
                        <button type="button">▲</button>
                        <button type="button">▼</button>
                    </div>
                </div>

                <div class="item-btns">
                    <button class="btn-wish">장바구니</button>
                    <button class="btn-wish white">삭제</button>
                </div>
            </div>
        </div>
        </c:forEach>

        <!-- 하단 버튼 -->
        <div class="action-btns">
            <button class="btn-action">선택 삭제</button>
            <button class="btn-action">장바구니</button>
        </div>

    </div>

</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>