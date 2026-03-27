<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% request.setAttribute("currentMenu", "dashboard"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>대시보드 - 집사상점</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/dashboard.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/header.jsp"/>

<main class="main">
    <div class="page-title">대시보드</div>

    <%-- 요약 통계 카드 --%>
    <div class="stats-bar" style="margin-bottom:28px">
        <div class="stat-card">
            <div class="stat-label">미처리 문의</div>
            <div class="stat-value text-red">${unprocessedInquiry}</div>
            <div class="stat-sub">처리 필요</div>
        </div>
        <div class="stat-card">
            <div class="stat-label">최신 댓글</div>
            <div class="stat-value">${recentCommentCount}</div>
            <div class="stat-sub">오늘 등록</div>
        </div>
        <div class="stat-card">
            <div class="stat-label">신규 게시글</div>
            <div class="stat-value text-blue">${recentBoardCount}</div>
            <div class="stat-sub">오늘 등록</div>
        </div>
        <div class="stat-card">
            <div class="stat-label">미처리 신고</div>
            <div class="stat-value text-red">${unprocessedReport}</div>
            <div class="stat-sub">처리 필요</div>
        </div>
    </div>

    <%-- 문의 내역 최신 목록 --%>
    <div class="dash-section">
        <div class="dash-section-title">
            📋 문의 내역
            <a href="/admin/inquiryList.do" style="font-size:12px;font-weight:400;color:var(--text-sub);margin-left:auto">전체보기 ›</a>
        </div>
        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
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
                            <tr class="empty-row"><td colspan="7">등록된 문의가 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="q" items="${inquiryList}" varStatus="s">
                                <tr style="cursor:pointer"
                                    onclick="location.href='/admin/inquiryDetail.do?inquiryId=${q.inquiryId}'">
                                    <td>${s.count}</td>
                                    <td><strong>${q.writerName}</strong></td>
                                    <td><span class="badge badge-waiting">${q.inquiryType}</span></td>
                                    <td style="max-width:200px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;color:var(--text-sub)">
                                        ${q.inquiryContent}
                                    </td>
                                    <td style="color:var(--text-sub)">${q.createdDate}</td>
                                    <td style="color:var(--text-sub)">${q.processedDate}</td>
                                    <td class="center">
                                        <c:choose>
                                            <c:when test="${q.processStatus=='Y'}">
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
        </div>
    </div>

    <%-- 댓글 내역 최신 목록 --%>
    <div class="dash-section">
        <div class="dash-section-title">
            💬 댓글 내역
            <a href="/admin/commentList.do" style="font-size:12px;font-weight:400;color:var(--text-sub);margin-left:auto">전체보기 ›</a>
        </div>
        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>작성자</th>
                        <th>게시글번호</th>
                        <th>내용</th>
                        <th>작성일</th>
                        <th class="center">신고 여부</th>
                        <th class="center">액션</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty commentList}">
                            <tr class="empty-row"><td colspan="7">등록된 댓글이 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="cm" items="${commentList}" varStatus="s">
                                <tr>
                                    <td>${s.count}</td>
                                    <td><strong>${cm.writerName}</strong></td>
                                    <td class="font-mono">${cm.boardNo}</td>
                                    <td style="max-width:220px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;color:var(--text-sub)">
                                        ${cm.commentContent}
                                    </td>
                                    <td style="color:var(--text-sub)">${cm.createdDate}</td>
                                    <td class="center">
                                        <c:choose>
                                            <c:when test="${cm.reportYn=='Y'}">
                                                <span class="badge badge-cancel">신고됨</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-done">정상</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="center">
                                        <button type="button" class="btn btn-danger btn-sm"
                                                onclick="deleteComment(${cm.commentId})">삭제</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <%-- 최신 커뮤니티 글 --%>
    <div class="dash-section">
        <div class="dash-section-title">
            📝 최신 커뮤니티 글
            <a href="/admin/boardList.do" style="font-size:12px;font-weight:400;color:var(--text-sub);margin-left:auto">전체보기 ›</a>
        </div>
        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>작성자</th>
                        <th>제목</th>
                        <th class="td-num">조회수</th>
                        <th class="td-num">좋아요</th>
                        <th>작성일</th>
                        <th class="center">신고 여부</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty boardList}">
                            <tr class="empty-row"><td colspan="7">등록된 게시글이 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="b" items="${boardList}" varStatus="s">
                                <tr style="cursor:pointer"
                                    onclick="location.href='/admin/boardDetail.do?boardNo=${b.boardNo}'">
                                    <td>${s.count}</td>
                                    <td><strong>${b.writerName}</strong></td>
                                    <td style="max-width:220px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap">
                                        ${b.boardTitle}
                                    </td>
                                    <td class="td-num">${b.viewCount}</td>
                                    <td class="td-num">${b.likeCount}</td>
                                    <td style="color:var(--text-sub)">${b.createdDate}</td>
                                    <td class="center">
                                        <c:choose>
                                            <c:when test="${b.reportYn=='Y'}">
                                                <span class="badge badge-cancel">신고됨</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-done">정상</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

</main>

<form id="delCommentForm" action="/admin/commentDelete.do" method="post">
    <input type="hidden" name="commentId" id="delCommentId">
</form>

<div class="toast" id="toast"></div>
<script>
    function deleteComment(id){
        if(!confirm('해당 댓글을 삭제하시겠습니까?'))return;
        document.getElementById('delCommentId').value=id;
        document.getElementById('delCommentForm').submit();
    }
    function showToast(msg){const t=document.getElementById('toast');t.textContent=msg;t.classList.add('show');setTimeout(()=>t.classList.remove('show'),2400);}
    <c:if test="${not empty successMsg}">window.onload=()=>showToast('✅ ${successMsg}');</c:if>
</script>
</body>
</html>
