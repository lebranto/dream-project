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
            <div class="modify-origin-title">수정전 업로드 사진</div>

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

            <div class="modify-new-title">새로 첨부할 사진</div>
            <div class="modify-preview-row" id="modifyNewImageArea"></div>
        </div>

        <div class="modify-upload-control">
            <label for="modifyImageInput" class="modify-file-btn">사진 첨부</label>
            <span id="modifyImageCountText">0개</span>
        </div>

        <input type="file"
               id="modifyImageInput"
               name="imageFiles"
               multiple
               hidden>
    </div>

    <div class="modify-submit-area">
        <button type="submit" class="modify-submit-btn">수정완료</button>
    </div>

</form>
</div>

<script>
const modifyImageInput = document.getElementById("modifyImageInput");
const modifyNewImageArea = document.getElementById("modifyNewImageArea");
const modifyExistingImageArea = document.getElementById("modifyExistingImageArea");
const modifyImageCountText = document.getElementById("modifyImageCountText");
const deleteImageInputArea = document.getElementById("deleteImageInputArea");

let modifySelectedImages = [];
let deletedImageNos = [];

document.querySelectorAll(".modify-existing-remove-btn").forEach(btn => {
    btn.onclick = function(){
        const imgNo = this.dataset.imgNo;

        if(!deletedImageNos.includes(imgNo)){
            deletedImageNos.push(imgNo);
        }

        this.parentElement.remove();
        renderDeleteInputs();
    }
});

function renderDeleteInputs(){
    deleteImageInputArea.innerHTML = "";

    deletedImageNos.forEach(no => {
        const input = document.createElement("input");
        input.type = "hidden";
        input.name = "deleteImageNos";
        input.value = no;
        deleteImageInputArea.appendChild(input);
    });
}

modifyImageInput.addEventListener("change", function(e){
    const files = Array.from(e.target.files);
    if(files.length === 0) return;

    const existingCount = modifyExistingImageArea.children.length;
    const newCount = modifySelectedImages.length;

    if(existingCount + newCount + files.length > 3){
        alert("이미지는 최대 3개까지만 가능합니다.");
        modifyImageInput.value = "";
        return;
    }

    modifySelectedImages = modifySelectedImages.concat(files);
    updateInputFiles();
    renderPreview();
    modifyImageInput.value = "";
});

function updateInputFiles(){
    const dt = new DataTransfer();

    modifySelectedImages.forEach(file => {
        dt.items.add(file);
    });

    modifyImageInput.files = dt.files;
}

function renderPreview(){
    modifyNewImageArea.innerHTML = "";

    modifySelectedImages.forEach((file, index) => {
        const reader = new FileReader();

        reader.onload = function(e){
            const div = document.createElement("div");
            div.className = "modify-preview-item";

            div.innerHTML =
                `<img src="${e.target.result}">
                 <button type="button"
                         class="modify-remove-btn"
                         data-index="${index}">×</button>`;

            modifyNewImageArea.appendChild(div);
        };

        reader.readAsDataURL(file);
    });

    modifyImageCountText.innerText = modifySelectedImages.length + "개";
    bindRemove();
}

function bindRemove(){
    document.querySelectorAll("#modifyNewImageArea .modify-remove-btn").forEach(btn => {
        btn.onclick = function(){
            const index = this.dataset.index;
            modifySelectedImages.splice(index, 1);
            updateInputFiles();
            renderPreview();
        };
    });
}

document.getElementById("modifyForm").addEventListener("submit", function(e){
    const title = document.getElementById("modifyBoardTitle").value.trim();
    const content = document.getElementById("modifyBoardContent").value.trim();

    if(title === ""){
        alert("제목을 입력해주세요.");
        e.preventDefault();
        return;
    }

    if(content.length < 5){
        alert("내용은 5자 이상 입력해주세요.");
        e.preventDefault();
        return;
    }
});
</script>

</body>
</html>