<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
   <jsp:include page="/WEB-INF/views/common/myPageSidebar.jsp" />
  </aside>


  <div class="content-wrap">
    <main class="content">
      <div class="page-title">마이페이지</div>

      <div class="inquiry-summary">
        ${memberName} 님의 문의 내역
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
            <c:forEach var="i" items="${inquiryList}">
              <div class="inquiry-card">
                <div class="number-cell">${i.inquiryId}</div>
                <a href="${contextPath}/mypage/inquirydetail?inquiryId=${i.inquiryId}" class="title-cell">${i.inquiryType}</a>
                <div class="date-cell">
                <fmt:formatDate value="${i.inquiryRegDate}" pattern="yyyy-MM-dd"/>
                </div>
                <div class="status-cell">${i.replyYn}</div>
              </div>
            </c:forEach>
          </div>

          <div class="pagination">
          
            <c:if test="${pi.currentPage > 1}">
              <a class="page-arrow"
                href="${contextPath}/mypage/inquiry?cpage=${pi.currentPage - 1}">
                ◀
              </a>
            </c:if>

            <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
              <a class="page-btn ${p == pi.currentPage ? 'active' : ''}"
                 href="${contextPath}/mypage/inquiry?cpage=${p}">
               ${p}
             </a>
           </c:forEach>

           <c:if test="${pi.currentPage < pi.maxPage}">
             <a class="page-arrow"
                href="${contextPath}/mypage/inquiry?cpage=${pi.currentPage + 1}">
             ▶
             </a>
           </c:if>
           
          </div>
        </c:otherwise>
      </c:choose>
    </main>
  </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>