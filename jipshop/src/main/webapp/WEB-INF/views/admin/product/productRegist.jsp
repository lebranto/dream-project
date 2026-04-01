<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setAttribute("currentMenu", "productRegist"); %>
<!DOCTYPE html>
<html lang="ko">
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<head>
    <meta charset="UTF-8">
    <title>상품 등록 - 집사상권</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/admin.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/product/productRegist.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>

<main class="main">

    <div class="page-title">상품 등록</div>

    <form action="${contextPath}/admin/productRegist" method="post"
          enctype="multipart/form-data" id="registForm" onsubmit="return validateForm()">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

       <div class="detail-card">
    <div class="detail-card-header">📦 기본 정보</div>
    <div class="detail-card-body">

        <!-- 업체 -->
        <div class="form-row top">
            <label class="form-label required">업체</label>
            <div class="form-col">

                <div class="company-mode-group">
                    <label>
                        <input type="radio" name="companyMode" value="select" checked onclick="toggleCompanyMode()"> 기존 업체
                    </label>
                    <label>
                        <input type="radio" name="companyMode" value="new" onclick="toggleCompanyMode()"> 새 업체 등록
                    </label>
                </div>

                <!-- 기존 -->
                <div id="companySelectRow" style="margin-top:8px;">
                    <select name="companyCode" id="companyCode" class="form-select w-lg">
                        <option value="">업체 선택</option>
                        <c:forEach var="com" items="${companyList}">
                            <option value="${com.COMPANYCODE}">
                                ${com.COMPANYNAME}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <!-- 신규 -->
                <div id="newCompanyArea" style="display:none; margin-top:8px;">

    <div class="form-row">
        <label class="form-label required">업체명</label>
        <input type="text" name="newCompanyName" class="form-input w-lg" placeholder="업체명">
    </div>

    <div class="form-row">
        <label class="form-label required">전화번호</label>
        <input type="text" name="companyPhone" class="form-input w-lg" placeholder="전화번호">
    </div>

    <div class="form-row">
        <label class="form-label required">주소</label>
        <input type="text" name="companyAddress" class="form-input w-lg" placeholder="주소">
    </div>

</div>

            </div>
        </div>

        <!-- 펫 -->
        <div class="form-row">
            <label class="form-label required">펫 유형</label>
            <select name="petType" id="petType" class="form-select w-md" required>
                <option value="">선택</option>
                <option value="강아지">강아지</option>
                <option value="고양이">고양이</option>
            </select>
        </div>

        <!-- 카테고리 (고정) -->
        <div class="form-row">
            <label class="form-label required">카테고리</label>
            <select name="categoryId" id="categoryId" class="form-select w-lg" required>
                <option value="">선택</option>
                <option value="1">사료</option>
                <option value="2">장난감</option>
                <option value="3">외출용품</option>
                <option value="4">미용용품</option>
            </select>
        </div>
<!-- 연령 -->
<div class="form-row">
    <label class="form-label">연령대</label>
    <select name="ageGroup" id="ageGroup" class="form-select w-md">
        <option value="">선택</option>
        <option value="키드">키드</option>
        <option value="어덜트">어덜트</option>
        <option value="시니어">시니어</option>
        <option value="전연령">전연령</option>
    </select>
</div>
        <!-- 상품명 -->
        <div class="form-row">
            <label class="form-label required">상품명</label>
            <input type="text" name="productName" class="form-input w-lg" required>
        </div>

        <!-- 가격 -->
        <div class="form-row">
            <label class="form-label required">가격</label>
            <input type="number" name="productPrice" class="form-input w-md" required>
        </div>

        <!-- 재고 -->
        <div class="form-row">
            <label class="form-label required">재고</label>
            <input type="number" name="productStock" class="form-input w-md" required>
        </div>

    </div>
</div>
        <div class="detail-card">
            <div class="detail-card-header">🖼 상품 이미지</div>
            <div class="detail-card-body">

                <div class="form-row top">
                    <label class="form-label required" style="padding-top:6px">대표 사진</label>
                    <div>
                        <div class="img-preview-box"
                             onclick="document.getElementById('photo1').click()">
                            <img id="preview1" src="" style="display:none;width:100%;height:100%;object-fit:cover">
                            <div class="img-ph" id="ph1">📷<br>클릭하여 업로드</div>
                        </div>
                        <input type="file" id="photo1" name="photo1"
                               accept="image/*" style="display:none"
                               onchange="previewImg(this,'preview1','ph1')">
                        <div style="font-size:11px;color:var(--text-sub);margin-top:4px">필수</div>
                    </div>
                </div>

                <div class="form-row top">
                    <label class="form-label" style="padding-top:6px">상세 사진</label>
                    <div>
                        <div class="img-preview-box"
                             onclick="document.getElementById('photo2').click()">
                            <img id="preview2" src="" style="display:none;width:100%;height:100%;object-fit:cover">
                            <div class="img-ph" id="ph2">📷<br>클릭하여 업로드</div>
                        </div>
                        <input type="file" id="photo2" name="photo2"
                               accept="image/*" style="display:none"
                               onchange="previewImg(this,'preview2','ph2')">
                        <div style="font-size:11px;color:var(--text-sub);margin-top:4px">선택</div>
                    </div>
                </div>

            </div>
        </div>

        <div class="detail-card">
            <div class="detail-card-header">📝 상품 상세 설명</div>
            <div class="detail-card-body">
                <textarea name="productDetail" class="form-textarea"
                          style="min-height:200px"
                          placeholder="상품 상세 설명을 입력하세요." required></textarea>
            </div>
        </div>

        <div class="btn-group">
            <button type="button" class="btn btn-outline"
                    onclick="location.href='${contextPath}/admin/productList'">취소</button>
            <button type="submit" class="btn btn-primary">등록</button>
        </div>

    </form>

</main>

<div class="toast" id="toast"></div>
<script>
    function previewImg(input, imgId, phId) {
        const file = input.files[0];
        if (!file) return;
        const reader = new FileReader();
        reader.onload = e => {
            const img = document.getElementById(imgId);
            img.src = e.target.result;
            img.style.display = 'block';
            document.getElementById(phId).style.display = 'none';
        };
        reader.readAsDataURL(file);
    }

    function toggleCompanyMode() {
        const mode = document.querySelector('input[name="companyMode"]:checked').value;
        const companySelectRow = document.getElementById("companySelectRow");
        const newCompanyArea = document.getElementById("newCompanyArea");
        const companyCode = document.getElementById("companyCode");
        const newCompanyName = document.getElementById("newCompanyName");

        if (mode === "select") {
            companySelectRow.style.display = "flex";
            newCompanyArea.style.display = "none";
            companyCode.disabled = false;
            newCompanyName.disabled = true;
            newCompanyName.value = "";
        } else {
            companySelectRow.style.display = "none";
            newCompanyArea.style.display = "block";
            companyCode.disabled = true;
            companyCode.value = "";
            newCompanyName.disabled = false;
        }
    }

    function validateForm() {
        const mode = document.querySelector('input[name="companyMode"]:checked').value;
        const companyCode = document.getElementById('companyCode');
        const newCompanyName = document.getElementById('newCompanyName');
        const petType = document.getElementById('petType');
        const categoryId = document.getElementById('categoryId');
        const ageGroup = document.getElementById('ageGroup');
        const photo1 = document.getElementById('photo1');

        if (mode === 'select' && (!companyCode.value || companyCode.value.trim() === '')) {
            alert('기존 업체를 선택해주세요.');
            companyCode.focus();
            return false;
        }

        if (mode === 'new' && (!newCompanyName.value || newCompanyName.value.trim() === '')) {
            alert('새 업체명을 입력해주세요.');
            newCompanyName.focus();
            return false;
        }

        if (!petType.value) {
            alert('펫 유형을 선택해주세요.');
            petType.focus();
            return false;
        }

        if (!categoryId.value) {
            alert('카테고리를 선택해주세요.');
            categoryId.focus();
            return false;
        }
        if (!ageGroup.value) {
            alert('연령대를 선택해주세요.');
            ageGroup.focus();
            return false;
        }

        if (!photo1.files || photo1.files.length === 0) {
            alert('대표 사진은 필수입니다.');
            return false;
        }

        return confirm('상품을 등록하시겠습니까?');
    }

    function showToast(msg) {
        const t = document.getElementById('toast');
        t.textContent = msg;
        t.classList.add('show');
        setTimeout(() => t.classList.remove('show'), 2400);
    }
    window.addEventListener("DOMContentLoaded", function() {
        toggleCompanyMode();
    });

    <c:if test="${not empty errorMsg}">
        window.onload = () => showToast('⚠️ ${errorMsg}');
    </c:if>
</script>
</body>
</html>
