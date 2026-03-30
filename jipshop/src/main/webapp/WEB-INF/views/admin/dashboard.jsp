<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% request.setAttribute("currentMenu", "dashboard"); %>
<!DOCTYPE html>
<html lang="ko">
<c:set var="contextPath" value="${pageContext.request.contextPath}" scope="application"/>
<head>
    <meta charset="UTF-8">
    <title>대시보드 - 집사상점</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/admin.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/dashboard.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>

<main class="main">

    <div class="page-title">대시보드</div>

    <%-- 통계 카드 --%>
    <div class="stats-bar">
        <div class="stat-card" onclick="location.href='${contextPath}/admin/inquiryList'" style="cursor:pointer">
            <div class="stat-label">미처리 문의</div>
            <div class="stat-value text-red">${unprocessedInquiryCount}</div>
            <div class="stat-sub">처리 필요</div>
        </div>
        <div class="stat-card" onclick="location.href='${contextPath}/admin/reportList'" style="cursor:pointer">
            <div class="stat-label">미처리 신고</div>
            <div class="stat-value text-red">${unprocessedReportCount}</div>
            <div class="stat-sub">처리 필요</div>
        </div>
        <div class="stat-card" onclick="location.href='${contextPath}/admin/orderList'" style="cursor:pointer">
            <div class="stat-label">오늘 주문</div>
            <div class="stat-value text-blue">${todayOrderCount}</div>
            <div class="stat-sub">오늘 기준</div>
        </div>
    </div>

    <%-- 최근 문의 --%>
    <div class="dash-section">
        <div class="dash-section-title">
            💬 최근 문의
            <a href="${contextPath}/admin/inquiryList" class="dash-more">전체보기 ›</a>
        </div>
        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>작성자</th>
                        <th>유형</th>
                        <th>내용</th>
                        <th>작성일</th>
                        <th class="center">처리 상태</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong>김민준</strong></td>
                        <td><span class="badge badge-waiting">상품문의</span></td>
                        <td class="td-ellipsis">해당 상품 재입고 예정이 있나요?</td>
                        <td style="color:var(--text-sub)">2026-03-25</td>
                        <td class="center"><span class="badge badge-pending">미처리</span></td>
                    </tr>
                    <tr>
                        <td><strong>이서연</strong></td>
                        <td><span class="badge badge-waiting">배송문의</span></td>
                        <td class="td-ellipsis">주문한 지 3일이 지났는데 배송이 안됐어요</td>
                        <td style="color:var(--text-sub)">2026-03-24</td>
                        <td class="center"><span class="badge badge-pending">미처리</span></td>
                    </tr>
                    <tr>
                        <td><strong>박도현</strong></td>
                        <td><span class="badge badge-waiting">환불요청</span></td>
                        <td class="td-ellipsis">상품이 사진과 달라서 환불 요청드립니다</td>
                        <td style="color:var(--text-sub)">2026-03-23</td>
                        <td class="center"><span class="badge badge-done">처리 완료</span></td>
                    </tr>
                    <tr>
                        <td><strong>최지우</strong></td>
                        <td><span class="badge badge-waiting">기타</span></td>
                        <td class="td-ellipsis">앱에서 결제가 안됩니다 도움 부탁드려요</td>
                        <td style="color:var(--text-sub)">2026-03-22</td>
                        <td class="center"><span class="badge badge-pending">미처리</span></td>
                    </tr>
                    <tr>
                        <td><strong>정하윤</strong></td>
                        <td><span class="badge badge-waiting">취소요청</span></td>
                        <td class="td-ellipsis">실수로 주문했습니다 취소 부탁드립니다</td>
                        <td style="color:var(--text-sub)">2026-03-21</td>
                        <td class="center"><span class="badge badge-done">처리 완료</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <%-- 최근 신고 --%>
    <div class="dash-section">
        <div class="dash-section-title">
            🚨 최근 신고 사항
            <a href="${contextPath}/admin/reportList" class="dash-more">전체보기 ›</a>
        </div>
        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>신고 유형</th>
                        <th>신고 사유</th>
                        <th>신고일</th>
                        <th class="center">처리 상태</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><span class="badge badge-cancel">욕설/비방</span></td>
                        <td class="td-ellipsis">댓글에 욕설이 포함되어 있습니다</td>
                        <td style="color:var(--text-sub)">2026-03-25</td>
                        <td class="center"><span class="badge badge-pending">미처리</span></td>
                    </tr>
                    <tr>
                        <td><span class="badge badge-cancel">허위정보</span></td>
                        <td class="td-ellipsis">허위 리뷰로 의심됩니다</td>
                        <td style="color:var(--text-sub)">2026-03-24</td>
                        <td class="center"><span class="badge badge-pending">미처리</span></td>
                    </tr>
                    <tr>
                        <td><span class="badge badge-cancel">스팸</span></td>
                        <td class="td-ellipsis">광고성 댓글입니다</td>
                        <td style="color:var(--text-sub)">2026-03-23</td>
                        <td class="center"><span class="badge badge-done">처리 완료</span></td>
                    </tr>
                    <tr>
                        <td><span class="badge badge-cancel">욕설/비방</span></td>
                        <td class="td-ellipsis">판매자에 대한 비방 댓글입니다</td>
                        <td style="color:var(--text-sub)">2026-03-22</td>
                        <td class="center"><span class="badge badge-done">처리 완료</span></td>
                    </tr>
                    <tr>
                        <td><span class="badge badge-cancel">기타</span></td>
                        <td class="td-ellipsis">부적절한 내용이 포함되어 있습니다</td>
                        <td style="color:var(--text-sub)">2026-03-21</td>
                        <td class="center"><span class="badge badge-pending">미처리</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <%-- 최근 주문 --%>
    <div class="dash-section">
        <div class="dash-section-title">
            🧾 최근 주문
            <a href="${contextPath}/admin/order/list" class="dash-more">전체보기 ›</a>
        </div>
        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>주문번호</th>
                        <th>구매자</th>
                        <th class="td-num">주문금액</th>
                        <th>주문일</th>
                        <th class="center">취소 요청</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty recentOrderList}">
                            <tr class="empty-row"><td colspan="5">최근 주문이 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="o" items="${recentOrderList}">
                                <tr>
                                    <td class="font-mono">${o.ORDERID}</td>
                                    <td><strong>${o.ORDERERNAME}</strong></td>
                                    <td class="td-num font-bold">
                                        <fmt:formatNumber value="${o.ORDERTOTALPRICE}" pattern="#,###"/>원
                                    </td>
                                    <td style="color:var(--text-sub)">
                                        <fmt:formatDate value="${o.ORDERDATE}" pattern="yyyy-MM-dd"/>
                                    </td>
                                    <td class="center">
                                        <c:choose>
                                            <c:when test="${o.ORDERCANCELYN == 'Y'}">
                                                <span class="badge badge-cancel">요청</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-done">없음</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

</main>

<div class="toast" id="toast"></div>
</body>
</html>
