<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>집사상점 - 장바구니</title>

<style>
/* 기본 초기화 */
* {
    box-sizing:border-box;
    margin:0;
    padding:0;
    font-family:'Pretendard', sans-serif;
}

body {
    background:#f5f5f5;
}

/* 컨테이너 */
.cart-container {
    max-width:1100px;
    margin:0 auto;
    background:#fff;
    padding:30px;
}

/* 헤더 */
.cart-header {
    display:flex;
    justify-content:space-between;
    align-items:flex-end;
    border-bottom:2px solid #000;
    padding-bottom:15px;
    margin-bottom:30px;
}

.cart-header h1 {
    font-size:24px;
}

.steps {
    font-size:14px;
    color:#ccc;
}

.steps .active {
    color:#333;
    font-weight:bold;
}

/* 테이블 */
.table-wrapper {
    overflow-x:auto;
    border-bottom:1px solid #ddd;
}

.cart-table {
    width:100%;
    min-width:800px;
    border-collapse:collapse;
    white-space:nowrap;
}

.cart-table th {
    background:#f9f9f9;
    padding:15px;
    border-top:1px solid #ddd;
    border-bottom:1px solid #ddd;
    font-size:14px;
}

.cart-table td {
    padding:20px 10px;
    border-bottom:1px solid #eee;
    text-align:center;
}

/* 상품 */
.product-info {
    display:flex;
    align-items:center;
    gap:15px;
    text-align:left;
    min-width:300px;
}

.product-info img {
    width:80px;
    height:80px;
    object-fit:cover;
    border-radius:4px;
}

.product-info span {
    overflow:hidden;
    text-overflow:ellipsis;
}

/* 버튼 */
.opt-btn {
    padding:5px 10px;
    border:1px solid #ccc;
    background:#fff;
    border-radius:3px;
    cursor:pointer;
}

.price {
    font-weight:bold;
}

/* 금액 */
.total-summary {
    display:flex;
    justify-content:flex-end;
    align-items:center;
    border:1px solid #eee;
    padding:30px;
    margin:20px 0;
    gap:40px;
    min-width:800px;
}

.summary-item {
    text-align:right;
}

.summary-item span {
    display:block;
    margin-bottom:10px;
    font-size:15px;
}

.summary-item strong {
    font-size:20px;
}

.highlight1 {
    color:#ffb84d;
}

.highlight2 {
    color:#FF9B65;
}


/* 하단 */
.continue-shopping {
    margin-top:10px;
    font-size:14px;
    color:#666;
    cursor:pointer;
}

.cart-actions {
    display:flex;
    justify-content:space-between;
    min-width:800px;
}

.delete-btn {
    padding:10px 20px;
    border:1px solid #ccc;
    background:#fff;
    cursor:pointer;
}

.order-btn {
    padding:15px 60px;
    background:#ffda79;
    border:none;
    font-size:16px;
    font-weight:bold;
    border-radius:4px;
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

<!-- ✅ 헤더 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="cart-container">

    <!-- 상단 -->
    <header class="cart-header">
        <h1>장바구니</h1>
        <div class="steps">
            <span class="active">01 장바구니</span> &gt;
            <span>02 주문서작성/결제</span> &gt;
            <span>03 주문완료</span>
        </div>
    </header>

    <!-- 테이블 -->
    <div class="table-wrapper">
        <table class="cart-table">
            <thead>
                <tr>
                    <th><input type="checkbox" checked></th>
                    <th>상품/옵션 정보</th>
                    <th>수량</th>
                    <th>상품금액</th>
                    <th>배송비</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><input type="checkbox" checked></td>
                    <td class="product-info">
                        <img src="https://placehold.co/80x80" />
                        <span>관절 건강 강아지 사료 1kg</span>
                    </td>
                    <td><button class="opt-btn">옵션변경</button></td>
                    <td class="price">19,900원</td>
                    <td>무료배송</td>
                </tr>

                <tr>
                    <td><input type="checkbox"></td>
                    <td class="product-info">
                        <img src="https://placehold.co/80x80" />
                        <span>집사상점 추천 고양이 츄르 20개입</span>
                    </td>
                    <td><button class="opt-btn">옵션변경</button></td>
                    <td class="price">15,500원</td>
                    <td>무료배송</td>
                </tr>
            </tbody>
        </table>
    </div>

    <div class="continue-shopping">&lt; 쇼핑 계속하기</div>

    <!-- 금액 -->
    <div class="total-summary">
        <div class="summary-item">
            <span>총 1개의 상품금액</span>
            <strong class="highlight1">19,900원</strong>
        </div>
        <div class="summary-item">
            <span>배송비</span>
            <strong>0원</strong>
        </div>
        <div class="summary-item total">
            <span>합계</span>
            <strong class="highlight2">19,900원</strong>
        </div>
    </div>

    <!-- 버튼 -->
    <div class="cart-actions">
        <button class="delete-btn">선택 상품 삭제</button>
        <button class="order-btn">선택 상품 주문</button>
    </div>

</div>

<!-- ✅ 푸터 -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>