<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setAttribute("currentMenu", "member"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 관리 - 집사상점</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/memberList.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>

<main class="main">
    <div class="page-title">
        회원 관리
        <span class="page-title-badge">총 ${totalCount}명</span>
    </div>

    <%-- 검색 필터 --%>
    <form action="/admin/memberList.do" method="get">
        <div class="filter-bar">
            <span class="filter-label">기간</span>
            <input type="date" name="startDate" class="filter-input" value="${param.startDate}">
            <span class="filter-sep">~</span>
            <input type="date" name="endDate"   class="filter-input" value="${param.endDate}">
            <select name="memberStatus" class="filter-select">
                <option value="">전체 상태</option>
                <option value="ACTIVE"   <c:if test="${param.memberStatus=='ACTIVE'}">selected</c:if>>활성</option>
                <option value="INACTIVE" <c:if test="${param.memberStatus=='INACTIVE'}">selected</c:if>>비활성</option>
                <option value="BANNED"   <c:if test="${param.memberStatus=='BANNED'}">selected</c:if>>정지</option>
            </select>
            <input type="text" name="keyword" class="filter-input"
                   placeholder="이름 또는 아이디" value="${param.keyword}" style="flex:1; min-width:140px;">
            <button type="submit" class="btn btn-primary">조회</button>
            <button type="button" class="btn btn-outline" onclick="location.href='/admin/memberList.do'">초기화</button>
        </div>
    </form>

    <div class="toolbar">
        <div class="toolbar-left">
            <span class="bulk-info" id="bulkInfo">0명 선택됨</span>
            <button type="button" class="btn btn-danger btn-sm" id="btnBulkBan"
                    style="display:none" onclick="bulkBan()">🚫 일괄 정지</button>
        </div>
        <div class="toolbar-right">
            <button class="btn btn-outline btn-sm" onclick="location.href='/admin/memberExcel.do'">📥 엑셀 다운로드</button>
        </div>
    </div>

    <form id="bulkForm" action="/admin/memberBulkAction.do" method="post">
        <input type="hidden" name="action" value="ban">
        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th class="center"><input type="checkbox" id="checkAll" onchange="toggleAll()"></th>
                        <th>번호</th>
                        <th>아이디</th>
                        <th>이름</th>
                        <th>연락처</th>
                        <th>주소</th>
                        <th>가입일</th>
                        <th class="center">회원 상태</th>
                        <th class="center">액션</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty memberList}">
                            <tr class="empty-row"><td colspan="9">조회된 회원이 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="m" items="${memberList}" varStatus="s">
                                <tr>
                                    <td class="center">
                                        <input type="checkbox" name="memberNos" value="${m.memberNo}"
                                               class="rowCheck" onchange="updateBulk()">
                                    </td>
                                    <td>${totalCount - (currentPage-1)*pageSize - s.index}</td>
                                    <td>${m.memberId}</td>
                                    <td><strong>${m.memberName}</strong></td>
                                    <td class="font-mono" style="color:var(--text-sub)">${m.memberPhone}</td>
                                    <td style="color:var(--text-sub); max-width:160px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap">${m.memberAddress}</td>
                                    <td style="color:var(--text-sub)">${m.joinDate}</td>
                                    <td class="center">
                                        <c:choose>
                                            <c:when test="${m.memberStatus=='ACTIVE'}">
                                                <span class="badge badge-active">활성</span>
                                            </c:when>
                                            <c:when test="${m.memberStatus=='INACTIVE'}">
                                                <span class="badge badge-inactive">비활성</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-banned">정지</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="center">
                                        <button type="button" class="btn btn-outline btn-sm"
                                                onclick="location.href='/admin/memberDetail.do?memberNo=${m.memberNo}'">상세</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a class="page-num" href="?page=${currentPage-1}&startDate=${param.startDate}&endDate=${param.endDate}&memberStatus=${param.memberStatus}&keyword=${param.keyword}">◀</a>
                </c:if>
                <c:forEach begin="${startPage}" end="${endPage}" var="p">
                    <a class="page-num ${p==currentPage?'active':''}" href="?page=${p}&startDate=${param.startDate}&endDate=${param.endDate}&memberStatus=${param.memberStatus}&keyword=${param.keyword}">${p}</a>
                </c:forEach>
                <c:if test="${currentPage < totalPages}">
                    <a class="page-num" href="?page=${currentPage+1}&startDate=${param.startDate}&endDate=${param.endDate}&memberStatus=${param.memberStatus}&keyword=${param.keyword}">▶</a>
                </c:if>
            </div>
        </div>
    </form>
</main>
<div class="toast" id="toast"></div>
<script>
    function toggleAll(){
        const m=document.getElementById('checkAll');
        document.querySelectorAll('.rowCheck').forEach(c=>c.checked=m.checked);
        updateBulk();
    }
    function updateBulk(){
        const n=document.querySelectorAll('.rowCheck:checked').length;
        const info=document.getElementById('bulkInfo');
        info.textContent=n+'명 선택됨';
        info.classList.toggle('visible',n>0);
        document.getElementById('btnBulkBan').style.display=n>0?'':'none';
    }
    function bulkBan(){
        const n=document.querySelectorAll('.rowCheck:checked').length;
        if(!confirm(n+'명을 일괄 정지하시겠습니까?'))return;
        document.getElementById('bulkForm').submit();
    }
    <c:if test="${not empty successMsg}">window.onload=()=>showToast('✅ ${successMsg}');</c:if>
    function showToast(msg){const t=document.getElementById('toast');t.textContent=msg;t.classList.add('show');setTimeout(()=>t.classList.remove('show'),2400);}
</script>
</body>
</html>
