<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문서작성/결제</title>

<style>
/* 👉 기존 UI 100% 유지 */
body{ margin:0; font-family:'맑은 고딕', sans-serif; background:#f5f5f5; }
.container{ width:1100px; margin:0 auto; background:#fff; padding:30px; }

.top-area{
    display:flex; justify-content:space-between; align-items:flex-end;
    border-bottom:1px solid #ddd; padding-bottom:15px;
}
.title{ font-size:24px; font-weight:bold; }
.step{ font-size:13px; color:#bbb; }
.step b{ color:#000; }

.order-table{ width:100%; border-collapse:collapse; margin-top:20px; }
.order-table th{ background:#F7F7F7; padding:15px; font-size:14px; }
.order-table td{ padding:20px 10px; text-align:center; border-bottom:1px solid #eee; }

.product{ display:flex; align-items:center; gap:15px; text-align:left; }
.product img{ width:80px; height:80px; object-fit:cover; }

.total-box{
    margin-top:20px; border:1px solid #ddd; padding:25px;
    display:flex; justify-content:flex-end; gap:60px;
}
.total-box div{ text-align:center; }

.price1{ color:#FFD780; font-weight:bold; }
.price2{ color:#FF9B65; font-weight:bold; }

.info-title{ margin-top:40px; font-weight:bold; }

.info-table{ width:100%; margin-top:10px; border-top:1px solid #ddd; }
.info-table td{ padding:10px; border-bottom:1px solid #eee; }
.info-table input, select{ padding:8px; width:200px; }

.info-table td:first-child{ white-space: nowrap; width:120px; }

.label{ display:inline-block; padding-left:12px; position:relative; }
.label.required::before{
    content:"*"; position:absolute; left:0; color:#FF9B65; font-weight:bold;
}
</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>

<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container">

<!-- 상단 -->
<div class="top-area">
    <div class="title">주문서작성/결제</div>
    <div class="step">
        01 장바구니 > <b>02 주문서작성/결제</b> > 03 주문완료
    </div>
</div>

<!-- 주문상품 -->
<h4>주문상세내역</h4>

<table class="order-table">
<tr>
    <th>상품/옵션 정보</th>
    <th>수량</th>
    <th>상품금액</th>
    <th>배송비</th>
</tr>

<c:forEach var="o" items="${orderList}">
<tr class="order-row" data-price="${o.productPrice}" data-qty="${o.cartQty}">
    <td>
        <div class="product">
            <img src="${pageContext.request.contextPath}${o.productPhoto1}" />
            ${o.productName}
        </div>
    </td>
    <td>${o.cartQty}개</td>
    <td class="row-price">${o.productPrice * o.cartQty}원</td>
    <td>무료배송</td>
</tr>
</c:forEach>

<c:if test="${empty orderList}">
<tr>
    <td colspan="4">주문 상품이 없습니다</td>
</tr>
</c:if>

</table>

<div style="margin-top:10px; color:#555;" onclick="history.back()">&lt; 장바구니 가기</div>

<!-- 총 금액 -->
<div class="total-box">
    <div>총 <span id="totalCount">0</span>개의 상품금액<br>
        <span id="totalPrice" class="price1">0원</span>
    </div>
    <div>배송비<br>0원</div>
    <div>합계<br>
        <span id="finalPrice" class="price2">0원</span>
    </div>
</div>

<!-- 주문자 정보 -->
<div class="info-title">주문자 정보</div>

<table class="info-table">
<tr>
    <td><span class="label required">주문하시는 분</span></td>
    <td><input type="text" id="orderName"></td>
</tr>
<tr>
    <td><span class="label required">핸드폰 번호</span></td>
    <td><input type="text" id="orderPhone"></td>
</tr>
<tr>
    <td><span class="label required">이메일</span></td>
    <td>
        <input type="text" id="email1">
        <select id="email2">
            <option value="">선택</option>
            <option>naver.com</option>
            <option>gmail.com</option>
        </select>
    </td>
</tr>
</table>

<!-- 배송정보 -->
<h4 style="margin-top:40px;">배송정보</h4>

<table class="info-table">
<tr>
<td><span class="label required">받으실 분</span></td>
<td><input type="text" id="receiver"></td>
</tr>

<tr>
<td><span class="label required">주소</span></td>
<td>
<input type="text" id="address" placeholder="주소">
<button type="button" onclick="execDaumPostcode()">검색</button><br><br>
<input type="text" id="detailAddress" placeholder="상세주소">
</td>
</tr>

<tr>
<td><span class="label required">핸드폰</span></td>
<td><input type="text" id="receiverPhone"></td>
</tr>
</table>

<!-- 결제 -->
<h4 style="margin-top:40px;">결제</h4>

<div style="padding:20px; border:1px solid #ddd;">
    입금자명 <input type="text" id="depositor">
    <br><br>
    은행
    <select id="bank">
        <option value="">선택</option>
        <option>국민은행</option>
        <option>우리은행</option>
    </select>
</div>

<!-- 동의 -->
<div style="margin-top:20px; text-align:center;">
<label>
<input type="checkbox" id="agree"> 결제 동의
</label>
</div>

<!-- 버튼 -->
<div style="text-align:center; margin-top:20px;">
<button id="payBtn" style="width:200px;height:50px;">결제하기</button>
</div>

</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
// 주소 API
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById("address").value = data.roadAddress || data.jibunAddress;
        }
    }).open();
}

// ✅ 총 금액 계산 (핵심)
function calcTotal(){
    let total = 0;
    let count = 0;

    document.querySelectorAll(".order-row").forEach(row => {
        const price = parseInt(row.dataset.price);
        const qty = parseInt(row.dataset.qty);

        total += price * qty;
        count++;
    });

    document.getElementById("totalCount").innerText = count;
    document.getElementById("totalPrice").innerText = total.toLocaleString()+"원";
    document.getElementById("finalPrice").innerText = total.toLocaleString()+"원";
}

calcTotal();

// ✅ 결제 버튼
document.getElementById("payBtn").addEventListener("click", function(){

    const required = [
        "orderName","orderPhone","email1",
        "receiver","address","detailAddress","receiverPhone",
        "depositor"
    ];

    for(let id of required){
        if(!document.getElementById(id).value.trim()){
            alert("필수 입력하세요");
            return;
        }
    }

    if(document.getElementById("email2").value === ""){
        alert("이메일 선택하세요");
        return;
    }

    if(document.getElementById("bank").value === ""){
        alert("은행 선택하세요");
        return;
    }

    if(!document.getElementById("agree").checked){
        alert("동의 필요");
        return;
    }

    alert("결제 진행");
});
</script>

</body>
</html>