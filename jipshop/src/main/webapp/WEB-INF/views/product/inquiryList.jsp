<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 문의</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/inquiry.css">
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="inquiry-wrap">
        <div class="inquiry-container">

            <div class="inquiry-header">
                <div class="col-no">번호</div>
                <div class="col-title">문의 제목</div>
                <div class="col-date">문의 날짜</div>
                <div class="col-status">답변 여부</div>
            </div>

            <c:choose>
                <c:when test="${empty inquiryList}">
                    <div class="inquiry-row empty-row">
                        <div class="empty-text">등록된 문의가 없습니다.</div>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="inquiry" items="${inquiryList}">
                        <div class="inquiry-row">
                            <div class="col-no">${inquiry.inquiryNo}</div>
                            <div class="col-title">${inquiry.title}</div>
                            <div class="col-date">${inquiry.enrollDate}</div>
                            <div class="col-status">${inquiry.answerStatus}</div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

            <div class="write-btn-area">
                <a href="${pageContext.request.contextPath}/inquiry/write" class="write-btn">글쓰기</a>
            </div>

            <div class="paging-area">
                <c:if test="${startPage > 1}">
                    <a href="${pageContext.request.contextPath}/inquiry/list?page=${startPage - 1}" class="paging-arrow">&lt;</a>
                </c:if>

                <c:forEach var="p" begin="${startPage}" end="${endPage}">
                    <c:choose>
                        <c:when test="${p == currentPage}">
                            <span class="paging-num active">${p}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/inquiry/list?page=${p}" class="paging-num">${p}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:if test="${endPage < maxPage}">
                    <a href="${pageContext.request.contextPath}/inquiry/list?page=${endPage + 1}" class="paging-arrow">&gt;</a>
                </c:if>
            </div>

        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>