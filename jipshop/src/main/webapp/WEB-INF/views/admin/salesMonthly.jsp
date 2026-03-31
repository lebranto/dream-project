<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% request.setAttribute("currentMenu", "salesMonthly"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>매출 일별조회 - 집사상점</title>
    <c:set var="contextPath" value="${pageContext.request.contextPath}"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/salesMonthly.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>

<main class="main">
    <div class="page-title">매출 일별 조회</div>

    <form action="${contextPath}/admin/salesMonthly" method="get">
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
                <fmt:formatNumber value="${totalSales * 0.1}" pattern="#,###"/>원
            </div>
            <div class="stat-sub">현금 결제 수수료 합계</div>
        </div>
        <div class="stat-card">
            <div class="stat-label">지급 예정액</div>
            <div class="stat-value text-red">
                <fmt:formatNumber value="${totalSales * 1.1 * 0.9}" pattern="#,###"/>원
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
                    <th class="td-num">현금 수수료</th>
                    <th class="td-num">입금 금액</th>
                    <th class="td-num">지급 예정액</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty orderlist}">
                        <tr class="empty-row"><td colspan="6">조회된 매출 데이터가 없습니다.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="o" items="${orderlist}">
                            <tr>
                                <td style="color:var(--text-sub)">
                                <fmt:formatDate value="${o.orderDate}" pattern="yyyy-MM-dd"/> 
                                </td>
                                <td><strong>${o.companyName}</strong></td>
                                <td class="td-num font-bold">
                                <fmt:formatNumber value="${o.orderTotalPrice}" pattern="#,###"/>
                                </td>
                                <td class="td-num" style="color:var(--text-sub)">
                                    <fmt:formatNumber value="${o.orderTotalPrice * 0.1}" pattern="#,###"/>
                                </td>
                                <td class="td-num">
                                    <fmt:formatNumber value="${o.orderTotalPrice * 1.1}" pattern="#,###"/>
                                </td>
                                <td class="td-num" style="color:var(--accent)">
                                    <fmt:formatNumber value="${o.orderTotalPrice * 1.1 * 0.9}" pattern="#,###"/>
                                </td>
                            </tr>
                        </c:forEach>
                        <tr class="sum-row">
                            <td colspan="2" class="center">합 계</td>
                            <td class="td-num">
                            <fmt:formatNumber value="${totalSales}" pattern="#,###"/>
                            </td>
                            <td class="td-num">
                            <fmt:formatNumber value="${totalSales * 0.1}" pattern="#,###"/>
                            </td>
                            <td class="td-num"> 
                            <fmt:formatNumber value="${totalSales * 1.1}" pattern="#,###"/>
                            </td>
                            <td class="td-num">
                            <fmt:formatNumber value="${totalSales * 1.1 * 0.9}" pattern="#,###"/>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        <div class="pagination">
            <c:if test="${pi.currentPage > 1}">
                <a class="page-num" href="?cpage=${pi.currentPage-1}&startDate=${param.startDate}&endDate=${param.endDate}">◀</a>
            </c:if>
            <c:forEach begin="${pi.startPage}" end="${pi.endPage}" var="p">
                <a class="page-num ${p==pi.currentPage?'active':''}"
                   href="?cpage=${p}&startDate=${param.startDate}&endDate=${param.endDate}">${p}</a>
            </c:forEach>
            <c:if test="${pi.currentPage < pi.maxPage}">
                <a class="page-num" href="?cpage=${pi.currentPage+1}&startDate=${param.startDate}&endDate=${param.endDate}">▶</a>
            </c:if>
        </div>
    </div>
</main>
</body>
</html>
