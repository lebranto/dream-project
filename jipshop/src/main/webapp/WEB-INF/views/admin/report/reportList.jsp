<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setAttribute("currentMenu", "reportList"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>신고 사항 - 집사상점</title>

    <link rel="stylesheet" href="${contextPath}/resources/css/admin/admin.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/report/reportList.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/admin/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>

<main class="main">

    <div class="page-title">
        신고 사항
        <span class="page-title-badge">총 ${totalCount}건</span>
    </div>

    <!-- 검색/필터 -->
    <form action="${contextPath}/admin/reportList.do" method="get">
        <div class="filter-bar">
            <span class="filter-label">기간</span>

            <input type="date"
                   name="startDate"
                   class="filter-input"
                   value="${startDate}">

            <span class="filter-sep">~</span>

            <input type="date"
                   name="endDate"
                   class="filter-input"
                   value="${endDate}">

            <select name="reportStatus" class="filter-select">
                <option value="">전체 상태</option>
                <option value="PENDING" <c:if test="${reportStatus eq 'PENDING'}">selected</c:if>>처리 대기</option>
                <option value="DONE" <c:if test="${reportStatus eq 'DONE'}">selected</c:if>>처리 완료</option>
            </select>

            <input type="text"
                   name="keyword"
                   class="filter-input"
                   value="${keyword}"
                   placeholder="신고자, 게시글번호, 신고유형, 신고내용 검색"
                   style="flex:1; min-width:180px;">

            <button type="submit" class="btn btn-primary">조회</button>
            <button type="button"
                    class="btn btn-outline"
                    onclick="location.href='${contextPath}/admin/reportList.do'">
                초기화
            </button>
        </div>
    </form>

    <!-- 상단 툴바 -->
    <div class="toolbar">
        <div class="toolbar-left">
            <span class="bulk-info" id="bulkInfo">0건 선택됨</span>

            <button type="button"
                    class="btn btn-success btn-sm"
                    id="btnBulkDone"
                    style="display:none"
                    onclick="bulkProcess()">
                일괄 처리
            </button>

            <button type="button"
                    class="btn btn-danger btn-sm"
                    id="btnBulkDel"
                    style="display:none"
                    onclick="bulkDelete()">
                일괄 삭제
            </button>
        </div>
    </div>

    <!-- 목록 + 일괄 처리 -->
    <form id="bulkForm" action="${contextPath}/admin/reportBulkAction.do" method="post">
        <input type="hidden" name="action" id="bulkAction">

        <div class="table-wrap">
            <table>
                <thead>
                    <thead>
    <tr>
        <th style="width: 44px;">
            <input type="checkbox" id="checkAll">
        </th>
        <th style="width: 110px;">댓글 ID</th>
        <th style="width: 130px;">신고자 ID</th>
        <th style="width: 130px;">신고대상 ID</th>
        <th style="width: 110px;">게시판번호</th>
        <th style="width: 120px;">신고 유형</th>
        <th>신고 내용</th>
        <th style="width: 120px;">신고일</th>
        <th style="width: 120px;">처리 상태</th>
        <th style="width: 100px;">액션</th>
    </tr>
</thead>
                </thead>

                <tbody>
                    <c:choose>
                        <c:when test="${empty reportList}">
                            <tr>
                                <td colspan="10" class="empty-row">접수된 신고가 없습니다.</td>
                            </tr>
                        </c:when>

                       <c:otherwise>
    <c:forEach var="r" items="${reportList}" varStatus="s">
        <tr class="clickable-row"
            onclick="location.href='${contextPath}/admin/reportDetail.do?reportId=${r.reportId}'">

            <td onclick="event.stopPropagation();">
                <input type="checkbox"
                       name="reportIds"
                       value="${r.reportId}"
                       class="row-check">
            </td>

            <td>
                <c:out value="${r.commentId}" default="-"/>
            </td>

            <td>
                <c:out value="${r.reporterId}" default="-"/>
            </td>

            <td>
                <c:out value="${r.reportedMemberId}" default="-"/>
            </td>

            <td>
                <c:out value="${r.boardNo}" default="-"/>
            </td>

            <td>
                <c:out value="${r.reportTypeName}" default="기타"/>
            </td>

            <td class="left">
                <c:choose>
                    <c:when test="${not empty r.reportReason}">
                        <c:out value="${r.reportReason}"/>
                    </c:when>
                    <c:otherwise>
                        내용 없음
                    </c:otherwise>
                </c:choose>
            </td>

            <td>
                <c:out value="${r.reportDate}" default="-"/>
            </td>

            <td>
                <c:choose>
                    <c:when test="${r.reportProcessYn eq 'Y'}">
                        <span class="badge badge-done">처리 완료</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge badge-pending">처리 대기</span>
                    </c:otherwise>
                </c:choose>
            </td>

            <td onclick="event.stopPropagation();">
                <c:choose>
                    <c:when test="${r.reportProcessYn eq 'Y'}">
                        <button type="button" class="action-btn done-btn" disabled>완료</button>
                    </c:when>
                    <c:otherwise>
                        <button type="button"
                                class="action-btn"
                                onclick="processOne(${r.reportId});">
                            처리
                        </button>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
</c:otherwise>
                    </c:choose>
                </tbody>
            </table>

            
<!-- 페이징 -->
<div class="pagination">
    <c:if test="${pi.currentPage > 1}">
        <a class="page-num"
           href="${contextPath}/admin/reportList.do?currentPage=${pi.currentPage - 1}&startDate=${param.startDate}&endDate=${param.endDate}&reportStatus=${param.reportStatus}&keyword=${param.keyword}">
            ◀
        </a>
    </c:if>

    <c:forEach begin="${pi.startPage}" end="${pi.endPage}" var="p">
        <a class="page-num ${p == pi.currentPage ? 'active' : ''}"
           href="${contextPath}/admin/reportList.do?currentPage=${p}&startDate=${param.startDate}&endDate=${param.endDate}&reportStatus=${param.reportStatus}&keyword=${param.keyword}">
            ${p}
        </a>
    </c:forEach>

    <c:if test="${pi.currentPage < pi.maxPage}">
        <a class="page-num"
           href="${contextPath}/admin/reportList.do?currentPage=${pi.currentPage + 1}&startDate=${param.startDate}&endDate=${param.endDate}&reportStatus=${param.reportStatus}&keyword=${param.keyword}">
            ▶
        </a>
    </c:if>
</div>
        </div>
    </form>

</main>

<!-- 단건 처리용 숨김 폼 -->
<form id="processOneForm"
      action="${contextPath}/admin/reportProcess.do"
      method="post"
      style="display:none;">
    <input type="hidden" name="reportId" id="processReportId">
</form>

<div class="toast" id="toast"></div>

<script>
    document.addEventListener("DOMContentLoaded", function() {

        const checkAll = document.getElementById("checkAll");
        const bulkInfo = document.getElementById("bulkInfo");
        const btnBulkDone = document.getElementById("btnBulkDone");
        const btnBulkDel = document.getElementById("btnBulkDel");
        const bulkForm = document.getElementById("bulkForm");
        const bulkAction = document.getElementById("bulkAction");
        const processOneForm = document.getElementById("processOneForm");
        const processReportId = document.getElementById("processReportId");

        function getCheckedRows() {
            return document.querySelectorAll(".row-check:checked");
        }

        function getAllRows() {
            return document.querySelectorAll(".row-check");
        }

        function updateBulk() {
            const checkedCount = getCheckedRows().length;
            bulkInfo.textContent = checkedCount + "건 선택됨";
            btnBulkDone.style.display = checkedCount > 0 ? "" : "none";
            btnBulkDel.style.display = checkedCount > 0 ? "" : "none";
        }

        if (checkAll) {
            checkAll.addEventListener("change", function() {
                const checked = this.checked;
                getAllRows().forEach(function(chk) {
                    chk.checked = checked;
                });
                updateBulk();
            });
        }

        getAllRows().forEach(function(chk) {
            chk.addEventListener("change", function() {
                const all = getAllRows();
                const checked = getCheckedRows();

                if (checkAll) {
                    checkAll.checked = all.length > 0 && all.length === checked.length;
                }

                updateBulk();
            });
        });

        window.bulkProcess = function() {
            const checked = getCheckedRows();

            if (checked.length === 0) {
                alert("선택된 신고가 없습니다.");
                return;
            }

            if (!confirm(checked.length + "건을 처리 완료하시겠습니까?")) {
                return;
            }

            bulkAction.value = "done";
            bulkForm.submit();
        };

        window.bulkDelete = function() {
            const checked = getCheckedRows();

            if (checked.length === 0) {
                alert("선택된 신고가 없습니다.");
                return;
            }

            if (!confirm(checked.length + "건을 삭제하시겠습니까?")) {
                return;
            }

            bulkAction.value = "delete";
            bulkForm.submit();
        };

        window.processOne = function(reportId) {
            if (!confirm("해당 신고를 처리 완료하시겠습니까?")) {
                return;
            }

            processReportId.value = reportId;
            processOneForm.submit();
        };

        function showToast(msg) {
            const toast = document.getElementById("toast");
            if (!toast) return;

            toast.textContent = msg;
            toast.classList.add("show");

            setTimeout(function() {
                toast.classList.remove("show");
            }, 2400);
        }

        <c:if test="${not empty alertMsg}">
            showToast("${alertMsg}");
        </c:if>

        updateBulk();
    });
</script>

</body>
</html>