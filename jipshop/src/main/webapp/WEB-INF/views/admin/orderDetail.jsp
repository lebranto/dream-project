<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% request.setAttribute("currentMenu", "orderList"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문 상세 - 집사상권</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/admin.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/orderDetail.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>

<main class="main">
    <div class="page-title">주문 상세</div>

    <div class="detail-card">
        <div class="detail-card-header">🧾 주문 정보</div>
        <div class="detail-card-body">
            <dl class="detail-grid">
                <dt>주문번호</dt>
                <dd>${order.orderId}</dd>

                <dt>주문자</dt>
                <dd>${order.ordererName}</dd>

                <dt>주문자 연락처</dt>
                <dd>${order.ordererPhone}</dd>

                <dt>이메일</dt>
                <dd>${order.ordererEmail}</dd>

                <dt>주문일자</dt>
                <dd>${order.orderDateStr}</dd>

                <dt>총 주문금액</dt>
                <dd><fmt:formatNumber value="${order.orderTotalPrice}" pattern="#,###"/>원</dd>

                <dt>주문 상태</dt>
                <dd>
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
                            ${order.orderStatusLabel}
                        </c:otherwise>
                    </c:choose>
                </dd>

                <dt>취소 상태</dt>
                <dd>
                    <c:choose>
                        <c:when test="${order.orderCancelYn == 'Y' and order.cancelStatus == 'PENDING'}">
                            <span class="badge badge-cancel">취소 요청</span>
                        </c:when>
                        <c:when test="${order.orderCancelYn == 'Y' and order.cancelStatus == 'APPROVED'}">
                            <span class="badge badge-cancel">취소 완료</span>
                        </c:when>
                        <c:when test="${order.orderCancelYn == 'Y' and order.cancelStatus == 'REJECTED'}">
                            <span class="badge badge-waiting">취소 반려</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge badge-done">정상</span>
                        </c:otherwise>
                    </c:choose>
                </dd>
            </dl>
        </div>
    </div>

    <div class="detail-card">
        <div class="detail-card-header">🚚 배송 정보</div>
        <div class="detail-card-body">
            <dl class="detail-grid">
                <dt>받는 사람</dt>
                <dd>${order.recvName}</dd>

                <dt>연락처</dt>
                <dd>${order.recvPhone}</dd>

                <dt>배송지</dt>
                <dd>${order.recvAddress}</dd>

                <dt>도착 예정일</dt>
                <dd>
                    <c:choose>
                        <c:when test="${empty order.expectedDateStr}">-</c:when>
                        <c:otherwise>${order.expectedDateStr}</c:otherwise>
                    </c:choose>
                </dd>

                <dt>배송 상태</dt>
                <dd>
                    <c:choose>
                        <c:when test="${order.deliveryStatus == '결제완료' || order.deliveryStatus == '준비중' || order.deliveryStatus == '상품준비중'}">
                            <span class="badge badge-waiting">결제 완료</span>
                        </c:when>
                        <c:when test="${order.deliveryStatus == '출고완료'}">
                            <span class="badge badge-out">출고 완료</span>
                        </c:when>
                        <c:when test="${order.deliveryStatus == '배송중'}">
                            <span class="badge badge-shipping">배송 중</span>
                        </c:when>
                        <c:when test="${order.deliveryStatus == '배송완료'}">
                            <span class="badge badge-done">배송완료</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge badge-waiting">${order.deliveryStatus}</span>
                        </c:otherwise>
                    </c:choose>
                </dd>

                <dt>배송 여부</dt>
                <dd>
                    <c:choose>
                        <c:when test="${order.deliveryYn == 'Y'}">
                            <span class="badge badge-done">완료</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge badge-waiting">미완료</span>
                        </c:otherwise>
                    </c:choose>
                </dd>

                <dt>주문 메모</dt>
                <dd>
                    <c:choose>
                        <c:when test="${empty order.orderMemo}">-</c:when>
                        <c:otherwise>${order.orderMemo}</c:otherwise>
                    </c:choose>
                </dd>
            </dl>
        </div>
    </div>

    <div class="detail-card">
        <div class="detail-card-header">⚙ 배송 상태 변경</div>
        <div class="detail-card-body">
            <c:choose>
                <c:when test="${order.orderCancelYn == 'Y' and order.cancelStatus == 'PENDING'}">
                    <div class="status-lock-message">
                        현재 취소 요청 상태인 주문입니다. 배송 상태 변경 전 취소 처리 여부를 먼저 확인하세요.
                    </div>
                </c:when>
                <c:otherwise>
                    <form action="${contextPath}/admin/order/deliveryStatusUpdate" method="post" class="status-form">
                        <input type="hidden" name="orderId" value="${order.orderId}">

                        <select name="deliveryStatus" class="form-select status-select">
                            <option value="PAY"  <c:if test="${order.orderStatus == 'PAY'}">selected</c:if>>결제 완료</option>
                            <option value="OUT"  <c:if test="${order.orderStatus == 'OUT'}">selected</c:if>>출고 완료</option>
                            <option value="SHIP" <c:if test="${order.orderStatus == 'SHIP'}">selected</c:if>>배송 중</option>
                            <option value="DONE" <c:if test="${order.orderStatus == 'DONE'}">selected</c:if>>배송 완료</option>
                        </select>

                        <button type="submit" class="btn btn-primary">상태 변경</button>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="detail-card">
        <div class="detail-card-header">📦 주문 상품 / 개별 취소 관리</div>
        <div class="detail-card-body">
            <div class="detail-table-wrap">
                <table class="detail-table">
                    <thead>
                        <tr>
                            <th class="center">상세번호</th>
                            <th>상품명</th>
                            <th class="right">상품금액</th>
                            <th class="center">취소여부</th>
                            <th class="center">취소상태</th>
                            <th>취소사유</th>
                            <th class="center">요청일</th>
                            <th class="center">처리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty detailList}">
                                <tr class="empty-row">
                                    <td colspan="8">주문 상품 정보가 없습니다.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="d" items="${detailList}">
                                    <tr>
                                        <td class="center">${d.detailId}</td>
                                        <td>${d.productName}</td>
                                        <td class="right">
                                            <fmt:formatNumber value="${d.productPrice}" pattern="#,###"/>원
                                        </td>
                                        <td class="center">
                                            <c:choose>
                                                <c:when test="${d.cancelYn == 'Y'}">
                                                    <span class="badge badge-cancel">취소</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-done">정상</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="center">
                                            <c:choose>
                                                <c:when test="${d.cancelStatus == 'PENDING'}">
                                                    <span class="badge badge-cancel">승인 대기</span>
                                                </c:when>
                                                <c:when test="${d.cancelStatus == 'APPROVED'}">
                                                    <span class="badge badge-cancel">취소 승인</span>
                                                </c:when>
                                                <c:when test="${d.cancelStatus == 'REJECTED'}">
                                                    <span class="badge badge-waiting">취소 반려</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-done">없음</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${d.cancelReason}</td>
                                        <td class="center">
                                            <c:choose>
                                                <c:when test="${empty d.cancelRequestDateStr}">-</c:when>
                                                <c:otherwise>${d.cancelRequestDateStr}</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="center">
    <c:choose>
        <c:when test="${d.cancelStatus == 'PENDING'}">
            <button type="button"
                    class="btn btn-outline btn-sm"
                    onclick="location.href='${contextPath}/admin/orderCancel/list?keyword=${order.orderId}'">
                취소관리 이동
            </button>
        </c:when>
        <c:otherwise>
            <span class="action-empty">-</span>
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
    </div>

    <div class="btn-group">
        <button type="button" class="btn btn-outline"
                onclick="location.href='${contextPath}/admin/order/list'">목록</button>
    </div>
</main>

<div class="toast" id="toast"></div>

<script>
function showToast(msg) {
    const t = document.getElementById('toast');
    t.textContent = msg;
    t.classList.add('show');
    setTimeout(() => t.classList.remove('show'), 2200);
}

<c:if test="${not empty successMsg}">
window.onload = function() {
    showToast("${successMsg}");
};
</c:if>
</script>

</body>
</html>