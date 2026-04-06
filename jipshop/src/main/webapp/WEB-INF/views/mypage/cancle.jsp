<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 취소</title>

    <link rel="stylesheet" href="${contextPath}/resources/css/mypage/cancle.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="page">
    <aside class="sidebar">
        <jsp:include page="/WEB-INF/views/common/myPageSidebar.jsp" />
    </aside>

    <main class="content">
        <div class="title-box">마이페이지</div>

        <div class="cancel-box">
            <div class="top-area">
                <div class="product-image">
                    <img src="${contextPath}${orderList.photo1}" alt="${orderList.productName}">
                </div>

                <div class="top-text">
                    ${orderList.productName}을(를)<br>
                    구매 취소하시겠습니까?
                </div>
            </div>

            <div class="notice-text">
제작사의 사정에 따라 취소 금액이 늦게 들어올 수 있으며
한번 취소된 상품은 다시 되돌릴 수 없습니다.

취소를 원하시면 비밀번호 입력과 취소 사유 선택 후
확인 버튼을 눌러주세요.
            </div>

            <form action="${contextPath}/mypage/cancle" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="orderId" value="${orderList.orderId}">
                <input type="hidden" name="detailId" value="${orderList.detailId}">
                <input type="hidden" name="cancelReason" id="cancelReason">

                <div class="form-area">
                    <div class="form-row">
                        <div class="label-box">취소구분</div>
                        <button type="button" class="select-btn" id="reasonSelectBtn" onclick="openModal()">
                            사유 선택
                        </button>
                    </div>

                    <div class="form-row form-row-top">
                        <div class="label-box">상세사유</div>
                        <div class="detail-box">
                            <textarea
                                id="cancelDetail"
                                class="reason-input"
                                maxlength="10"
                                placeholder="10글자 이하 입력"
                            ></textarea>
                            <div class="text-count">
                                <span id="textCount">0</span>/10
                            </div>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="label-box">비밀번호</div>
                        <input
                            type="password"
                            name="userPwd"
                            class="password-input"
                            placeholder="비밀번호 입력"
                            required
                        >
                    </div>

                    <div class="btn-row">
                        <button type="submit" class="confirm-btn">확인</button>
                    </div>
                </div>
            </form>
        </div>
    </main>
</div>

<div id="reasonModal" class="modal-overlay">
    <div class="modal-box">
        <div class="modal-title">취소 사유 선택</div>

        <div class="reason-option-wrap">
            <button type="button" class="reason-option" onclick="selectReason('단순변심')">단순변심</button>
            <button type="button" class="reason-option" onclick="selectReason('주문실수')">주문실수</button>
            <button type="button" class="reason-option" onclick="selectReason('상품불량')">상품불량</button>
            <button type="button" class="reason-option" onclick="selectReason('오배송')">오배송</button>
            <button type="button" class="reason-option" onclick="selectReason('배송지연')">배송지연</button>
        </div>

        <div class="modal-btn-row">
            <button type="button" class="modal-close-btn" onclick="closeModal()">닫기</button>
        </div>
    </div>
</div>

<script>
    let selectedReason = "";

    function openModal() {
        document.getElementById("reasonModal").classList.add("show");
    }

    function closeModal() {
        document.getElementById("reasonModal").classList.remove("show");
    }

    function selectReason(reason) {
        selectedReason = reason;
        document.getElementById("reasonSelectBtn").textContent = reason;
        closeModal();
    }

    function validateForm() {
        const detail = document.getElementById("cancelDetail").value.trim();

        if (!selectedReason) {
            alert("취소구분을 선택해주세요.");
            return false;
        }

        if (detail.length > 10) {
            alert("상세사유는 10글자 이하만 입력 가능합니다.");
            return false;
        }

        document.getElementById("cancelReason").value = selectedReason + "|" + detail;
        return true;
    }

    document.getElementById("cancelDetail").addEventListener("input", function() {
        document.getElementById("textCount").textContent = this.value.length;
    });

    document.getElementById("reasonModal").addEventListener("click", function(e) {
        if (e.target === this) {
            closeModal();
        }
    });
</script>

</body>
</html>