<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setAttribute("currentMenu", "newUser"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>신고 상세 - 집사상점</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/reportDetail.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/header.jsp"/>

<main class="main">
    <div class="page-title">신고 사항</div>

    <%-- 신고 정보 --%>
    <div class="detail-card">
        <div class="detail-card-header">🚨 신고 정보</div>
        <dl class="detail-grid">
            <dt>신고자</dt>
            <dd><strong>${report.reporterName}</strong></dd>
            <dt>신고 대상</dt>
            <dd>${report.reportedName}</dd>
            <dt>신고일</dt>
            <dd>${report.reportDate}</dd>
            <dt>처리 상태</dt>
            <dd>
                <c:choose>
                    <c:when test="${report.reportStatus=='DONE'}">
                        <span class="badge badge-done">처리 완료</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge badge-pending">처리 대기</span>
                    </c:otherwise>
                </c:choose>
            </dd>
        </dl>
    </div>

    <%-- 신고 내용 --%>
    <div class="section-label">신고 내용</div>
    <div class="content-box" style="margin-bottom:20px">
        <c:choose>
            <c:when test="${not empty report.reportContent}">
                ${report.reportContent}
            </c:when>
            <c:otherwise>
                <span style="color:var(--text-sub)">신고 내용이 없습니다.</span>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- 처리 메모 --%>
    <div class="section-label">처리 메모</div>
    <c:choose>
        <c:when test="${report.reportStatus == 'DONE'}">
            <%-- 처리 완료 상태 --%>
            <div class="content-box reply" style="margin-bottom:20px">
                <c:choose>
                    <c:when test="${not empty report.processNote}">${report.processNote}</c:when>
                    <c:otherwise><span style="color:var(--text-sub)">처리 메모 없음</span></c:otherwise>
                </c:choose>
            </div>
            <div class="btn-group">
                <button class="btn btn-outline" onclick="location.href='/admin/reportList.do'">목록</button>
            </div>
        </c:when>
        <c:otherwise>
            <%-- 처리 대기 상태 : 처리 폼 노출 --%>
            <form action="/admin/reportProcess.do" method="post">
                <input type="hidden" name="reportId" value="${report.reportId}">
                <textarea name="processNote" class="form-textarea"
                          placeholder="처리 내용 또는 조치 사항을 입력하세요."
                          style="margin-bottom:10px"></textarea>
                <div class="btn-group">
                    <button type="button" class="btn btn-outline"
                            onclick="location.href='/admin/reportList.do'">목록</button>
                    <button type="submit" class="btn btn-primary">처리 완료</button>
                </div>
            </form>
        </c:otherwise>
    </c:choose>

</main>
<div class="toast" id="toast"></div>
<script>
    function showToast(msg){const t=document.getElementById('toast');t.textContent=msg;t.classList.add('show');setTimeout(()=>t.classList.remove('show'),2400);}
    <c:if test="${not empty successMsg}">window.onload=()=>showToast('✅ ${successMsg}');</c:if>
</script>
</body>
</html>
