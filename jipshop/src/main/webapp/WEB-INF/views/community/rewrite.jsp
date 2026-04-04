<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<link rel="stylesheet" href="${contextPath}/resources/css/community/rewrite.css">

<style>
    * {
        box-sizing: border-box;
    }

    :root {
        --bg-main: #fbf6ee;
        --bg-soft: #fffaf2;
        --bg-card: #fffdf9;
        --bg-input: #fffdfa;
        --line: #eadcc2;
        --line-soft: #f1e7d4;
        --text-main: #3f3427;
        --text-sub: #8a7762;
        --point: #efc85c;
        --point-deep: #e0b347;
        --point-soft: #fff2c9;
        --shadow: 0 14px 30px rgba(120, 93, 52, 0.08);
    }

    body {
        margin: 0;
        background: linear-gradient(180deg, #fbf6ee 0%, #f8f1e6 100%);
        color: var(--text-main);
        font-family: "Malgun Gothic", "맑은 고딕", sans-serif;
    }

    .modify-wrap {
        width: min(1180px, 92%);
        margin: 0 auto;
        padding: 42px 0 84px;
    }

    #modifyForm {
        width: 100%;
    }

    .modify-category-wrap,
    .modify-form-block {
        margin-bottom: 18px;
        padding: 24px 24px 22px;
        border: 1px solid var(--line);
        border-radius: 28px;
        background: var(--bg-card);
        box-shadow: var(--shadow);
    }

    .modify-category-label,
    .modify-form-label {
        font-size: 16px;
        font-weight: 800;
        color: var(--text-main);
        margin-bottom: 14px;
    }

    .modify-category-group {
        display: flex;
        gap: 10px;
        flex-wrap: wrap;
    }

    .modify-category-btn {
        min-width: 96px;
        height: 42px;
        padding: 0 16px;
        border: 1px solid #eadab7;
        border-radius: 999px;
        background: #fffaf0;
        color: var(--text-main);
        font-size: 14px;
        font-weight: 700;
        cursor: pointer;
        transition: all 0.18s ease;
    }

    .modify-category-btn:hover {
        border-color: var(--point-deep);
        background: #fff4d7;
        transform: translateY(-1px);
    }

    .modify-category-btn.active {
        background: linear-gradient(135deg, #f7d978 0%, #e8bd55 100%);
        border-color: #e2b245;
        color: #3b2d16;
        box-shadow: 0 10px 18px rgba(224, 179, 71, 0.20);
    }

    .modify-text-input,
    .modify-textarea-input {
        width: 100%;
        border: 1px solid var(--line-soft);
        border-radius: 22px;
        background: var(--bg-input);
        color: var(--text-main);
        outline: none;
        transition: border-color 0.18s ease, box-shadow 0.18s ease, background 0.18s ease;
    }

    .modify-text-input {
        height: 58px;
        padding: 0 18px;
        font-size: 15px;
    }

    .modify-textarea-input {
        min-height: 280px;
        padding: 18px 20px;
        font-size: 15px;
        line-height: 1.7;
        resize: none;
    }

    .modify-text-input::placeholder,
    .modify-textarea-input::placeholder {
        color: #b19d86;
    }

    .modify-text-input:focus,
    .modify-textarea-input:focus {
        border-color: #e3bb5a;
        background: #fffdf8;
        box-shadow: 0 0 0 6px rgba(239, 200, 92, 0.14);
    }

    .modify-upload-box {
        width: 100%;
        min-height: 320px;
        border: 2px dashed #ecd79e;
        border-radius: 28px;
        background: linear-gradient(180deg, #fffdf8 0%, #fff8ea 100%);
        padding: 20px;
    }

    .rewrite-old-upload-title,
    .rewrite-new-upload-title {
        font-size: 17px;
        font-weight: 800;
        color: var(--text-main);
        margin-bottom: 14px;
    }

    .rewrite-new-upload-title {
        margin-top: 28px;
    }

    .modify-preview-row {
        display: flex;
        flex-wrap: wrap;
        gap: 14px;
        min-height: 120px;
    }

    .modify-preview-item {
        position: relative;
        width: 170px;
        height: 170px;
        border: 1px solid var(--line);
        border-radius: 22px;
        overflow: hidden;
        background: linear-gradient(180deg, #fffefb 0%, #faf4e8 100%);
        box-shadow: 0 10px 22px rgba(103, 80, 42, 0.08);
        transition: transform 0.18s ease, box-shadow 0.18s ease, border-color 0.18s ease;
    }

    .modify-preview-item:hover {
        transform: translateY(-2px);
        border-color: #e1b654;
        box-shadow: 0 14px 28px rgba(103, 80, 42, 0.11);
    }

    .modify-preview-item img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        display: block;
    }

    .modify-remove-btn {
        position: absolute;
        top: 10px;
        right: 10px;
        width: 32px;
        height: 32px;
        border: none;
        border-radius: 50%;
        background: rgba(59, 45, 22, 0.72);
        color: #fff;
        font-size: 20px;
        line-height: 1;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 5;
        transition: background 0.18s ease, transform 0.18s ease;
    }

    .modify-remove-btn:hover {
        background: #de6767;
        transform: scale(1.05);
    }

    .rewrite-upload-control {
        display: flex;
        align-items: center;
        gap: 14px;
        margin-top: 16px;
        flex-wrap: wrap;
    }

    .rewrite-file-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        min-width: 110px;
        height: 42px;
        padding: 0 18px;
        border: 1px solid var(--line);
        border-radius: 999px;
        background: #fffaf0;
        color: var(--text-main);
        font-size: 13px;
        font-weight: 800;
        text-decoration: none;
        cursor: pointer;
        transition: all 0.18s ease;
    }

    .rewrite-file-btn:hover {
        background: #fff2d4;
        border-color: #e0b347;
    }

    .rewrite-file-count-text,
    #modifyImageCountText {
        color: var(--text-sub);
        font-size: 14px;
        font-weight: 700;
    }

    .modify-submit-area {
        display: flex;
        justify-content: center;
        margin-top: 26px;
    }

    .rewrite-submit-btn {
        min-width: 170px;
        height: 54px;
        padding: 0 28px;
        border: none;
        border-radius: 18px;
        background: linear-gradient(135deg, #f4d271 0%, #e8bb50 100%);
        color: #3d2e15;
        font-size: 16px;
        font-weight: 900;
        cursor: pointer;
        box-shadow: 0 14px 26px rgba(224, 179, 71, 0.24);
        transition: transform 0.16s ease, box-shadow 0.16s ease, opacity 0.16s ease;
    }

    .rewrite-submit-btn:hover {
        transform: translateY(-1px);
    }

    @media (max-width: 1024px) {
        .modify-preview-item {
            width: 150px;
            height: 150px;
        }
    }

    @media (max-width: 768px) {
        .modify-wrap {
            padding: 26px 0 64px;
        }

        .modify-category-wrap,
        .modify-form-block {
            padding: 20px 18px;
            border-radius: 22px;
        }

        .modify-preview-item {
            width: calc(50% - 7px);
            height: 150px;
        }
    }
</style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="modify-wrap">

<form id="modifyForm"
      action="${contextPath}/community/rewrite"
      method="post"
      enctype="multipart/form-data">

    <input type="hidden" name="boardNo" value="${board.boardNo}">
    <input type="hidden" name="boardCode" value="${board.boardCode}">
    <input type="hidden" name="categoryCode" id="modifyCategoryCode" value="${board.categoryCode}">

    <div id="deleteImageInputArea"></div>

    <c:if test="${board.boardCode == 2}">
        <div class="modify-category-wrap">
            <div class="modify-category-label">카테고리 선택 *</div>
            <div class="modify-category-group">
                <button type="button" class="modify-category-btn" data-code="101">강아지</button>
                <button type="button" class="modify-category-btn" data-code="102">고양이</button>
                <button type="button" class="modify-category-btn" data-code="103">공통</button>
            </div>
        </div>
    </c:if>

    <c:if test="${board.boardCode == 3}">
        <div class="modify-category-wrap">
            <div class="modify-category-label">카테고리 선택 *</div>
            <div class="modify-category-group">
                <button type="button" class="modify-category-btn" data-code="201">질문</button>
                <button type="button" class="modify-category-btn" data-code="202">고민</button>
                <button type="button" class="modify-category-btn" data-code="203">자유</button>
            </div>
        </div>
    </c:if>

    <div class="modify-form-block">
        <div class="modify-form-label">제목 수정 *</div>
        <input type="text"
               name="boardTitle"
               id="modifyBoardTitle"
               class="modify-text-input"
               value="${board.boardTitle}">
    </div>

    <div class="modify-form-block">
        <div class="modify-form-label">내용 수정 *</div>
        <textarea name="boardContent"
                  id="modifyBoardContent"
                  class="modify-textarea-input">${board.boardContent}</textarea>
    </div>

    <div class="modify-form-block">
        <div class="modify-form-label">사진 업로드</div>

        <div class="modify-upload-box">
            <div class="rewrite-old-upload-title">수정전 업로드 사진</div>

            <div class="modify-preview-row" id="modifyExistingImageArea">
                <c:forEach var="img" items="${imageList}">
                    <div class="modify-preview-item modify-existing-item"
                         data-img-no="${img.imgNo}">
                        <img src="${contextPath}${img.filePath}${img.changeName}">
                        <button type="button"
                                class="modify-remove-btn modify-existing-remove-btn"
                                data-img-no="${img.imgNo}">×</button>
                    </div>
                </c:forEach>
            </div>

            <div class="rewrite-new-upload-title">새로 첨부할 사진</div>
            <div class="modify-preview-row" id="modifyNewImageArea"></div>
        </div>

        <div class="rewrite-upload-control">
            <label for="modifyImageInput" class="rewrite-file-btn">사진 첨부</label>
            <span id="modifyImageCountText" class="rewrite-file-count-text">0개</span>
        </div>

        <input type="file"
               id="modifyImageInput"
               name="imageFiles"
               accept="image/*"
               multiple
               hidden>
    </div>

    <div class="modify-submit-area">
        <button type="submit" class="rewrite-submit-btn">수정완료</button>
    </div>

</form>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
document.addEventListener("DOMContentLoaded", function() {

    const modifyForm = document.getElementById("modifyForm");
    const modifyImageInput = document.getElementById("modifyImageInput");
    const modifyNewImageArea = document.getElementById("modifyNewImageArea");
    const modifyExistingImageArea = document.getElementById("modifyExistingImageArea");
    const modifyImageCountText = document.getElementById("modifyImageCountText");
    const deleteImageInputArea = document.getElementById("deleteImageInputArea");
    const modifyCategoryCode = document.getElementById("modifyCategoryCode");
    const categoryButtons = document.querySelectorAll(".modify-category-btn");

    let modifySelectedImages = [];
    let deletedImageNos = [];

    categoryButtons.forEach(function(btn) {
        if (btn.dataset.code === modifyCategoryCode.value) {
            btn.classList.add("active");
        }

        btn.addEventListener("click", function() {
            categoryButtons.forEach(function(item) {
                item.classList.remove("active");
            });

            this.classList.add("active");
            modifyCategoryCode.value = this.dataset.code;
        });
    });

    document.querySelectorAll(".modify-existing-remove-btn").forEach(function(btn) {
        btn.onclick = function() {
            const imgNo = this.dataset.imgNo;

            if (!deletedImageNos.includes(imgNo)) {
                deletedImageNos.push(imgNo);
            }

            this.parentElement.remove();
            renderDeleteInputs();
        };
    });

    function renderDeleteInputs() {
        deleteImageInputArea.innerHTML = "";

        deletedImageNos.forEach(function(no) {
            const input = document.createElement("input");
            input.type = "hidden";
            input.name = "deleteImageNos";
            input.value = no;
            deleteImageInputArea.appendChild(input);
        });
    }

    if (modifyImageInput) {
        modifyImageInput.addEventListener("change", function(e) {
            const files = Array.from(e.target.files);
            if (files.length === 0) return;

            const existingCount = modifyExistingImageArea
                ? modifyExistingImageArea.querySelectorAll(".modify-existing-item").length
                : 0;
            const newCount = modifySelectedImages.length;

            if (existingCount + newCount + files.length > 3) {
                alert("이미지는 최대 3개까지만 가능합니다.");
                modifyImageInput.value = "";
                return;
            }

            modifySelectedImages = modifySelectedImages.concat(files);
            updateInputFiles();
            renderPreview();
        });
    }

    function updateInputFiles() {
        const dt = new DataTransfer();

        modifySelectedImages.forEach(function(file) {
            dt.items.add(file);
        });

        modifyImageInput.files = dt.files;
        modifyImageCountText.innerText = modifySelectedImages.length + "개";
    }

    function renderPreview() {
        modifyNewImageArea.innerHTML = "";

        modifySelectedImages.forEach(function(file, index) {
            const reader = new FileReader();

            reader.onload = function(e) {
                const div = document.createElement("div");
                div.className = "modify-preview-item";

                div.innerHTML =
                    '<img src="' + e.target.result + '">' +
                    '<button type="button" class="modify-remove-btn" data-index="' + index + '">×</button>';

                modifyNewImageArea.appendChild(div);
                bindRemove();
            };

            reader.readAsDataURL(file);
        });

        modifyImageCountText.innerText = modifySelectedImages.length + "개";
    }

    function bindRemove() {
        document.querySelectorAll("#modifyNewImageArea .modify-remove-btn").forEach(function(btn) {
            btn.onclick = function() {
                const index = parseInt(this.dataset.index, 10);
                modifySelectedImages.splice(index, 1);
                updateInputFiles();
                renderPreview();
            };
        });
    }

    if (modifyForm) {
        modifyForm.addEventListener("submit", function(e) {
            const title = document.getElementById("modifyBoardTitle").value.trim();
            const content = document.getElementById("modifyBoardContent").value.trim();
            const boardCode = "${board.boardCode}";
            const categoryCode = modifyCategoryCode.value;

            if ((boardCode === "2" || boardCode === "3") && (!categoryCode || categoryCode === "0")) {
                alert("카테고리를 선택해주세요.");
                e.preventDefault();
                return;
            }

            if (title === "") {
                alert("제목을 입력해주세요.");
                e.preventDefault();
                return;
            }

            if (content.length < 5) {
                alert("내용은 5자 이상 입력해주세요.");
                e.preventDefault();
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