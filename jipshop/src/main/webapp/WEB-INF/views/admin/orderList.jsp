<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    request.setAttribute("currentMenu", "orderList");
%>
<!DOCTYPE html>
<html lang="ko">
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 관리 - 집사상권</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/admin.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/orderList.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/admin/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>

<main class="main">

    <div class="page-title">
        주문 관리
        <span class="page-title-badge">총 ${pi.listCount}건</span>
    </div>

    <div class="stats-bar">
        <div class="stat-card">
            <div class="stat-label">전체 주문</div>
            <div class="stat-value">${pi.listCount}</div>
            <div class="stat-sub">조회 결과</div>
        </div>
        <div class="stat-card">
            <div class="stat-label">결제 완료</div>
            <div class="stat-value">${payCount}</div>
            <div class="stat-sub">배송 대기</div>
        </div>
        <div class="stat-card">
            <div class="stat-label">출고 완료</div>
            <div class="stat-value">${outCount}</div>
            <div class="stat-sub">상품 인계 완료</div>
        </div>
        <div class="stat-card">
            <div class="stat-label">배송 중</div>
            <div class="stat-value">${shippingCount}</div>
            <div class="stat-sub">배송 진행</div>
        </div>
        <div class="stat-card">
            <div class="stat-label">배송 완료</div>
            <div class="stat-value">${deliveredCount}</div>
            <div class="stat-sub">배송 종료</div>
        </div>
        <div class="stat-card">
            <div class="stat-label">취소 요청</div>
            <div class="stat-value">${cancelReqCount}</div>
            <div class="stat-sub">처리 필요</div>
        </div>
    </div>

    <form id="searchForm" action="${contextPath}/admin/order/list" method="get">
        <input type="hidden" name="currentPage" value="1">

        <div class="filter-bar">
            <span class="filter-label">기간</span>
            <input type="date" name="startDate" class="filter-input" value="${param.startDate}">
            <span class="filter-sep">~</span>
            <input type="date" name="endDate" class="filter-input" value="${param.endDate}">

            <select name="orderStatus" class="filter-select">
                <option value="">전체 상태</option>
                <option value="PAY" <c:if test="${param.orderStatus == 'PAY'}">selected</c:if>>결제 완료</option>
                <option value="OUT" <c:if test="${param.orderStatus == 'OUT'}">selected</c:if>>출고 완료</option>
                <option value="SHIP" <c:if test="${param.orderStatus == 'SHIP'}">selected</c:if>>배송 중</option>
                <option value="DONE" <c:if test="${param.orderStatus == 'DONE'}">selected</c:if>>배송 완료</option>
                <option value="REQ_CANCEL" <c:if test="${param.orderStatus == 'REQ_CANCEL'}">selected</c:if>>취소 요청</option>
            </select>

            <input type="text" name="keyword" class="filter-input"
                   placeholder="주문번호 / 주문자 / 상품명"
                   value="${param.keyword}"
                   style="flex:1; min-width:180px;">

            <button type="submit" class="btn btn-primary">조회</button>
            <button type="button" class="btn btn-outline" onclick="resetSearch()">초기화</button>
        </div>
    </form>

    <form id="bulkForm" action="${contextPath}/admin/order/delete" method="post">
        <div class="toolbar">
            <div class="toolbar-left">
                <span class="bulk-info" id="bulkInfo">0건 선택됨</span>
                <button type="button" class="btn btn-danger btn-sm" id="btnBulkDelete"
                        style="display:none;" onclick="submitBulk()">일괄 삭제</button>
            </div>
        </div>

        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th class="center"><input type="checkbox" id="checkAll" onchange="toggleAll()"></th>
                        <th>번호</th>
                        <th>주문번호</th>
                        <th>주문자</th>
                        <th>연락처</th>
                        <th>대표상품</th>
                        <th>주문금액</th>
                        <th class="center">배송여부</th>
                        <th class="center">취소요청</th>
                        <th class="center">주문상태</th>
                        <th class="center">상세</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty orderList}">
                            <tr class="empty-row">
                                <td colspan="11">조회된 주문이 없습니다.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="order" items="${orderList}" varStatus="status">
                                <tr>
                                    <td class="center">
                                        <input type="checkbox" class="rowCheck" name="orderIds"
                                               value="${order.orderId}" onchange="updateBulk()">
                                    </td>
                                    <td>${(pi.currentPage - 1) * pi.boardLimit + status.count}</td>
                                    <td>${order.orderId}</td>
                                    <td>${order.ordererName}</td>
                                    <td>${order.ordererPhone}</td>
                                    <td>${order.productName}</td>
                                    <td class="td-num">
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
                                            <c:when test="${order.orderCancelYn == 'Y' and order.cancelStatus == 'PENDING'}">
                                                <span class="badge badge-cancel">요청</span>
                                            </c:when>
                                            <c:when test="${order.orderCancelYn == 'Y' and order.cancelStatus == 'APPROVED'}">
                                                <span class="badge badge-cancel">완료</span>
                                            </c:when>
                                            <c:when test="${order.orderCancelYn == 'Y' and order.cancelStatus == 'REJECTED'}">
                                                <span class="badge badge-waiting">반려</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-done">없음</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="center">
                                        <c:choose>
                                            <c:when test="${order.orderStatusLabel == '결제 완료'}">
                                                <span class="badge badge-waiting">결제 완료</span>
                                            </c:when>
                                            <c:when test="${order.orderStatusLabel == '출고 완료'}">
                                                <span class="badge badge-out">출고 완료</span>
                                            </c:when>
                                            <c:when test="${order.orderStatusLabel == '배송 중'}">
                                                <span class="badge badge-shipping">배송 중</span>
                                            </c:when>
                                            <c:when test="${order.orderStatusLabel == '배송완료'}">
                                                <span class="badge badge-done">배송완료</span>
                                            </c:when>
                                            <c:when test="${order.orderStatusLabel == '취소 요청'}">
                                                <span class="badge badge-cancel">취소 요청</span>
                                            </c:when>
                                            <c:when test="${order.orderStatusLabel == '취소 완료'}">
                                                <span class="badge badge-cancel">취소 완료</span>
                                            </c:when>
                                            <c:when test="${order.orderStatusLabel == '취소 반려'}">
                                                <span class="badge badge-waiting">취소 반려</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-waiting">${order.orderStatusLabel}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="center">
                                        <button type="button" class="btn btn-outline btn-sm"
                                                onclick="location.href='${contextPath}/admin/order/orderDetail?orderId=${order.orderId}'">
                                            상세
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

            <div class="pagination">
                <c:if test="${pi.currentPage > 1}">
                    <a class="page-num"
                       href="${contextPath}/admin/order/list?currentPage=${pi.currentPage - 1}&startDate=${param.startDate}&endDate=${param.endDate}&orderStatus=${param.orderStatus}&keyword=${param.keyword}">◀</a>
                </c:if>

                <c:forEach begin="${pi.startPage}" end="${pi.endPage}" var="p">
                    <a class="page-num ${p == pi.currentPage ? 'active' : ''}"
                       href="${contextPath}/admin/order/list?currentPage=${p}&startDate=${param.startDate}&endDate=${param.endDate}&orderStatus=${param.orderStatus}&keyword=${param.keyword}">
                        ${p}
                    </a>
                </c:forEach>

                <c:if test="${pi.currentPage < pi.maxPage}">
                    <a class="page-num"
                       href="${contextPath}/admin/order/list?currentPage=${pi.currentPage + 1}&startDate=${param.startDate}&endDate=${param.endDate}&orderStatus=${param.orderStatus}&keyword=${param.keyword}">▶</a>
                </c:if>
            </div>
        </div>
    </form>
</main>

<div class="toast" id="toast"></div>

<script>
function toggleAll() {
    const master = document.getElementById("checkAll");
    document.querySelectorAll(".rowCheck").forEach(chk => chk.checked = master.checked);
    updateBulk();
}

function updateBulk() {
    const count = document.querySelectorAll(".rowCheck:checked").length;
    const bulkInfo = document.getElementById("bulkInfo");
    const btnBulkDelete = document.getElementById("btnBulkDelete");

    bulkInfo.textContent = count + "건 선택됨";
    bulkInfo.classList.toggle("visible", count > 0);
    btnBulkDelete.style.display = count > 0 ? "inline-flex" : "none";
}

function submitBulk() {
    const count = document.querySelectorAll(".rowCheck:checked").length;
    if (count === 0) {
        alert("선택된 주문이 없습니다.");
        return;
    }

    if (!confirm(count + "건의 주문을 삭제하시겠습니까?")) {
        return;
    }

    document.getElementById("bulkForm").submit();
}

function resetSearch() {
    location.href = "${contextPath}/admin/order/list";
}

function showToast(msg) {
    const t = document.getElementById("toast");
    t.textContent = msg;
    t.classList.add("show");
    setTimeout(() => t.classList.remove("show"), 2200);
}

<c:if test="${not empty successMsg}">
window.onload = function() {
    showToast("${successMsg}");
};
</c:if>
</script>
</body>
</html>