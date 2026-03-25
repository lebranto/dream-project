<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문취소 관리</title>
<link rel="stylesheet" href="./adminOrderCancel.css">
    <!-- 공통 관리자 CSS -->
    <link rel="stylesheet" href="${contextPath}/resources/css/admin.css">
    <!-- 주문취소 관리 전용 CSS -->
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/adminOrderCancel.css">
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/adminHeader.jsp" />

    <div class="admin-wrapper">
        <jsp:include page="/WEB-INF/views/common/adminSidebar.jsp" />

        <main class="admin-content order-cancel-page">
            <div class="order-cancel-inner">

                <div class="content-header order-cancel-header">
                    <h2>주문취소 관리</h2>
                    <hr>
                </div>

                <!-- 검색 영역 -->
                <form action="${contextPath}/admin/orderCancel/list" method="get" class="cancel-search-form">
                    <div class="cancel-search-row">
                        <div class="cancel-search-label">기간 :</div>

                        <div class="cancel-search-inputs">
                            <input type="date" name="startDate" value="${param.startDate}" class="date-input">
                            <span class="date-tilde">~</span>
                            <input type="date" name="endDate" value="${param.endDate}" class="date-input">
                        </div>

                        <div class="cancel-search-btns">
                            <button type="submit" class="mini-btn search-btn">조회</button>
                            <button type="button" class="mini-btn reset-btn" onclick="location.href='${contextPath}/admin/orderCancel/list'">초기화</button>
                        </div>
                    </div>
                </form>

                <!-- 상단 액션 버튼 -->
                <div class="cancel-top-actions">
                    <button type="button" class="action-btn process-btn" onclick="openProcessModal()">처리</button>
                    <button type="button" class="action-btn delete-btn" onclick="openDeleteModal()">삭제</button>
                </div>

                <!-- 목록 테이블 -->
                <div class="cancel-table-wrap">
                    <table class="cancel-table">
                        <colgroup>
                            <col style="width: 6%;">
                            <col style="width: 7%;">
                            <col style="width: 12%;">
                            <col style="width: 12%;">
                            <col style="width: 20%;">
                            <col style="width: 19%;">
                            <col style="width: 14%;">
                            <col style="width: 10%;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th>[체크칸]</th>
                                <th>번호</th>
                                <th>구매자</th>
                                <th>주문번호</th>
                                <th>상품명</th>
                                <th>취소사유</th>
                                <th>취소신청일</th>
                                <th>처리 상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty cancelList}">
                                    <c:forEach var="cancel" items="${cancelList}" varStatus="status">
                                        <tr>
                                            <td>
                                                <input type="checkbox"
                                                       class="row-check"
                                                       name="checkedOrder"
                                                       value="${cancel.orderId}">
                                            </td>

                                            <td>${cancel.rnum}</td>
                                            <td>${cancel.ordererName}</td>
                                            <td>${cancel.orderId}</td>

                                            <td>
                                                <a href="javascript:void(0);"
                                                   class="product-link"
                                                   onclick="openDetailModal(this)"
                                                   data-order-id="${cancel.orderId}"
                                                   data-orderer-name="${cancel.ordererName}"
                                                   data-orderer-phone="${cancel.ordererPhone}"
                                                   data-orderer-email="${cancel.ordererEmail}"
                                                   data-recv-name="${cancel.recvName}"
                                                   data-recv-phone="${cancel.recvPhone}"
                                                   data-recv-address="${cancel.recvAddress}"
                                                   data-order-date="<fmt:formatDate value='${cancel.orderDate}' pattern='yyyy-MM-dd' />"
                                                   data-cancel-request-date="<fmt:formatDate value='${cancel.cancelRequestDate}' pattern='yyyy-MM-dd' />"
                                                   data-cancel-reason="${cancel.cancelReason}"
                                                   data-cancel-status="${cancel.cancelStatus}"
                                                   data-order-total-price="${cancel.orderTotalPrice}"
                                                   data-order-delivery-fee="${cancel.orderDeliveryFee}"
                                                   data-product-name="${cancel.productName}"
                                                   data-detail-qty="${cancel.detailQty}"
                                                   data-detail-price="${cancel.detailPrice}">
                                                    ${cancel.productName}
                                                </a>
                                            </td>

                                            <td class="reason-cell">${cancel.cancelReason}</td>
                                            <td>
                                                <fmt:formatDate value="${cancel.cancelRequestDate}" pattern="yyyy-MM-dd" />
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${cancel.orderCancelYn eq 'Y'}">Y</c:when>
                                                    <c:otherwise>${empty cancel.cancelStatus ? 'N' : cancel.cancelStatus}</c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <tr>
                                        <td colspan="8" class="empty-row">조회된 주문취소 신청 내역이 없습니다.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <!-- 페이징 -->
                <c:if test="${not empty pi}">
                    <div class="pagination-area">
                        <c:if test="${pi.currentPage > 1}">
                            <a class="page-arrow left"
                               href="${contextPath}/admin/orderCancel/list?currentPage=${pi.currentPage - 1}&startDate=${param.startDate}&endDate=${param.endDate}"></a>
                        </c:if>

                        <div class="page-box">
                            <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
                                <c:choose>
                                    <c:when test="${p eq pi.currentPage}">
                                        <span class="page-num current">${p}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="page-num"
                                           href="${contextPath}/admin/orderCancel/list?currentPage=${p}&startDate=${param.startDate}&endDate=${param.endDate}">
                                            ${p}
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>

                        <c:if test="${pi.currentPage < pi.maxPage}">
                            <a class="page-arrow right"
                               href="${contextPath}/admin/orderCancel/list?currentPage=${pi.currentPage + 1}&startDate=${param.startDate}&endDate=${param.endDate}"></a>
                        </c:if>
                    </div>
                </c:if>

            </div>
        </main>
    </div>

    <!-- 삭제 form -->
    <form id="deleteForm" action="${contextPath}/admin/orderCancel/delete" method="post">
        <input type="hidden" name="orderIds" id="deleteOrderIds">
    </form>

    <!-- 처리 form -->
    <form id="processForm" action="${contextPath}/admin/orderCancel/process" method="post">
        <input type="hidden" name="orderIds" id="processOrderIds">
        <input type="hidden" name="processType" id="processType">
    </form>

    <!-- 삭제 확인 모달 -->
    <div class="modal-overlay" id="deleteModal">
        <div class="confirm-modal">
            <div class="confirm-modal-header">
                <h3>삭제여부</h3>
                <button type="button" class="modal-close-btn" onclick="closeModal('deleteModal')">×</button>
            </div>
            <div class="confirm-modal-body">
                해당 주문취소 내역을 삭제하시겠습니까?
            </div>
            <div class="confirm-modal-footer">
                <button type="button" class="modal-btn cancel-btn" onclick="closeModal('deleteModal')">취소</button>
                <button type="button" class="modal-btn approve-btn" onclick="submitDelete()">삭제</button>
            </div>
        </div>
    </div>

    <!-- 처리 확인 모달 -->
    <div class="modal-overlay" id="processModal">
        <div class="confirm-modal">
            <div class="confirm-modal-header">
                <h3>승인여부</h3>
                <button type="button" class="modal-close-btn" onclick="closeModal('processModal')">×</button>
            </div>
            <div class="confirm-modal-body">
                주문취소를 승인하시겠습니까?
            </div>
            <div class="confirm-modal-footer">
                <button type="button" class="modal-btn reject-btn" onclick="submitProcess('reject')">거절</button>
                <button type="button" class="modal-btn approve-btn" onclick="submitProcess('approve')">승인</button>
            </div>
        </div>
    </div>

    <!-- 주문상세 모달 -->
    <div class="modal-overlay detail-overlay" id="detailModal">
        <div class="detail-modal">
            <div class="detail-modal-header">
                <h3>주문상세</h3>
                <button type="button" class="modal-close-btn big-close" onclick="closeModal('detailModal')">×</button>
            </div>

            <div class="detail-modal-body">
                <div class="detail-section">
                    <h4>주문 기본 정보</h4>
                    <table class="detail-table">
                        <tr>
                            <th>주문번호</th>
                            <td id="detailOrderId"></td>
                            <th>주문일</th>
                            <td id="detailOrderDate"></td>
                        </tr>
                        <tr>
                            <th>구매자명</th>
                            <td id="detailOrdererName"></td>
                            <th>연락처</th>
                            <td id="detailOrdererPhone"></td>
                        </tr>
                        <tr>
                            <th>이메일</th>
                            <td colspan="3" id="detailOrdererEmail"></td>
                        </tr>
                    </table>
                </div>

                <div class="detail-section">
                    <h4>수령 정보</h4>
                    <table class="detail-table">
                        <tr>
                            <th>수령인</th>
                            <td id="detailRecvName"></td>
                            <th>연락처</th>
                            <td id="detailRecvPhone"></td>
                        </tr>
                        <tr>
                            <th>주소</th>
                            <td colspan="3" id="detailRecvAddress"></td>
                        </tr>
                    </table>
                </div>

                <div class="detail-section">
                    <h4>취소 신청 정보</h4>
                    <table class="detail-table">
                        <tr>
                            <th>상품명</th>
                            <td id="detailProductName"></td>
                            <th>수량</th>
                            <td id="detailQty"></td>
                        </tr>
                        <tr>
                            <th>상품금액</th>
                            <td id="detailPrice"></td>
                            <th>배송비</th>
                            <td id="detailDeliveryFee"></td>
                        </tr>
                        <tr>
                            <th>총 주문금액</th>
                            <td id="detailTotalPrice"></td>
                            <th>취소상태</th>
                            <td id="detailCancelStatus"></td>
                        </tr>
                        <tr>
                            <th>취소신청일</th>
                            <td id="detailCancelRequestDate"></td>
                            <th>취소사유</th>
                            <td id="detailCancelReason"></td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="detail-modal-footer">
                <button type="button" class="detail-close-btn" onclick="closeModal('detailModal')">닫기</button>
            </div>
        </div>
    </div>

    <script>
        function getCheckedValues() {
            const checked = document.querySelectorAll(".row-check:checked");
            const values = [];

            checked.forEach(function(chk) {
                values.push(chk.value);
            });

            return values;
        }

        function openDeleteModal() {
            const checkedValues = getCheckedValues();

            if (checkedValues.length === 0) {
                alert("삭제할 주문취소 내역을 선택해주세요.");
                return;
            }

            document.getElementById("deleteModal").style.display = "flex";
        }

        function submitDelete() {
            const checkedValues = getCheckedValues();

            if (checkedValues.length === 0) {
                alert("삭제할 항목이 없습니다.");
                return;
            }

            document.getElementById("deleteOrderIds").value = checkedValues.join(",");
            document.getElementById("deleteForm").submit();
        }

        function openProcessModal() {
            const checkedValues = getCheckedValues();

            if (checkedValues.length === 0) {
                alert("처리할 주문취소 내역을 선택해주세요.");
                return;
            }

            document.getElementById("processModal").style.display = "flex";
        }

        function submitProcess(type) {
            const checkedValues = getCheckedValues();

            if (checkedValues.length === 0) {
                alert("처리할 항목이 없습니다.");
                return;
            }

            document.getElementById("processOrderIds").value = checkedValues.join(",");
            document.getElementById("processType").value = type;
            document.getElementById("processForm").submit();
        }

        function closeModal(modalId) {
            document.getElementById(modalId).style.display = "none";
        }

        function openDetailModal(el) {
            document.getElementById("detailOrderId").innerText = el.dataset.orderId || "";
            document.getElementById("detailOrderDate").innerText = el.dataset.orderDate || "";
            document.getElementById("detailOrdererName").innerText = el.dataset.ordererName || "";
            document.getElementById("detailOrdererPhone").innerText = el.dataset.ordererPhone || "";
            document.getElementById("detailOrdererEmail").innerText = el.dataset.ordererEmail || "";
            document.getElementById("detailRecvName").innerText = el.dataset.recvName || "";
            document.getElementById("detailRecvPhone").innerText = el.dataset.recvPhone || "";
            document.getElementById("detailRecvAddress").innerText = el.dataset.recvAddress || "";
            document.getElementById("detailProductName").innerText = el.dataset.productName || "";
            document.getElementById("detailQty").innerText = el.dataset.detailQty || "";
            document.getElementById("detailPrice").innerText = formatNumber(el.dataset.detailPrice) + "원";
            document.getElementById("detailDeliveryFee").innerText = formatNumber(el.dataset.orderDeliveryFee) + "원";
            document.getElementById("detailTotalPrice").innerText = formatNumber(el.dataset.orderTotalPrice) + "원";
            document.getElementById("detailCancelStatus").innerText = el.dataset.cancelStatus || "";
            document.getElementById("detailCancelRequestDate").innerText = el.dataset.cancelRequestDate || "";
            document.getElementById("detailCancelReason").innerText = el.dataset.cancelReason || "";

            document.getElementById("detailModal").style.display = "flex";
        }

        function formatNumber(value) {
            if (!value) return "0";
            return Number(value).toLocaleString();
        }

        window.onclick = function(event) {
            const deleteModal = document.getElementById("deleteModal");
            const processModal = document.getElementById("processModal");
            const detailModal = document.getElementById("detailModal");

            if (event.target === deleteModal) {
                closeModal("deleteModal");
            }
            if (event.target === processModal) {
                closeModal("processModal");
            }
            if (event.target === detailModal) {
                closeModal("detailModal");
            }
        };
    </script>

</body>
</html>