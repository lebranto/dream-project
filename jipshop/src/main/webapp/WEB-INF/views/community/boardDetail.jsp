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

    <!-- 이미지 영역 : 최대 3장 -->
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

    <!-- 수정/삭제 -->
    <div class="board-action-area">
    <c:if test="${loginMemberNo ne 0 and loginMemberNo eq board.memberNo}">
        <a class="action-btn"
           href="${pageContext.request.contextPath}/community/rewrite?boardNo=${board.boardNo}">
            수정
        </a>

        <a class="action-btn"
           href="${pageContext.request.contextPath}/community/delete?boardNo=${board.boardNo}"
           onclick="return confirm('정말 삭제하시겠습니까?');">
            삭제
        </a>
    </c:if>
</div>

    <!-- 댓글 등록 -->
    <div class="comment-write-wrap">
        <div class="comment-write-title">댓글</div>
        <div class="comment-write-box">
            <textarea id="commentInput" placeholder="댓글을 입력해주세요"></textarea>
            <button type="button" id="commentSubmitBtn">등록</button>
        </div>
    </div>

    <!-- 댓글 목록 -->
    <div class="comment-list-wrap">
        <div class="comment-list-title">댓글창</div>

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
                                <button type="button" class="report-btn">신고</button>
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
        <p>삭제하시겠습니까?</p>
        <div class="modal-btn-area">
            <button type="button" class="modal-btn confirm-btn" id="confirmDeleteBtn">삭제</button>
            <button type="button" class="modal-btn cancel-btn" id="cancelDeleteBtn">취소</button>
        </div>
    </div>
</div>

<!-- 신고 모달 -->
<div class="modal-overlay" id="reportModal">
    <div class="modal-box">
        <h3>댓글 신고하기</h3>
        <p>해당 댓글을 신고하시겠습니까?</p>
        <div class="modal-btn-area">
            <button type="button" class="modal-btn confirm-btn" id="confirmReportBtn">신고하기</button>
            <button type="button" class="modal-btn cancel-btn" id="cancelReportBtn">취소</button>
        </div>
    </div>
</div>

<script>

document.addEventListener("DOMContentLoaded", function () {
    const likeBtn = document.getElementById("likeBtn");
    const dislikeBtn = document.getElementById("dislikeBtn");

    if (!likeBtn || !dislikeBtn) return;

    likeBtn.addEventListener("click", function () {
        likeBtn.classList.toggle("active-like");
        dislikeBtn.classList.remove("active-dislike");
    });

    dislikeBtn.addEventListener("click", function () {
        dislikeBtn.classList.toggle("active-dislike");
        likeBtn.classList.remove("active-like");
    });
});


  

    /* 삭제 모달 */
    const deleteModal = document.getElementById("deleteModal");
    const openDeleteModalBtn = document.getElementById("openDeleteModalBtn");
    const cancelDeleteBtn = document.getElementById("cancelDeleteBtn");
    const confirmDeleteBtn = document.getElementById("confirmDeleteBtn");

    openDeleteModalBtn.addEventListener("click", function() {
        deleteModal.classList.add("show");
    });

    cancelDeleteBtn.addEventListener("click", function() {
        deleteModal.classList.remove("show");
    });

    confirmDeleteBtn.addEventListener("click", function() {
        alert("삭제완료");
        location.href = contextPath + "/community/main";
    });

    /* 댓글 등록 */
    const commentInput = document.getElementById("commentInput");
    const commentSubmitBtn = document.getElementById("commentSubmitBtn");
    const commentList = document.getElementById("commentList");

    commentSubmitBtn.addEventListener("click", function() {
        const content = commentInput.value.trim();

        if (content === "") return;

        const emptyBox = document.querySelector(".comment-empty");
        if (emptyBox) emptyBox.remove();

        const newComment = document.createElement("div");
        newComment.className = "comment-item";
        newComment.innerHTML = `
            <div class="comment-writer">
                <span class="writer-badge">작성자</span>
            </div>
            <div class="comment-content"></div>
            <div class="comment-right">
                <button type="button" class="report-btn">신고</button>
            </div>
        `;

        newComment.querySelector(".comment-content").innerText = content;
        commentList.prepend(newComment);
        commentInput.value = "";

        bindReportButtons();
    });

    /* 신고 모달 */
    const reportModal = document.getElementById("reportModal");
    const confirmReportBtn = document.getElementById("confirmReportBtn");
    const cancelReportBtn = document.getElementById("cancelReportBtn");

    function handleReportClick() {
        reportModal.classList.add("show");
    }

    function bindReportButtons() {
        const reportBtns = document.querySelectorAll(".report-btn");

        reportBtns.forEach(function(btn) {
            btn.removeEventListener("click", handleReportClick);
            btn.addEventListener("click", handleReportClick);
        });
    }

    cancelReportBtn.addEventListener("click", function() {
        reportModal.classList.remove("show");
    });

    confirmReportBtn.addEventListener("click", function() {
        alert("신고되었습니다");
        location.reload();
    });

    bindReportButtons();
});
</script>

</body>
</html>