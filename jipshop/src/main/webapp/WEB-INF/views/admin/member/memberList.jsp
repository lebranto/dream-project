<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<% request.setAttribute("currentMenu", "member"); %>
<!DOCTYPE html>
<html lang="ko">
<c:set var="contextPath" value="${pageContext.request.contextPath}" scope="application" />
<head>
    <meta charset="UTF-8">
    <title>회원 관리 - 집사상점</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/admin.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/member/memberList.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>

<main class="main">

    <div class="page-title">
        회원 관리
        <span class="page-title-badge">총 ${totalCount}명</span>
    </div>

    <%-- 통계 카드 --%>
    <div class="stats-bar">
        <div class="stat-card">
            <div class="stat-label">전체 회원</div>
            <div class="stat-value">${totalCount}</div>
            <div class="stat-sub">등록 회원 수</div>
        </div>
        <div class="stat-card">
            <div class="stat-label">활성</div>
            <div class="stat-value text-green">${activeCount}</div>
            <div class="stat-sub">정상 이용 중</div>
        </div>
        <div class="stat-card">
            <div class="stat-label">정지</div>
            <div class="stat-value text-red">${bannedCount}</div>
            <div class="stat-sub">이용 정지</div>
        </div>
    </div>

    <%-- 검색 필터 --%>
    <form action="/admin/memberList" method="get" id="searchForm">
        <div class="filter-bar">
            <span class="filter-label">가입일</span>
            <input type="date" name="startDate" class="filter-input" value="${param.startDate}">
            <span class="filter-sep">~</span>
            <input type="date" name="endDate"   class="filter-input" value="${param.endDate}">
            <select name="memberStatus" class="filter-select">
                <option value="">전체 상태</option>
                <option value="Y" <c:if test="${param.memberStatus=='Y'}">selected</c:if>>활성</option>
                <option value="N" <c:if test="${param.memberStatus=='N'}">selected</c:if>>정지</option>
            </select>
            <input type="text" name="keyword" class="filter-input"
                   placeholder="이름 / 아이디 / 이메일 / 연락처"
                   value="${param.keyword}" style="flex:1; min-width:180px;">
            <button type="submit" class="btn btn-primary">조회</button>
            <button type="button" class="btn btn-outline"
                    onclick="location.href='/admin/memberList'">초기화</button>
        </div>
    </form>

    <%-- 툴바 --%>
    <div class="toolbar">
        <div class="toolbar-left">
            <span class="bulk-info" id="bulkInfo">0명 선택됨</span>
            <button type="button" class="btn btn-danger btn-sm" id="btnBulkBan"
                    style="display:none" onclick="bulkAction('ban')">🚫 일괄 정지</button>
            <button type="button" class="btn btn-success btn-sm" id="btnBulkActive"
                    style="display:none" onclick="bulkAction('active')">✅ 일괄 활성</button>
        </div>
    </div>

    <%-- 일괄 처리 폼 --%>
    <form id="bulkForm" action="/admin/memberBulkAction" method="post">
        <input type="hidden" name="action"    id="bulkActionInput">
        <input type="hidden" name="returnUrl" value="/admin/memberList?startDate=${param.startDate}&endDate=${param.endDate}&memberStatus=${param.memberStatus}&keyword=${param.keyword}&page=${currentPage}">

        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th class="center">
                            <input type="checkbox" id="checkAll" onchange="toggleAll()">
                        </th>
                        <th>번호</th>
                        <th>아이디</th>
                        <th>이름</th>
                        <th>연락처</th>
                        <th>이메일</th>
                        <th>주소</th>
                        <th>가입일</th>
                        <th class="center">상태</th>
                        <th class="center">액션</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty memberList}">
                            <tr class="empty-row"><td colspan="10">조회된 회원이 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="m" items="${memberList}" varStatus="s">
                                <tr>
                                    <td class="center">
                                        <input type="checkbox" name="memberNos"
                                               value="${m.memberNo}"
                                               class="rowCheck" onchange="updateBulk()">
                                    </td>
                                    <td>${totalCount - (currentPage-1)*pageSize - s.index}</td>
                                    <td class="font-mono">${m.memberId}</td>
                                    <td><strong>${m.memberName}</strong></td>
                                    <td class="font-mono" style="color:var(--text-sub)">${m.phone}</td>
                                    <td style="color:var(--text-sub)">${m.email}</td>
                                    <td class="td-ellipsis">${m.address}</td>
                                    <td style="color:var(--text-sub)"><fmt:formatDate value="${m.joinDate}" pattern="yyyy-MM-dd"/></td>
                                    <td class="center">
                                        <c:choose>
                                            <c:when test="${m.activeYn == 'Y'}">
                                                <span class="badge badge-active">활성</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-banned">정지</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="center">
                                        <button type="button" class="btn btn-outline btn-sm"
                                                onclick="location.href='${contextPath}/admin/memberDetail?memberNo=${m.memberNo}'">
                                            상세
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

            <%-- 페이지네이션 --%>
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a class="page-num" href="?page=${currentPage-1}&startDate=${param.startDate}&endDate=${param.endDate}&memberStatus=${param.memberStatus}&keyword=${param.keyword}">◀</a>
                </c:if>
                <c:forEach begin="${startPage}" end="${endPage}" var="p">
                    <a class="page-num <c:if test="${p==currentPage}">active</c:if>"
                       href="?page=${p}&startDate=${param.startDate}&endDate=${param.endDate}&memberStatus=${param.memberStatus}&keyword=${param.keyword}">${p}</a>
                </c:forEach>
                <c:if test="${currentPage < totalPages}">
                    <a class="page-num" href="?page=${currentPage+1}&startDate=${param.startDate}&endDate=${param.endDate}&memberStatus=${param.memberStatus}&keyword=${param.keyword}">▶</a>
                </c:if>
            </div>
        </div>
    </form>

</main>

<div class="toast" id="toast"></div>

<script>
    /* ── 전체 선택 ── */
    function toggleAll() {
        const master = document.getElementById('checkAll');
        document.querySelectorAll('.rowCheck').forEach(c => c.checked = master.checked);
        updateBulk();
    }

    /* ── 선택 카운트 ── */
    function updateBulk() {
        const n = document.querySelectorAll('.rowCheck:checked').length;
        const info = document.getElementById('bulkInfo');
        info.textContent = n + '명 선택됨';
        info.classList.toggle('visible', n > 0);
        document.getElementById('btnBulkBan').style.display    = n > 0 ? '' : 'none';
        document.getElementById('btnBulkActive').style.display = n > 0 ? '' : 'none';
    }

    /* ── 일괄 처리 ── */
    function bulkAction(action) {
        const n = document.querySelectorAll('.rowCheck:checked').length;
        const msg = action === 'ban'
            ? n + '명을 이용 정지 처리하시겠습니까?'
            : n + '명을 활성 처리하시겠습니까?';
        if (!confirm(msg)) return;
        document.getElementById('bulkActionInput').value = action;
        document.getElementById('bulkForm').submit();
    }

    /* ── 토스트 ── */
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
