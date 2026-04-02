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
                <div class="col-title">문의 유형</div>
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
                            <div class="col-no">${inquiry.inquiryId}</div>
                            <div class="col-title">${inquiry.inquiryType}</div>
                            <div class="col-date">${inquiry.inquiryRegDate}</div>
                            <div class="col-status">
                                <c:choose>
                                    <c:when test="${inquiry.replyYn eq 'Y'}">답변완료</c:when>
                                    <c:otherwise>미답변</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

            <div class="write-btn-area">
                <a href="${pageContext.request.contextPath}/product/inquiryWrite" class="write-btn">글쓰기</a>
            </div>

            <div class="paging-area">
                <c:if test="${pi.startPage > 1}">
                    <a href="${pageContext.request.contextPath}/product/inquiryList?currentPage=${pi.startPage - 1}" class="paging-arrow">&lt;</a>
                </c:if>

                <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
                    <c:choose>
                        <c:when test="${p == pi.currentPage}">
                            <span class="paging-num active">${p}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/product/inquiryList?currentPage=${p}" class="paging-num">${p}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:if test="${pi.endPage < pi.maxPage}">
                    <a href="${pageContext.request.contextPath}/product/inquiryList?currentPage=${pi.endPage + 1}" class="paging-arrow">&gt;</a>
                </c:if>
            </div>

        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>