<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이용약관</title>
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
    <h1>이용약관</h1>

    <h2>제1조 (목적)</h2>
    <p>
        본 약관은 집사상점(이하 "회사")이 제공하는 반려동물 용품 쇼핑몰 서비스의 이용과 관련하여
        회사와 이용자의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.
    </p>

    <h2>제2조 (정의)</h2>
    <p>
        "이용자"란 회사의 사이트에 접속하여 본 약관에 따라 회사가 제공하는 서비스를 받는 회원 및 비회원을 말합니다.
    </p>

    <h2>제3조 (서비스의 제공)</h2>
    <p>
        회사는 다음과 같은 서비스를 제공합니다.
        <br>1. 반려동물 용품 정보 제공
        <br>2. 상품 구매 및 결제 서비스
        <br>3. 배송 조회 및 고객 문의 서비스
        <br>4. 기타 회사가 정하는 서비스
    </p>

    <h2>제4조 (회원가입)</h2>
    <p>
        이용자는 회사가 정한 가입 양식에 따라 회원정보를 기입한 후 본 약관에 동의함으로써 회원가입을 신청합니다.
    </p>

    <h2>제5조 (이용자의 의무)</h2>
    <p>
        이용자는 다음 행위를 하여서는 안 됩니다.
        <br>1. 허위 정보의 등록
        <br>2. 타인의 정보 도용
        <br>3. 회사가 게시한 정보의 무단 변경
        <br>4. 기타 관계 법령에 위반되는 행위
    </p>

    <h2>제6조 (면책조항)</h2>
    <p>
        회사는 천재지변, 시스템 장애 등 불가항력적 사유로 서비스를 제공할 수 없는 경우 책임을 지지 않습니다.
    </p>

    <a href="${pageContext.request.contextPath}/" class="back-btn">메인으로 돌아가기</a>
</div>

</body>
</html>