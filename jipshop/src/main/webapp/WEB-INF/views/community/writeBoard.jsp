<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<link rel="stylesheet" href="${contextPath}/resources/css/community/writeBoard.css">
<link rel="stylesheet" href="./writeBoard.css">

<style>
    .custom-modal-overlay{
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0,0,0,0.35);
        display: none;
        justify-content: center;
        align-items: center;
        z-index: 9999;
    }

    .custom-modal-overlay.show{
        display: flex;
    }

    .custom-modal{
        width: 320px;
        background: #fff;
        border-radius: 10px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        padding: 28px 24px 22px;
        text-align: center;
    }

    .custom-modal-message{
        font-size: 15px;
        color: #222;
        line-height: 1.6;
        margin-bottom: 20px;
        word-break: keep-all;
    }

    .custom-modal-btn{
        display: inline-flex;
        justify-content: center;
        align-items: center;
        min-width: 90px;
        height: 38px;
        border-radius: 6px;
        background-color: #efc24f;
        color: #222;
        text-decoration: none;
        font-size: 14px;
        font-weight: 700;
        cursor: pointer;
        border: none;
    }
</style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="write-wrap">

    <form id="writeForm" action="${contextPath}/community/insertBoard" method="post" enctype="multipart/form-data">
  		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        <c:choose>
            <c:when test="${param.boardType eq 'myKidBoard'}">
                <input type="hidden" name="boardCode" value="1">
            </c:when>
            <c:when test="${param.boardType eq 'tip'}">
                <input type="hidden" name="boardCode" value="2">
            </c:when>
            <c:when test="${param.boardType eq 'free'}">
                <input type="hidden" name="boardCode" value="3">
            </c:when>
            <c:otherwise>
                <input type="hidden" name="boardCode" value="1">
            </c:otherwise>
        </c:choose>

        <input type="hidden" name="categoryCode" id="categoryCode">

        <div class="board-title-box">
            <h1 class="board-title">
                <c:choose>
                    <c:when test="${param.boardType eq 'myKidBoard'}">우리 아이 자랑 게시글 작성</c:when>
                    <c:when test="${param.boardType eq 'tip'}">육아 꿀팁 게시글 작성</c:when>
                    <c:when test="${param.boardType eq 'free'}">자유 게시판 게시글 작성</c:when>
                    <c:otherwise>게시글 작성</c:otherwise>
                </c:choose>
            </h1>
        </div>

        <c:if test="${param.boardType eq 'tip'}">
            <div class="form-block inline-block">
                <div class="form-label">
                    카테고리 선택 <span class="required">*</span>
                </div>

                <div class="select-btn-group">
                    <button type="button" class="select-btn category-btn" data-code="201">강아지</button>
                    <button type="button" class="select-btn category-btn" data-code="202">고양이</button>
                    <button type="button" class="select-btn category-btn" data-code="203">공통</button>
                </div>
            </div>
        </c:if>

        <c:if test="${param.boardType eq 'free'}">
            <div class="form-block inline-block">
                <div class="form-label">
                    카테고리 선택 <span class="required">*</span>
                </div>

                <div class="select-btn-group">
                    <button type="button" class="select-btn category-btn" data-code="301">질문</button>
                    <button type="button" class="select-btn category-btn" data-code="302">고민</button>
                    <button type="button" class="select-btn category-btn" data-code="303">자유</button>
                </div>
            </div>
        </c:if>

        <div class="form-block">
            <div class="form-label">
                제목 작성 <span class="required">*</span>
            </div>

            <input type="text" id="boardTitle" name="boardTitle" class="text-input" placeholder="제목을 입력해주세요">
        </div>

        <div class="form-block">
            <div class="form-label">
                내용 작성 <span class="required">*</span>
            </div>

            <textarea id="boardContent" name="boardContent" class="textarea-input" placeholder="5글자 이상 작성해주세요"></textarea>
        </div>

        <div class="form-block">
            <div class="form-label">사진 업로드</div>
            <div class="upload-guide">최대 3개까지만 업로드 가능합니다.</div>

            <div class="upload-box">
                <div class="preview-row" id="imagePreviewArea"></div>
            </div>

            <div class="upload-control-row">
                <label for="imageInput" class="file-select-btn">사진 첨부</label>
                <span class="file-count-text" id="imageCountText">0개</span>
            </div>

            <input type="file" id="imageInput" name="imageFiles" accept="image/*" multiple hidden>
        </div>

        <div class="submit-area">
            <button type="submit" id="submitBtn" class="submit-link" style="border:none; cursor:pointer;">작성완료</button>
        </div>

    </form>
</div>

<div class="custom-modal-overlay" id="customModal">
    <div class="custom-modal">
        <div class="custom-modal-message" id="customModalMessage">필수 항목을 확인해주세요.</div>
        <button type="button" class="custom-modal-btn" id="customModalConfirm">확인</button>
    </div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script>
    const boardType = "${param.boardType}";
    const categoryButtons = document.querySelectorAll(".category-btn");
    const categoryCodeInput = document.getElementById("categoryCode");

    const titleInput = document.getElementById("boardTitle");
    const contentInput = document.getElementById("boardContent");

    const imageInput = document.getElementById("imageInput");
    const imagePreviewArea = document.getElementById("imagePreviewArea");
    const imageCountText = document.getElementById("imageCountText");

    const writeForm = document.getElementById("writeForm");

    const customModal = document.getElementById("customModal");
    const customModalMessage = document.getElementById("customModalMessage");
    const customModalConfirm = document.getElementById("customModalConfirm");

    let selectedImages = [];
    let focusTarget = null;

    function showModal(message, target) {
        customModalMessage.textContent = message;
        focusTarget = target || null;
        customModal.classList.add("show");
    }

    function closeModal() {
        customModal.classList.remove("show");
        if (focusTarget) {
            focusTarget.focus();
        }
    }

    customModalConfirm.addEventListener("click", closeModal);

    customModal.addEventListener("click", function(e) {
        if (e.target === customModal) {
            closeModal();
        }
    });

    categoryButtons.forEach(function(btn) {
        btn.addEventListener("click", function() {
            categoryButtons.forEach(function(item) {
                item.classList.remove("active");
            });
            this.classList.add("active");
            categoryCodeInput.value = this.dataset.code;
        });
    });

    if (boardType === "myKidBoard") {
        categoryCodeInput.value = "101";
    }

    imageInput.addEventListener("change", function(e) {
        const files = Array.from(e.target.files);

        if (files.length === 0) return;

        const mergedFiles = selectedImages.concat(files);

        if (mergedFiles.length > 3) {
            showModal("사진은 최대 3개까지만 첨부할 수 있습니다.");
            return;
        }

        selectedImages = mergedFiles;
        updateImageInput();
        renderImagePreview();
    });

    function updateImageInput() {
        const dt = new DataTransfer();
        selectedImages.forEach(function(file) {
            dt.items.add(file);
        });
        imageInput.files = dt.files;
    }

    function renderImagePreview() {
        imagePreviewArea.innerHTML = "";

        selectedImages.forEach(function(file, index) {
            const reader = new FileReader();

            reader.onload = function(e) {
                const item = document.createElement("div");
                item.className = "preview-item";

                item.innerHTML =
                    '<img src="' + e.target.result + '" alt="이미지 미리보기">' +
                    '<button type="button" class="remove-btn" data-index="' + index + '">×</button>';

                imagePreviewArea.appendChild(item);
                bindRemoveButtons();
            };

            reader.readAsDataURL(file);
        });

        imageCountText.textContent = selectedImages.length + "개";
    }

    function bindRemoveButtons() {
        const removeButtons = document.querySelectorAll(".remove-btn");

        removeButtons.forEach(function(btn) {
            btn.onclick = function() {
                const index = parseInt(this.dataset.index);
                selectedImages.splice(index, 1);
                updateImageInput();
                renderImagePreview();
            };
        });
    }


    document.addEventListener("DOMContentLoaded", function() {
        const writeForm = document.querySelector("#writeForm");
        const titleInput = document.querySelector('input[name="boardTitle"]');
        const contentInput = document.querySelector('textarea[name="boardContent"]');
        const categoryCodeInput = document.querySelector('input[name="categoryCode"]');
        
        const loginMemberNo = "${loginUser.memberNo}";
        const boardType = "${param.boardType}"; 

        if (writeForm) {
            writeForm.addEventListener("submit", function(e) {
                const title = titleInput ? titleInput.value.trim() : "";
                const content = contentInput ? contentInput.value.trim() : "";
                const categoryCode = categoryCodeInput ? categoryCodeInput.value : "";

                if (!loginMemberNo || loginMemberNo === "" || loginMemberNo === "0") {
                    e.preventDefault();
                    alert("로그인 후 사용 가능합니다.");
                    location.href = "${pageContext.request.contextPath}/member/login";
                    return;
                }


        if (boardType === "tip" || boardType === "free") {
            if (!categoryCode) {
                e.preventDefault();
                showModal("카테고리를 선택해주세요.");
                return;
            }
        }

        if (title === "") {
            e.preventDefault();
            showModal("제목을 입력해주세요.", titleInput);
            return;
        }

        if (content.length < 5) {
            e.preventDefault();
            showModal("내용은 5자 이상 입력해주세요.", contentInput);
            return;
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