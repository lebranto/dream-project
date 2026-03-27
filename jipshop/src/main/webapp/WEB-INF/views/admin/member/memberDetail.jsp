<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% request.setAttribute("currentMenu", "member"); %>
<!DOCTYPE html>
<html lang="ko">
<c:set var="contextPath" value="${pageContext.request.contextPath}" scope="application" />
<head>
    <meta charset="UTF-8">
    <title>회원 상세 - 집사상점</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/admin.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/member/memberDetail.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>

<main class="main">

    <div class="page-title">회원 상세 / 수정</div>

    <%-- 상단: 상태 카드 + 기본 정보 --%>
    <div class="member-top">

        <%-- 상태 카드 --%>
        <div class="member-status-card">
            <div class="detail-card-header">👤 회원 상태</div>
            <div class="status-card-body">
                <div class="member-avatar">
                    ${fn:substring(member.memberName, 0, 1)}
                </div>
                <div class="member-card-name">${member.memberName}</div>
                <c:choose>
                    <c:when test="${member.activeYn == 'Y'}">
                        <span class="badge badge-active">활성</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge badge-banned">정지</span>
                    </c:otherwise>
                </c:choose>
                <div class="member-card-join">가입일 <fmt:formatDate value="${member.joinDate}" pattern="yyyy-MM-dd"/></div>
            </div>
        </div>

        <%-- 기본 정보 --%>
        <div class="detail-card" style="flex:1">
            <div class="detail-card-header">📋 기본 정보</div>
            <dl class="detail-grid">
                <dt>회원번호</dt><dd>${member.memberNo}</dd>
                <dt>아이디</dt><dd class="font-mono">${member.memberId}</dd>
                <dt>이름</dt><dd><strong>${member.memberName}</strong></dd>
                <dt>연락처</dt><dd>${member.phone}</dd>
                <dt>이메일</dt><dd>${member.email}</dd>
                <dt>주소</dt><dd>${member.address}</dd>
                <dt>가입일</dt><dd><fmt:formatDate value="${member.joinDate}" pattern="yyyy-MM-dd"/></dd>
            </dl>
        </div>

    </div>

    <%-- 정보 수정 폼 --%>
    
    <div class="detail-card">
        <div class="detail-card-header">✏️ 정보 수정</div>
        <div class="detail-card-body">
            <form action="${contextPath}/admin/memberUpdate" method="post" id="editForm" onsubmit="return confirmEdit()">
                <input type="hidden" name="memberNo" value="${member.memberNo}">

                <div class="form-row">
                    <label class="form-label required">이름</label>
                    <input type="text" name="memberName" class="form-input w-md"
                           value="${member.memberName}" required>
                </div>
                <div class="form-row">
                    <label class="form-label required">연락처</label>
                    <input type="text" name="phone" class="form-input w-md"
                           value="${member.phone}"
                           placeholder="010-0000-0000" required>
                </div>
                <div class="form-row">
                    <label class="form-label">이메일</label>
                    <input type="email" name="email" class="form-input w-lg"
                           value="${member.email}">
                </div>
                <div class="form-row">
                    <label class="form-label required">주소</label>
                    <input type="text" name="address" class="form-input"
                           value="${member.address}" required>
                </div>

                <div class="form-divider"></div>

                <div class="btn-group">
                    <button type="button" class="btn btn-outline"
                            onclick="llocation.href='${contextPath}/admin/memberList'">목록</button>
                    <button type="button" class="btn btn-danger"
                            onclick="location.href='${contextPath}/admin/memberStop?memberNo=${member.memberNo}'">
                        이용 정지 / 탈퇴 처리
                    </button>
                    <button type="submit" class="btn btn-primary">수정 완료</button>
                </div>
            </form>
        </div>
    </div>

    <%-- 반려동물 목록 --%>
    <div class="detail-card">
        <div class="detail-card-header">🐾 등록 반려동물 (${petCount}마리)</div>
        <c:choose>
            <c:when test="${empty petList}">
                <div class="empty-section">등록된 반려동물이 없습니다.</div>
            </c:when>
            <c:otherwise>
                <div class="table-wrap no-border">
                    <table>
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>종류</th>
                                <th>이름</th>
                                <th>생년월일</th>
                                <th class="td-num">몸무게(kg)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="pet" items="${petList}" varStatus="s">
                                <tr>
                                    <td>${s.count}</td>
                                    <td>
                                        <span class="badge badge-waiting">${pet.petType}</span>
                                    </td>
                                    <td><strong>${pet.petName}</strong></td>
                                    <td style="color:var(--text-sub)">${pet.petAge}</td>
                                    <td class="td-num">${pet.petWeight}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- 최근 주문 이력 --%>
    <div class="detail-card">
        <div class="detail-card-header">🧾 최근 주문 이력 (최근 5건)</div>
        <c:choose>
            <c:when test="${empty recentOrders}">
                <div class="empty-section">주문 내역이 없습니다.</div>
            </c:when>
            <c:otherwise>
                <div class="table-wrap no-border">
                    <table>
                        <thead>
                            <tr>
                                <th>주문번호</th>
                                <th>상품명 (외)</th>
                                <th class="td-num">주문금액</th>
                                <th>주문일</th>
                                <th>상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="ord" items="${recentOrders}">
                                <tr>
                                    <td class="font-mono">${ord.orderId}</td>
                                    <td>${ord.productSummary}</td>
                                    <td class="td-num font-bold">
                                        <fmt:formatNumber value="${ord.orderTotalPrice}" pattern="#,###"/>원
                                    </td>
                                    <td style="color:var(--text-sub)">${ord.orderDate}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${ord.orderStatusLabel == '배송완료'}">
                                                <span class="badge badge-done">배송완료</span>
                                            </c:when>
                                            <c:when test="${ord.orderStatusLabel == '배송 중'}">
                                                <span class="badge badge-shipping">배송 중</span>
                                            </c:when>
                                            <c:when test="${ord.orderStatusLabel == '취소 요청'}">
                                                <span class="badge badge-cancel">취소 요청</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-waiting">${ord.orderStatusLabel}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</main>

<div class="toast" id="toast"></div>

<script>
	function confirmEdit() {
	    const name    = document.querySelector('input[name="memberName"]').value.trim();
	    const phone   = document.querySelector('input[name="phone"]').value.trim();
	    const address = document.querySelector('input[name="address"]').value.trim();
	
	    if (!name) {
	        alert('이름을 입력해주세요.');
	        document.querySelector('input[name="memberName"]').focus();
	        return false;
	    }
	    if (!phone) {
	        alert('연락처를 입력해주세요.');
	        document.querySelector('input[name="phone"]').focus();
	        return false;
	    }
	    if (!address) {
	        alert('주소를 입력해주세요.');
	        document.querySelector('input[name="address"]').focus();
	        return false;
	    }
	
	    return confirm('회원 정보를 수정하시겠습니까?');
	}

    function showToast(msg) {
        const t = document.getElementById('toast');
        t.textContent = msg;
        t.classList.add('show');
        setTimeout(() => t.classList.remove('show'), 2400);
    }

    <c:if test="${not empty successMsg}">
        window.onload = () => showToast('✅ ${successMsg}');
    </c:if>
    <c:if test="${not empty errorMsg}">
        window.onload = () => showToast('⚠️ ${errorMsg}');
    </c:if>
</script>

</body>
</html>
