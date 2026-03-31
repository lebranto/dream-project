<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<header class="header">
    <a href="${pageContext.request.contextPath}/" class="header-link">홈페이지</a>
    <div class="header-user">
        <div class="avatar"><sec:authentication property="principal.memberName"/></div>
        <span> <strong>님</strong></span>
    </div>
    <a href="${pageContext.request.contextPath}/member/logout" class="header-link">로그아웃</a>
</header>
