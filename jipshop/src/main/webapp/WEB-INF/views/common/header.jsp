<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/header.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

<c:set var="contextPath" value="${pageContext.request.contextPath}" scope="application" />
<header class="site-header">
    <!-- 상단 유틸 메뉴 -->
    <div class="top-bar">
        <div class="top-bar-inner">
            <div class="top-menu">
              <sec:authorize access="isAnonymous()">
                 <a href="${contextPath}/member/login">로그인</a>
                 <a href="${contextPath}/security/insert">회원가입</a>
                 <a href="${contextPath}/mypage/purchase">마이페이지</a>
                 <a href="${contextPath}/product/inquiryList">문의</a>
              </sec:authorize>
             <sec:authorize access="isAuthenticated()">
                <label><sec:authentication property="principal.memberName"/>님 환영합니다.</label> &nbsp;&nbsp;
                <a href="${contextPath}/mypage/purchase">마이페이지</a>
                <a href="#">문의</a>
                <form:form method="post" action="${contextPath}/member/logout" style="display: inline;">
                    <button type="submit" class="border-0 bg-transparent text-secondary p-0 ml-2">로그아웃</button>
                </form:form>
             </sec:authorize>
             <sec:authorize access="hasRole('ROLE_ADMIN')">
					<a href="${contextPath}/admin/memberList">관리자페이지</a>
				</sec:authorize>
            </div>
        </div>
    </div>

    <!-- 로고 / 검색+아이콘 -->
    <div class="header-middle">
        <div class="header-middle-inner">
            <!-- 로고 (왼쪽 끝) -->
            <div class="logo-area">
                <a href="${pageContext.request.contextPath}">
                    <img src="${pageContext.request.contextPath}/resources/images/logo.png">
                </a>
            </div>

            <!-- 검색창 + 하트 + 장바구니 묶음 (오른쪽 끝) -->
            <div class="search-icon-group">
                <div class="search-area">
                    <input type="text" placeholder="검색어를 입력하세요">
                    <button type="button">
                        <i class="bi bi-search"></i>
                    </button>
                </div>
                <div class="icon-area">
                    <a href="${pageContext.request.contextPath}/orders/favorites"><i class="bi bi-heart"></i></a>
                    <a href="${pageContext.request.contextPath}/orders/cart">
                        <img src="${pageContext.request.contextPath}/resources/img/장바구니.png" alt="장바구니">
                    </a>
                </div>
            </div>

        </div>
    </div>

    <nav class="main-nav">
        <div class="nav-inner">
            <div class="all-menu">
               <a href="${contextPath}/product/list" class="nav-link all-menu-btn">
                    <span class="menu-circle">☰</span>
                    <span>전체 메뉴</span>
                </a>
                <div class="allmenu-dropdown">
                    <div class="allmenu-wrap">
                        <div class="allmenu-box">
                            <div class="allmenu-title">강아지</div>
                            <a href="${contextPath}/product/list?petType=강아지&categoryName=사료">사료</a>
							<a href="${contextPath}/product/list?petType=강아지&categoryName=장난감">장난감</a>
					<a href="${contextPath}/product/list?petType=강아지&categoryName=외출용품">외출용품</a>
						<a href="${contextPath}/product/list?petType=강아지&categoryName=미용용품">미용용품</a>
                        </div>
                        <div class="allmenu-box">
                            <div class="allmenu-title">고양이</div>
                            <a href="${contextPath}/product/list?petType=고양이&categoryName=사료">사료</a>
<a href="${contextPath}/product/list?petType=고양이&categoryName=장난감">장난감</a>
<a href="${contextPath}/product/list?petType=고양이&categoryName=외출용품">외출용품</a>
<a href="${contextPath}/product/list?petType=고양이&categoryName=미용용품">미용용품</a>
                        </div>
                    </div>
                </div>
            </div>

            <ul class="main-menu">
                <li class="menu-item has-sub">
                    <a href="javascript:void(0);" class="nav-link">강아지</a>
                    <div class="small-dropdown">
                        <a href="${contextPath}/product/list?petType=강아지&categoryName=사료">사료</a>
<a href="${contextPath}/product/list?petType=강아지&categoryName=장난감">장난감</a>
<a href="${contextPath}/product/list?petType=강아지&categoryName=외출용품">외출용품</a>
<a href="${contextPath}/product/list?petType=강아지&categoryName=미용용품">미용용품</a>
                    </div>
                </li>
                <li class="menu-item has-sub">
                    <a href="javascript:void(0);" class="nav-link">고양이</a>
                    <div class="small-dropdown">
                        <a href="${contextPath}/product/list?petType=고양이&categoryName=사료">사료</a>
<a href="${contextPath}/product/list?petType=고양이&categoryName=장난감">장난감</a>
<a href="${contextPath}/product/list?petType=고양이&categoryName=외출용품">외출용품</a>
<a href="${contextPath}/product/list?petType=고양이&categoryName=미용용품">미용용품</a>
                    </div>
                </li>
                <li class="menu-item">
                    <a href="#" class="nav-link">추천</a>
                </li>
                <li class="menu-item">
                    <a href="${pageContext.request.contextPath}/community/main" class="nav-link">커뮤니티</a>
                </li>
            </ul>
        </div>
    </nav>

</header>
