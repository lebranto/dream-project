<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    request.setAttribute("currentMenu", "orderList");
%>
<!DOCTYPE html>
<html lang="ko">
<c:set var="contextPath" value="${pageContext.request.contextPath}" scope="application" />
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 관리 - 집사상권</title>
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
        주문 관리
        <span class="page-title-badge">총 ${totalCount}건</span>
    </div>

    <%-- 통계 카드 --%>
    <div class="stats-bar">
        <div class="stat-card">
            <div class="stat-label">전체 주문</div>
            <div class="stat-value">${totalCount}</div>
            <div class="stat-sub">조회 기간 기준</div>
        </div>
        <div class="stat-card">
            <div class="stat-label">배송 중</div>
            <div class="stat-value text-blue">${shippingCount}</div>
            <div class="stat-sub">진행 중</div>
        </div>
        <div class="stat-card">
            <div class="stat-label">배송 완료</div>
            <div class="stat-value text-green">${deliveredCount}</div>
            <div class="stat-sub">완료</div>
        </div>
        <div class="stat-card">
            <div class="stat-label">취소 요청</div>
            <div class="stat-value text-red">${cancelReqCount}</div>
            <div class="stat-sub">처리 필요</div>
        </div>
    </div>

    <%-- 검색 필터 --%>
    <form id="searchForm" action="/admin/orderList.do" method="get">
        <div class="filter-bar">
            <span class="filter-label">기간</span>
            <input type="date" name="startDate" class="filter-input" value="${param.startDate}">
            <span class="filter-sep">~</span>
            <input type="date" name="endDate" class="filter-input" value="${param.endDate}">
            <select name="orderStatus" class="filter-select">
                <option value="">전체 상태</option>
                <option value="PAY" <c:if test="${param.orderStatus == 'PAY'}">selected</c:if>>결제 완료</option>
                <option value="SHIP" <c:if test="${param.orderStatus == 'SHIP'}">selected</c:if>>배송 중</option>
                <option value="DONE" <c:if test="${param.orderStatus == 'DONE'}">selected</c:if>>배송 완료</option>
                <option value="REQ_CANCEL" <c:if test="${param.orderStatus == 'REQ_CANCEL'}">selected</c:if>>취소 요청</option>
            </select>
            <input type="text" name="keyword" class="filter-input"
                   placeholder="구매자명 또는 주문번호" value="${param.keyword}" style="flex:1; min-width:160px;">
            <button type="submit" class="btn btn-primary">조회</button>
            <button type="button" class="btn btn-outline" onclick="resetSearch()">초기화</button>
        </div>
    </form>

    <%-- 툴바 --%>
    <form id="bulkForm" action="/admin/orderBulkAction.do" method="post">
        <input type="hidden" name="action" id="bulkAction">

        <div class="toolbar">
            <div class="toolbar-left">
                <span class="bulk-info" id="bulkInfo">0건 선택됨</span>
                <button type="button" class="btn btn-outline btn-sm" id="btnBulkConfirm"
                        style="display:none" onclick="submitBulk('confirm')">✅ 일괄 확인</button>
                <button type="button" class="btn btn-danger btn-sm" id="btnBulkCancel"
                        style="display:none" onclick="submitBulk('cancel')">❌ 일괄 취소</button>
            </div>
            <div class="toolbar-right">
                <button type="button" class="btn btn-outline btn-sm"
                        onclick="location.href='/admin/orderExcel.do'">📥 엑셀 다운로드</button>
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
                        <th>연락처</th>
                        <th>주문번호</th>
                        <th>상품명</th>
                        <th>주문금액</th>
                        <th class="center">배송 여부</th>
                        <th class="center">취소 요청</th>
                        <th>주문 상태</th>
                        <th class="center">액션</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty orderList}">
                            <tr>
                                <td colspan="11" class="center" style="padding:30px; color:var(--text-sub);">
                                    조회된 주문이 없습니다.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="order" items="${orderList}" varStatus="status">
                                <tr>
                                    <td class="center">
                                        <input type="checkbox" name="orderIds"
                                               value="${order.orderId}"
                                               class="rowCheck" onchange="updateBulk()">
                                    </td>
                                    <td>${totalCount - (currentPage - 1) * pageSize - status.index}</td>
                                    <td><strong>${order.ordererName}</strong></td>
                                    <td class="font-mono" style="color:var(--text-sub)">${order.ordererPhone}</td>
                                    <td class="font-mono">${order.orderId}</td>
                                    <td>${order.orderTotalPrice}</td>
                                    <td class="font-bold">
                                        <fmt:formatNumber value="${order.orderTotalPrice}" pattern="#,###"/>원
                                    </td>
                                    <td class="center">
                                        <c:choose>
                                            <c:when test="${order.deliveryYn == 'Y'}">
                                                <span class="badge badge-done">완료</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-waiting">미완료</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="center">
                                        <c:choose>
                                            <c:when test="${order.cancelYn == 'Y'}">
                                                <span class="badge badge-cancel">요청</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-done">없음</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${order.orderStatus == 'DONE'}">
                                                <span class="badge badge-done">배송완료</span>
                                            </c:when>
                                            <c:when test="${order.orderStatus == 'SHIP'}">
                                                <span class="badge badge-shipping">배송 중</span>
                                            </c:when>
                                            <c:when test="${order.orderStatus == 'PAY'}">
                                                <span class="badge badge-waiting">결제 완료</span>
                                            </c:when>
                                            <c:when test="${order.orderStatus == 'REQ_CANCEL'}">
                                                <span class="badge badge-cancel">취소 요청</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-waiting">${order.orderStatus}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="center">
                                        <button type="button" class="btn btn-outline btn-sm"
                                                onclick="location.href='/admin/orderDetail.do?orderId=${order.orderId}'">
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
                    <a class="page-num" href="/admin/orderList.do?page=${currentPage-1}&startDate=${param.startDate}&endDate=${param.endDate}&orderStatus=${param.orderStatus}&keyword=${param.keyword}">◀</a>
                </c:if>
                <c:forEach begin="${startPage}" end="${endPage}" var="p">
                    <a class="page-num ${p == currentPage ? 'active' : ''}"
                       href="/admin/orderList.do?page=${p}&startDate=${param.startDate}&endDate=${param.endDate}&orderStatus=${param.orderStatus}&keyword=${param.keyword}">
                        ${p}
                    </a>
                </c:forEach>
                <c:if test="${currentPage < totalPages}">
                    <a class="page-num" href="/admin/orderList.do?page=${currentPage+1}&startDate=${param.startDate}&endDate=${param.endDate}&orderStatus=${param.orderStatus}&keyword=${param.keyword}">▶</a>
                </c:if>
            </div>
        </div>
    </form>

</main>

<%-- 토스트 --%>
<div class="toast" id="toast"></div>

<script>
    /* 전체 선택 */
    function toggleAll() {
        const master = document.getElementById('checkAll');
        document.querySelectorAll('.rowCheck').forEach(c => c.checked = master.checked);
        updateBulk();
    }

    /* 선택 카운트 업데이트 */
    function updateBulk() {
        const checked = document.querySelectorAll('.rowCheck:checked');
        const count = checked.length;
        const bulkInfo = document.getElementById('bulkInfo');

        bulkInfo.textContent = count + '건 선택됨';
        bulkInfo.classList.toggle('visible', count > 0);
        document.getElementById('btnBulkConfirm').style.display = count > 0 ? '' : 'none';
        document.getElementById('btnBulkCancel').style.display  = count > 0 ? '' : 'none';
    }

    /* 일괄 처리 */
    function submitBulk(action) {
        const checked = document.querySelectorAll('.rowCheck:checked');
        if (checked.length === 0) return;
        const msg = action === 'confirm' ? '확인 처리' : '취소 처리';
        if (!confirm(checked.length + '건을 ' + msg + ' 하시겠습니까?')) return;
        document.getElementById('bulkAction').value = action;
        document.getElementById('bulkForm').submit();
    }

    /* 검색 초기화 */
    function resetSearch() {
        location.href = '/admin/orderList.do';
    }

    /* 토스트 */
    function showToast(msg) {
        const t = document.getElementById('toast');
        t.textContent = msg;
        t.classList.add('show');
        setTimeout(() => t.classList.remove('show'), 2400);
    }

    /* 서버에서 전달된 메시지 표시 */
    <c:if test="${not empty successMsg}">
        window.onload = () => showToast('✅ ${successMsg}');
    </c:if>
</script>
</body>
</html>
