<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% request.setAttribute("currentMenu", "salesMonthly"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>매출 월별조회 - 집사상점</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/salesMonthly.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>

<main class="main">
    <div class="page-title">매출 월별 조회</div>

    <form action="/admin/salesMonthly.do" method="get">
        <div class="filter-bar">
            <span class="filter-label">기간</span>
            <input type="date" name="startDate" class="filter-input" value="${param.startDate}">
            <span class="filter-sep">~</span>
            <input type="date" name="endDate"   class="filter-input" value="${param.endDate}">
            <button type="submit" class="btn btn-primary">조회</button>
            <button type="button" class="btn btn-outline"
                    onclick="location.href='/admin/salesMonthly.do'">초기화</button>
        </div>
    </form>

    <%-- 통계 카드 --%>
    <div class="stats-bar">
        <div class="stat-card">
            <div class="stat-label">총 매출금액</div>
            <div class="stat-value text-green">
                <fmt:formatNumber value="${totalSales}" pattern="#,###"/>원
            </div>
            <div class="stat-sub">조회 기간 합계</div>
        </div>
        <div class="stat-card">
            <div class="stat-label">총 주문 건수</div>
            <div class="stat-value">${totalOrderCount}</div>
            <div class="stat-sub">전체 주문</div>
        </div>
        <div class="stat-card">
            <div class="stat-label">현금 수수료</div>
            <div class="stat-value text-blue">
                <fmt:formatNumber value="${totalCashFee}" pattern="#,###"/>원
            </div>
            <div class="stat-sub">현금 결제 수수료 합계</div>
        </div>
        <div class="stat-card">
            <div class="stat-label">지급 예정액</div>
            <div class="stat-value text-red">
                <fmt:formatNumber value="${totalPayable}" pattern="#,###"/>원
            </div>
            <div class="stat-sub">판매자 지급 예정</div>
        </div>
    </div>

    <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <th>입점일</th>
                    <th>판매업체명</th>
                    <th class="td-num">매출 금액</th>
                    <th class="td-num">전체 수수료</th>
                    <th class="td-num">입금 금액</th>
                    <th class="td-num">지급 예정액</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty salesList}">
                        <tr class="empty-row"><td colspan="6">조회된 매출 데이터가 없습니다.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="s" items="${salesList}">
                            <tr>
                                <td style="color:var(--text-sub)">${s.saleMonth}</td>
                                <td><strong>${s.sellerName}</strong></td>
                                <td class="td-num font-bold">
                                    <fmt:formatNumber value="${s.salesAmount}" pattern="#,###"/>
                                </td>
                                <td class="td-num" style="color:var(--text-sub)">
                                    <fmt:formatNumber value="${s.totalFee}" pattern="#,###"/>
                                </td>
                                <td class="td-num">
                                    <fmt:formatNumber value="${s.depositAmount}" pattern="#,###"/>
                                </td>
                                <td class="td-num" style="color:var(--accent)">
                                    <fmt:formatNumber value="${s.payableAmount}" pattern="#,###"/>
                                </td>
                            </tr>
                        </c:forEach>
                        <tr class="sum-row">
                            <td colspan="2" class="center">합 계</td>
                            <td class="td-num"><fmt:formatNumber value="${totalSales}"   pattern="#,###"/></td>
                            <td class="td-num"><fmt:formatNumber value="${totalFee}"     pattern="#,###"/></td>
                            <td class="td-num"><fmt:formatNumber value="${totalDeposit}" pattern="#,###"/></td>
                            <td class="td-num"><fmt:formatNumber value="${totalPayable}" pattern="#,###"/></td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a class="page-num" href="?page=${currentPage-1}&startDate=${param.startDate}&endDate=${param.endDate}">◀</a>
            </c:if>
            <c:forEach begin="${startPage}" end="${endPage}" var="p">
                <a class="page-num ${p==currentPage?'active':''}"
                   href="?page=${p}&startDate=${param.startDate}&endDate=${param.endDate}">${p}</a>
            </c:forEach>
            <c:if test="${currentPage < totalPages}">
                <a class="page-num" href="?page=${currentPage+1}&startDate=${param.startDate}&endDate=${param.endDate}">▶</a>
            </c:if>
        </div>
    </div>
</main>
</body>
</html>
