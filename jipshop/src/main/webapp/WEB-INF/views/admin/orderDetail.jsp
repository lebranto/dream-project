<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% request.setAttribute("currentMenu", "orderList"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문 상세 - 집사상권</title>
    <link rel="stylesheet" href="/resources/css/admin.css">
    <link rel="stylesheet" href="/resources/css/orderDetail.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>

<main class="main">
    <div class="page-title">주문 상세</div>

    <%-- 주문 정보 --%>
    <div class="detail-card">
        <div class="detail-card-header">🧾 주문 정보</div>
        <dl class="detail-grid">
            <dt>주문번호</dt>
            <dd class="font-mono">${order.orderId}</dd>
            <dt>주문자</dt>
            <dd><strong>${order.ordererName}</strong></dd>
            <dt>연락처</dt>
            <dd>${order.ordererPhone}</dd>
            <dt>이메일</dt>
            <dd>${order.ordererEmail}</dd>
            <dt>주문금액</dt>
            <dd class="font-bold">
                <fmt:formatNumber value="${order.orderTotalPrice}" pattern="#,###"/>원
            </dd>
            <dt>주문 상태</dt>
            <dd>
                <c:choose>
                    <c:when test="${order.orderStatus=='DONE'}">
                        <span class="badge badge-done">배송완료</span>
                    </c:when>
                    <c:when test="${order.orderStatus=='SHIP'}">
                        <span class="badge badge-shipping">배송 중</span>
                    </c:when>
                    <c:when test="${order.orderStatus=='PAY'}">
                        <span class="badge badge-waiting">결제 완료</span>
                    </c:when>
                    <c:when test="${order.orderStatus=='REQ_CANCEL'}">
                        <span class="badge badge-cancel">취소 요청</span>
                    </c:when>
                </c:choose>
            </dd>
        </dl>
    </div>

    <%-- 배송 정보 --%>
    <div class="detail-card">
        <div class="detail-card-header">🚚 배송 정보</div>
        <dl class="detail-grid">
            <dt>받는 분</dt>
            <dd>${order.recvName}</dd>
            <dt>연락처</dt>
            <dd>${order.recvPhone}</dd>
            <dt>배송지</dt>
            <dd>${order.recvAddress}</dd>
            <dt>배송 메모</dt>
            <dd>${order.orderMemo}</dd>
            <dt>택배사</dt>
            <dd>${delivery.courier}</dd>
            <dt>도착 예정일</dt>
            <dd>${delivery.expectedDate}</dd>
            <dt>배송 여부</dt>
            <dd>
                <span class="badge ${delivery.deliveryYn=='Y'?'badge-done':'badge-waiting'}">
                    ${delivery.deliveryYn=='Y'?'배송 완료':'배송 중'}
                </span>
            </dd>
        </dl>
    </div>

    <%-- 배송 상태 변경 --%>
    <div class="detail-card">
        <div class="detail-card-header">⚙️ 배송 상태 변경</div>
        <div class="detail-card-body">
            <form action="/admin/orderStatusUpdate.do" method="post" style="display:flex;gap:10px;align-items:center">
                <input type="hidden" name="orderId" value="${order.orderId}">
                <select name="orderStatus" class="form-select" style="width:160px">
                    <option value="PAY"        ${order.orderStatus=='PAY'       ?'selected':''}>결제 완료</option>
                    <option value="SHIP"       ${order.orderStatus=='SHIP'      ?'selected':''}>배송 중</option>
                    <option value="DONE"       ${order.orderStatus=='DONE'      ?'selected':''}>배송 완료</option>
                    <option value="REQ_CANCEL" ${order.orderStatus=='REQ_CANCEL'?'selected':''}>취소 요청</option>
                </select>
                <button type="submit" class="btn btn-primary">상태 변경</button>
            </form>
        </div>
    </div>

    <div class="btn-group">
        <button class="btn btn-outline" onclick="location.href='/admin/orderList.do'">목록</button>
    </div>
</main>
<div class="toast" id="toast"></div>
<script>
    function showToast(msg){const t=document.getElementById('toast');t.textContent=msg;t.classList.add('show');setTimeout(()=>t.classList.remove('show'),2400);}
    <c:if test="${not empty successMsg}">window.onload=()=>showToast('✅ ${successMsg}');</c:if>
</script>
</body>
</html>
