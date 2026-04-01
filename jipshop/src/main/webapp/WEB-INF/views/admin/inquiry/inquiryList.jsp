<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% request.setAttribute("currentMenu", "inquiryList"); %>
<!DOCTYPE html>
<html lang="ko">
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<head>
    <meta charset="UTF-8">
    <title>문의 내역 - 집사상권</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/admin.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/inquiry/inquiryList.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>

<main class="main">

    <div class="page-title">
        문의 내역
        <span class="page-title-badge">총 ${totalCount}건</span>
    </div>

    <%-- 검색 필터 --%>
    <form action="${contextPath}/admin/inquiryList" method="get">
        <div class="filter-bar">
            <span class="filter-label">유형</span>
            <select name="inquiryType" class="filter-select">
                <option value="">전체 유형</option>
                <option value="상품문의" <c:if test="${param.inquiryType == '상품문의'}">selected</c:if>>상품문의</option>
                <option value="교환반품" <c:if test="${param.inquiryType == '교환반품'}">selected</c:if>>교환반품</option>
            </select>
            <select name="replyYn" class="filter-select">
                <option value="">전체 상태</option>
                <option value="N" <c:if test="${param.replyYn == 'N'}">selected</c:if>>미처리</option>
                <option value="Y" <c:if test="${param.replyYn == 'Y'}">selected</c:if>>처리 완료</option>
            </select>
            <input type="text" name="keyword" class="filter-input"
                   placeholder="작성자 / 내용 검색"
                   value="${param.keyword}" style="flex:1; min-width:180px;">
            <button type="submit" class="btn btn-primary">조회</button>
            <button type="button" class="btn btn-outline"
                    onclick="location.href='${contextPath}/admin/inquiryList'">초기화</button>
        </div>
    </form>

    <%-- 테이블 --%>
    <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>유형</th>
                    <th>작성자</th>
                    <th>내용</th>
                    <th>작성일</th>
                    <th class="center">처리 상태</th>
                    <th class="center">액션</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty inquiryList}">
                        <tr class="empty-row">
                            <td colspan="7">조회된 문의가 없습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="i" items="${inquiryList}" varStatus="s">
                            <tr>
                                <td>${totalCount - (pi.currentPage-1)*pi.boardLimit - s.index}</td>
                                <td><span class="badge badge-waiting">${i.inquiryType}</span></td>
                                <td><strong>${i.memberName}</strong>
                                    <span class="font-mono" style="font-size:11px;color:var(--text-sub)">
                                        (${i.memberId})
                                    </span>
                                </td>
                                <td class="td-ellipsis">${i.inquiryContent}</td>
                                <td style="color:var(--text-sub)">
                                    <fmt:formatDate value="${i.inquiryRegDate}" pattern="yyyy-MM-dd"/>
                                </td>
                                <td class="center">
                                    <c:choose>
                                        <c:when test="${i.replyYn == 'Y'}">
                                            <span class="badge badge-done">처리 완료</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-pending">미처리</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="center" onclick="event.stopPropagation()">
                                    <form action="${contextPath}/admin/inquiryDelete" method="post"
                                          style="display:inline">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        <input type="hidden" name="inquiryId" value="${i.inquiryId}">
                                        <button type="button" class="btn btn-outline btn-sm"
          									  onclick="location.href='${contextPath}/admin/inquiryDetail?inquiryId=${i.inquiryId}'">
        										상세
        								</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <%-- 페이지네이션 --%>
        <div class="pagination">
            <c:if test="${pi.currentPage > 1}">
                <a class="page-num"
                   href="?page=${pi.currentPage-1}&inquiryType=${param.inquiryType}&replyYn=${param.replyYn}&keyword=${param.keyword}">◀</a>
            </c:if>
            <c:forEach begin="${pi.startPage}" end="${pi.endPage}" var="p">
                <a class="page-num <c:if test="${p == pi.currentPage}">active</c:if>"
                   href="?page=${p}&inquiryType=${param.inquiryType}&replyYn=${param.replyYn}&keyword=${param.keyword}">${p}</a>
            </c:forEach>
            <c:if test="${pi.currentPage < pi.maxPage}">
                <a class="page-num"
                   href="?page=${pi.currentPage+1}&inquiryType=${param.inquiryType}&replyYn=${param.replyYn}&keyword=${param.keyword}">▶</a>
            </c:if>
        </div>
    </div>

</main>

<div class="toast" id="toast"></div>
<script>
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
