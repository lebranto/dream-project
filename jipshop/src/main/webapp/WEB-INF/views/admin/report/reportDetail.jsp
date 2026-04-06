<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    request.setAttribute("currentMenu", "reportList");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>댓글 신고 상세</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/report/reportDetail.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/admin/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>

<main class="main">
    <div class="page-title">댓글 신고 상세</div>

    <div class="detail-card">
        <div class="detail-card-header">신고 기본 정보</div>
        <div class="detail-card-body">
            <dl class="detail-grid">
                <dt>신고자</dt>
                <dd>${report.reporterId}</dd>

                <dt>신고 대상ID</dt>
                <dd>${report.reportedMemberId}</dd>

                <dt>신고일</dt>
                <dd>${report.reportDate}</dd>

                <dt>처리 상태</dt>
                <dd>
                    <c:choose>
                        <c:when test="${report.reportProcessYn eq 'Y'}">
                            <span class="status-btn done">처리 완료</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-btn pending">처리 대기</span>
                        </c:otherwise>
                    </c:choose>
                </dd>
            </dl>
        </div>
    </div>

    <div class="detail-card">
        <div class="detail-card-header">신고 상세 정보</div>
        <div class="detail-card-body">

            <div class="section-block">
                <div class="section-label">신고유형</div>
                <div class="content-box small-box">
                    <c:out value="${report.reportTypeName}" default="유형 없음"/>
                </div>
            </div>

            <div class="section-block">
                <div class="section-label">신고내용</div>
                <div class="content-box">
                    <c:choose>
                        <c:when test="${not empty report.reportReason}">
                            ${report.reportReason}
                        </c:when>
                        <c:otherwise>
                            신고 내용이 없습니다.
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="section-block">
                <div class="section-label">신고된 댓글 내용</div>
                <div class="content-box reply">
                    <c:choose>
                        <c:when test="${not empty report.commentContent}">
                            ${report.commentContent}
                        </c:when>
                        <c:otherwise>
                            댓글 내용이 없습니다.
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        </div>
    </div>

    <div class="detail-btn-area">
        <button type="button" class="btn btn-line"
                onclick="location.href='${pageContext.request.contextPath}/admin/reportList.do'">
            목록
        </button>

        <c:if test="${report.reportProcessYn eq 'N'}">
            <form action="${pageContext.request.contextPath}/admin/reportProcess.do" method="post" style="display:inline-block;">
                <input type="hidden" name="reportId" value="${report.reportId}">
                <button type="submit" class="btn btn-primary">처리 완료</button>
            </form>
        </c:if>
    </div>
</main>

</body>
</html>