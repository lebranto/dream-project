<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setAttribute("currentMenu", "productRegist"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상품 등록 - 집사상점</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/productRegist.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/header.jsp"/>

<main class="main">
    <div class="page-title">상품 등록</div>

    <form action="/admin/productRegist.do" method="post" enctype="multipart/form-data" id="registForm">
        <div class="form-wrap">

            <!-- ✅ 카테고리 2개 -->
            <div class="form-row">
                <label class="form-label required">카테고리</label>

                <!-- 반려동물 종류 -->
                <select name="petType" class="form-select" style="width:160px" required>
                    <option value="">반려동물 종류 선택</option>
                    <option value="DOG">강아지</option>
                    <option value="CAT">고양이</option>
                </select>

                <!-- ✅ 상품 카테고리 (고정값으로 변경) -->
                <select name="categoryId" class="form-select" style="width:160px" required>
                    <option value="">상품 카테고리 선택</option>
                    <option value="FOOD">사료</option>
                    <option value="TOY">장난감</option>
                    <option value="OUTING">외출용품</option>
                    <option value="GROOMING">미용용품</option>
                </select>
            </div>

            <div class="form-row">
                <label class="form-label required">상품명</label>
                <input type="text" name="productName" class="form-input" placeholder="상품명 입력" required>
            </div>

            <!-- ✅ 업체명 (필수 제거) -->
            <div class="form-row">
                <label class="form-label">업체명</label>
                <input type="text" name="companyName" class="form-input" placeholder="업체명 입력 (선택)">
            </div>

            <div class="form-row">
                <label class="form-label required">판매금액</label>
                <input type="number" name="productPrice" class="form-input w-md" placeholder="0" min="0" required>
                <span style="font-size:13px; color:var(--text-sub)">원</span>
            </div>

            <div class="form-row">
                <label class="form-label required">재고 수량</label>
                <input type="number" name="productStock" class="form-input w-md" placeholder="0" min="0" required>
            </div>

            <div class="form-row" style="align-items:flex-start">
                <label class="form-label" style="padding-top:4px">사진 등록</label>
                <div style="display:flex; gap:12px; flex-wrap:wrap">
                    <div>
                        <div class="img-preview-box" onclick="document.getElementById('thumbFile').click()">
                            <img id="thumbPreview" src="" alt="" style="display:none">
                            <div class="img-placeholder" id="thumbPlaceholder">📷<br>대표 사진</div>
                        </div>
                        <input type="file" id="thumbFile" name="thumbFile"
                               accept="image/*" onchange="previewImg(this,'thumbPreview','thumbPlaceholder')">
                    </div>
                    <div>
                        <div class="img-preview-box" onclick="document.getElementById('detailFile').click()">
                            <img id="detailPreview" src="" alt="" style="display:none">
                            <div class="img-placeholder" id="detailPlaceholder">📷<br>상세 사진</div>
                        </div>
                        <input type="file" id="detailFile" name="detailFile"
                               accept="image/*" onchange="previewImg(this,'detailPreview','detailPlaceholder')">
                    </div>
                </div>
            </div>

            <div class="form-row" style="align-items:flex-start">
                <label class="form-label" style="padding-top:4px">상세 정보</label>
                <textarea name="productDetail" class="form-textarea" placeholder="상품 상세 설명을 입력하세요." style="flex:1"></textarea>
            </div>

        </div>

        <div class="btn-group">
            <button type="button" class="btn btn-outline" onclick="history.back()">취소</button>
            <button type="submit" class="btn btn-primary">등록</button>
        </div>
    </form>
</main>

<div class="toast" id="toast"></div>
<script>
    function previewImg(input, previewId, placeholderId) {
        const file = input.files[0];
        if (!file) return;
        const reader = new FileReader();
        reader.onload = e => {
            const img = document.getElementById(previewId);
            img.src = e.target.result;
            img.style.display = 'block';
            document.getElementById(placeholderId).style.display = 'none';
        };
        reader.readAsDataURL(file);
    }
    function showToast(msg){
        const t=document.getElementById('toast');
        t.textContent=msg;
        t.classList.add('show');
        setTimeout(()=>t.classList.remove('show'),2400);
    }
    <c:if test="${not empty errorMsg}">
        window.onload=()=>showToast('⚠️ ${errorMsg}');
    </c:if>
</script>
</body>
</html>