<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    request.setAttribute("currentMenu", "orderCancelList");
%>
<!DOCTYPE html>
<html lang="ko">
<c:set var="contextPath" value="${pageContext.request.contextPath}" scope="application" />
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문취소 관리 - 집사상권</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/admin.css">
</head>
<body>

<%-- 사이드바 --%>
<jsp:include page="/WEB-INF/views/admin/common/sidebar.jsp"/>

<%-- 헤더 --%>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>

<main class="main">

    <%-- 페이지 제목 --%>
    <div class="page-title">
        주문취소 관리
        <span class="page-title-badge">취소 요청 ${pendingCount}건</span>
    </div>

    <%-- 검색 필터 --%>
    <form id="searchForm" action="/admin/orderCancelList.do" method="get">
        <div class="filter-bar">
            <span class="filter-label">기간</span>
            <input type="date" name="startDate" class="filter-input" value="${param.startDate}">
            <span class="filter-sep">~</span>
            <input type="date" name="endDate" class="filter-input" value="${param.endDate}">
            <select name="cancelStatus" class="filter-select">
                <option value="">전체 상태</option>
                <option value="PENDING"  <c:if test="${param.cancelStatus == 'PENDING'}">selected</c:if>>승인 대기</option>
                <option value="APPROVED" <c:if test="${param.cancelStatus == 'APPROVED'}">selected</c:if>>취소 승인</option>
                <option value="REJECTED" <c:if test="${param.cancelStatus == 'REJECTED'}">selected</c:if>>취소 반려</option>
            </select>
            <input type="text" name="keyword" class="filter-input"
                   placeholder="구매자명 또는 주문번호" value="${param.keyword}" style="flex:1; min-width:160px;">
            <button type="submit" class="btn btn-primary">조회</button>
            <button type="button" class="btn btn-outline" onclick="resetSearch()">초기화</button>
        </div>
    </form>

    <%-- 일괄 처리 폼 --%>
    <form id="bulkForm" action="/admin/orderCancelBulkAction.do" method="post">
        <input type="hidden" name="action" id="bulkAction">

        <div class="toolbar">
            <div class="toolbar-left">
                <span class="bulk-info" id="bulkInfo">0건 선택됨</span>
                <button type="button" class="btn btn-success btn-sm" id="btnBulkApprove"
                        style="display:none" onclick="submitBulk('approve')">✅ 일괄 승인</button>
                <button type="button" class="btn btn-danger btn-sm" id="btnBulkReject"
                        style="display:none" onclick="openRejectModal('bulk')">🚫 일괄 반려</button>
            </div>
        </div>

        <%-- 테이블 --%>
        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th class="center">
                            <input type="checkbox" id="checkAll" onchange="toggleAll()">
                        </th>
                        <th>번호</th>
                        <th>구매자명</th>
                        <th>주문번호</th>
                        <th>상품명</th>
                        <th>취소 사유</th>
                        <th>취소 신청일</th>
                        <th>처리 상태</th>
                        <th class="center">재고 복구</th>
                        <th class="center">액션</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty cancelList}">
                            <tr>
                                <td colspan="10" class="center" style="padding:30px; color:var(--text-sub);">
                                    취소 요청 내역이 없습니다.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="cancel" items="${cancelList}" varStatus="status">
                                <tr>
                                    <td class="center">
                                        <%-- 승인 대기 건만 체크박스 활성화 --%>
                                        <c:choose>
                                            <c:when test="${cancel.cancelStatus == 'PENDING'}">
                                                <input type="checkbox" name="cancelIds"
                                                       value="${cancel.orderId}"
                                                       class="rowCheck" onchange="updateBulk()">
                                            </c:when>
                                            <c:otherwise>
                                                <input type="checkbox" disabled>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${totalCount - (currentPage - 1) * pageSize - status.index}</td>
                                    <td><strong>${cancel.ordererName}</strong></td>
                                    <td class="font-mono">${cancel.orderId}</td>
                                    <td>${cancel.productName}</td>
                                    <td>${cancel.cancelReason}</td>
                                    <td style="color:var(--text-sub)">${cancel.cancelRequestDate}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${cancel.cancelStatus == 'PENDING'}">
                                                <span class="badge badge-pending">승인 대기</span>
                                            </c:when>
                                            <c:when test="${cancel.cancelStatus == 'APPROVED'}">
                                                <span class="badge badge-done">취소 승인</span>
                                            </c:when>
                                            <c:when test="${cancel.cancelStatus == 'REJECTED'}">
                                                <span class="badge badge-rejected">취소 반려</span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td class="center">
                                        <c:choose>
                                            <c:when test="${cancel.stockRestoredYn == 'Y'}">
                                                <span class="badge badge-done">복구 완료</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-waiting">미복구</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="center">
                                        <c:choose>
                                            <c:when test="${cancel.cancelStatus == 'PENDING'}">
                                                <div class="td-actions">
                                                    <button type="button" class="btn btn-success btn-sm"
                                                            onclick="approveOne('${cancel.orderId}')">승인</button>
                                                    <button type="button" class="btn btn-danger btn-sm"
                                                            onclick="openRejectModal('${cancel.orderId}')">반려</button>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="font-size:12px; color:var(--text-sub)">처리 완료</span>
                                            </c:otherwise>
                                        </c:choose>
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
                    <a class="page-num" href="/admin/orderCancelList.do?page=${currentPage-1}&startDate=${param.startDate}&endDate=${param.endDate}&cancelStatus=${param.cancelStatus}&keyword=${param.keyword}">◀</a>
                </c:if>
                <c:forEach begin="${startPage}" end="${endPage}" var="p">
                    <a class="page-num ${p == currentPage ? 'active' : ''}"
                       href="/admin/orderCancelList.do?page=${p}&startDate=${param.startDate}&endDate=${param.endDate}&cancelStatus=${param.cancelStatus}&keyword=${param.keyword}">
                        ${p}
                    </a>
                </c:forEach>
                <c:if test="${currentPage < totalPages}">
                    <a class="page-num" href="/admin/orderCancelList.do?page=${currentPage+1}&startDate=${param.startDate}&endDate=${param.endDate}&cancelStatus=${param.cancelStatus}&keyword=${param.keyword}">▶</a>
                </c:if>
            </div>
        </div>
    </form>

</main>

<%-- 반려 모달 --%>
<div class="modal-overlay" id="rejectModal">
    <div class="modal">
        <div class="modal-title">🚫 취소 반려</div>
        <div class="modal-desc">
            선택한 취소 요청을 반려합니다.<br>
            반려 사유를 입력해주세요. 입력한 내용은 구매자에게 안내됩니다.
        </div>
        <div class="modal-field">
            <label>반려 사유 <span style="color:var(--red)">*</span></label>
            <textarea id="rejectReason" placeholder="예) 이미 배송이 시작되어 취소가 불가합니다."></textarea>
        </div>
        <div class="modal-actions">
            <button type="button" class="btn btn-outline" onclick="closeModal()">취소</button>
            <button type="button" class="btn btn-danger"  onclick="confirmReject()">반려 처리</button>
        </div>
    </div>
</div>

<%-- 단건 승인 폼 (hidden) --%>
<form id="singleForm" action="/admin/orderCancelAction.do" method="post">
    <input type="hidden" name="action"  id="singleAction">
    <input type="hidden" name="orderId" id="singleOrderId">
    <input type="hidden" name="rejectReason" id="singleRejectReason">
</form>

<%-- 토스트 --%>
<div class="toast" id="toast"></div>

<script>
    let rejectTarget = null; // 'bulk' 또는 단건 orderId

    /* ===== 전체 선택 ===== */
    function toggleAll() {
        const master = document.getElementById('checkAll');
        document.querySelectorAll('.rowCheck').forEach(c => c.checked = master.checked);
        updateBulk();
    }

    /* ===== 선택 카운트 업데이트 ===== */
    function updateBulk() {
        const checked = document.querySelectorAll('.rowCheck:checked');
        const count = checked.length;
        const bulkInfo = document.getElementById('bulkInfo');

        bulkInfo.textContent = count + '건 선택됨';
        bulkInfo.classList.toggle('visible', count > 0);
        document.getElementById('btnBulkApprove').style.display = count > 0 ? '' : 'none';
        document.getElementById('btnBulkReject').style.display  = count > 0 ? '' : 'none';
    }

    /* ===== 일괄 승인 ===== */
    function submitBulk(action) {
        const checked = document.querySelectorAll('.rowCheck:checked');
        if (checked.length === 0) return;
        if (!confirm(checked.length + '건을 승인 처리 하시겠습니까?\n재고가 자동으로 복구됩니다.')) return;
        document.getElementById('bulkAction').value = action;
        document.getElementById('bulkForm').submit();
    }

    /* ===== 단건 승인 ===== */
    function approveOne(orderId) {
        if (!confirm('해당 취소 요청을 승인하시겠습니까?\n재고가 자동으로 복구됩니다.')) return;
        document.getElementById('singleAction').value  = 'approve';
        document.getElementById('singleOrderId').value = orderId;
        document.getElementById('singleForm').submit();
    }

    /* ===== 반려 모달 열기 ===== */
    function openRejectModal(target) {
        rejectTarget = target;
        document.getElementById('rejectReason').value = '';
        document.getElementById('rejectReason').style.borderColor = '';
        document.getElementById('rejectModal').classList.add('open');
    }

    /* ===== 모달 닫기 ===== */
    function closeModal() {
        document.getElementById('rejectModal').classList.remove('open');
        rejectTarget = null;
    }

    /* ===== 반려 처리 확정 ===== */
    function confirmReject() {
        const reason = document.getElementById('rejectReason').value.trim();
        if (!reason) {
            document.getElementById('rejectReason').style.borderColor = 'var(--red)';
            return;
        }
        closeModal();

        if (rejectTarget === 'bulk') {
            // 일괄 반려
            const reasonInput = document.createElement('input');
            reasonInput.type  = 'hidden';
            reasonInput.name  = 'rejectReason';
            reasonInput.value = reason;
            document.getElementById('bulkForm').appendChild(reasonInput);
            document.getElementById('bulkAction').value = 'reject';
            document.getElementById('bulkForm').submit();
        } else {
            // 단건 반려
            document.getElementById('singleAction').value       = 'reject';
            document.getElementById('singleOrderId').value      = rejectTarget;
            document.getElementById('singleRejectReason').value = reason;
            document.getElementById('singleForm').submit();
        }
    }

    /* ===== 모달 배경 클릭 닫기 ===== */
    document.getElementById('rejectModal').addEventListener('click', function(e) {
        if (e.target === this) closeModal();
    });

    /* ===== 검색 초기화 ===== */
    function resetSearch() {
        location.href = '/admin/orderCancelList.do';
    }

    /* ===== 토스트 ===== */
    function showToast(msg) {
        const t = document.getElementById('toast');
        t.textContent = msg;
        t.classList.add('show');
        setTimeout(() => t.classList.remove('show'), 2400);
    }

    /* 서버 성공 메시지 */
    <c:if test="${not empty successMsg}">
        window.onload = () => showToast('✅ ${successMsg}');
    </c:if>
</script>
</body>
</html>
