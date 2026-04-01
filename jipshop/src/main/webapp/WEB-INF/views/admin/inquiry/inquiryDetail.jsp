<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% request.setAttribute("currentMenu", "inquiryList"); %>
<!DOCTYPE html>
<html lang="ko">
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<head>
    <meta charset="UTF-8">
    <title>문의 상세 - 집사상권</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/admin.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/inquiry/inquiryDetail.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>

<main class="main">

    <div class="page-title">문의 상세</div>

    <%-- 문의 내용 --%>
    <div class="detail-card">
        <div class="detail-card-header">
            💬 문의 내용
            <c:choose>
                <c:when test="${inquiry.replyYn == 'Y'}">
                    <span class="badge badge-done" style="margin-left:8px">처리 완료</span>
                </c:when>
                <c:otherwise>
                    <span class="badge badge-pending" style="margin-left:8px">미처리</span>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="detail-card-body">
            <dl class="detail-grid">
                <dt>문의 번호</dt><dd>${inquiry.inquiryId}</dd>
                <dt>유형</dt>
                <dd><span class="badge badge-waiting">${inquiry.inquiryType}</span></dd>
                <dt>작성자</dt>
                <dd><strong>${inquiry.memberName}</strong>
                    <span class="font-mono" style="color:var(--text-sub)">(${inquiry.memberId})</span>
                </dd>
                <dt>작성일</dt>
                <dd style="color:var(--text-sub)">
                    <fmt:formatDate value="${inquiry.inquiryRegDate}" pattern="yyyy-MM-dd HH:mm"/>
                </dd>
            </dl>
            <div class="inquiry-content">${inquiry.inquiryContent}</div>
            <c:if test="${not empty inquiry.inquiryPhoto}">
                <div style="margin-top:12px">
                    <img src="${contextPath}${inquiry.inquiryPhoto}"
                         style="max-width:400px;border-radius:8px;border:1px solid var(--border)">
                </div>
            </c:if>
        </div>
    </div>

    <%-- 답변 영역 --%>
    <div class="detail-card">
        <div class="detail-card-header">✏️ 답변
            <c:if test="${inquiry.replyYn == 'Y'}">
                <span style="font-size:11px;font-weight:400;color:var(--text-sub);margin-left:8px">
                    답변일 <fmt:formatDate value="${inquiry.replyDate}" pattern="yyyy-MM-dd HH:mm"/>
                </span>
            </c:if>
        </div>
        <div class="detail-card-body">
            <c:choose>
                <c:when test="${inquiry.replyYn == 'Y'}">
                    <%-- 이미 답변된 경우: 내용 표시 + 수정 폼 --%>
                    <div class="reply-content">${inquiry.replyContent}</div>
                    <div style="margin-top:14px;color:var(--text-sub);font-size:12px">
                        답변을 수정하려면 아래에 다시 입력하세요.
                    </div>
                </c:when>
            </c:choose>

            <form action="${contextPath}/admin/inquiryReply" method="post" id="replyForm">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="inquiryId" value="${inquiry.inquiryId}">
                <textarea name="replyContent" class="form-textarea"
                          style="min-height:120px;margin-top:12px"
                          placeholder="답변 내용을 입력하세요.">${inquiry.replyContent}</textarea>
                <div class="btn-group" style="margin-top:12px">
                    <button type="button" class="btn btn-outline"
                            onclick="location.href='${contextPath}/admin/inquiryList'">목록</button>
                    <form action="${contextPath}/admin/inquiryDelete" method="post" style="display:inline">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <input type="hidden" name="inquiryId" value="${inquiry.inquiryId}">
                        <button type="submit" class="btn btn-danger"
                                onclick="return confirm('문의를 삭제하시겠습니까?')">삭제</button>
                    </form>
                    <button type="submit" class="btn btn-primary"
                            onclick="return confirmReply()">
                        <c:choose>
                            <c:when test="${inquiry.replyYn == 'Y'}">답변 수정</c:when>
                            <c:otherwise>답변 등록</c:otherwise>
                        </c:choose>
                    </button>
                </div>
            </form>
        </div>
    </div>

</main>

<div class="toast" id="toast"></div>
<script>
    function confirmReply() {
        const content = document.querySelector('textarea[name="replyContent"]').value.trim();
        if (!content) {
            alert('답변 내용을 입력해주세요.');
            return false;
        }
        return confirm('답변을 등록하시겠습니까?');
    }

    function showToast(msg) {
        const t = document.getElementById('toast');
        t.textContent = msg;
        t.classList.add('show');
        setTimeout(() => t.classList.remove('show'), 2400);
    }
    <c:if test="${not empty successMsg}">
        window.onload = () => showToast('✅ ${successMsg}');
    </c:if>
    <c:if test="${not empty errorMsg}">
        window.onload = () => showToast('⚠️ ${errorMsg}');
    </c:if>
</script>
</body>
</html>
