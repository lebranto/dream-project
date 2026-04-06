<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
   <jsp:include page="/WEB-INF/views/common/myPageSidebar.jsp" />
  </aside>

  <div class="content-wrap">
    <main class="content">
      <div class="page-title">마이페이지</div>

      <div class="detail-summary">${loginUser.memberName} 님의 조회 내역</div>

      <section class="detail-box">
        <div class="detail-head">
          <div class="detail-head-label">제목 :</div>
          <div class="detail-head-title">${myinquiry.inquiryType}</div>
          <div class="detail-head-date-label">작성일 :</div>
          <div class="detail-head-date">
          <fmt:formatDate value="${myinquiry.inquiryRegDate}" pattern="yyyy-MM-dd"/> 
          </div>
        </div>

        <div class="detail-body">
          <div class="question-area">
            <div class="photo-box">
              <c:choose>
                <c:when test="${not empty myinquiry.inquiryPhoto}">
                  <img src="${contextPath}${myinquiry.inquiryPhoto}" alt="문의 첨부 사진">
                </c:when>
                <c:otherwise>
                  사진<br>(선택사항)
                </c:otherwise>
              </c:choose>
            </div>

            <div class="question-content-wrap">
              <div class="question-content">${myinquiry.inquiryContent}</div>
            </div>
          </div>

          <div class="answer-area">
            <div class="answer-content">
              <c:choose>
                <c:when test="${not empty myinquiry.replyContent}">
                  ${myinquiry.replyContent}
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
                onclick="location.href='${contextPath}/inquiry/edit?no=${myinquiry.inquiryId}'">
          수정
        </button>

		<form action="${contextPath}/mypage/delete" method="post" style="display:inline">
        
         <input type="hidden" name="inquiryId" value="${myinquiry.inquiryId}">
        <button class="action-btn" type="submit"
                onclick="return confirm('정말 삭제하시겠습니까?');">
          삭제
        </button>
		
		</form>

      </div>
    </main>
  </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>