<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문취소 관리</title>

    <link rel="stylesheet" href="${contextPath}/resources/css/admin/admin.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/orderCancelList.css">

    <!-- 🔥 추가 보정 -->
    <style>
        .reason-cell {
            max-width: 160px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .badge {
            padding: 3px 6px;
            border-radius: 4px;
            font-size: 11px;
        }

        .badge-user { background:#ffe0e0; }
        .badge-admin { background:#e0f3ff; }
        .badge-wait { background:#f0f0f0; }

        .badge-done { background:#d4f8d4; }
        .badge-ship { background:#fff3d1; }
    </style>
</head>

<body>

<jsp:include page="/WEB-INF/views/admin/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>

<main class="main">

<%-- 페이지 제목 --%>
    <!-- 헤더 유지 -->
<div class="page-title">
    주문취소 관리
    <span class="page-title-badge">취소 요청 ${pendingCount}건</span>
</div>

<!-- 검색 -->
<form action="${contextPath}/admin/orderCancel/list" method="get">
    <div class="filter-bar">

        <span class="filter-label">기간</span>
        <input type="date" name="startDate" class="filter-input" value="${search.startDate}">
        <span class="filter-sep">~</span>
        <input type="date" name="endDate" class="filter-input" value="${search.endDate}">

        <select name="cancelStatus" class="filter-select">
            <option value="">전체</option>
            <option value="PENDING" ${search.cancelStatus eq 'PENDING' ? 'selected' : ''}>승인대기</option>
            <option value="APPROVED" ${search.cancelStatus eq 'APPROVED' ? 'selected' : ''}>승인</option>
            <option value="REJECTED" ${search.cancelStatus eq 'REJECTED' ? 'selected' : ''}>반려</option>
        </select>

        <input type="text" name="keyword" class="filter-input"
               placeholder="구매자명 / 주문번호"
               value="${search.keyword}">

        <button type="submit" class="btn btn-primary">조회</button>
        <button type="button" class="btn btn-outline"
                onclick="location.href='${contextPath}/admin/orderCancel/list'">초기화</button>

    </div>
</form>

<div class="table-wrap">
<table>
<thead>
<tr>
    <th class="center"><input type="checkbox"></th>
    <th>구매자</th>
    <th class="center">주문번호</th>
    <th>상품명</th>
    <th style="width:180px;">취소사유</th>
    <th class="center">귀책</th>
    <th class="center">배송</th>
    <th class="center">배송비</th>
    <th class="center">신청일</th>
    <th class="center">상태</th>
    <th class="center">액션</th>
</tr>
</thead>

<tbody>
<c:choose>

<c:when test="${empty list}">
<tr class="empty-row">
    <td colspan="12">데이터 없음</td>
</tr>
</c:when>

<c:otherwise>
<c:forEach var="c" items="${list}" varStatus="status">

<tr>
    <td class="center"><input type="checkbox"></td>
    <td>${c.ordererName}</td>
    <td class="center">${c.orderId}</td>
    <td>${c.productName}</td>

    <!-- 취소사유 (앞부분만 표시) -->
    <td class="reason-cell">
        ${fn:split(c.cancelReason, '|')[0]}
    </td>

    <!-- 귀책 -->
    <td class="center">
        <c:choose>
            <c:when test="${c.responsibilityType == '사용자 귀책'}">
                <span class="badge badge-user">사용자</span>
            </c:when>
            <c:when test="${c.responsibilityType == '판매자 귀책'}">
                <span class="badge badge-admin">판매자</span>
            </c:when>
            <c:otherwise>
                <span class="badge badge-wait">확인</span>
            </c:otherwise>
        </c:choose>
    </td>

    <!-- 배송 -->
    <td class="center">
        ${c.deliveryStatus}
    </td>

    <!-- 배송비 -->
    <td class="center">${c.shippingFeePolicy}</td>

    <td class="center">${c.cancelRequestDateStr}</td>

    <!-- 상태 -->
    <td class="center">${c.cancelStatusLabel}</td>

    <!-- 액션 -->
    <td class="center">
        <c:choose>
            <c:when test="${c.cancelStatus eq 'PENDING'}">

                <form action="${contextPath}/admin/orderCancel/approve" method="post" style="display:inline;">
                   <input type="hidden" name="detailId" value="${c.detailId}">
                    <button type="submit" class="btn btn-success btn-sm">승인</button>
                </form>

                <form action="${contextPath}/admin/orderCancel/reject" method="post" style="display:inline;">
                    <input type="hidden" name="orderId" value="${c.orderId}">
                    <button type="submit" class="btn btn-danger btn-sm">반려</button>
                </form>

            </c:when>

            <c:otherwise>
                완료
            </c:otherwise>
        </c:choose>
    </td>

</tr>

</c:forEach>
</c:otherwise>
</c:choose>
</tbody>
</table>

<!-- 페이징 -->
<div class="pagination">
    <c:if test="${pi.currentPage > 1}">
        <a class="page-num"
           href="${contextPath}/admin/orderCancel/list?currentPage=${pi.currentPage - 1}&startDate=${param.startDate}&endDate=${param.endDate}&cancelStatus=${param.cancelStatus}&keyword=${param.keyword}">
            ◀
        </a>
    </c:if>

    <c:forEach begin="${pi.startPage}" end="${pi.endPage}" var="p">
        <a class="page-num ${p == pi.currentPage ? 'active' : ''}"
           href="${contextPath}/admin/orderCancel/list?currentPage=${p}&startDate=${param.startDate}&endDate=${param.endDate}&cancelStatus=${param.cancelStatus}&keyword=${param.keyword}">
            ${p}
        </a>
    </c:forEach>

    <c:if test="${pi.currentPage < pi.maxPage}">
        <a class="page-num"
           href="${contextPath}/admin/orderCancel/list?currentPage=${pi.currentPage + 1}&startDate=${param.startDate}&endDate=${param.endDate}&cancelStatus=${param.cancelStatus}&keyword=${param.keyword}">
            ▶
        </a>
    </c:if>
</div>

</div>

</main>

</body>
</html>