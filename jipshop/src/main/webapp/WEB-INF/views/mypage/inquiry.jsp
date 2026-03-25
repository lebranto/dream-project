<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>마이페이지 문의 내역</title>
 <c:set var="contextPath" value="${pageContext.request.contextPath}" />
  <!-- <link rel="stylesheet" href="${contextPath}/resources/css/mypage/inquiry.css"> -->
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/inquiry.css">
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

      <div class="inquiry-summary">
        ${loginUser.userName} 님의 문의 내역
      </div>

      <div class="table-header">
        <div>번호</div>
        <div>문의 제목</div>
        <div>등록 날짜</div>
        <div>답변 여부</div>
      </div>

      <c:choose>
        <c:when test="${empty inquiryList}">
          <div class="empty-box">문의 사항이 없습니다.</div>
        </c:when>

        <c:otherwise>
          <div class="inquiry-list">
            <c:forEach var="q" items="${inquiryList}">
              <div class="inquiry-card">
                <div class="number-cell">${q.inquiryNo}</div>
                <div class="title-cell">${q.inquiryTitle}</div>
                <div class="date-cell">${q.createDate}</div>
                <div class="status-cell">${q.answerStatus}</div>
              </div>
            </c:forEach>
          </div>

          <div class="pagination">
            <c:if test="${pi.currentPage > 1}">
              <a class="page-arrow" href="${contextPath}/mypage/question?cpage=${pi.currentPage - 1}">◀</a>
            </c:if>

            <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
              <a class="page-btn ${p == pi.currentPage ? 'active' : ''}"
                 href="${contextPath}/mypage/question?cpage=${p}">
                ${p}
              </a>
            </c:forEach>

            <c:if test="${pi.currentPage < pi.maxPage}">
              <a class="page-arrow" href="${contextPath}/mypage/question?cpage=${pi.currentPage + 1}">▶</a>
            </c:if>
          </div>
        </c:otherwise>
      </c:choose>
    </main>
  </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>