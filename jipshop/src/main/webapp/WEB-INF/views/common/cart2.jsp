<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>장바구니</title>

<style>
*{box-sizing:border-box;margin:0;padding:0;font-family:'Pretendard',sans-serif;}
body{background:#f5f5f5;}

.cart-container{
    max-width:1000px;
    margin:0 auto;
    background:#fff;
    padding:30px;
}

/* 헤더 */
.cart-header{
    display:flex;
    justify-content:space-between;
    align-items:flex-end;
    border-bottom:2px solid #000;
    padding-bottom:15px;
    margin-bottom:30px;
}
.cart-header h1{font-size:24px;}
.steps{font-size:14px;color:#ccc;}
.steps .active{color:#333;font-weight:bold;}

/* 테이블 */
.table-wrapper{overflow-x:auto;border-bottom:1px solid #ddd;}
.cart-table{width:100%;min-width:800px;border-collapse:collapse;}
.cart-table th{
    background:#f9f9f9;
    padding:15px;
    border-bottom:1px solid #ddd;
}
.cart-table td{
    padding:20px 10px;
    border-bottom:1px solid #eee;
    text-align:center;
}

/* 상품 */
.product-info{display:flex;align-items:center;gap:15px;text-align:left;}
.product-info img{width:80px;height:80px;border-radius:4px;}
.price{font-weight:bold;}

/* 버튼 */
.opt-btn{
    padding:5px 10px;
    border:1px solid #ccc;
    background:#fff;
    cursor:pointer;
}

/* 금액 */
.total-summary{
    display:flex;
    justify-content:flex-end;
    gap:40px;
    border:1px solid #eee;
    padding:30px;
    margin:20px 0;
}
.highlight{color:#ffb84d;}

/* 하단 */
.cart-actions{
    display:flex;
    justify-content:space-between;
}
.order-btn{
    padding:15px 60px;
    background:#ffda79;
    border:none;
    cursor:pointer;
}

/* ✅ 모달 */
.modal{
    display:none;
    position:fixed;
    top:0;left:0;
    width:100%;height:100%;
    background:rgba(0,0,0,0.5);
}

.modal-content{
    background:#fff;
    width:400px;
    margin:150px auto;
    padding:20px;
    border-radius:8px;
    position:relative;
    text-align:center;
}

.close{
    position:absolute;
    right:15px;
    top:10px;
    cursor:pointer;
}

.modal-btn{
    margin-top:15px;
    padding:10px 20px;
    background:#ffda79;
    border:none;
    cursor:pointer;
}
</style>

</head>
<body>

<!-- 헤더 -->
<jsp:include page="/WEB-INF/views/common/header2.jsp" />

<div class="cart-container">

    <header class="cart-header">
        <h1>장바구니</h1>
        <div class="steps">
            <span class="active">01 장바구니</span> >
            <span>02 주문서작성/결제</span> >
            <span>03 주문완료</span>
        </div>
    </header>

    <div class="table-wrapper">
        <table class="cart-table">
            <tr>
                <th></th>
                <th>상품</th>
                <th>옵션</th>
                <th>가격</th>
            </tr>

            <tr>
                <td><input type="checkbox"></td>
                <td class="product-info">
                    <img src="https://placehold.co/80x80">
                    사료 1kg
                </td>
                <td><button class="opt-btn">옵션변경</button></td>
                <td class="price">19,900원</td>
            </tr>
        </table>
    </div>

    <div class="total-summary">
        <div>합계 <strong class="highlight">19,900원</strong></div>
    </div>

    <div class="cart-actions">
        <button>삭제</button>
        <button class="order-btn">주문하기</button>
    </div>

</div>

<!-- ✅ 모달 -->
<div id="optionModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h3>옵션 변경</h3>
        <select>
            <option>1kg</option>
            <option>2kg</option>
        </select>
        <br><br>
        <button class="modal-btn">변경하기</button>
    </div>
</div>

<!-- 푸터 -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
const modal = document.getElementById("optionModal");
const btns = document.querySelectorAll(".opt-btn");
const close = document.querySelector(".close");

btns.forEach(btn=>{
    btn.addEventListener("click",()=>{
        modal.style.display="block";
    });
});

close.onclick=()=>modal.style.display="none";

window.onclick=(e)=>{
    if(e.target===modal){
        modal.style.display="none";
    }
};
</script>

</body>
</html>