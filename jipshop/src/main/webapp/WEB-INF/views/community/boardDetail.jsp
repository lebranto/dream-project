<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${board.boardTitle}</title>
<link rel="stylesheet" href="${contextPath}/resources/css/community/boardDetail.css">
<link rel="stylesheet" href="${contextPath}/resources/css/community/communitySidebar.css">
<style type="text/css">
@charset "UTF-8";

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
    font-family: "맑은 고딕", "Malgun Gothic", sans-serif;
}

body {
    background: #f5f3ef;
    color: #3b3024;
}

a {
    text-decoration: none;
    color: inherit;
}

button {
    border: none;
    background: none;
    cursor: pointer;
}

.detail-wrap {
    width: min(1140px, 92%);
    margin: 30px auto 60px;
}

/* 상단 정보 */
.detail-top-box {
    width: 100%;
    border: 1px solid #ecdcb8;
    border-radius: 28px 28px 0 0;
    overflow: hidden;
    background: #fffdfa;
    box-shadow: 0 10px 28px rgba(95, 73, 37, 0.04);
}

.detail-top-row {
    display: grid;
    grid-template-columns: 12% 14% 1fr 12% 8% 8%;
    align-items: center;
    min-height: 56px;
    text-align: center;
    font-size: 14px;
    border-bottom: 1px solid #eadfc8;
}

.detail-head-row {
    background: #f7edd3;
    font-weight: 700;
    color: #7a6546;
}

.detail-value-row {
    background: #fffdfa;
    color: #4f4336;
}

.col-title {
    padding: 0 12px;
}

.col-category {
    display: flex;
    justify-content: center;
    gap: 6px;
    flex-wrap: wrap;
}

.badge {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 6px 14px;
    border-radius: 999px;
    background: #f8f1df;
    border: 1px solid #ead9b6;
    font-size: 12px;
    font-weight: 700;
    color: #735d3f;
}

/* 본문 */
.detail-content-box {
    width: 100%;
    min-height: 320px;
    padding: 28px;
    border: 1px solid #ecdcb8;
    border-top: none;
    background: #fffdfa;
}

.detail-content-text {
    font-size: 15px;
    line-height: 1.9;
    color: #423527;
    white-space: pre-wrap;
}

/* 이미지 */
.detail-media-box {
    width: 100%;
    display: flex;
    justify-content: center;
    gap: 18px;
    padding: 26px 0 12px;
    flex-wrap: wrap;
}

.media-item {
    width: 220px;
    height: 220px;
    border: 1px solid #ead9b6;
    border-radius: 24px;
    background: #fffaf2;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
}

.media-item img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
}

/* 반응 */
.reaction-area {
    display: flex;
    justify-content: center;
    gap: 18px;
    margin: 14px 0 24px;
}

.reaction-btn {
    width: 46px;
    height: 46px;
    border-radius: 50%;
    background: #f1eadc;
    border: 1px solid #e4d5b6;
    font-size: 20px;
    transition: 0.18s ease;
}

.reaction-btn:hover {
    transform: translateY(-1px);
}

.active-like {
    background: #efca61;
}

.active-dislike {
    background: #ddd3c1;
}

/* 수정삭제 */
.board-action-area {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
    margin-bottom: 18px;
}

.action-btn {
    min-width: 68px;
    height: 38px;
    padding: 0 16px;
    border-radius: 14px;
    background: #fbf4e3;
    border: 1px solid #e3d2ad;
    font-size: 13px;
    font-weight: 700;
    color: #4a3927;
    display: inline-flex;
    align-items: center;
    justify-content: center;
}

/* 댓글 작성 */
.comment-write-wrap {
    width: 100%;
    margin-top: 12px;
    border: 1px solid #ecdcb8;
    border-radius: 24px;
    overflow: hidden;
    background: #fffdfa;
    box-shadow: 0 10px 28px rgba(95, 73, 37, 0.04);
}

.comment-write-title {
    padding: 16px 18px;
    font-size: 15px;
    font-weight: 700;
    background: #f7edd3;
    color: #735f42;
    border-bottom: 1px solid #eadfc8;
}

.comment-write-box {
    padding: 18px;
}

.comment-write-box textarea {
    width: 100%;
    height: 96px;
    resize: none;
    border: 1px solid #e2d3b2;
    border-radius: 18px;
    padding: 14px;
    outline: none;
    font-size: 14px;
    background: #fffdfa;
    color: #423527;
}

.comment-write-box button {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    min-width: 82px;
    height: 38px;
    margin-left: auto;
    margin-top: 12px;
    padding: 0 16px;
    border-radius: 14px;
    background: linear-gradient(180deg, #efcc62 0%, #e4bb47 100%);
    color: #4b371f;
    font-size: 13px;
    font-weight: 700;
}

/* 댓글 목록 */
.comment-list-wrap {
    width: 100%;
    margin-top: 18px;
    border: 1px solid #ecdcb8;
    border-radius: 24px;
    overflow: hidden;
    background: #fffdfa;
    box-shadow: 0 10px 28px rgba(95, 73, 37, 0.04);
}

.comment-list-title {
    padding: 16px 18px;
    background: #f7edd3;
    font-size: 15px;
    font-weight: 700;
    color: #735f42;
    border-bottom: 1px solid #eadfc8;
}

.comment-item {
    display: grid;
    grid-template-columns: 140px 1fr 90px;
    align-items: center;
    min-height: 86px;
    border-bottom: 1px solid #eee2c8;
    padding: 0 18px;
}

.comment-item:last-child {
    border-bottom: none;
}

.comment-writer {
    text-align: left;
}

.writer-badge {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 6px 14px;
    border-radius: 999px;
    background: #f8f1df;
    border: 1px solid #ead9b6;
    font-size: 12px;
    font-weight: 700;
    color: #735d3f;
}

.comment-content {
    text-align: left;
    font-size: 14px;
    color: #3c3126;
    white-space: pre-wrap;
    line-height: 1.7;
    padding: 14px 0;
}

.comment-right {
    text-align: right;
}

.report-btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    min-width: 58px;
    height: 32px;
    padding: 0 10px;
    border: 1px solid #dfcfc1;
    border-radius: 12px;
    background: #faf4f1;
    font-size: 12px;
    color: #8b5b5b;
}

.comment-empty {
    padding: 36px 20px;
    text-align: center;
    color: #8a7964;
    font-size: 14px;
}

/* 모달 */
.modal-overlay {
    position: fixed;
    inset: 0;
    background: rgba(40, 32, 18, 0.36);
    display: none;
    align-items: center;
    justify-content: center;
    z-index: 9999;
}

.modal-overlay.show {
    display: flex;
}

.modal-box {
    width: 340px;
    padding: 28px 24px;
    background: #fffdf8;
    border: 1px solid #eadfc8;
    border-radius: 24px;
    text-align: center;
    box-shadow: 0 16px 40px rgba(50, 38, 18, 0.18);
}

.modal-box h3 {
    font-size: 22px;
    margin-bottom: 14px;
    color: #3f3123;
}

.modal-box p {
    font-size: 14px;
    color: #5b4a38;
    margin-bottom: 22px;
    line-height: 1.7;
}

.modal-btn-area {
    display: flex;
    justify-content: center;
    gap: 10px;
}

.modal-btn {
    min-width: 92px;
    height: 40px;
    border-radius: 14px;
    font-size: 13px;
    font-weight: 700;
}

.confirm-btn {
    background: linear-gradient(180deg, #efcc62 0%, #e4bb47 100%);
    color: #4b371f;
}

.cancel-btn {
    background: #eee5d6;
    color: #645441;
}

.report-modal-box {
    width: 430px;
    padding: 34px 28px;
}

.report-main-text {
    font-size: 16px;
    font-weight: 700;
    color: #3d3124;
    margin-bottom: 10px;
}

.report-sub-text {
    font-size: 14px;
    line-height: 1.7;
    color: #6a5844;
    margin-bottom: 24px;
}

.report-type-area {
    margin: 18px 0 14px;
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.report-type-label {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 14px;
    cursor: pointer;
    color: #4b3a2a;
}

.report-reason-area textarea {
    width: 100%;
    min-height: 90px;
    resize: none;
    border: 1px solid #e2d3b2;
    border-radius: 16px;
    padding: 12px;
    font-size: 14px;
    background: #fffdfa;
}
body {
    background: #f7f5f1 !important;
}

.detail-top-box,
.detail-content-box,
.comment-write-wrap,
.comment-list-wrap {
    background: #fffaf3 !important;
    border-color: #eadfc8 !important;
    box-shadow: 0 8px 22px rgba(92, 71, 39, 0.03) !important;
}

.detail-head-row,
.comment-write-title,
.comment-list-title {
    background: #f9efd9 !important;
    color: #7a6546 !important;
}

.detail-value-row,
.comment-item {
    background: #fffdf9 !important;
}

.action-btn {
    background: #f4ede2 !important;
    border: 1px solid #e2d7c7 !important;
    color: #564636 !important;
}

/* 수정/삭제 핑크 */
.action-btn.edit-btn {
    background: #f8dfe5 !important;
    border-color: #efc7d0 !important;
    color: #8a4f62 !important;
}

.action-btn.delete-btn {
    background: #f6d5dc !important;
    border-color: #eab8c3 !important;
    color: #914a5b !important;
}

.comment-write-box button,
.confirm-btn {
    background: linear-gradient(180deg, #efd16e 0%, #e6c04f 100%) !important;
    color: #4a3927 !important;
}

.cancel-btn {
    background: #f2e9dd !important;
    color: #665442 !important;
}

.report-btn {
    background: #fbebee !important;
    border-color: #efd0d7 !important;
    color: #9a5a68 !important;
}
</style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="community-layout">

    <jsp:include page="/WEB-INF/views/community/communitySidebar.jsp" />

    <div class="community-content">
        <div class="detail-wrap">

            <!-- 상단 정보 -->
            <div class="detail-top-box">
                <div class="detail-top-row detail-head-row">
                    <div class="col-writer">작성자</div>
                    <div class="col-category">카테고리</div>
                    <div class="col-title">제목</div>
                    <div class="col-date">작성일자</div>
                    <div class="col-count">조회수</div>
                    <div class="col-like">좋아요수</div>
                </div>

                <div class="detail-top-row detail-value-row">
                    <div class="col-writer">${board.memberId}</div>

                    <div class="col-category">
                        <c:if test="${not empty board.categoryName}">
                            <span class="badge">${board.categoryName}</span>
                        </c:if>
                    </div>

                    <div class="col-title">${board.boardTitle}</div>
                    <div class="col-date">${board.createDate}</div>
                    <div class="col-count">${board.readCount}</div>
                    <div class="col-like" id="likeCountArea">${likeCount}</div>
                </div>
            </div>

            <!-- 내용 -->
            <div class="detail-content-box">
                <div class="detail-content-text">${board.boardContent}</div>
            </div>

            <!-- 이미지 -->
            <div class="detail-media-box">
                <c:choose>
                    <c:when test="${not empty imageList}">
                        <c:forEach var="img" items="${imageList}" varStatus="status">
                            <c:if test="${status.index < 3}">
                                <div class="media-item">
                                    <img src="${contextPath}${img.filePath}${img.changeName}" alt="게시글 이미지">
                                </div>
                            </c:if>
                        </c:forEach>

                        <c:if test="${imageList.size() == 1}">
                            <div class="media-item empty-box"></div>
                            <div class="media-item empty-box"></div>
                        </c:if>

                        <c:if test="${imageList.size() == 2}">
                            <div class="media-item empty-box"></div>
                        </c:if>
                    </c:when>

                    <c:otherwise>
                        <div class="media-item empty-box"></div>
                        <div class="media-item empty-box"></div>
                        <div class="media-item empty-box"></div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 좋아요 / 싫어요 -->
            <div class="reaction-area">
                <button type="button"
                        id="likeBtn"
                        class="reaction-btn ${likeCheck > 0 ? 'active-like' : ''}">
                    👍
                </button>

                <button type="button"
                        id="dislikeBtn"
                        class="reaction-btn">
                    👎
                </button>
            </div>

            <!-- 수정 / 삭제 -->
            <div class="board-action-area">
                <c:if test="${loginMemberNo ne 0 and loginMemberNo eq board.memberNo}">
                    <a class="action-btn"
                       href="${contextPath}/community/rewrite?boardNo=${board.boardNo}">
                        수정
                    </a>

                    <a href="javascript:void(0);"
                       class="action-btn"
                       id="openDeleteModalBtn">
                        삭제
                    </a>
                </c:if>
            </div>

            <!-- 댓글 작성 -->
            <div class="comment-write-wrap">
                <div class="comment-write-title">댓글 작성</div>
                <div class="comment-write-box">
                    <form id="commentForm" action="${contextPath}/community/insertComment" method="post">
                        <input type="hidden" name="boardNo" value="${board.boardNo}">
                        <textarea name="commentContent" id="commentInput" placeholder="댓글을 입력해주세요."></textarea>
                        <button type="submit" id="commentSubmitBtn">등록</button>
                    </form>
                </div>
            </div>

            <!-- 댓글 목록 -->
            <div class="comment-list-wrap">
                <div class="comment-list-title">댓글</div>

                <div id="commentList">
                    <c:choose>
                        <c:when test="${not empty commentList}">
                            <c:forEach var="comment" items="${commentList}">
                                <div class="comment-item">
                                    <div class="comment-writer">
                                        <span class="writer-badge">${comment.memberId}</span>
                                    </div>

                                    <div class="comment-content">${comment.commentContent}</div>

                                    <div class="comment-right">
                                        <button type="button"
                                                class="report-btn"
                                                onclick="openReportModal('${comment.commentId}')">
                                            신고
                                        </button>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>

                        <c:otherwise>
                            <div class="comment-empty">등록된 댓글이 없습니다.</div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        </div>
    </div>

</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script>
document.addEventListener("DOMContentLoaded", function () {

    const contextPath = "${contextPath}";
    const boardNo = "${board.boardNo}";
    const loginMemberNo = "${loginMemberNo}";

    const likeBtn = document.getElementById("likeBtn");
    const dislikeBtn = document.getElementById("dislikeBtn");
    const likeCountArea = document.getElementById("likeCountArea");

    const deleteModal = document.getElementById("deleteModal");
    const openDeleteModalBtn = document.getElementById("openDeleteModalBtn");
    const cancelDeleteBtn = document.getElementById("cancelDeleteBtn");
    const confirmDeleteBtn = document.getElementById("confirmDeleteBtn");

    const commentForm = document.getElementById("commentForm");
    const commentInput = document.getElementById("commentInput");

    const reportModal = document.getElementById("reportModal");
    const cancelReportBtn = document.getElementById("cancelReportBtn");
    const reportCommentId = document.getElementById("reportCommentId");
    const reportReason = document.getElementById("reportReason");
    const reportForm = document.getElementById("reportForm");

    if (likeBtn) {
        likeBtn.addEventListener("click", function () {

            if (!loginMemberNo || loginMemberNo === "0") {
                alert("로그인 후 이용 가능합니다.");
                return;
            }

            fetch(contextPath + "/community/like", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
                },
                body: "boardNo=" + encodeURIComponent(boardNo)
            })
            .then(response => response.json())
            .then(data => {
                if (data.result === "loginRequired") {
                    alert("로그인 후 이용 가능합니다.");
                    return;
                }

                likeCountArea.innerText = data.likeCount;

                if (data.likeCheck === "1" || data.likeCheck === 1) {
                    likeBtn.classList.add("active-like");
                } else {
                    likeBtn.classList.remove("active-like");
                }
            })
            .catch(error => {
                console.error(error);
                alert("좋아요 처리 중 오류가 발생했습니다.");
            });
        });
    }

    if (dislikeBtn) {
        dislikeBtn.addEventListener("click", function (e) {
            e.preventDefault();
        });
    }

    if (openDeleteModalBtn && deleteModal) {
        openDeleteModalBtn.addEventListener("click", function() {
            deleteModal.classList.add("show");
        });
    }

    if (cancelDeleteBtn && deleteModal) {
        cancelDeleteBtn.addEventListener("click", function() {
            deleteModal.classList.remove("show");
        });
    }

    if (confirmDeleteBtn) {
        confirmDeleteBtn.addEventListener("click", function() {
            alert("게시글이 삭제되었습니다.");
            location.href = contextPath + "/community/delete?boardNo=" + boardNo;
        });
    }

    if (commentForm && commentInput) {
        commentForm.addEventListener("submit", function(e) {
            const content = commentInput.value.trim();

            if (content === "") {
                e.preventDefault();
                alert("댓글 내용을 입력해주세요.");
                commentInput.focus();
            }
        });
    }

    window.openReportModal = function(commentId) {
        if (!loginMemberNo || loginMemberNo === "0") {
            alert("로그인 후 이용 가능합니다.");
            return;
        }

        if (!commentId) {
            alert("신고할 댓글 정보가 없습니다.");
            return;
        }

        reportCommentId.value = commentId;
        reportReason.value = "";

        document.querySelectorAll('input[name="reportTypeId"]').forEach(function(radio) {
            radio.checked = false;
        });

        reportModal.classList.add("show");
    };

    if (cancelReportBtn && reportModal) {
        cancelReportBtn.addEventListener("click", function() {
            reportModal.classList.remove("show");
            reportCommentId.value = "";
            reportReason.value = "";

            document.querySelectorAll('input[name="reportTypeId"]').forEach(function(radio) {
                radio.checked = false;
            });
        });
    }

    if (reportModal) {
        reportModal.addEventListener("click", function(e) {
            if (e.target === reportModal) {
                reportModal.classList.remove("show");
                reportCommentId.value = "";
                reportReason.value = "";

                document.querySelectorAll('input[name="reportTypeId"]').forEach(function(radio) {
                    radio.checked = false;
                });
            }
        });
    }

    if (reportForm) {
        reportForm.addEventListener("submit", function(e) {
            const selectedType = document.querySelector('input[name="reportTypeId"]:checked');

            if (!reportCommentId.value) {
                e.preventDefault();
                alert("신고 대상 댓글 정보가 없습니다.");
                return;
            }

            if (!selectedType) {
                e.preventDefault();
                alert("신고 유형을 선택해주세요.");
                return;
            }
        });
    }

});
</script>
<c:if test="${not empty alertMsg}">
    <script>
        alert("${alertMsg}");
    </script>
</c:if>
</body>
</html>