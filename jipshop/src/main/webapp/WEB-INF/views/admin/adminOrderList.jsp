<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 관리</title>

<link rel="stylesheet" href="${contextPath}/resources/css/admin.css">
<link rel="stylesheet" href="${contextPath}/resources/css/admin/adminOrderList.css">
</head>
<body>

    <%@ include file="/WEB-INF/views/common/adminHeader.jsp" %>

    <div class="admin-wrapper">
        <%@ include file="/WEB-INF/views/common/adminSidebar.jsp" %>

        <main class="admin-content order-admin-content">
            <section class="order-page">
                <div class="order-page-header">
                    <h2>주문 관리</h2>
                    <hr>
                </div>

                <!-- 검색 영역 -->
                <form action="${contextPath}/admin/order/list" method="get" id="searchForm" class="order-search-form">
                    <input type="hidden" name="currentPage" value="1">

                    <div class="order-search-row">
                        <div class="date-search-group">
                            <span class="search-label">기간 :</span>

                            <select name="startYear" class="date-select">
                                <option value="">시작 년</option>
                                <c:forEach var="y" begin="2020" end="2035">
                                    <option value="${y}" ${param.startYear == y.toString() ? 'selected' : ''}>${y}년</option>
                                </c:forEach>
                            </select>

                            <select name="startMonth" class="date-select">
                                <option value="">월</option>
                                <c:forEach var="m" begin="1" end="12">
                                    <option value="${m}" ${param.startMonth == m.toString() ? 'selected' : ''}>${m}월</option>
                                </c:forEach>
                            </select>

                            <select name="startDay" class="date-select">
                                <option value="">일</option>
                                <c:forEach var="d" begin="1" end="31">
                                    <option value="${d}" ${param.startDay == d.toString() ? 'selected' : ''}>${d}일</option>
                                </c:forEach>
                            </select>

                            <span class="date-tilde">~</span>

                            <select name="endYear" class="date-select">
                                <option value="">끝 년</option>
                                <c:forEach var="y" begin="2020" end="2035">
                                    <option value="${y}" ${param.endYear == y.toString() ? 'selected' : ''}>${y}년</option>
                                </c:forEach>
                            </select>

                            <select name="endMonth" class="date-select">
                                <option value="">월</option>
                                <c:forEach var="m" begin="1" end="12">
                                    <option value="${m}" ${param.endMonth == m.toString() ? 'selected' : ''}>${m}월</option>
                                </c:forEach>
                            </select>

                            <select name="endDay" class="date-select">
                                <option value="${d}" ${param.endDay == d.toString() ? 'selected' : ''}>${d}일</option>
                                <option value="">일</option>
                                <c:forEach var="d" begin="1" end="31">
                                    <option value="${d}" ${param.endDay == d.toString() ? 'selected' : ''}>${d}일</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="order-search-btns">
                            <button type="submit" class="search-btn">조회</button>
                            <button type="button" class="reset-btn"
                                    onclick="location.href='${contextPath}/admin/order/list'">초기화</button>
                        </div>
                    </div>
                </form>

                <!-- 상단 버튼 -->
                <div class="order-top-action">
                    <button type="button" class="delete-btn" id="openDeleteModalBtn">삭제</button>
                </div>

                <!-- 목록 -->
                <form id="orderListForm" action="${contextPath}/admin/order/delete" method="post">
                    <div class="order-table-wrap">
                        <table class="order-table">
                            <thead>
                                <tr>
                                    <th class="col-check">(체크)</th>
                                    <th class="col-no">번호</th>
                                    <th class="col-name">구매자</th>
                                    <th class="col-phone">전화번호</th>
                                    <th class="col-product">상품명</th>
                                    <th class="col-delivery">배송 여부</th>
                                    <th class="col-cancel">구매 취소</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty orderList}">
                                        <tr>
                                            <td colspan="7" class="empty-row">조회된 주문 내역이 없습니다.</td>
                                        </tr>
                                    </c:when>

                                    <c:otherwise>
                                        <c:forEach var="o" items="${orderList}" varStatus="status">
                                            <tr>
                                                <td>
                                                    <input type="checkbox" name="orderIds" value="${o.orderId}" class="row-check">
                                                </td>
                                                <td>${o.rowNum}</td>
                                                <td>${o.ordererName}</td>
                                                <td>${o.ordererPhone}</td>
                                                <td class="product-name-cell">
                                                    <a href="javascript:void(0);"
                                                       class="product-link openDetailModal"
                                                       data-order-id="${o.orderId}"
                                                       data-product-name="${o.productName}"
                                                       data-product-price="${o.productPrice}"
                                                       data-order-date="${o.orderDateStr}"
                                                       data-order-number="${o.orderId}"
                                                       data-orderer-name="${o.ordererName}"
                                                       data-orderer-phone="${o.ordererPhone}"
                                                       data-orderer-address="${o.ordererAddress}"
                                                       data-recv-name="${o.recvName}"
                                                       data-recv-phone="${o.recvPhone}"
                                                       data-recv-address="${o.recvAddress}"
                                                       data-company-name="${o.companyName}"
                                                       data-company-phone="${o.companyPhone}"
                                                       data-company-address="${o.companyAddress}"
                                                       data-start-address="${o.startAddress}"
                                                       data-arrive-address="${o.arriveAddress}"
                                                       data-expected-date="${o.expectedDateStr}"
                                                       data-delivery-yn="${o.deliveryYn}"
                                                       data-cancel-yn="${o.orderCancelYn}"
                                                       data-product-photo="${o.productPhoto1}">
                                                        ${o.productName}
                                                    </a>
                                                </td>
                                                <td>
                                                    <div class="delivery-check-wrap">
                                                        <input type="checkbox"
                                                               class="delivery-check"
                                                               data-order-id="${o.orderId}"
                                                               ${o.deliveryYn eq 'Y' ? 'checked' : ''}>
                                                        <span class="delivery-yn-text">${o.deliveryYn}</span>
                                                    </div>
                                                </td>
                                                <td>${o.orderCancelYn}</td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </form>

                <!-- 페이징 -->
                <div class="order-pagination">
                    <c:if test="${pi.currentPage > 1}">
                        <a class="page-arrow prev"
                           href="${contextPath}/admin/order/list?currentPage=${pi.currentPage - 1}&startYear=${param.startYear}&startMonth=${param.startMonth}&startDay=${param.startDay}&endYear=${param.endYear}&endMonth=${param.endMonth}&endDay=${param.endDay}"></a>
                    </c:if>

                    <div class="page-number-wrap">
                        <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
                            <a href="${contextPath}/admin/order/list?currentPage=${p}&startYear=${param.startYear}&startMonth=${param.startMonth}&startDay=${param.startDay}&endYear=${param.endYear}&endMonth=${param.endMonth}&endDay=${param.endDay}"
                               class="page-number ${pi.currentPage == p ? 'active' : ''}">
                                ${p}
                            </a>
                        </c:forEach>
                    </div>

                    <c:if test="${pi.currentPage < pi.maxPage}">
                        <a class="page-arrow next"
                           href="${contextPath}/admin/order/list?currentPage=${pi.currentPage + 1}&startYear=${param.startYear}&startMonth=${param.startMonth}&startDay=${param.startDay}&endYear=${param.endYear}&endMonth=${param.endMonth}&endDay=${param.endDay}"></a>
                    </c:if>
                </div>
            </section>
        </main>
    </div>

    <!-- 삭제 확인 모달 -->
    <div class="custom-modal-overlay" id="deleteConfirmModal">
        <div class="custom-modal delete-confirm-modal">
            <div class="modal-header">
                <h3>주문 삭제</h3>
                <button type="button" class="modal-close" data-close="#deleteConfirmModal">×</button>
            </div>

            <div class="modal-body">
                <p class="modal-main-text">선택한 주문 내역을 삭제하시겠습니까?</p>
                <p class="modal-sub-text">삭제 후 복구가 어렵습니다.</p>
            </div>

            <div class="modal-footer">
                <button type="button" class="modal-cancel-btn" data-close="#deleteConfirmModal">취소</button>
                <button type="button" class="modal-ok-btn" id="confirmDeleteBtn">삭제</button>
            </div>
        </div>
    </div>

    <!-- 주문 상세 모달 -->
    <div class="custom-modal-overlay" id="orderDetailModal">
        <div class="custom-modal order-detail-modal">
            <div class="modal-header">
                <h3>주문 관리</h3>
                <button type="button" class="modal-close" data-close="#orderDetailModal">×</button>
            </div>

            <div class="modal-body order-detail-body">
                <div class="detail-product-box">
                    <div class="detail-product-thumb">
                        <img id="detailProductImg" src="${contextPath}/resources/images/no-image.png" alt="상품 이미지">
                    </div>

                    <div class="detail-product-info">
                        <div class="detail-info-item">
                            <span class="info-label">상품명</span>
                            <span class="info-value" id="detailProductName"></span>
                        </div>
                        <div class="detail-info-item">
                            <span class="info-label">가격</span>
                            <span class="info-value" id="detailProductPrice"></span>
                        </div>
                        <div class="detail-info-item">
                            <span class="info-label">주문일</span>
                            <span class="info-value" id="detailOrderDate"></span>
                        </div>
                        <div class="detail-info-item">
                            <span class="info-label">주문번호</span>
                            <span class="info-value" id="detailOrderNumber"></span>
                        </div>
                    </div>
                </div>

                <div class="detail-customer-box">
                    <p>고객명 : <span id="detailOrdererName"></span></p>
                    <p>전화번호 : <span id="detailOrdererPhone"></span></p>
                    <p>주소지 : <span id="detailOrdererAddress"></span></p>
                </div>

                <div class="detail-company-box">
                    <p>업체명 : <span id="detailCompanyName"></span></p>
                    <p>전화번호 : <span id="detailCompanyPhone"></span></p>
                    <p>주소지 : <span id="detailCompanyAddress"></span></p>
                </div>

                <div class="detail-delivery-box">
                    <p>출발지 : <span id="detailStartAddress"></span></p>
                    <p>도착지 : <span id="detailArriveAddress"></span></p>
                    <p>도착 예정일 : <span id="detailExpectedDate"></span></p>
                </div>

                <div class="detail-status-box">
                    <label for="detailDeliveryCheck">배송 여부</label>
                    <input type="checkbox" id="detailDeliveryCheck">
                    <span id="detailDeliveryYnText">N</span>
                </div>
            </div>
        </div>
    </div>

<script>
document.addEventListener("DOMContentLoaded", function() {

    const contextPath = "${contextPath}";
    const openDeleteModalBtn = document.getElementById("openDeleteModalBtn");
    const deleteConfirmModal = document.getElementById("deleteConfirmModal");
    const confirmDeleteBtn = document.getElementById("confirmDeleteBtn");
    const orderListForm = document.getElementById("orderListForm");
    const orderDetailModal = document.getElementById("orderDetailModal");

    // 삭제 모달 열기
    openDeleteModalBtn.addEventListener("click", function() {
        const checkedList = document.querySelectorAll(".row-check:checked");

        if (checkedList.length === 0) {
            alert("삭제할 주문을 선택해주세요.");
            return;
        }

        deleteConfirmModal.classList.add("show");
    });

    // 삭제 실행
    confirmDeleteBtn.addEventListener("click", function() {
        orderListForm.submit();
    });

    // 모달 닫기
    document.querySelectorAll("[data-close]").forEach(btn => {
        btn.addEventListener("click", function() {
            const target = document.querySelector(this.dataset.close);
            if (target) target.classList.remove("show");
        });
    });

    // 모달 바깥 클릭 닫기
    document.querySelectorAll(".custom-modal-overlay").forEach(modal => {
        modal.addEventListener("click", function(e) {
            if (e.target === modal) {
                modal.classList.remove("show");
            }
        });
    });

    // 상세 모달 열기
    document.querySelectorAll(".openDetailModal").forEach(link => {
        link.addEventListener("click", function() {
            document.getElementById("detailProductName").innerText = this.dataset.productName || "";
            document.getElementById("detailProductPrice").innerText = this.dataset.productPrice ? this.dataset.productPrice + "원" : "";
            document.getElementById("detailOrderDate").innerText = this.dataset.orderDate || "";
            document.getElementById("detailOrderNumber").innerText = this.dataset.orderNumber || "";

            document.getElementById("detailOrdererName").innerText = this.dataset.ordererName || "";
            document.getElementById("detailOrdererPhone").innerText = this.dataset.ordererPhone || "";
            document.getElementById("detailOrdererAddress").innerText = this.dataset.ordererAddress || "";

            document.getElementById("detailCompanyName").innerText = this.dataset.companyName || "";
            document.getElementById("detailCompanyPhone").innerText = this.dataset.companyPhone || "";
            document.getElementById("detailCompanyAddress").innerText = this.dataset.companyAddress || "";

            document.getElementById("detailStartAddress").innerText = this.dataset.startAddress || "000시 000구 000읍";
            document.getElementById("detailArriveAddress").innerText = this.dataset.arriveAddress || this.dataset.recvAddress || "";
            document.getElementById("detailExpectedDate").innerText = this.dataset.expectedDate || "";

            const detailDeliveryCheck = document.getElementById("detailDeliveryCheck");
            const detailDeliveryYnText = document.getElementById("detailDeliveryYnText");

            if (this.dataset.deliveryYn === "Y") {
                detailDeliveryCheck.checked = true;
                detailDeliveryYnText.innerText = "Y";
            } else {
                detailDeliveryCheck.checked = false;
                detailDeliveryYnText.innerText = "N";
            }

            detailDeliveryCheck.setAttribute("data-order-id", this.dataset.orderId);

            const productImg = document.getElementById("detailProductImg");
            if (this.dataset.productPhoto) {
                productImg.src = contextPath + "/resources/uploadFiles/" + this.dataset.productPhoto;
            } else {
                productImg.src = contextPath + "/resources/images/no-image.png";
            }

            orderDetailModal.classList.add("show");
        });
    });

    // 목록 배송 여부 체크
    document.querySelectorAll(".delivery-check").forEach(chk => {
        chk.addEventListener("change", function() {
            const orderId = this.dataset.orderId;
            const deliveryYn = this.checked ? "Y" : "N";
            const textSpan = this.closest(".delivery-check-wrap").querySelector(".delivery-yn-text");

            fetch(contextPath + "/admin/order/updateDeliveryYn", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
                },
                body: "orderId=" + encodeURIComponent(orderId) + "&deliveryYn=" + encodeURIComponent(deliveryYn)
            })
            .then(res => res.text())
            .then(result => {
                if (result === "success") {
                    textSpan.innerText = deliveryYn;
                } else {
                    alert("배송 여부 변경 실패");
                    this.checked = !this.checked;
                }
            })
            .catch(err => {
                alert("서버 오류");
                this.checked = !this.checked;
            });
        });
    });

    // 상세 모달 배송 여부 체크
    document.getElementById("detailDeliveryCheck").addEventListener("change", function() {
        const orderId = this.dataset.orderId;
        const deliveryYn = this.checked ? "Y" : "N";
        const detailText = document.getElementById("detailDeliveryYnText");

        fetch(contextPath + "/admin/order/updateDeliveryYn", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
            },
            body: "orderId=" + encodeURIComponent(orderId) + "&deliveryYn=" + encodeURIComponent(deliveryYn)
        })
        .then(res => res.text())
        .then(result => {
            if (result === "success") {
                detailText.innerText = deliveryYn;

                const listCheckbox = document.querySelector('.delivery-check[data-order-id="' + orderId + '"]');
                if (listCheckbox) {
                    listCheckbox.checked = this.checked;
                    const listText = listCheckbox.closest(".delivery-check-wrap").querySelector(".delivery-yn-text");
                    listText.innerText = deliveryYn;
                }
            } else {
                alert("배송 여부 변경 실패");
                this.checked = !this.checked;
            }
        })
        .catch(err => {
            alert("서버 오류");
            this.checked = !this.checked;
        });
    });

});
</script>

</body>
</html>