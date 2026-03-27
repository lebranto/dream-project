<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty pi and pi.maxPage > 0}">
    <div class="community-paging">

        <!-- 이전 -->
        <c:choose>
            <c:when test="${pi.currentPage > 1}">
                <c:url var="prevUrl" value="${pageUrl}">
                    <c:param name="currentPage" value="${pi.currentPage - 1}" />
                    <c:param name="boardType" value="${boardType}" />
                    <c:param name="searchType" value="${param.searchType}" />
                    <c:param name="keyword" value="${param.keyword}" />
                </c:url>
                <a class="page-nav" href="${prevUrl}">&lt;</a>
            </c:when>
            <c:otherwise>
                <span class="page-nav disabled">&lt;</span>
            </c:otherwise>
        </c:choose>

        <!-- 숫자 -->
        <div class="page-number-wrap">
            <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
                <c:choose>
                    <c:when test="${i eq pi.currentPage}">
                        <span class="page-number current">${i}</span>
                    </c:when>
                    <c:otherwise>
                        <c:url var="pageUrlVar" value="${pageUrl}">
                            <c:param name="currentPage" value="${i}" />
                            <c:param name="boardType" value="${boardType}" />
                            <c:param name="searchType" value="${param.searchType}" />
                            <c:param name="keyword" value="${param.keyword}" />
                        </c:url>
                        <a class="page-number" href="${pageUrlVar}">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>

        <!-- 다음 -->
        <c:choose>
            <c:when test="${pi.currentPage < pi.maxPage}">
                <c:url var="nextUrl" value="${pageUrl}">
                    <c:param name="currentPage" value="${pi.currentPage + 1}" />
                    <c:param name="boardType" value="${boardType}" />
                    <c:param name="searchType" value="${param.searchType}" />
                    <c:param name="keyword" value="${param.keyword}" />
                </c:url>
                <a class="page-nav" href="${nextUrl}">&gt;</a>
            </c:when>
            <c:otherwise>
                <span class="page-nav disabled">&gt;</span>
            </c:otherwise>
        </c:choose>

    </div>
</c:if>