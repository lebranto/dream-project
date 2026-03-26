<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    request.setAttribute("currentMenu", "orderCancel");
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

<jsp:include page="/WEB-INF/views/admin/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>

<main class="main">

    <div class="page-title">
        주문취소 관리
        <span class="page-title-badge">취소요청 ${pendingCount}건</span>
    </div>

    <form id="searchForm" action="${contextPath}/admin/orderCancel/list" method="get">
        <div class="filter-bar">
            <span class="filter-label">기간</span>
            <input type="date" name="startDate" class="filter-input" value="${search.startDate}">
            <span class="filter-sep">~</span>
            <input type="date" name="endDate" class="filter-input" value="${search.endDate}">

            <select name="cancelStatus" class="filter-select">
                <option value="">전체 상태</option>
                <option value="PENDING" <c:if test="${search.cancelStatus == 'PENDING'}">selected</c:if>>승인 대기</option>
                <option value="APPROVED" <c:if test="${search.cancelStatus == 'APPROVED'}">selected</c:if>>취소 승인</option>
                <option value="REJECTED" <c:if test="${search.cancelStatus == 'REJECTED'}">selected</c:if>>취소 반려</option>
            </select>

            <input type="text" name="keyword" class="filter-input"
                   placeholder="구매자명 또는 주문번호"
                   value="${search.keyword}"
                   style="flex:1; min-width:160px;">

            <button type="submit" class="btn btn-primary">조회</button>
            <button type="button" class="btn btn-outline" onclick="resetSearch()">초기화</button>
        </div>
    </form>

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
                    <th class="center">처리 상태</th>
                    <th class="center">재고 복구</th>
                    <th class="center">액션</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty list}">
                        <tr>
                            <td colspan="10" class="center" style="padding:30px; color:var(--text-sub);">
                                취소 요청 내역이 없습니다.
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="c" items="${list}" varStatus="status">
                            <tr>
                                <td class="center">
                                    <input type="checkbox" class="rowCheck" value="${c.orderId}">
                                </td>
                                <td>${pi.listCount - ((pi.currentPage - 1) * pi.boardLimit) - status.index}</td>
                                <td><strong>${c.ordererName}</strong></td>
                                <td class="font-mono">HG${c.orderId}</td>
                                <td>${c.productName}</td>
                                <td>${c.cancelReason}</td>
                                <td>${c.cancelRequestDateStr}</td>

                                <td class="center">
                                    <c:choose>
                                        <c:when test="${c.cancelStatus == 'PENDING'}">
                                            <span class="badge badge-waiting">승인 대기</span>
                                        </c:when>
                                        <c:when test="${c.cancelStatus == 'APPROVED'}">
                                            <span class="badge badge-done">취소 승인</span>
                                        </c:when>
                                        <c:when test="${c.cancelStatus == 'REJECTED'}">
                                            <span class="badge badge-cancel">취소 반려</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-waiting">${c.cancelStatusLabel}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="center">
                                    <c:choose>
                                        <c:when test="${c.cancelStatus == 'APPROVED'}">
                                            <span class="badge badge-done">복구 완료</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-waiting">미복구</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="center">
                                    <c:choose>
                                        <c:when test="${c.cancelStatus == 'PENDING'}">
                                            <form action="${contextPath}/admin/orderCancel/approve" method="post" style="display:inline;">
                                                <input type="hidden" name="orderId" value="${c.orderId}">
                                                <button type="submit" class="btn btn-success btn-sm">승인</button>
                                            </form>

                                            <form action="${contextPath}/admin/orderCancel/reject" method="post" style="display:inline;">
                                                <input type="hidden" name="orderId" value="${c.orderId}">
                                                <button type="submit" class="btn btn-danger btn-sm">반려</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            처리 완료
                                        </c:otherwise>
                                    </c:choose>
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
                   href="${contextPath}/admin/orderCancel/list?currentPage=${pi.currentPage - 1}&startDate=${search.startDate}&endDate=${search.endDate}&cancelStatus=${search.cancelStatus}&keyword=${search.keyword}">
                    ◀
                </a>
            </c:if>

            <c:forEach begin="${pi.startPage}" end="${pi.endPage}" var="p">
                <a class="page-num ${p == pi.currentPage ? 'active' : ''}"
                   href="${contextPath}/admin/orderCancel/list?currentPage=${p}&startDate=${search.startDate}&endDate=${search.endDate}&cancelStatus=${search.cancelStatus}&keyword=${search.keyword}">
                    ${p}
                </a>
            </c:forEach>

            <c:if test="${pi.currentPage < pi.maxPage}">
                <a class="page-num"
                   href="${contextPath}/admin/orderCancel/list?currentPage=${pi.currentPage + 1}&startDate=${search.startDate}&endDate=${search.endDate}&cancelStatus=${search.cancelStatus}&keyword=${search.keyword}">
                    ▶
                </a>
            </c:if>
        </div>
    </div>

</main>

<script>
    function resetSearch() {
        location.href = '${contextPath}/admin/orderCancel/list';
    }

    function toggleAll() {
        const master = document.getElementById('checkAll');
        document.querySelectorAll('.rowCheck').forEach(c => c.checked = master.checked);
    }
</script>

</body>
</html>