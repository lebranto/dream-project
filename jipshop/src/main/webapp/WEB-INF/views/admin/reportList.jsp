<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setAttribute("currentMenu", "newUser"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>신고 사항 - 집사상권</title>
    <link rel="stylesheet" href="/resources/css/admin.css">
    <link rel="stylesheet" href="/resources/css/reportList.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>

<main class="main">
    <div class="page-title">
        신고 사항
        <span class="page-title-badge">총 ${totalCount}건</span>
    </div>

    <form action="/admin/reportList.do" method="get">
        <div class="filter-bar">
            <span class="filter-label">기간</span>
            <input type="date" name="startDate" class="filter-input" value="${param.startDate}">
            <span class="filter-sep">~</span>
            <input type="date" name="endDate"   class="filter-input" value="${param.endDate}">
            <select name="reportStatus" class="filter-select">
                <option value="">전체 상태</option>
                <option value="PENDING"  <c:if test="${param.reportStatus=='PENDING'}">selected</c:if>>처리 대기</option>
                <option value="DONE"     <c:if test="${param.reportStatus=='DONE'}">selected</c:if>>처리 완료</option>
            </select>
            <input type="text" name="keyword" class="filter-input"
                   placeholder="신고자 또는 피신고자" value="${param.keyword}" style="flex:1;min-width:140px">
            <button type="submit" class="btn btn-primary">조회</button>
            <button type="button" class="btn btn-outline"
                    onclick="location.href='/admin/reportList.do'">초기화</button>
        </div>
    </form>

    <div class="toolbar">
        <div class="toolbar-left">
            <span class="bulk-info" id="bulkInfo">0건 선택됨</span>
            <button type="button" class="btn btn-success btn-sm" id="btnBulkDone"
                    style="display:none" onclick="bulkProcess()">✅ 일괄 처리</button>
            <button type="button" class="btn btn-danger btn-sm" id="btnBulkDel"
                    style="display:none" onclick="bulkDelete()">🗑 일괄 삭제</button>
        </div>
    </div>

    <form id="bulkForm" action="/admin/reportBulkAction.do" method="post">
        <input type="hidden" name="action" id="bulkAction">
        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th class="center"><input type="checkbox" id="checkAll" onchange="toggleAll()"></th>
                        <th>번호</th>
                        <th>신고자</th>
                        <th>신고 대상</th>
                        <th>신고 내용</th>
                        <th>처리 여부</th>
                        <th>신고일</th>
                        <th class="center">처리 상태</th>
                        <th class="center">액션</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty reportList}">
                            <tr class="empty-row"><td colspan="9">접수된 신고가 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="r" items="${reportList}" varStatus="s">
                                <tr style="cursor:pointer"
                                    onclick="location.href='/admin/reportDetail.do?reportId=${r.reportId}'">
                                    <td class="center" onclick="event.stopPropagation()">
                                        <input type="checkbox" name="reportIds" value="${r.reportId}"
                                               class="rowCheck" onchange="updateBulk()">
                                    </td>
                                    <td>${totalCount-(currentPage-1)*pageSize-s.index}</td>
                                    <td><strong>${r.reporterName}</strong></td>
                                    <td>${r.reportedName}</td>
                                    <td style="max-width:200px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;color:var(--text-sub)">
                                        ${r.reportContent}
                                    </td>
                                    <td>${r.processNote}</td>
                                    <td style="color:var(--text-sub)">${r.reportDate}</td>
                                    <td class="center">
                                        <c:choose>
                                            <c:when test="${r.reportStatus=='DONE'}">
                                                <span class="badge badge-done">처리 완료</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-pending">처리 대기</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="center" onclick="event.stopPropagation()">
                                        <c:if test="${r.reportStatus=='PENDING'}">
                                            <button type="button" class="btn btn-success btn-sm"
                                                    onclick="processOne(${r.reportId})">처리</button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a class="page-num" href="?page=${currentPage-1}&startDate=${param.startDate}&endDate=${param.endDate}&reportStatus=${param.reportStatus}&keyword=${param.keyword}">◀</a>
                </c:if>
                <c:forEach begin="${startPage}" end="${endPage}" var="p">
                    <a class="page-num ${p==currentPage?'active':''}"
                       href="?page=${p}&startDate=${param.startDate}&endDate=${param.endDate}&reportStatus=${param.reportStatus}&keyword=${param.keyword}">${p}</a>
                </c:forEach>
                <c:if test="${currentPage < totalPages}">
                    <a class="page-num" href="?page=${currentPage+1}&startDate=${param.startDate}&endDate=${param.endDate}&reportStatus=${param.reportStatus}&keyword=${param.keyword}">▶</a>
                </c:if>
            </div>
        </div>
    </form>
</main>

<form id="processOneForm" action="/admin/reportProcess.do" method="post">
    <input type="hidden" name="reportId" id="processReportId">
</form>
<div class="toast" id="toast"></div>
<script>
    function toggleAll(){const m=document.getElementById('checkAll');document.querySelectorAll('.rowCheck').forEach(c=>c.checked=m.checked);updateBulk();}
    function updateBulk(){
        const n=document.querySelectorAll('.rowCheck:checked').length;
        const i=document.getElementById('bulkInfo');
        i.textContent=n+'건 선택됨';i.classList.toggle('visible',n>0);
        document.getElementById('btnBulkDone').style.display=n>0?'':'none';
        document.getElementById('btnBulkDel').style.display=n>0?'':'none';
    }
    function bulkProcess(){if(!confirm(document.querySelectorAll('.rowCheck:checked').length+'건을 처리 완료하시겠습니까?'))return;document.getElementById('bulkAction').value='done';document.getElementById('bulkForm').submit();}
    function bulkDelete(){if(!confirm(document.querySelectorAll('.rowCheck:checked').length+'건을 삭제하시겠습니까?'))return;document.getElementById('bulkAction').value='delete';document.getElementById('bulkForm').submit();}
    function processOne(id){if(!confirm('해당 신고를 처리 완료 하시겠습니까?'))return;document.getElementById('processReportId').value=id;document.getElementById('processOneForm').submit();}
    function showToast(msg){const t=document.getElementById('toast');t.textContent=msg;t.classList.add('show');setTimeout(()=>t.classList.remove('show'),2400);}
    <c:if test="${not empty successMsg}">window.onload=()=>showToast('✅ ${successMsg}');</c:if>
</script>
</body>
</html>
