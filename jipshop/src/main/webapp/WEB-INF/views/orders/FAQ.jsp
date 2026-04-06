<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>FAQ</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">

<style>

/* ===== 전체 레이아웃 ===== */
.content-wrapper {
    max-width: 1100px;
    margin: 0 auto;
    padding: 40px 20px;
}

.mypage-container {
    display:flex;
    gap:40px;
    align-items:flex-start;
}

/* 사이드바 고정 */
.mypage-sidebar {
    width:220px;
    flex-shrink:0;
    position:sticky;
    top:100px;
}

/* 본문 */
.mypage-content {
    flex:1;
}

/* ===== 타이틀 ===== */
.page-title {
    font-size:28px;
    font-weight:bold;
    margin-bottom:20px;
}

/* ===== 공지사항 ===== */
.notice-box {
    border:1px solid #ccc;
    margin-bottom:30px;
}

.notice-title {
    background:#FFD780;
    padding:10px;
    text-align:center;
    font-weight:bold;
}

.notice-content {
    background:#f3ecd2;
    padding:20px;
    line-height:1.8;
}

/* ===== FAQ ===== */
.faq-box {
    border:1px solid #ccc;
}

.faq-title {
    background:#FFD780;
    padding:10px;
    text-align:center;
    font-weight:bold;
}

/* 질문 */
.faq-question {
    background:#f3ecd2;
    padding:15px;
    border-bottom:1px solid #ddd;
    font-weight:bold;
}

/* 답변 */
.faq-answer {
    background:#c8d6df;
    padding:20px;
    border-bottom:1px solid #ddd;
    font-size:14px;
    line-height:1.6;
}

/* 마지막 줄 border 제거 */
.faq-box div:last-child {
    border-bottom:none;
}

/* ===== 버튼 ===== */
.btn-area {
    display:flex;
    justify-content:flex-end;
    margin-top:30px;
}

.btn-edit {
    padding:10px 30px;
    background:#ccc;
    border:none;
    cursor:pointer;
}

</style>
</head>

<body>

<!-- 헤더 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="content-wrapper">

    <div class="mypage-container">

        <!-- 사이드바 -->
        
        
       	<aside class="sidebar">
  
  		<jsp:include page="/WEB-INF/views/common/myPageSidebar.jsp" />
    
  		</aside>

        <!-- 본문 -->
        <div class="mypage-content">

            <div class="page-title">FAQ</div>

            <!-- 공지사항 -->
            <div class="notice-box">
                <div class="notice-title">공지 사항</div>
                <div class="notice-content">
                    1. 주문이 많이 밀리고 있습니다. 최대한 조치를 취해 택배사와 협력을 하고 있으니 배송이 늦게 되는 점 양해 부탁드립니다.<br><br>
                    2. 인기 상품인 000가 현재 품절이 되었습니다. 다음달 다시 재고가 입고 될 예정이니 참고 부탁 드리겠습니다.<br><br>
                    3. 현재 저희 페이지에서 반려동물 사랑 단체와 함께 동물 사랑 기부금을 운영하고 있습니다. 궁금하신 사항이 있다면 동물 사랑 기부금 홈페이지를 참고해 주시기 바랍니다.
                </div>
            </div>

            <!-- FAQ -->
            <div class="faq-box">

                <div class="faq-title">FAQ</div>

                <div class="faq-question">1. 주문에서 배송까지 걸리는 시간은 얼마나 되나요.</div>
                <div class="faq-answer">
                    기본적으로 걸리는 시간은 1~2일 정도로 예상이 됩니다. 하지만 주문이 밀리거나 해당 제품에 문제가 생길시에는 더 오래 걸릴 수 있으니 배송기간을 확인해 주시고 문제가 생긴다면 문의를 주시면 감사드리겠습니다.
                </div>

                <div class="faq-question">2. 상품을 반품하고 싶은데 어디에서 하면 되나요.</div>
                <div class="faq-answer">
                    상품의 반품은 고객센터에서 가능합니다. 주문번호와 반품하시는 사유를 알려주시면 저희 쪽에서 빠른 시일내에 조치를 취하겠습니다.
                </div>

                <div class="faq-question">3. 물품의 종류는 강아지와 고양이용 두가지 밖에 없나요?</div>
                <div class="faq-answer">
                    저희 사이트에서는 강아지 용품과 고양이 용품을 주로 팔고 있습니다. 안타깝게도 다른 반려동물의 용품은 팔고 있지 않으니 이점 참고해 주시면 감사드리겠습니다.
                </div>

                <div class="faq-question">4. 배송을 받지 않고 오프라인으로 직접 가져가는 것도 가능한가요?</div>
                <div class="faq-answer">
                    물품은 저희 회사쪽으로 오는게 아닌 해당 업체에서 바로 배송을 하기 때문에 저희 회사에서 직접 가져가는 것은 불가능 합니다.
                </div>

            </div>

            <!-- 버튼 -->
            <div class="btn-area">
                <button class="btn-edit">수정</button>
            </div>

        </div>

    </div>

</div>

<!-- 푸터 -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>