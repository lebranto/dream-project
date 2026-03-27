<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String adminName = (String) session.getAttribute("adminName");
    if (adminName == null) adminName = "관리자";
%>
<header class="header">
    <a href="/index.do" class="header-link">홈페이지</a>
    <div class="header-user">
        <div class="avatar">관</div>
        <span><sec:authentication property="principal.memberName"/> <strong>님</strong></span>
    </div>
    <a href="/admin/logout.do" class="header-link">로그아웃</a>
</header>
