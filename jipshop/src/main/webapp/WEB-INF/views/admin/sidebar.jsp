<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String currentMenu = (String) request.getAttribute("currentMenu");
    if (currentMenu == null) currentMenu = "";
%>
<nav class="sidebar">
    <div class="sidebar-logo">
        <div class="logo-icon">🏠</div>
        <span>집사상점</span>
    </div>

    <div class="sidebar-section">회원</div>
    <a href="${contextPath}/jipshop/admin/memberList" class="sidebar-item <%= "member".equals(currentMenu) ? "active" : "" %>">
        👤 회원 관리
    </a>

    <div class="sidebar-section">상품</div>
    <a href="${contextPath}/jipshop/admin/productRegist" class="sidebar-item <%= "productRegist".equals(currentMenu) ? "active" : "" %>">
        📦 상품 등록
    </a>
    <a href="/admin/productList.do" class="sidebar-item <%= "productList".equals(currentMenu) ? "active" : "" %>">
        📋 상품목록
    </a>

    <div class="sidebar-section">매출</div>
    <a href="/admin/salesDaily.do" class="sidebar-item <%= "salesDaily".equals(currentMenu) ? "active" : "" %>">
        📈 일별조회
    </a>
    <a href="/admin/salesMonthly.do" class="sidebar-item <%= "salesMonthly".equals(currentMenu) ? "active" : "" %>">
        📅 월별조회
    </a>

    <div class="sidebar-section">주문</div>
    <a href="/admin/orderList.do" class="sidebar-item <%= "orderList".equals(currentMenu) ? "active" : "" %>">
        🧾 주문 관리
    </a>
    <a href="/admin/orderCancelList.do" class="sidebar-item <%= "orderCancelList".equals(currentMenu) ? "active" : "" %>">
        ❌ 취소 관리
    </a>

    <div class="sidebar-section">고객센터</div>
    <a href="/admin/inquiryList.do" class="sidebar-item <%= "inquiryList".equals(currentMenu) ? "active" : "" %>">
        💬 문의 조회
    </a>
    <a href="/admin/newUser.do" class="sidebar-item <%= "newUser".equals(currentMenu) ? "active" : "" %>">
        🔔 신규 사용
    </a>
</nav>
