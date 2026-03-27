<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setAttribute("currentMenu", "inquiryList"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>문의 내역 - 집사상점</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/inquiryList.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/header.jsp"/>

<main class="main">
    <div class="page-title">
        문의 내역
        <span class="page-title-badge">총 ${totalCount}건</span>
    </div>

    <form action="/admin/inquiryList.do" method="get">
        <div class="filter-bar">
            <span class="filter-label">작성일</span>
            <input type="date" name="startDate" class="filter-input" value="${param.startDate}">
            <span class="filter-sep">~</span>
            <input type="date" name="endDate"   class="filter-input" value="${param.endDate}">
            <button type="submit" class="btn btn-primary">조회</button>
            <button type="button" class="btn btn-outline"
                    onclick="location.href='/admin/inquiryList.do'">초기화</button>
        </div>
    </form>

    <div class="toolbar">
        <div class="toolbar-left">
            <span class="bulk-info" id="bulkInfo">0건 선택됨</span>
            <button type="button" class="btn btn-danger btn-sm" id="btnBulkDel"
                    style="display:none" onclick="bulkDelete()">🗑 일괄 삭제</button>
        </div>
    </div>

    <form id="bulkForm" action="/admin/inquiryBulkDelete.do" method="post">
        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th class="center"><input type="checkbox" id="checkAll" onchange="toggleAll()"></th>
                        <th>번호</th>
                        <th>작성자</th>
                        <th>유형</th>
                        <th>내용</th>
                        <th>작성일</th>
                        <th>처리일</th>
                        <th class="center">처리 상태</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty inquiryList}">
                            <tr class="empty-row"><td colspan="8">등록된 문의가 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="q" items="${inquiryList}" varStatus="s">
                                <tr style="cursor:pointer"
                                    onclick="location.href='/admin/inquiryDetail.do?inquiryId=${q.inquiryId}'">
                                    <td class="center" onclick="event.stopPropagation()">
                                        <input type="checkbox" name="inquiryIds" value="${q.inquiryId}"
                                               class="rowCheck" onchange="updateBulk()">
                                    </td>
                                    <td>${totalCount - (currentPage-1)*pageSize - s.index}</td>
                                    <td><strong>${q.writerName}</strong></td>
                                    <td>
                                        <span class="badge badge-waiting">${q.inquiryType}</span>
                                    </td>
                                    <td style="max-width:260px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; color:var(--text-sub)">
                                        ${q.inquiryContent}
                                    </td>
                                    <td style="color:var(--text-sub)">${q.createdDate}</td>
                                    <td style="color:var(--text-sub)">${q.processedDate}</td>
                                    <td class="center">
                                        <c:choose>
                                            <c:when test="${q.processStatus == 'Y'}">
                                                <span class="badge badge-done">처리 완료</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-pending">미처리</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a class="page-num" href="?page=${currentPage-1}&startDate=${param.startDate}&endDate=${param.endDate}">◀</a>
                </c:if>
                <c:forEach begin="${startPage}" end="${endPage}" var="p">
                    <a class="page-num ${p==currentPage?'active':''}"
                       href="?page=${p}&startDate=${param.startDate}&endDate=${param.endDate}">${p}</a>
                </c:forEach>
                <c:if test="${currentPage < totalPages}">
                    <a class="page-num" href="?page=${currentPage+1}&startDate=${param.startDate}&endDate=${param.endDate}">▶</a>
                </c:if>
            </div>
        </div>
    </form>
</main>
<div class="toast" id="toast"></div>
<script>
    function toggleAll(){const m=document.getElementById('checkAll');document.querySelectorAll('.rowCheck').forEach(c=>c.checked=m.checked);updateBulk();}
    function updateBulk(){const n=document.querySelectorAll('.rowCheck:checked').length;const i=document.getElementById('bulkInfo');i.textContent=n+'건 선택됨';i.classList.toggle('visible',n>0);document.getElementById('btnBulkDel').style.display=n>0?'':'none';}
    function bulkDelete(){if(!confirm(document.querySelectorAll('.rowCheck:checked').length+'건을 삭제하시겠습니까?'))return;document.getElementById('bulkForm').submit();}
    function showToast(msg){const t=document.getElementById('toast');t.textContent=msg;t.classList.add('show');setTimeout(()=>t.classList.remove('show'),2400);}
    <c:if test="${not empty successMsg}">window.onload=()=>showToast('✅ ${successMsg}');</c:if>
</script>
</body>
</html>
