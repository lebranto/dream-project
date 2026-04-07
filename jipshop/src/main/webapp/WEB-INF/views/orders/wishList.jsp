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
.content-wrapper { max-width: 1100px; margin: 0 auto; padding: 40px 20px; }

.mypage-container {
    display:flex;
    gap:40px;
    align-items:flex-start;
    flex-wrap:wrap;
}

.mypage-sidebar {
    width:130px;
    flex-shrink:0;
    position:sticky;
    top:100px;
}

.mypage-content {
    flex:1;
    min-width:600px;
}

input[type="checkbox"] {
    width:20px;
    height:20px;
    cursor:pointer;
}

.mypage-banner {
    background:#fdf5e6;
    padding:20px;
    text-align:center;
    font-size:24px;
    font-weight:bold;
    margin-bottom:50px;
}

.page-title { font-size:28px; margin-bottom:25px; }

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
    min-width:500px;
}

.item-img {
    width:120px;
    margin-right:30px;
}

.item-details { flex:1; }

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

@media (max-width: 900px){

    .mypage-container {
        flex-direction:column;
    }

    .mypage-sidebar {
        width:100%;
        position:relative;
        top:auto;
    }

    .mypage-content {
        width:100%;
        min-width:unset;
    }

    .item-card {
        flex-direction:column;
        align-items:flex-start;
        gap:15px;
    }

    .item-img {
        margin-right:0;
    }

    .item-btns {
        flex-direction:row;
        margin-left:0;
    }
}
</style>
</head>

<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="content-wrapper">
<div class="mypage-container">

<aside class="mypage-sidebar">
    <jsp:include page="/WEB-INF/views/common/myPageSidebar.jsp" />
</aside>

<div class="mypage-content">

<div class="mypage-banner">마이페이지</div>
<h2 class="page-title">찜리스트</h2>

<div class="list-header">
    <div class="header-chk"><input type="checkbox" id="allCheck"></div>
    <div class="header-info">상품/옵션 정보</div>
    <div class="header-qty">수량</div>
</div>

<div id="wishContainer">
<c:choose>
<c:when test="${not empty sessionScope.wishList}">
<c:forEach var="w" items="${sessionScope.wishList}">
<div class="wish-item" data-id="${w.productId}">

    <input type="checkbox" class="item-check">

    <div class="item-card">

        <img src="${pageContext.request.contextPath}${w.productPhoto1}" class="item-img">

        <div class="item-details">
            <div>${w.productName}</div>
            <div>${w.productPrice}원</div>
        </div>

        <div class="quantity-control">
            <span>수량</span>
            <input type="text" value="1" class="qty-input" readonly>

            <div class="qty-btn-stack">
                <button type="button" class="plus">▲</button>
                <button type="button" class="minus">▼</button>
            </div>
        </div>

        <div class="item-btns">
            <button type="button" class="btn-wish cart-btn">장바구니</button>
            <button type="button" class="btn-wish white single-delete">삭제</button>
        </div>

    </div>
</div>
</c:forEach>
</c:when>

<c:otherwise>
<div id="emptyMessage" style="text-align:center; padding:40px;">
    찜한 상품이 없습니다 ❤️
</div>
</c:otherwise>
</c:choose>
</div>

<div class="action-btns">
    <button type="button" class="btn-action delete-selected">선택 삭제</button>
    <button type="button" class="btn-action add-cart-selected">장바구니</button>
</div>

</div>
</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
const contextPath = "${pageContext.request.contextPath}";

// 전체 선택
const allCheck = document.getElementById("allCheck");
if(allCheck){
    allCheck.addEventListener("change", function(){
        document.querySelectorAll(".item-check").forEach(chk => {
            chk.checked = this.checked;
        });
    });
}

// 수량 증가/감소
document.querySelectorAll(".wish-item").forEach(item => {

    const plus = item.querySelector(".plus");
    const minus = item.querySelector(".minus");
    const qtyInput = item.querySelector(".qty-input");

    plus.addEventListener("click", () => {
        qtyInput.value = parseInt(qtyInput.value) + 1;
    });

    minus.addEventListener("click", () => {
        if(parseInt(qtyInput.value) > 1){
            qtyInput.value = parseInt(qtyInput.value) - 1;
        }
    });
});

// 공통 : 찜 비었을 때 메시지
function checkEmptyWish(){
    const remain = document.querySelectorAll(".wish-item");

    if(remain.length === 0){
        document.getElementById("wishContainer").innerHTML = `
            <div id="emptyMessage" style="text-align:center; padding:40px;">
                찜한 상품이 없습니다 ❤️
            </div>
        `;
    }
}

// 개별 삭제
document.querySelectorAll(".single-delete").forEach(btn => {

    btn.addEventListener("click", function(){
    	
    	if(!confirm("선택된 상품을 찜리스트에서 삭제하시겠습니까?")){
            return;
        }

        const row = this.closest(".wish-item");
        const productId = row.dataset.id;

        fetch(contextPath + "/wishList/delete", {
            method:"POST",
            headers:{"Content-Type":"application/x-www-form-urlencoded"},
            body:"productId=" + productId
        })
        .then(res => res.text())
        .then(result => {

            if(result.trim() === "login"){
                alert("로그인 후 이용해주세요");
                location.href = contextPath + "/member/login";
                return;
            }

            row.remove();
            checkEmptyWish();
        });
    });
});

// 선택 삭제
document.querySelector(".delete-selected").addEventListener("click", function(){

    const checked = document.querySelectorAll(".item-check:checked");

    if(checked.length === 0){
        alert("삭제할 상품을 선택해주세요.");
        return;
    }
    
    if(!confirm("선택된 상품을 찜리스트에서 삭제하시겠습니까?")){
        return;
    }

    let ids = [];

    checked.forEach(chk => {
        ids.push(chk.closest(".wish-item").dataset.id);
    });

    fetch(contextPath + "/wishList/deleteAll", {
        method:"POST",
        headers:{"Content-Type":"application/x-www-form-urlencoded"},
        body:"ids=" + ids.join(",")
    })
    .then(res => res.text())
    .then(result => {

        if(result.trim() === "login"){
            alert("로그인 후 이용해주세요");
            location.href = contextPath + "/member/login";
            return;
        }

        checked.forEach(chk => {
            chk.closest(".wish-item").remove();
        });

        checkEmptyWish();
    });
});

// 개별 : 찜 → 장바구니 이동
// cart 추가 성공하면 wish 자동 삭제
document.querySelectorAll(".cart-btn").forEach(btn => {

    btn.addEventListener("click", function(){

        const row = this.closest(".wish-item");

        const productId = row.dataset.id;
        const qty = row.querySelector(".qty-input").value;
        const productName = row.querySelector(".item-details div:nth-child(1)").innerText;
        const productPrice = row.querySelector(".item-details div:nth-child(2)").innerText.replace("원", "").trim();
        const productPhoto = row.querySelector("img").getAttribute("src").replace(contextPath, "");

        fetch(contextPath + "/cartList/addAjax", {
            method:"POST",
            headers:{"Content-Type":"application/x-www-form-urlencoded"},
            body:
                "productId=" + encodeURIComponent(productId) +
                "&productName=" + encodeURIComponent(productName) +
                "&productPrice=" + encodeURIComponent(productPrice) +
                "&productPhoto=" + encodeURIComponent(productPhoto) +
                "&qty=" + encodeURIComponent(qty)
        })
        .then(res => res.text())
        .then(result => {

            if(result.trim() === "login"){
                alert("로그인 후 이용해주세요");
                location.href = contextPath + "/member/login";
                return;
            }

            // 장바구니 추가 성공 후 찜 삭제
            return fetch(contextPath + "/wishList/delete", {
                method:"POST",
                headers:{"Content-Type":"application/x-www-form-urlencoded"},
                body:"productId=" + productId
            });
        })
        .then(res => {
            if(!res) return;
            return res.text();
        })
        .then(() => {

            row.remove();
            checkEmptyWish();

            alert("장바구니로 이동되었습니다 🛒");

            // 헤더 장바구니 숫자 갱신 함수 있으면 실행
            if(typeof updateCartCountUI === "function"){
                fetch(contextPath + "/cartList/count")
                .then(res => res.text())
                .then(count => {
                    updateCartCountUI(parseInt(count));
                });
            }
        });
    });
});

// 선택한 상품들 : 찜 → 장바구니 이동
document.querySelector(".add-cart-selected").addEventListener("click", async function(){

    const checked = document.querySelectorAll(".item-check:checked");

    if(checked.length === 0){
        alert("장바구니로 이동할 상품을 선택해주세요.");
        return;
    }

    for(const chk of checked){

        const row = chk.closest(".wish-item");

        const productId = row.dataset.id;
        const qty = row.querySelector(".qty-input").value;
        const productName = row.querySelector(".item-details div:nth-child(1)").innerText;
        const productPrice = row.querySelector(".item-details div:nth-child(2)").innerText.replace("원", "").trim();
        const productPhoto = row.querySelector("img").getAttribute("src").replace(contextPath, "");

        const cartRes = await fetch(contextPath + "/cartList/addAjax", {
            method:"POST",
            headers:{"Content-Type":"application/x-www-form-urlencoded"},
            body:
                "productId=" + encodeURIComponent(productId) +
                "&productName=" + encodeURIComponent(productName) +
                "&productPrice=" + encodeURIComponent(productPrice) +
                "&productPhoto=" + encodeURIComponent(productPhoto) +
                "&qty=" + encodeURIComponent(qty)
        });

        const cartResult = await cartRes.text();

        if(cartResult.trim() === "login"){
            alert("로그인 후 이용해주세요");
            location.href = contextPath + "/member/login";
            return;
        }

        await fetch(contextPath + "/wishList/delete", {
            method:"POST",
            headers:{"Content-Type":"application/x-www-form-urlencoded"},
            body:"productId=" + productId
        });

        row.remove();
    }

    checkEmptyWish();

    alert("선택한 상품이 장바구니로 이동되었습니다 🛒✨");

    if(typeof updateCartCountUI === "function"){
        fetch(contextPath + "/cartList/count")
        .then(res => res.text())
        .then(count => {
            updateCartCountUI(parseInt(count));
        });
    }
});
</script>

</body>
</html>
