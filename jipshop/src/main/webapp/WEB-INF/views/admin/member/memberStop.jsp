<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<% request.setAttribute("currentMenu", "member"); %>
<!DOCTYPE html>
<html lang="ko">
<c:set var="contextPath" value="${pageContext.request.contextPath}" scope="application"/>
<head>
    <meta charset="UTF-8">
    <title>탈퇴 처리 - 집사상권</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/admin.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/member/memberStop.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>

<main class="main">

    <div class="page-title">탈퇴 처리</div>

    <%-- 대상 회원 정보 --%>
    <div class="target-member-card">
        <div class="target-avatar">${fn:substring(member.memberName, 0, 1)}</div>
        <div class="target-info">
            <div class="target-name">
                ${member.memberName}
                <span class="font-mono" style="font-size:13px;color:var(--text-sub);font-weight:400">
                    (${member.memberId})
                </span>
            </div>
            <div class="target-meta">${member.phone} · ${member.email}</div>
            <div class="target-meta">가입일 <fmt:formatDate value="${member.joinDate}" pattern="yyyy-MM-dd"/></div>
        </div>
        <div>
            <c:choose>
                <c:when test="${member.activeYn == 'Y'}">
                    <span class="badge badge-active">현재 활성</span>
                </c:when>
                <c:otherwise>
                    <span class="badge badge-banned">탈퇴</span>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <%-- 탈퇴 처리 폼 --%>
    <div class="detail-card">
        <div class="detail-card-header">⚠️ 회원 탈퇴 처리</div>
        <div class="detail-card-body">
            <form action="${contextPath}/admin/memberWithdraw" method="post"
                  id="withdrawForm" onsubmit="return confirmWithdraw()">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="memberNo" value="${member.memberNo}">

                <div class="form-row">
                    <label class="form-label required">탈퇴 사유</label>
                    <input type="text" name="withdrawReason" id="withdrawReason"
                           class="form-input" placeholder="탈퇴 처리 사유를 입력하세요." required>
                </div>

                <div class="danger-box">
                    <strong>⚠️ 탈퇴 처리 전 반드시 확인하세요</strong>
                    <ul>
                        <li>탈퇴 처리 시 <code>MEMBER_ACTIVE_YN = 'N'</code> 으로 변경됩니다.</li>
                        <li>탈퇴 후 해당 계정으로 로그인이 불가합니다.</li>
                        <li>주문, 리뷰 등 기존 데이터는 보존됩니다.</li>
                    </ul>
                </div>

                <div class="form-row">
                    <label class="form-label">확인 입력</label>
                    <input type="text" id="withdrawConfirmInput" class="form-input w-md"
                           placeholder="'탈퇴처리' 입력 후 처리 가능">
                    <span class="form-hint" style="color:var(--red)">'탈퇴처리' 를 입력해야 처리됩니다.</span>
                </div>

                <div class="btn-group">
                    <button type="button" class="btn btn-outline"
                            onclick="location.href='${contextPath}/admin/memberDetail?memberNo=${member.memberNo}'">
                        취소
                    </button>
                    <button type="submit" class="btn btn-danger">⚠️ 탈퇴 처리</button>
                </div>
            </form>
        </div>
    </div>

</main>

<div class="toast" id="toast"></div>

<script>
    function confirmWithdraw() {
        const reason = document.getElementById('withdrawReason').value.trim();
        const confirmInput = document.getElementById('withdrawConfirmInput').value.trim();

        if (!reason) {
            alert('탈퇴 사유를 입력해주세요.');
            document.getElementById('withdrawReason').focus();
            return false;
        }
        if (confirmInput !== '탈퇴처리') {
            alert("'탈퇴처리' 를 정확히 입력해주세요.");
            document.getElementById('withdrawConfirmInput').focus();
            return false;
        }
        return confirm('정말로 탈퇴 처리하시겠습니까?\n이 작업은 되돌릴 수 없습니다.');
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
</script>
</body>
</html>
