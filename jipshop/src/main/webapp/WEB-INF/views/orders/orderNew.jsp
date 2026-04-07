<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>주문서작성/결제</title>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<style>
body{
    margin:0;
    font-family:'맑은 고딕', sans-serif;
    background:#f5f5f5;
}

.container{
    width:1100px;
    margin:0 auto;
    background:#fff;
    padding:30px;
}

.top-area{
    display:flex;
    justify-content:space-between;
    align-items:flex-end;
    border-bottom:1px solid #ddd;
    padding-bottom:15px;
}

.title{
    font-size:24px;
    font-weight:bold;
}

.step{
    font-size:13px;
    color:#bbb;
}

.step b{
    color:#000;
}

.order-table{
    width:100%;
    border-collapse:collapse;
    margin-top:20px;
}

.order-table th{
    background:#F7F7F7;
    padding:15px;
    font-size:14px;
}

.order-table td{
    padding:20px 10px;
    text-align:center;
    border-bottom:1px solid #eee;
    vertical-align:middle;
}

.product{
    display:flex;
    align-items:center;
    gap:15px;
    text-align:left;
}

.product img{
    width:80px;
    height:80px;
    object-fit:cover;
    border:1px solid #eee;
}

.qty-input{
    width:70px !important;
    text-align:center;
}

.total-box{
    margin-top:20px;
    border:1px solid #ddd;
    padding:25px;
    display:flex;
    justify-content:flex-end;
    gap:60px;
}

.total-box div{
    text-align:center;
}

.price1{
    color:#FFD780;
    font-weight:bold;
}

.price2{
    color:#FF9B65;
    font-weight:bold;
}

.info-title{
    margin-top:40px;
    font-weight:bold;
}

.info-table{
    width:100%;
    margin-top:10px;
    border-top:1px solid #ddd;
    border-collapse:collapse;
}

.info-table td{
    padding:10px;
    border-bottom:1px solid #eee;
}

.info-table input,
.info-table select{
    padding:8px;
    width:200px;
}

.info-table td:first-child{
    white-space:nowrap;
    width:140px;
    background:#fafafa;
}

.label{
    display:inline-block;
    padding-left:12px;
    position:relative;
}

.label.required::before{
    content:"*";
    position:absolute;
    left:0;
    color:#FF9B65;
    font-weight:bold;
}

.addr-input{
    width:320px !important;
    margin-bottom:8px;
}

.memo-input{
    width:400px !important;
}

.pay-box{
    padding:20px 10px;
    border-top:1px solid #ddd;
    border-bottom:1px solid #ddd;
}

.pay-box label{
    margin-right:20px;
}

.btn-area{
    text-align:center;
    margin-top:20px;
}

.pay-btn{
    width:200px;
    height:50px;
    font-size:18px;
    background:#eee;
    border:1px solid #ccc;
    border-radius:5px;
    cursor:pointer;
}

.go-cart{
    margin-top:10px;
    color:#555;
}

.go-cart a{
    color:#555;
    text-decoration:none;
}

.empty-row{
    padding:40px 0;
    color:#777;
}

.summary-price{
    font-weight:bold;
}

.hidden-area{
    display:none;
}
</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="${contextPath}/resources/css/common/main3.css">
</head>

<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container">

    <div class="top-area">
        <div class="title">주문서작성/결제</div>
        <div class="step">
            01 장바구니 &gt; <b>02 주문서작성/결제</b> &gt; 03 주문완료
        </div>
    </div>

    <form id="orderForm" action="${contextPath}/orders/orderNew" method="post">

        <!-- ORDERS용 hidden -->
        <input type="hidden" name="memberNo" value="${memberNo}">
        <input type="hidden" name="orderTotalPrice" id="orderTotalPrice" value="${totalPrice}">
        <input type="hidden" name="orderDeliveryFee" id="orderDeliveryFee" value="${totalDelivery}">
        <input type="hidden" name="ordererEmail" id="ordererEmail">
        <input type="hidden" name="payMethod" id="payMethod" value="무통장입금">
		<input type="hidden" name="qty" value="${qty}">
		
        <h4>주문상세내역</h4>

        <table class="order-table">
            <tr>
                <th>상품/옵션 정보</th>
                <th>수량</th>
                <th>상품금액</th>
                <th>배송비</th>
            </tr>

            <c:choose>
                <c:when test="${not empty productList}">
    <c:forEach var="p" items="${productList}" varStatus="st">
	    <tr>
	        <td>
	            <div class="product">
	                <img src="${contextPath}${p.productPhoto1}" alt="${p.productName}">
	                <div>${p.productName}</div>
	            </div>
	        </td>
	        <td>
	            <input type="number"
	                   class="qty-input"
	                   id="qty_${st.index}"
	                   value="${p.cartQty}"
	                   min="1"
	                   data-index="${st.index}"
	                   data-unit-price="${p.productPrice}"
	                   onchange="changeQty(${st.index})">
	        </td>
	        <td>
	            <span class="row-price" id="rowPrice_${st.index}">
	                <fmt:formatNumber value="${p.productPrice}" pattern="#,###"/>
	            </span>원
	        </td>
	        <td>0원</td>
	    </tr>
	    <tr class="hidden-area">
	        <td colspan="4">
	            <input type="hidden" name="detailList[${st.index}].productId"   value="${p.productId}">
	            <input type="hidden" name="detailList[${st.index}].detailQty"   id="hiddenQty_${st.index}"   value="${p.cartQty}">
	            <input type="hidden" name="detailList[${st.index}].detailPrice" id="hiddenPrice_${st.index}" value="${p.productPrice}">
	        </td>
	    </tr>
	</c:forEach>
</c:when>
<c:otherwise>
    <tr>
        <td colspan="4" class="empty-row">주문할 상품이 없습니다.</td>
    </tr>
</c:otherwise>
            </c:choose>
        </table>

        <div class="go-cart">
            <a href="${contextPath}/orders/cartList">&lt; 장바구니 가기</a>
        </div>

        <div class="total-box">
            <div>
                총 <span id="totalCount">${totalCount}</span>개의 상품금액<br>
                <span class="price1" id="displayTotalPrice">
                    <fmt:formatNumber value="${totalPrice}" pattern="#,###" />
                </span>원
            </div>
            <div>
                배송비<br>
                <span id="displayDeliveryFee">
                    <fmt:formatNumber value="${totalDelivery}" pattern="#,###" />
                </span>원
            </div>
            <div>
                합계<br>
                <span class="price2" id="displayFinalPrice">
                    <fmt:formatNumber value="${finalPrice}" pattern="#,###" />
                </span>원
            </div>
        </div>

        <div class="info-title">주문자 정보</div>

        <table class="info-table">
            <tr>
                <td><span class="label required">주문하시는 분</span></td>
                <td>
                    <input type="text" id="ordererName" name="ordererName" value="${memberName}">
                </td>
            </tr>
            <tr>
                <td><span class="label">전화번호</span></td>
                <td>
                    <input type="text" name="ordererTel" value="02-0000-0000">
                </td>
            </tr>
            <tr>
                <td><span class="label required">핸드폰 번호</span></td>
                <td>
                    <input type="text" id="ordererPhone" name="ordererPhone" value="${phone}">
                </td>
            </tr>
            <tr>
                <td><span class="label required">이메일</span></td>
                <td>
                    <c:set var="emailArr" value="${fn:split(email, '@')}" />
                    <input type="text" id="email1" value="${emailArr[0]}">
                    <select id="email2">
                        <option value="">직접입력</option>
                        <option value="naver.com" <c:if test="${emailArr[1] eq 'naver.com'}">selected</c:if>>naver.com</option>
                        <option value="gmail.com" <c:if test="${emailArr[1] eq 'gmail.com'}">selected</c:if>>gmail.com</option>
                        <option value="daum.net" <c:if test="${emailArr[1] eq 'daum.net'}">selected</c:if>>daum.net</option>
                    </select>
                </td>
            </tr>
        </table>

        <h4 style="margin-top:40px;">배송정보</h4>

        <table class="info-table">
           <tr style="display:none;">
                <td><span class="label">배송지 확인</span></td>
                <td>
                    <input type="radio" name="addrType" id="addrDefault" checked> 기본 배송지
                    <input type="radio" name="addrType" id="addrDirect"> 직접 입력
                </td>
            </tr>
 
            <tr>
                <td><span class="label required">받으실 분</span></td>
                <td>
                    <input type="text" id="recvName" name="recvName" value="${memberName}">
                </td>
            </tr>

            <tr>
                <td><span class="label required">받으실 곳</span></td>
                <td>
                    <input type="text" id="recvAddress" class="addr-input" placeholder="주소">
                    <button type="button" onclick="execDaumPostcode()">우편번호 검색</button>
                    <br>
                    <input type="text" id="detailAddress" class="addr-input" placeholder="상세주소">
                    <input type="hidden" id="finalRecvAddress" name="recvAddress">
                </td>
            </tr>

            <tr>
                <td><span class="label">전화번호</span></td>
                <td>
                    <input type="text" name="recvTel">
                </td>
            </tr>

            <tr>
                <td><span class="label required">핸드폰 번호</span></td>
                <td>
                    <input type="text" id="recvPhone" name="recvPhone" value="${phone}">
                </td>
            </tr>

            <tr>
                <td><span class="label">구매자 메모</span></td>
                <td>
                    <input type="text" name="orderMemo" class="memo-input" placeholder="친절한 말 부탁드립니다.">
                </td>
            </tr>
        </table>

        <h4 style="margin-top:40px;">결제수단 선택 / 결제</h4>

        <div class="pay-box">
         <!--   <label><input type="radio" name="payRadio" value="무통장입금" checked> 무통장 입금</label>
            <label><input type="radio" name="payRadio" value="신용카드"> 신용카드</label>
            <label><input type="radio" name="payRadio" value="휴대폰결제"> 휴대폰결제</label> -->

            <div style="margin-top:15px; color:#888; font-size:13px;">
                (무통장 입금의 경우 입금 확인 후부터 배송단계가 진행됩니다.)
            </div>

            <div style="margin-top:15px;">
                입금자명
                <input type="text" id="depositor" name="depositor" style="width:200px; height:35px;">
            </div>

            <div style="margin-top:10px;">
                입금은행
                <select id="bank" name="bank">
                    <option value="">선택하세요</option>
                    <option value="국민은행">국민은행 05499012421*** 집사상점</option>
                    <option value="우리은행">우리은행 69024653318*** 집사상점</option>
                </select>
            </div>
        </div>

        <h4 style="margin-top:40px;">결제정보</h4>

        <table class="info-table">
            <tr>
                <td>상품 합계 금액</td>
                <td>
                    <span class="summary-price" id="summaryProductPrice">
                        <fmt:formatNumber value="${totalPrice}" pattern="#,###" />
                    </span>원
                </td>
            </tr>
            <tr>
                <td>배송비</td>
                <td>
                    <span id="summaryDeliveryFee">
                        <fmt:formatNumber value="${totalDelivery}" pattern="#,###" />
                    </span>원
                </td>
            </tr>
            <tr>
                <td><b>최종 결제 금액</b></td>
                <td>
                    <b>
                        <span id="summaryFinalPrice">
                            <fmt:formatNumber value="${finalPrice}" pattern="#,###" />
                        </span>원
                    </b>
                </td>
            </tr>
        </table>

        <div style="margin-top:20px; text-align:center;">
            <label>
                <input type="checkbox" id="agree">
                <span style="color:red;">(필수)</span>
                구매하실 상품의 결제정보를 확인하였으며, 구매진행에 동의합니다.
            </label>
        </div>

        <div class="btn-area">
            <button type="button" id="payBtn" class="pay-btn">결제하기</button>
        </div>

    </form>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById("recvAddress").value = data.roadAddress || data.jibunAddress;
            document.getElementById("detailAddress").focus();
        }
    }).open();
}

document.getElementById("addrDefault").addEventListener("change", function(){
    if(this.checked){
        document.getElementById("recvName").value = "${loginUser.memberName}";
        document.getElementById("recvAddress").value = "${loginUser.address}";
        document.getElementById("recvPhone").value = "${loginUser.phone}";
        document.getElementById("detailAddress").value = "";
    }
});

document.getElementById("addrDirect").addEventListener("change", function(){
    if(this.checked){
        document.getElementById("recvName").value = "";
        document.getElementById("recvAddress").value = "";
        document.getElementById("recvPhone").value = "";
        document.getElementById("detailAddress").value = "";
    }
});

function changeQty(index){
    const qtyInput = document.getElementById("qty_" + index);
    let qty = parseInt(qtyInput.value, 10);

    if (isNaN(qty) || qty < 1) {
        qty = 1;
        qtyInput.value = 1;
    }

    const unitPrice = parseInt(qtyInput.dataset.unitPrice, 10);
    const rowTotal = qty * unitPrice;

    document.getElementById("rowPrice_" + index).innerText = rowTotal.toLocaleString();
    document.getElementById("hiddenQty_" + index).value = qty;
    document.getElementById("hiddenPrice_" + index).value = rowTotal;

    updateTotalPrice();
}

function updateTotalPrice(){
    let totalProductPrice = 0;
    let totalCount = 0;

    document.querySelectorAll(".qty-input").forEach(function(input){
        const qty = parseInt(input.value, 10);
        const unitPrice = parseInt(input.dataset.unitPrice, 10);

        if (!isNaN(qty) && !isNaN(unitPrice)) {
            totalProductPrice += qty * unitPrice;
            totalCount += qty;
        }
    });

    let deliveryFee = 0;
    if (totalProductPrice > 0 && totalProductPrice < 30000) {
        deliveryFee = 3000;
    }

    const finalPrice = totalProductPrice + deliveryFee;

    document.getElementById("totalCount").innerText = totalCount;
    document.getElementById("displayTotalPrice").innerText = totalProductPrice.toLocaleString();
    document.getElementById("displayDeliveryFee").innerText = deliveryFee.toLocaleString();
    document.getElementById("displayFinalPrice").innerText = finalPrice.toLocaleString();

    document.getElementById("summaryProductPrice").innerText = totalProductPrice.toLocaleString();
    document.getElementById("summaryDeliveryFee").innerText = deliveryFee.toLocaleString();
    document.getElementById("summaryFinalPrice").innerText = finalPrice.toLocaleString();

    document.getElementById("orderTotalPrice").value = totalProductPrice;
    document.getElementById("orderDeliveryFee").value = deliveryFee;
}

window.onload = function(){
    updateTotalPrice();
};

document.getElementById("payBtn").addEventListener("click", function(){

    const required = [
        "ordererName",
        "ordererPhone",
        "email1",
        "recvName",
        "recvAddress",
        "detailAddress",
        "recvPhone",
        "depositor"
    ];

    for(let id of required){
        let el = document.getElementById(id);
        if(!el.value.trim()){
            alert("필수 입력사항을 확인해주세요.");
            el.focus();
            return;
        }
    }

    if(document.getElementById("email2").value === ""){
        alert("이메일 도메인을 선택해주세요.");
        document.getElementById("email2").focus();
        return;
    }

    if(document.getElementById("bank").value === ""){
        alert("입금은행을 선택해주세요.");
        document.getElementById("bank").focus();
        return;
    }

    if(!document.getElementById("agree").checked){
        alert("구매 진행 동의가 필요합니다.");
        return;
    }

    let email = document.getElementById("email1").value.trim() + "@" + document.getElementById("email2").value;
    document.getElementById("ordererEmail").value = email;

    let baseAddr = document.getElementById("recvAddress").value.trim();
    let detailAddr = document.getElementById("detailAddress").value.trim();
    document.getElementById("finalRecvAddress").value = baseAddr + " " + detailAddr;

    let checkedPay = document.querySelector("input[name='payRadio']:checked");

    if(checkedPay){
        document.getElementById("payMethod").value = checkedPay.value;
    } else {
        // 라디오 없을 때 기본값 유지
        document.getElementById("payMethod").value = "무통장입금";
    }

    document.getElementById("orderForm").submit();
});

window.onload = function(){
    updateTotalPrice();
};

</script>

</body>
</html>