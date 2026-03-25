<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문서작성/결제</title>

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

/* 상단 */
.top-area{
    display:flex;
    justify-content:space-between;
    align-items:flex-end;
    border-bottom:1px solid #ddd;
    padding-bottom:15px;
}

.title{ font-size:24px; font-weight:bold; }
.step{ font-size:13px; color:#bbb; }
.step b{ color:#000; }

/* 테이블 */
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
}

/* 총 금액 */
.total-box{
    margin-top:20px;
    border:1px solid #ddd;
    padding:25px;
    display:flex;
    justify-content:flex-end;
    gap:60px;
}

.total-box div{ text-align:center; }

.price1{ color:#FFD780; font-weight:bold; }
.price2{ color:#FF9B65; font-weight:bold; }

/* 입력 */
.info-title{ margin-top:40px; font-weight:bold; }

.info-table{
    width:100%;
    margin-top:10px;
    border-top:1px solid #ddd;
}

.info-table td{
    padding:10px;
    border-bottom:1px solid #eee;
}

.info-table input, select{
    padding:8px;
    width:200px;
}

.info-table td:first-child{
    white-space: nowrap;
    width:120px;
}

/* ⭐ 라벨 정렬 + 필수 표시 */
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


</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>

<body>

<jsp:include page="/WEB-INF/views/common/header2.jsp" />

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

<tr>
    <td>
        <div class="product">
            <img src="https://placehold.co/80x80" />
            관절 건강 강아지 사료 1kg
        </div>
    </td>
    <td>1개</td>
    <td>19,900원</td>
    <td>무료배송</td>
</tr>
</table>

<div style="margin-top:10px; color:#555;">&lt; 장바구니 가기</div>

<!-- 총 금액 -->
<div class="total-box">
    <div>총 1개의 상품금액<br><span class="price1">19,900원</span></div>
    <div>배송비<br>0원</div>
    <div>합계<br><span class="price2">19,900원</span></div>
</div>

<!-- 주문자 정보 -->
<div class="info-title">주문자 정보</div>

<table class="info-table">
<tr>
    <td><span class="label required">주문하시는 분</span></td>
    <td><input type="text" id="orderName"></td>
</tr>
<tr>
    <td><span class="label">전화번호</span></td>
    <td><input type="text"></td>
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
            <option value="">직접입력</option>
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
<td><span class="label">배송지 확인</span></td>
<td>
<input type="radio" name="addr" checked>기본 배송지
<input type="radio" name="addr">최근 배송지
<input type="radio" name="addr">직접 입력
<select>
<option>배송지 관리</option>
</select>
</td>
</tr>

<tr>
<td><span class="label required">받으실 분</span></td>
<td><input type="text" id="receiver"></td>
</tr>

<tr>
<td><span class="label required">받으실 곳</span></td>
<td>
<input type="text" id="address" placeholder="주소">
<button type="button" onclick="execDaumPostcode()">우편번호 검색</button><br><br>
<input type="text" id="detailAddress" placeholder="상세주소">
</td>
</tr>

<tr>
<td><span class="label">전화번호</span></td>
<td><input type="text"></td>
</tr>

<tr>
<td><span class="label required">핸드폰 번호</span></td>
<td><input type="text" id="receiverPhone"></td>
</tr>

<tr>
<td><span class="label">구매자 메모</span></td>
<td><input type="text" style="width:400px;"></td>
</tr>
</table>

<!-- 결제수단 -->
<h4 style="margin-top:40px;">결제수단 선택 / 결제</h4>

<div style="padding:20px 10px; border-top:1px solid #ddd; border-bottom:1px solid #ddd;">
    <label><input type="radio" name="pay" checked> 무통장 입금</label>
    <label style="margin-left:20px;"><input type="radio" name="pay"> 신용카드</label>
    <label style="margin-left:20px;"><input type="radio" name="pay"> 휴대폰결제</label>

    <div style="margin-top:15px; color:#888; font-size:13px;">
        (무통장 입금의 경우 입금 확인 후부터 배송단계가 진행됩니다.)
    </div>

    <div style="margin-top:15px;">
        입금자명 <input type="text" id="depositor" style="width:200px; height:35px;">
    </div>

    <div style="margin-top:10px;">
        입금은행 
        <select id="bank">
            <option value="">선택하세요</option>
            <option>국민은행 05499012421*** 집사상점</option>
            <option>우리은행 69024653318*** 집사상점</option>
        </select>
    </div>
</div>

<!-- 결제정보 -->
<h4 style="margin-top:40px;">결제정보</h4>

<table class="info-table">
<tr>
    <td>상품 합계 금액</td>
    <td>19,900원</td>
</tr>
<tr>
    <td>배송비</td>
    <td>0원</td>
</tr>
<tr>
    <td><b>최종 결제 금액</b></td>
    <td><b>19,900원</b></td>
</tr>
</table>

<!-- 동의 -->
<div style="margin-top:20px; text-align:center;">
<label>
<input type="checkbox" id="agree">
<span style="color:red;">(필수)</span> 구매하실 상품의 결제정보를 확인하였으며, 구매진행에 동의합니다.
</label>
</div>

<!-- 버튼 -->
<div style="text-align:center; margin-top:20px;">
<button id="payBtn" style="width:200px;height:50px;font-size:18px;background:#eee;border:1px solid #ccc;border-radius:5px;">
결제하기
</button>
</div>

</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById("address").value = data.roadAddress || data.jibunAddress;
            document.getElementById("detailAddress").focus();
        }
    }).open();
}

// ✅ 필수 체크
document.getElementById("payBtn").addEventListener("click", function(){

    const required = [
        "orderName","orderPhone","email1",
        "receiver","address","detailAddress","receiverPhone",
        "depositor"
    ];

    for(let id of required){
        let el = document.getElementById(id);
        if(!el.value.trim()){
            alert("필수 입력사항 확인해주세요");
            el.focus();
            return;
        }
    }

    if(document.getElementById("email2").value === ""){
        alert("필수 입력사항 확인해주세요");
        return;
    }

    if(document.getElementById("bank").value === ""){
        alert("필수 입력사항 확인해주세요");
        return;
    }

    if(!document.getElementById("agree").checked){
        alert("필수 입력사항 확인해주세요");
        return;
    }

    alert("결제 진행합니다");
});
</script>

</body>
</html>