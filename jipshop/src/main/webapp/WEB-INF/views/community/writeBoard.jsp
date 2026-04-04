<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>

<link rel="stylesheet" href="${contextPath}/resources/css/community/writeBoard.css">

<style>
html, body {
    margin: 0 !important;
    padding: 0 !important;
    background: #f8f4ec !important;
    font-family: "Malgun Gothic", "맑은 고딕", sans-serif !important;
    color: #3f3427 !important;
}

body {
    background: #f8f4ec !important;
}

.write-wrap {
    width: min(1320px, 92%) !important;
    margin: 0 auto !important;
    padding: 38px 0 80px !important;
    background: transparent !important;
}

#writeForm {
    width: 100% !important;
    margin: 0 !important;
    padding: 0 !important;
    background: transparent !important;
}

.board-title-box {
    display: inline-flex !important;
    align-items: center !important;
    justify-content: center !important;
    width: 350px !important;
    min-height: 100px !important;
    margin: 0 0 24px 0 !important;
    padding: 0 !important;
    border-radius: 38px !important;
    border: 1px solid #e0d0b5 !important;
    background: #f7e5c0 !important;
    box-shadow: none !important;
}

.board-title {
    margin: 0 !important;
    font-size: 30px !important;
    font-weight: 900 !important;
    line-height: 1.45 !important;
    text-align: center !important;
    color: #3d3124 !important;
    word-break: keep-all !important;
}

.form-block,
.inline-block {
    width: 100% !important;
    margin: 0 0 18px 0 !important;
    padding: 28px 30px !important;
    border: 1px solid #e8dccb !important;
    border-radius: 30px !important;
    background: #fdfbf7 !important;
    box-shadow: none !important;
}

.form-label {
    margin-bottom: 16px !important;
    font-size: 16px !important;
    font-weight: 800 !important;
    color: #3f3427 !important;
}

.required {
    color: #d69a47 !important;
}

.select-btn-group {
    display: flex !important;
    flex-wrap: wrap !important;
    gap: 12px !important;
    align-items: center !important;
}

.select-btn {
    min-width: 92px !important;
    height: 42px !important;
    padding: 0 20px !important;
    border: 1px solid #e1cfac !important;
    border-radius: 999px !important;
    background: #f7f1e4 !important;
    color: #3f3427 !important;
    font-size: 14px !important;
    font-weight: 700 !important;
    cursor: pointer !important;
    box-shadow: none !important;
    outline: none !important;
}

.select-btn.active {
    background: #ecc75e !important;
    border-color: #ecc75e !important;
    color: #3a2d1d !important;
}

.text-input,
.textarea-input {
    width: 100% !important;
    display: block !important;
    border: 1px solid #eadfce !important;
    border-radius: 24px !important;
    background: #fffdfa !important;
    color: #3f3427 !important;
    outline: none !important;
    box-shadow: none !important;
}

.text-input {
    height: 60px !important;
    padding: 0 18px !important;
    font-size: 15px !important;
}

.textarea-input {
    min-height: 300px !important;
    padding: 18px 20px !important;
    resize: none !important;
    font-size: 15px !important;
    line-height: 1.7 !important;
}

.text-input::placeholder,
.textarea-input::placeholder {
    color: #b9a58a !important;
}

.text-input:focus,
.textarea-input:focus {
    border-color: #e0b950 !important;
    background: #fffdf8 !important;
}

.upload-guide {
    margin-bottom: 12px !important;
    font-size: 14px !important;
    font-weight: 600 !important;
    color: #8a7861 !important;
}

.upload-box {
    width: 100% !important;
    min-height: 280px !important;
    padding: 20px !important;
    border: 2px dashed #e7d4a9 !important;
    border-radius: 28px !important;
    background: #fff9ef !important;
}

.preview-row {
    display: flex !important;
    flex-wrap: wrap !important;
    gap: 14px !important;
    min-height: 120px !important;
}

.preview-item {
    position: relative !important;
    width: 160px !important;
    height: 160px !important;
    border: 1px solid #e4d7c1 !important;
    border-radius: 22px !important;
    overflow: hidden !important;
    background: #fff !important;
}

.preview-item img {
    width: 100% !important;
    height: 100% !important;
    object-fit: cover !important;
    display: block !important;
}

.remove-btn {
    position: absolute !important;
    top: 10px !important;
    right: 10px !important;
    width: 32px !important;
    height: 32px !important;
    border: none !important;
    border-radius: 50% !important;
    background: rgba(0,0,0,0.65) !important;
    color: #fff !important;
    font-size: 20px !important;
    cursor: pointer !important;
}
.board-title {
    font-size: 20px !important;
    line-height: 1.4 !important;
}


.upload-control-row {
    display: flex !important;
    align-items: center !important;
    gap: 14px !important;
    margin-top: 16px !important;
    flex-wrap: wrap !important;
}

.file-select-btn {
    display: inline-flex !important;
    align-items: center !important;
    justify-content: center !important;
    min-width: 110px !important;
    height: 42px !important;
    padding: 0 18px !important;
    border: 1px solid #e1d3bd !important;
    border-radius: 999px !important;
    background: #f7f0e3 !important;
    color: #3f3427 !important;
    font-size: 13px !important;
    font-weight: 800 !important;
    text-decoration: none !important;
    cursor: pointer !important;
}

.file-count-text {
    font-size: 14px !important;
    font-weight: 700 !important;
    color: #8b7962 !important;
}

.submit-area {
    display: flex !important;
    justify-content: center !important;
    margin-top: 28px !important;
}

.submit-link {
    min-width: 180px !important;
    height: 54px !important;
    padding: 0 28px !important;
    border: none !important;
    border-radius: 18px !important;
    background: #efc85c !important;
    color: #3b2d16 !important;
    font-size: 16px !important;
    font-weight: 900 !important;
    cursor: pointer !important;
    box-shadow: none !important;
}

.custom-modal-overlay {
    position: fixed !important;
    inset: 0 !important;
    background: rgba(0,0,0,0.35) !important;
    display: none !important;
    justify-content: center !important;
    align-items: center !important;
    z-index: 9999 !important;
}

.custom-modal-overlay.show {
    display: flex !important;
}

.custom-modal {
    width: 340px !important;
    background: #fffdf8 !important;
    border-radius: 16px !important;
    padding: 28px 24px 22px !important;
    box-shadow: 0 12px 30px rgba(0,0,0,0.16) !important;
    text-align: center !important;
}

.custom-modal-message {
    margin-bottom: 18px !important;
    font-size: 15px !important;
    color: #2f251c !important;
    line-height: 1.6 !important;
}

.custom-modal-btn {
    min-width: 90px !important;
    height: 40px !important;
    border: none !important;
    border-radius: 10px !important;
    background: #efc85c !important;
    color: #3b2d16 !important;
    font-size: 14px !important;
    font-weight: 800 !important;
    cursor: pointer !important;
}


@media (max-width: 768px) {
    .write-wrap {
        width: 94% !important;
    }

    .board-title-box {
    display: inline-flex !important;
    align-items: center !important;
    justify-content: center !important;

    width: 200px !important;   /* 가로 줄임 */
    height: 100px !important;  /* 높이 확 줄임 */

    margin-bottom: 16px !important;
    padding: 0 !important;

    border-radius: 20px !important;
    background: #f3ead8 !important;
    border: 1px solid #e0d0b5 !important;
}

    .board-title {
        font-size: 25px !important;
    }

    .form-block,
    .inline-block {
        padding: 22px 18px !important;
        border-radius: 24px !important;
    }

    .preview-item {
        width: calc(50% - 7px) !important;
        height: 150px !important;
    }
    
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
                    <button type="button" class="select-btn category-btn" data-code="101">강아지</button>
                    <button type="button" class="select-btn category-btn" data-code="102">고양이</button>
                    <button type="button" class="select-btn category-btn" data-code="103">공통</button>
                </div>
            </div>
        </c:if>

        <c:if test="${param.boardType eq 'free'}">
            <div class="form-block inline-block">
                <div class="form-label">
                    카테고리 선택 <span class="required">*</span>
                </div>

                <div class="select-btn-group">
                    <button type="button" class="select-btn category-btn" data-code="201">질문</button>
                    <button type="button" class="select-btn category-btn" data-code="202">고민</button>
                    <button type="button" class="select-btn category-btn" data-code="203">자유</button>
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
document.addEventListener("DOMContentLoaded", function() {
    const boardType = "${param.boardType}";
    const loginMemberNo = "${empty loginUser ? '' : loginUser.memberNo}";

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
        if (customModalMessage) {
            customModalMessage.textContent = message;
        } else {
            alert(message);
        }

        focusTarget = target || null;

        if (customModal) {
            customModal.classList.add("show");
        }
    }

    function closeModal() {
        if (customModal) {
            customModal.classList.remove("show");
        }

        if (focusTarget) {
            focusTarget.focus();
        }
    }

    if (customModalConfirm) {
        customModalConfirm.addEventListener("click", closeModal);
    }

    if (customModal) {
        customModal.addEventListener("click", function(e) {
            if (e.target === customModal) {
                closeModal();
            }
        });
    }

    if (categoryButtons.length > 0) {
        categoryButtons.forEach(function(btn) {
            btn.addEventListener("click", function() {
                categoryButtons.forEach(function(item) {
                    item.classList.remove("active");
                });

                this.classList.add("active");
                if (categoryCodeInput) {
                    categoryCodeInput.value = this.dataset.code;
                }
            });
        });
    }

    if (boardType === "myKidBoard" && categoryCodeInput) {
        categoryCodeInput.value = "101";
    }

    if (imageInput) {
        imageInput.addEventListener("change", function(e) {
            const files = Array.from(e.target.files);

            if (files.length === 0) return;

            const mergedFiles = selectedImages.concat(files);

            if (mergedFiles.length > 3) {
                showModal("사진은 최대 3개까지만 첨부할 수 있습니다.");
                imageInput.value = "";
                return;
            }

            selectedImages = mergedFiles;
            updateImageInput();
            renderImagePreview();
        });
    }

    function updateImageInput() {
        if (!imageInput || !imageCountText) return;

        const dt = new DataTransfer();

        selectedImages.forEach(function(file) {
            dt.items.add(file);
        });

        imageInput.files = dt.files;
        imageCountText.textContent = selectedImages.length + "개";
    }

    function renderImagePreview() {
        if (!imagePreviewArea || !imageCountText) return;

        imagePreviewArea.innerHTML = "";

        if (selectedImages.length === 0) {
            imageCountText.textContent = "0개";
            return;
        }

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
    }

    function bindRemoveButtons() {
        const removeButtons = document.querySelectorAll(".remove-btn");

        removeButtons.forEach(function(btn) {
            btn.onclick = function() {
                const index = parseInt(this.dataset.index, 10);
                selectedImages.splice(index, 1);
                updateImageInput();
                renderImagePreview();
            };
        });
    }

    if (writeForm) {
        writeForm.addEventListener("submit", function(e) {
            const title = titleInput ? titleInput.value.trim() : "";
            const content = contentInput ? contentInput.value.trim() : "";
            const categoryCode = categoryCodeInput ? categoryCodeInput.value : "";

            if ((boardType === "tip" || boardType === "free") && (!categoryCode || categoryCode === "0")) {
                e.preventDefault();
                showModal("카테고리를 선택해주세요.");
                return;
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
    } else {
        console.log("writeForm 못 찾음");
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