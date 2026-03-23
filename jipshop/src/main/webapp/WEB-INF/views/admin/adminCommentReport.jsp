<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 신고 상세</title>

<!-- 기존 관리자 공통 css -->
<link rel="stylesheet" href="${contextPath}/resources/css/admin/admin.css">
<link rel="stylesheet" href="./AdminCommentReport.css">
<!-- 현재 페이지 전용 css -->
<link rel="stylesheet" href="${contextPath}/resources/css/admin/adminCommentReport.css">
</head>
<body>

    <!-- 관리자 헤더 -->
    <jsp:include page="/WEB-INF/views/common/adminHeader.jsp" />

    <div class="admin-wrapper">
        
        <!-- 관리자 사이드바 -->
        <jsp:include page="/WEB-INF/views/common/adminSidebar.jsp" />

        <!-- 본문 -->
        <main class="admin-content report-detail-content">
            
            <div class="report-page-header">
                <h2>신고 사항</h2>
                <hr>
            </div>

            <section class="report-detail-wrap">
                
                <!-- 상단 정보 -->
                <div class="report-info-row">
                    <div class="report-info-item">
                        <span class="info-label">신고 사유 :</span>
                        <span class="info-value">
                            <c:out value="${reportDetail.reportTypeName}" />
                        </span>
                    </div>

                    <div class="report-info-item right">
                        <span class="info-label">신고일 :</span>
                        <span class="info-value">
                            <c:out value="${reportDetail.reportDate}" />
                        </span>
                    </div>
                </div>

                <!-- 신고 사유 상세 -->
                <div class="report-reason-box">
                    <div class="reason-title">신고 상세 사유</div>
                    <div class="reason-content">
                        <c:choose>
                            <c:when test="${not empty reportDetail.reportReason}">
                                <c:out value="${reportDetail.reportReason}" />
                            </c:when>
                            <c:otherwise>
                                별도 신고 사유가 없습니다.
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- 댓글 원문 -->
                <div class="report-comment-area">
                    <div class="comment-preview-title">신고된 댓글</div>

                    <div class="comment-preview-box">
                        <div class="comment-meta">
                            <div class="meta-left">
                                <span>댓글번호 : <c:out value="${reportDetail.commentId}" /></span>
                                <span>작성자 : <c:out value="${reportDetail.commentWriterId}" /></span>
                            </div>
                            <div class="meta-right">
                                <span>작성일 : <c:out value="${reportDetail.commentRegDate}" /></span>
                            </div>
                        </div>

                        <div class="comment-content-box">
                            <c:out value="${reportDetail.commentContent}" />
                        </div>

                        <div class="comment-link-guide">
                            영역을 누르면 댓글이 작성된 게시글/댓글 위치로 이동
                        </div>

                        <!-- 실제 상세 이동 링크 -->
                        <a href="${contextPath}/community/board/detail?boardNo=${reportDetail.boardNo}#comment-${reportDetail.commentId}"
                           class="comment-move-overlay"
                           title="댓글 원문 위치로 이동">
                        </a>
                    </div>
                </div>

                <!-- 하단 버튼 -->
                <div class="report-detail-btn-area">
                    <button type="button"
                            class="report-delete-btn"
                            onclick="openDeleteModal();">
                        삭제
                    </button>
                </div>

            </section>
        </main>
    </div>


    <!-- 삭제 확인 모달 -->
    <div id="deleteModal" class="report-modal">
        <div class="report-modal-content">
            <div class="report-modal-title">댓글 삭제</div>
            <div class="report-modal-text">
                해당 댓글을 삭제하시겠습니까?
            </div>

            <div class="report-modal-btn-area">
                <button type="button" class="modal-cancel-btn" onclick="closeDeleteModal();">취소</button>

                <form action="${contextPath}/admin/report/comment/delete" method="post" class="modal-delete-form">
                    <input type="hidden" name="reportId" value="${reportDetail.reportId}">
                    <input type="hidden" name="commentId" value="${reportDetail.commentId}">
                    <button type="submit" class="modal-delete-btn">삭제</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        function openDeleteModal() {
            document.getElementById("deleteModal").style.display = "flex";
        }

        function closeDeleteModal() {
            document.getElementById("deleteModal").style.display = "none";
        }

        window.onclick = function(e) {
            const modal = document.getElementById("deleteModal");
            if (e.target === modal) {
                closeDeleteModal();
            }
        }
    </script>

</body>
</html>