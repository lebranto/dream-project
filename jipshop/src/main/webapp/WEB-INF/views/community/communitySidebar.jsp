<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<div class="community-sidebar">
    <div class="community-sidebar-card">
        <div class="community-sidebar-title">
            🐾 커뮤니티
        </div>

        <ul class="community-sidebar-menu">
            <li>
                <a href="${contextPath}/community/main"
                   class="${empty param.boardType and empty boardType ? 'active' : ''}">
                    <span class="icon">🏠</span>
                    <span>커뮤니티 메인</span>
                </a>
            </li>

            <li>
                <a href="${contextPath}/community/myKidBoard"
                   class="${param.boardType eq 'myKid' or boardType eq 'myKid' ? 'active' : ''}">
                    <span class="icon">📸</span>
                    <span>우리아이 자랑게시판</span>
                </a>
            </li>

            <li>
                <a href="${contextPath}/community/tipFreeBoard?boardType=tip"
                   class="${param.boardType eq 'tip' or boardType eq 'tip' ? 'active' : ''}">
                    <span class="icon">🦴</span>
                    <span>육아꿀팁게시판</span>
                </a>
            </li>

            <li>
                <a href="${contextPath}/community/tipFreeBoard?boardType=free"
                   class="${param.boardType eq 'free' or boardType eq 'free' ? 'active' : ''}">
                    <span class="icon">💬</span>
                    <span>자유게시판</span>
                </a>
            </li>
        </ul>
    </div>
</div>