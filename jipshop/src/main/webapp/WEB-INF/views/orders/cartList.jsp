<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>집사상점 - 장바구니</title>

<style>
* { box-sizing:border-box; margin:0; padding:0; font-family:'Pretendard', sans-serif; }
body { background:#f5f5f5; }

.cart-container { max-width:1100px; margin:0 auto; background:#fff; padding:30px; }

.cart-header {
    display:flex; justify-content:space-between; align-items:flex-end;
    border-bottom:2px solid #000; padding-bottom:15px; margin-bottom:30px;
}

.cart-header h1 { font-size:24px; }

.table-wrapper { overflow-x:auto; border-bottom:1px solid #ddd; }

.cart-table {
    width:100%; min-width:800px;
    border-collapse:collapse; white-space:nowrap;
}

.cart-table th {
    background:#f9f9f9; padding:15px;
    border-top:1px solid #ddd; border-bottom:1px solid #ddd;
    font-size:14px;
}

.cart-table td {
    padding:20px 10px;
    border-bottom:1px solid #eee;
    text-align:center;
}

.product-info {
    display:flex; align-items:center; gap:15px;
    text-align:left; min-width:300px;
}

.product-info img {
    width:80px; height:80px;
    object-fit:cover; border-radius:4px;
}

.price { font-weight:bold; }

.qty-box {
    display:flex;
    align-items:center;
    justify-content:center;
    gap:8px;
}

.qty-btn {
    width:25px;
    height:25px;
    border:1px solid #ccc;
    background:#fff;
    cursor:pointer;
}

.qty {
    min-width:20px;
    text-align:center;
}

.total-summary {
    display:flex; justify-content:flex-end; align-items:center;
    border:1px solid #eee; padding:30px;
    margin:20px 0; gap:40px; min-width:800px;
}

.summary-item span {
    display:block; margin-bottom:10px;
    font-size:15px;
}

.summary-item strong { font-size:20px; }

.highlight1 { color:#ffb84d; }
.highlight2 { color:#FF9B65; }

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

.cart-table input[type="checkbox"]{
    transform: scale(1.5);
    cursor: pointer;
    accent-color: #666;
}
</style>
</head>

<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="cart-container">

<header class="cart-header">
    <h1>장바구니</h1>
</header>

<div class="table-wrapper">
<table class="cart-table">
<thead>
<tr>
    <!-- ✅ 수정 -->
    <th><input type="checkbox" id="allCheck"></th>
    <th>상품/옵션 정보</th>
    <th>수량</th>
    <th>상품금액</th>
    <th>배송비</th>
    <th>삭제</th>
</tr>
</thead>

<tbody>

<c:if test="${empty cartList}">
<tr>
    <td colspan="6" style="text-align:center; padding:40px;">
        장바구니가 비어 있습니다 🛒
    </td>
</tr>
</c:if>

<c:forEach var="c" items="${cartList}">
<tr data-id="${c.cartId}">
    <td><input type="checkbox" class="itemCheck"></td>

    <td class="product-info">
        <img src="${pageContext.request.contextPath}${c.productPhoto1}" />
        <span>${c.productName}</span>
    </td>

    <td>
        <div class="qty-box">
            <button class="qty-btn minus">-</button>
            <span class="qty">${c.cartQty}</span>
            <button class="qty-btn plus">+</button>
        </div>
    </td>

    <td class="price" data-price="${c.productPrice}">
    ${c.productPrice * c.cartQty}원
</td>

    <td>무료배송</td>

    <td>
        <a href="${pageContext.request.contextPath}/cartList/delete?cartId=${c.cartId}">
            삭제
        </a>
    </td>
</tr>
</c:forEach>

</tbody>
</table>
</div>

<div class="total-summary">
    <div class="summary-item">
        <span id="totalCount">총 0개의 상품금액</span>
        <strong id="totalPrice" class="highlight1">0원</strong>
    </div>
    <div class="summary-item">
        <span>배송비</span>
        <strong>0원</strong>
    </div>
    <div class="summary-item total">
        <span>합계</span>
        <strong id="finalPrice" class="highlight2">0원</strong>
    </div>
</div>

<div class="cart-actions">
    <button class="delete-btn">선택 상품 삭제</button>
</div>

</div>

<script>
const contextPath = "${pageContext.request.contextPath}";

// 전체 선택
document.getElementById("allCheck").addEventListener("change", function(){
    document.querySelectorAll(".itemCheck")
    .forEach(chk => chk.checked = this.checked);
    updateTotal();
});

// 금액 계산
function updateTotal() {
    let total = 0;
    let count = 0;

    document.querySelectorAll("tbody tr").forEach(row => {
        const chk = row.querySelector(".itemCheck");
        const priceEl = row.querySelector(".price");

        if (!priceEl || !chk) return;

        // ⭐ 체크된 것만 계산
        if (chk.checked) {
            const price = parseInt(priceEl.innerText.replace(/[^0-9]/g, ""));
            total += price;
            count++;
        }
    });

    document.getElementById("totalPrice").innerText = total.toLocaleString()+"원";
    document.getElementById("finalPrice").innerText = total.toLocaleString()+"원";
    document.getElementById("totalCount").innerText = `총 ${count}개의 상품금액`;
}

document.addEventListener("change", function(e){
    if(e.target.classList.contains("itemCheck")){
        updateTotal();
    }
});

// 수량 변경 (정상 동작)
document.addEventListener("click", function(e){

    if(e.target.classList.contains("qty-btn")){
        const row = e.target.closest("tr");
        const qtyEl = row.querySelector(".qty");
        const priceEl = row.querySelector(".price");

        let qty = parseInt(qtyEl.innerText);

        // ⭐ 여기 핵심 (단가 가져오기)
        const unitPrice = parseInt(priceEl.dataset.price);

        if(e.target.classList.contains("plus")) qty++;
        else if(qty > 1) qty--;

        qtyEl.innerText = qty;

        // ⭐ 총금액 재계산
        priceEl.innerText = (unitPrice * qty).toLocaleString()+"원";

        const cartId = row.dataset.id;

        fetch(contextPath + "/cartList/updateQty", {
            method:"POST",
            headers:{"Content-Type":"application/x-www-form-urlencoded"},
            body:`cartId=${cartId}&qty=${qty}`
        });

        updateTotal();
    }
});


// ✅ 선택 삭제 (완전 수정)
document.querySelector(".delete-btn").addEventListener("click", function(){

    const checked = document.querySelectorAll(".itemCheck:checked");

    if(checked.length === 0){
        alert("삭제할 상품을 선택하세요");
        return;
    }

    if(!confirm("선택한 상품을 삭제하시겠습니까?")){
        return;
    }

    let ids = [];

    checked.forEach(chk => {
        const row = chk.closest("tr");
        const cartId = row.dataset.id;

        if(cartId){
            ids.push(cartId);
        }
    });

    // ⭐ 여기 중요 (빈값 방지)
    if(ids.length === 0){
        alert("삭제할 상품이 없습니다.");
        return;
    }

    location.href = contextPath + "/cartList/deleteAll?ids=" + ids.join(",");
});

updateTotal();
</script>

</body>
</html>