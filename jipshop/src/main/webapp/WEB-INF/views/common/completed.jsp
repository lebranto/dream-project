<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문완료</title>

<style>
    body{
        margin:0;
        font-family: '맑은 고딕', sans-serif;
        background-color:#f5f5f5;
    }

    .container{
        width:1100px;
        margin:0 auto;
        background-color:white;
        padding-bottom:80px;
    }

	.top-area{
		display:flex;
		justify-content:space-between;
    	align-items:flex-end;
    	padding:30px 20px 2px;
        border-bottom:1px solid #ddd; /*가로 회색줄 */
        width:90%; 
        margin:0 auto;
	}

    .title-area{
        padding:0;
        font-size:24px;
        font-weight:bold;
    }

    .step-area{
        text-align:right;
        font-size:13px;
        color:#888;
        padding:0;
    }
    
    .step-area{
    	color:#C4C4C4;   /* 👈 기본은 연한 회색 */
    	font-size:14px;
	}

	.step{
    	color:#000;   /* 👈 01, 02 검은색 */
    	font-weight:500;
	}

	.step.active{
    	font-weight:bold; /* 👈 03은 강조 */
	}

    .complete-area{
        text-align:center;
        padding:80px 0;
    }

    .check-circle{
        width:80px;
        height:80px;
        background-color:#FF9B65;
        border-radius:50%;
        display:inline-flex;
        align-items:center;
        justify-content:center;
        margin-bottom:20px;
    }

    .check-circle::after{
        content:"✔";
        color:white;
        font-size:40px;
    }

    .complete-text{
        font-size:28px;
        font-weight:bold;
    }

    .order-info{
        width:90%;
        margin:0 auto;
        border-top:1px solid #ddd; /*가로 회색줄 */
        padding-top:20px;
        color:#333;
        font-size:14px;
    }
</style>

</head>
<body>

<jsp:include page="/WEB-INF/views/common/header2.jsp" />

<div class="container">

    <div class="top-area">
    <div class="title-area">주문완료</div>

    <div class="step-area">
        <span class="step">01</span> 장바구니 > 
    	<span class="step">02</span> 주문서작성/결제 > 
    	<span class="step active">03 주문완료</span>
    </div>
</div>

    <div class="complete-area">
        <div class="check-circle"></div>
        <div class="complete-text">주문완료 되었습니다</div>
    </div>

    <div class="order-info">
        &lt; 주문 내역 확인
    </div>

</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>