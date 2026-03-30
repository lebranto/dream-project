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
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

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

<!-- 삭제 모달 -->
<div class="modal-overlay" id="deleteModal">
    <div class="modal-box">
        <h3>게시글 삭제</h3>
        <p>정말 삭제하시겠습니까?</p>
        <div class="modal-btn-area">
            <button type="button" class="modal-btn cancel-btn" id="cancelDeleteBtn">취소</button>
            <button type="button" class="modal-btn confirm-btn" id="confirmDeleteBtn">삭제</button>
        </div>
    </div>
</div>

<!-- 신고 모달 -->
<div class="modal-overlay" id="reportModal">
    <div class="modal-box report-modal-box">
        <h3>댓글 신고</h3>
        <p class="report-main-text">신고 유형을 선택해주세요.</p>
        <p class="report-sub-text">신고된 댓글은 운영팀 확인 후 조치됩니다.</p>

        <form id="reportForm" action="${contextPath}/community/reportComment" method="post">
            <input type="hidden" name="boardNo" value="${board.boardNo}">
            <input type="hidden" name="commentId" id="reportCommentId">

            <div class="report-type-area">
                <label class="report-type-label">
                    <input type="radio" name="reportTypeId" value="1">
                    욕설
                </label>

                <label class="report-type-label">
                    <input type="radio" name="reportTypeId" value="2">
                    광고
                </label>

                <label class="report-type-label">
                    <input type="radio" name="reportTypeId" value="3">
                    기타
                </label>
            </div>

            <div class="report-reason-area">
                <textarea name="reportReason"
                          id="reportReason"
                          placeholder="신고 사유를 입력해주세요. (선택)"></textarea>
            </div>

            <div class="modal-btn-area">
                <button type="button" class="modal-btn cancel-btn" id="cancelReportBtn">취소</button>
                <button type="submit" class="modal-btn confirm-btn" id="confirmReportBtn">신고</button>
            </div>
        </form>
    </div>
</div>

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

</body>
</html>