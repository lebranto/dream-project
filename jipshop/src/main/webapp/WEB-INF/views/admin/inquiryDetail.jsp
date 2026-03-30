<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setAttribute("currentMenu", "inquiryList"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>문의 상세 - 집사상점</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/inquiryDetail.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>

<main class="main">
    <div class="page-title">문의 내역</div>

    <%-- 문의 정보 --%>
    <div class="detail-card">
        <div class="detail-card-header">📋 문의 정보</div>
        <dl class="detail-grid">
            <dt>작성자</dt>
            <dd><strong>${inquiry.writerName}</strong></dd>
            <dt>유형</dt>
            <dd><span class="badge badge-waiting">${inquiry.inquiryType}</span></dd>
            <dt>작성일</dt>
            <dd>${inquiry.createdDate}</dd>
            <dt>처리 상태</dt>
            <dd>
                <c:choose>
                    <c:when test="${inquiry.processStatus == 'Y'}">
                        <span class="badge badge-done">처리 완료</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge badge-pending">미처리</span>
                    </c:otherwise>
                </c:choose>
            </dd>
        </dl>
    </div>

    <%-- 문의 본문 --%>
    <div class="section-label">문의 내용</div>
    <div class="content-box" style="margin-bottom:20px">
        ${inquiry.inquiryContent}
    </div>

    <%-- 첨부 이미지 --%>
    <c:if test="${not empty inquiry.imageUrl}">
        <div class="section-label">첨부 이미지</div>
        <div style="margin-bottom:20px">
            <img src="${inquiry.imageUrl}" alt="첨부 이미지"
                 style="max-width:400px; border-radius:8px; border:1px solid var(--border)">
        </div>
    </c:if>

    <%-- 답변 작성 / 표시 --%>
    <div class="section-label">관리자 답변</div>
    <c:choose>
        <c:when test="${not empty inquiry.replyContent}">
            <%-- 이미 답변이 있는 경우 --%>
            <div class="content-box reply" style="margin-bottom:20px">
                ${inquiry.replyContent}
            </div>
            <div class="btn-group">
                <button type="button" class="btn btn-outline"
                        onclick="location.href='/admin/inquiryList.do'">목록</button>
                <button type="button" class="btn btn-warning"
                        onclick="toggleEditReply()">답변 수정</button>
            </div>

            <%-- 수정 폼 (기본 숨김) --%>
            <div id="editReplyWrap" style="display:none; margin-top:14px">
                <form action="/admin/inquiryReply.do" method="post">
                    <input type="hidden" name="inquiryId" value="${inquiry.inquiryId}">
                    <input type="hidden" name="action"    value="update">
                    <textarea name="replyContent" class="form-textarea"
                              style="margin-bottom:10px">${inquiry.replyContent}</textarea>
                    <div class="btn-group">
                        <button type="button" class="btn btn-outline" onclick="toggleEditReply()">취소</button>
                        <button type="submit" class="btn btn-primary">수정 완료</button>
                    </div>
                </form>
            </div>
        </c:when>
        <c:otherwise>
            <%-- 아직 답변 없는 경우 --%>
            <form action="/admin/inquiryReply.do" method="post">
                <input type="hidden" name="inquiryId" value="${inquiry.inquiryId}">
                <input type="hidden" name="action"    value="create">
                <textarea name="replyContent" class="form-textarea"
                          placeholder="답변 내용을 입력하세요."
                          style="margin-bottom:10px"></textarea>
                <div class="btn-group">
                    <button type="button" class="btn btn-outline"
                            onclick="location.href='/admin/inquiryList.do'">목록</button>
                    <button type="submit" class="btn btn-primary">답변 등록</button>
                </div>
            </form>
        </c:otherwise>
    </c:choose>

</main>
<div class="toast" id="toast"></div>
<script>
    function toggleEditReply(){
        const w=document.getElementById('editReplyWrap');
        w.style.display=w.style.display==='none'?'block':'none';
    }
    function showToast(msg){const t=document.getElementById('toast');t.textContent=msg;t.classList.add('show');setTimeout(()=>t.classList.remove('show'),2400);}
    <c:if test="${not empty successMsg}">window.onload=()=>showToast('✅ ${successMsg}');</c:if>
</script>
</body>
</html>
