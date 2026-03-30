<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지 최근 본 상품</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/mypage/recent.css"> 
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <aside class="sidebar">
        <jsp:include page="/WEB-INF/views/common/myPageSidebar.jsp" />
    </aside>


    <div class="content-wrap">
        <main class="content">
            <div class="page-title">마이페이지</div>

            <div class="recent-summary">
                ${memberName} 님의 조회 내역
            </div>
    <div class="filter-row">

        <!-- 빠른 기간 조회 -->
        <form action="${contextPath}/mypage/recent" method="get" class="period-form">
          <button class="period-btn" type="submit" name="period" value="7">1주일</button>
          <button class="period-btn" type="submit" name="period" value="30">1개월</button>
          <button class="period-btn" type="submit" name="period" value="90">3개월</button>
          <button class="period-btn" type="submit" name="period" value="180">6개월</button>
        </form>

        <!-- 직접 날짜 조회 -->
        <form action="${contextPath}/mypage/recent" method="get" class="date-form">
          <div class="date-group">
            <input type="date" class="date-input" name="startDate" value="${param.startDate}">
            <span>~</span>
            <input type="date" class="date-input" name="endDate" value="${param.endDate}">
            <button class="search-btn" type="submit">조회</button>
          </div>
        </form>
        
        
      </div>
      
      
            <div class="table-header">
                <div>상품명/가격</div>
                <div>조회일</div>
                <div></div>
            </div>

            <c:choose>
                <c:when test="${empty recentlyList}">
                    <div class="empty-box">
                        최근 본 상품이 없습니다
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="recent-list">
                        <c:forEach var="l" items="${recentlyList}">
                            <div class="recent-card">
                                <div class="product-cell">
                                   <img class="product-thumb"
                                         src="${l.photo1}"
                                         alt="${l.productName}"> 
                                    <div class="product-info">
                                        <div class="product-name">${l.productName}</div> 
                                        <div>
                                           <fmt:formatNumber value="${l.productPrice}" pattern="#,###" />원
                                        </div>
                                    </div>
                                </div>

                                <div class="view-cell">
                                    <fmt:formatDate value="${l.viewedDate}" pattern="yyyy-MM-dd" />
                                </div>

                                <div class="go-cell">
                                    <button class="go-btn"
                                            type="button"
                                            onclick="location.href='${contextPath}/product/detail?productNo=${item.productNo}'">
                                        상품 보러가기
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
<div class="pagination">
  <c:choose>
 
    <c:when test="${not empty param.period}">

      <c:if test="${pi.currentPage > 1}">
        <a class="page-arrow"
           href="${contextPath}/mypage/recent?cpage=${pi.currentPage - 1}&period=${param.period}">
          ◀
        </a>
      </c:if>
      <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
        <a class="page-btn ${p == pi.currentPage ? 'active' : ''}"
           href="${contextPath}/mypage/recent?cpage=${p}&period=${param.period}">
          ${p}
        </a>
      </c:forEach>
      <c:if test="${pi.currentPage < pi.maxPage}">
        <a class="page-arrow"
           href="${contextPath}/mypage/recent?cpage=${pi.currentPage + 1}&period=${param.period}">
          ▶
        </a>
      </c:if>
    </c:when>

 
    <c:when test="${not empty param.startDate and not empty param.endDate}">
      <c:if test="${pi.currentPage > 1}">
        <a class="page-arrow"
           href="${contextPath}/mypage/recent?cpage=${pi.currentPage - 1}&startDate=${param.startDate}&endDate=${param.endDate}">
          ◀
        </a>
      </c:if>
      <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
        <a class="page-btn ${p == pi.currentPage ? 'active' : ''}"
           href="${contextPath}/mypage/recent?cpage=${p}&startDate=${param.startDate}&endDate=${param.endDate}">
          ${p}
        </a>
      </c:forEach>

      <c:if test="${pi.currentPage < pi.maxPage}">
        <a class="page-arrow"
           href="${contextPath}/mypage/recent?cpage=${pi.currentPage + 1}&startDate=${param.startDate}&endDate=${param.endDate}">
          ▶
        </a>
      </c:if>
    </c:when>
 
    <c:otherwise>
      <c:if test="${pi.currentPage > 1}">
        <a class="page-arrow"
           href="${contextPath}/mypage/recent?cpage=${pi.currentPage - 1}">
          ◀
        </a>
      </c:if>

      <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
        <a class="page-btn ${p == pi.currentPage ? 'active' : ''}"
           href="${contextPath}/mypage/recent?cpage=${p}">
          ${p}
        </a>
      </c:forEach>

      <c:if test="${pi.currentPage < pi.maxPage}">
        <a class="page-arrow"
           href="${contextPath}/mypage/recent?cpage=${pi.currentPage + 1}">
          ▶
        </a>
      </c:if>
   </c:otherwise>
  </c:choose>
</div>
                    
                </c:otherwise>
            </c:choose>
        </main>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>