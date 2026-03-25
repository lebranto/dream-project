<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인정보처리방침</title>
<style>
    body {
        font-family: 'Malgun Gothic', sans-serif;
        margin: 0;
        padding: 0;
        background-color: #fdfaf5;
        color: #333;
    }
    .policy-container {
        width: 80%;
        max-width: 900px;
        margin: 50px auto;
        background: #fff;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        line-height: 1.8;
    }
    h1 {
        text-align: center;
        margin-bottom: 30px;
    }
    h2 {
        margin-top: 25px;
        color: #5a3d2b;
    }
    .back-btn {
        display: inline-block;
        margin-top: 30px;
        padding: 10px 18px;
        background-color: #8b5e3c;
        color: white;
        text-decoration: none;
        border-radius: 8px;
    }
    .back-btn:hover {
        background-color: #6f472c;
    }
</style>
</head>
<body>

<div class="policy-container">
    <h1>개인정보처리방침</h1>

    <h2>1. 개인정보 수집 항목</h2>
    <p>
        회사는 회원가입, 주문, 고객문의 등을 위해 다음과 같은 개인정보를 수집할 수 있습니다.
        <br>- 이름
        <br>- 아이디
        <br>- 비밀번호
        <br>- 전화번호
        <br>- 이메일 주소
        <br>- 배송지 주소
    </p>

    <h2>2. 개인정보 수집 및 이용 목적</h2>
    <p>
        수집한 개인정보는 다음의 목적을 위해 사용됩니다.
        <br>1. 회원관리 및 본인확인
        <br>2. 상품 주문 및 결제 처리
        <br>3. 배송 서비스 제공
        <br>4. 고객 문의 응대
    </p>

    <h2>3. 개인정보 보유 및 이용기간</h2>
    <p>
        회사는 개인정보 수집 및 이용 목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다.
        단, 관계 법령에 따라 일정 기간 보관이 필요한 경우 해당 기간 동안 보관합니다.
    </p>

    <h2>4. 개인정보 제3자 제공</h2>
    <p>
        회사는 이용자의 동의 없이 개인정보를 외부에 제공하지 않습니다.
        다만, 법령에 의한 경우는 예외로 합니다.
    </p>

    <h2>5. 이용자의 권리</h2>
    <p>
        이용자는 언제든지 본인의 개인정보를 조회하거나 수정할 수 있으며,
        회원 탈퇴를 통해 개인정보 삭제를 요청할 수 있습니다.
    </p>

    <a href="${pageContext.request.contextPath}/" class="back-btn">메인으로 돌아가기</a>
</div>

</body>
</html>