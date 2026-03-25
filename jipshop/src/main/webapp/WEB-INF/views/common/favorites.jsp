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
/* ===== 기존 UI 그대로 ===== */
.content-wrapper { max-width: 1100px; margin: 0 auto; padding: 40px 20px; }
.mypage-container { display:flex; gap:40px; align-items:flex-start; }

.mypage-sidebar {
    width:220px; flex-shrink:0;
    position: sticky; top:100px;
}

.mypage-content { flex:1; }

input[type="checkbox"] {
    width:20px; height:20px; cursor:pointer;
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
}

.item-img { width:120px; margin-right:30px; }
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
    <!-- ✅ id 추가 -->
    <div class="header-chk"><input type="checkbox" id="allCheck"></div>
    <div class="header-info">상품/옵션 정보</div>
    <div class="header-qty">수량</div>
</div>

<!-- 리스트 -->
<c:forEach begin="1" end="5">
<div class="wish-item">
    <input type="checkbox" class="item-check">

    <div class="item-card">
        <img src="${pageContext.request.contextPath}/resources/images/강아지.png" class="item-img">

        <div class="item-details">
            <div>상품명</div>
            <div>가격</div>
        </div>

        <div class="quantity-control">
            <span>수량</span>
            <input type="text" value="1" class="qty-input">

            <div class="qty-btn-stack">
                <button type="button" class="plus">▲</button>
                <button type="button" class="minus">▼</button>
            </div>
        </div>

        <div class="item-btns">
            <button class="btn-wish cart-btn">장바구니</button>
            <button class="btn-wish white single-delete">삭제</button>
        </div>
    </div>
</div>
</c:forEach>

<!-- 하단 버튼 -->
<div class="action-btns">
    <button class="btn-action delete-selected">선택 삭제</button>
    <button class="btn-action add-cart-selected">장바구니</button>
</div>

</div>
</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<!-- ================= JS ================= -->
<script>
// ✅ 전체 선택
const allCheck = document.getElementById("allCheck");
const itemChecks = document.querySelectorAll(".item-check");

allCheck.addEventListener("change", () => {
    itemChecks.forEach(chk => chk.checked = allCheck.checked);
});

itemChecks.forEach(chk => {
    chk.addEventListener("change", () => {
        const total = itemChecks.length;
        const checked = document.querySelectorAll(".item-check:checked").length;
        allCheck.checked = (total === checked);
    });
});

// ✅ 수량 버튼
document.querySelectorAll(".wish-item").forEach(item => {
    const plus = item.querySelector(".plus");
    const minus = item.querySelector(".minus");
    const input = item.querySelector(".qty-input");

    plus.addEventListener("click", () => {
        input.value = parseInt(input.value) + 1;
    });

    minus.addEventListener("click", () => {
        let val = parseInt(input.value);
        if(val > 1) input.value = val - 1;
    });
});

// ✅ 선택 삭제
document.querySelector(".delete-selected").addEventListener("click", () => {
    document.querySelectorAll(".wish-item").forEach(item => {
        if(item.querySelector(".item-check").checked){
            item.remove();
        }
    });
});

// ✅ 개별 삭제
document.querySelectorAll(".single-delete").forEach(btn => {
    btn.addEventListener("click", () => {
        btn.closest(".wish-item").remove();
    });
});

// ✅ 장바구니 (개별)
document.querySelectorAll(".cart-btn").forEach(btn => {
    btn.addEventListener("click", () => {
        alert("장바구니에 추가되었습니다");
    });
});

// ✅ 선택 장바구니
document.querySelector(".add-cart-selected").addEventListener("click", () => {
    const checked = document.querySelectorAll(".item-check:checked");

    if(checked.length === 0){
        alert("상품을 선택하세요");
        return;
    }

    alert("선택 상품이 장바구니에 추가되었습니다");
});
</script>

</body>
</html>