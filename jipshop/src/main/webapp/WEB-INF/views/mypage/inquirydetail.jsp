<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>문의 상세 화면</title>
   <c:set var="contextPath" value="${pageContext.request.contextPath}" />
  <link rel="stylesheet" href="${contextPath}/resources/css/mypage/inquirydetail.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
    <aside class="sidebar">
   <div class="menu-group">
      <div class="menu-title">my 쇼핑</div>
      <ul class="menu-list">
        <a href="${contextPath}/mypage/purchase">구매 내역 보기</a><br>
        <a href="${contextPath}/mypage/recent">최근 본 상품</a>
      </ul>
    </div>

    <div class="menu-group">
      <div class="menu-title">문의</div>
      <ul class="menu-list">
        <a href="${contextPath}/mypage/inquiry">문의 내역</a>
      </ul>
    </div>

    <div class="menu-group">
      <div class="menu-title">회원 정보</div>
      <ul class="menu-list">
        <a href="${contextPath}/mypage/updateMemberCheck">회원 정보 수정</a><br>
        <a href="${contextPath}/mypage/updateMemberCheck">반려동물 정보 수정</a><br>
        <a href="${contextPath}/mypage/memberDelete">회원 탈퇴</a>
      </ul>
    </div>
    
     <div class="menu-group">
      <div class="menu-title">고객 센터</div>
      <ul class="menu-list">
        <a href="${contextPath}/mypage/purchase">1:1문의</a><br>
        <a href="${contextPath}/mypage/recent">FAQ</a><br>
      </ul>
    </div>
  </aside>

  <div class="content-wrap">
    <main class="content">
      <div class="page-title">마이페이지</div>

      <div class="detail-summary">${loginUser.userName} 님의 조회 내역</div>

      <section class="detail-box">
        <div class="detail-head">
          <div class="detail-head-label">제목 :</div>
          <div class="detail-head-title">${inquiry.title}</div>
          <div class="detail-head-date-label">작성일 :</div>
          <div class="detail-head-date">${inquiry.createDate}</div>
        </div>

        <div class="detail-body">
          <div class="question-area">
            <div class="photo-box">
              <c:choose>
                <c:when test="${not empty inquiry.imagePath}">
                  <img src="${pageContext.request.contextPath}${inquiry.imagePath}" alt="문의 첨부 사진">
                </c:when>
                <c:otherwise>
                  사진<br>(선택사항)
                </c:otherwise>
              </c:choose>
            </div>

            <div class="question-content-wrap">
              <div class="question-content">${inquiry.questionContent}</div>
            </div>
          </div>

          <div class="answer-area">
            <div class="answer-content">
              <c:choose>
                <c:when test="${not empty inquiry.answerContent}">
                  ${inquiry.answerContent}
                </c:when>
                <c:otherwise>
                  아직 답변이 등록되지 않았습니다.
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>
      </section>

      <div class="bottom-actions">
        <button class="action-btn" type="button"
                onclick="location.href='${pageContext.request.contextPath}/inquiry/edit?no=${inquiry.inquiryNo}'">
          수정
        </button>

        <button class="action-btn" type="button"
                onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='${pageContext.request.contextPath}/inquiry/delete?no=${inquiry.inquiryNo}'">
          삭제
        </button>
      </div>
    </main>
  </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>