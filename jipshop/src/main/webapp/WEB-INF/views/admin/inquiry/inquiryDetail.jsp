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
                <%-- 답변 완료 상태: 내용 표시 + 수정 버튼 --%>
                <c:when test="${inquiry.replyYn == 'Y'}">
                    <div class="reply-box" id="replyView">
                        <div class="reply-content">${inquiry.replyContent}</div>
                        <div class="btn-group" style="margin-top:12px">
                        	<button type="button" class="btn btn-outline"
                					onclick="location.href='${contextPath}/admin/inquiryList'">목록</button>
                            <button type="button" class="btn btn-outline btn-sm"
                                    onclick="toggleEdit(true)">✏️ 수정</button>
                        </div>
                    </div>

                    <%-- 수정 폼 (기본 숨김) --%>
                    <form action="${contextPath}/admin/inquiryReply" method="post"
                          id="replyEditForm" style="display:none" onsubmit="return confirmReply()">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <input type="hidden" name="inquiryId" value="${inquiry.inquiryId}">
                        <textarea id="replyEditContent" name="replyContent" class="form-textarea"
                                  style="min-height:120px">${inquiry.replyContent}</textarea>
                        <div class="btn-group" style="margin-top:12px">
                            <button type="button" class="btn btn-outline"
                                    onclick="toggleEdit(false)">취소</button>
                            <button type="submit" class="btn btn-primary">수정 완료</button>
                        </div>
                    </form>
                </c:when>

                <%-- 미처리 상태: 답변 등록 폼 --%>
                <c:otherwise>
                    <form action="${contextPath}/admin/inquiryReply" method="post"
                          onsubmit="return confirmReply()">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <input type="hidden" name="inquiryId" value="${inquiry.inquiryId}">
                        <textarea id="replyContent" name="replyContent" class="form-textarea"
                                  style="min-height:120px"
                                  placeholder="답변 내용을 입력하세요."></textarea>
                        <div class="btn-group" style="margin-top:12px">
                        	<button type="button" class="btn btn-outline"
                					onclick="location.href='${contextPath}/admin/inquiryList'">목록</button>
                            <button type="submit" class="btn btn-primary">답변 등록</button>
                        </div>
                    </form>
                </c:otherwise>
            </c:choose>

        </div>
    </div>

</main>

<div class="toast" id="toast"></div>
<script>
    function toggleEdit(show) {
        document.getElementById('replyView').style.display     = show ? 'none' : '';
        document.getElementById('replyEditForm').style.display = show ? '' : 'none';
    }

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
