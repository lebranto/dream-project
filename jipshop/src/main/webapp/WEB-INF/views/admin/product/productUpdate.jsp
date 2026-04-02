<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setAttribute("currentMenu", "productList"); %>
<!DOCTYPE html>
<html lang="ko">
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<head>
    <meta charset="UTF-8">
    <title>상품 수정 - 집사상점</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/admin.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/product/productRegist.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>

<main class="main">

    <div class="page-title">상품 수정</div>

    <form action="${contextPath}/admin/productUpdate" method="post"
          enctype="multipart/form-data" id="updateForm" onsubmit="return validateForm()">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

        <!-- 기본 전달값 -->
        <input type="hidden" name="productId" value="${product.productId}">
        <input type="hidden" name="page" value="${param.page}">
        <input type="hidden" name="categoryIdSearch" value="${param.categoryId}">
        <input type="hidden" name="productActiveYnSearch" value="${param.productActiveYn}">
        <input type="hidden" name="keyword" value="${param.keyword}">

        <!-- 기존 이미지 유지용 -->
        <input type="hidden" name="productPhoto1" value="${product.productPhoto1}">
        <input type="hidden" name="productPhoto2" value="${product.productPhoto2}">

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

                        <!-- 기존 업체 -->
                        <div id="companySelectRow" style="margin-top:8px;">
                            <select name="companyCode" id="companyCode" class="form-select w-lg">
                                <option value="">업체 선택</option>
                                <c:forEach var="com" items="${companyList}">
                                    <option value="${com.COMPANYCODE}"
                                        <c:if test="${product.companyCode == com.COMPANYCODE}">selected</c:if>>
                                        ${com.COMPANYNAME}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- 신규 업체 -->
                        <div id="newCompanyArea" style="display:none; margin-top:8px;">

                            <div class="form-row">
                                <label class="form-label required">업체명</label>
                                <input type="text" id="newCompanyName" name="newCompanyName" class="form-input w-lg" placeholder="업체명">
                            </div>

                            <div class="form-row">
                                <label class="form-label required">전화번호</label>
                                <input type="text" id="companyPhone" name="companyPhone" class="form-input w-lg" placeholder="전화번호">
                            </div>

                            <div class="form-row">
                                <label class="form-label required">주소</label>
                                <input type="text" id="companyAddress" name="companyAddress" class="form-input w-lg" placeholder="주소">
                            </div>

                        </div>

                    </div>
                </div>

                <!-- 펫 -->
                <div class="form-row">
                    <label class="form-label required">펫 유형</label>
                    <select name="petType" id="petType" class="form-select w-md" required>
                        <option value="">선택</option>
                        <option value="강아지" <c:if test="${product.petType eq '강아지'}">selected</c:if>>강아지</option>
                        <option value="고양이" <c:if test="${product.petType eq '고양이'}">selected</c:if>>고양이</option>
                    </select>
                </div>

                <!-- 카테고리 -->
                <div class="form-row">
                    <label class="form-label required">카테고리</label>
                    <select name="categoryId" id="categoryId" class="form-select w-lg" required>
                        <option value="">선택</option>
                        <option value="1" <c:if test="${product.categoryId == 1}">selected</c:if>>사료</option>
                        <option value="2" <c:if test="${product.categoryId == 2}">selected</c:if>>장난감</option>
                        <option value="3" <c:if test="${product.categoryId == 3}">selected</c:if>>외출용품</option>
                        <option value="4" <c:if test="${product.categoryId == 4}">selected</c:if>>미용용품</option>
                    </select>
                </div>

                <!-- 연령 -->
                <div class="form-row">
                    <label class="form-label">연령대</label>
                    <select name="ageGroup" id="ageGroup" class="form-select w-md">
                        <option value="">선택</option>
                        <option value="키드" <c:if test="${product.ageGroup eq '키드'}">selected</c:if>>키드</option>
                        <option value="어덜트" <c:if test="${product.ageGroup eq '어덜트'}">selected</c:if>>어덜트</option>
                        <option value="시니어" <c:if test="${product.ageGroup eq '시니어'}">selected</c:if>>시니어</option>
                        <option value="전연령" <c:if test="${product.ageGroup eq '전연령'}">selected</c:if>>전연령</option>
                    </select>
                </div>

                <!-- 상품명 -->
                <div class="form-row">
                    <label class="form-label required">상품명</label>
                    <input type="text" name="productName" class="form-input w-lg" value="${product.productName}" required>
                </div>

                <!-- 가격 -->
                <div class="form-row">
                    <label class="form-label required">가격</label>
                    <input type="number" name="productPrice" class="form-input w-md" value="${product.productPrice}" required>
                </div>

                <!-- 재고 -->
                <div class="form-row">
                    <label class="form-label required">재고</label>
                    <input type="number" name="productStock" class="form-input w-md" value="${product.productStock}" required>
                </div>

            </div>
        </div>

        <div class="detail-card">
            <div class="detail-card-header">🖼 상품 이미지</div>
            <div class="detail-card-body">

                <!-- 대표 사진 -->
<div class="form-row top">
    <label class="form-label required" style="padding-top:6px">대표 사진</label>
    <div>
        <div class="img-preview-box"
             onclick="document.getElementById('photo1').click()">

            <c:choose>
                <c:when test="${not empty product.productPhoto1}">
                    <img id="preview1"
                         src="${contextPath}${product.productPhoto1}"
                         style="display:block;width:100%;height:100%;object-fit:cover">
                    <div class="img-ph" id="ph1" style="display:none;">📷<br>클릭하여 업로드</div>
                </c:when>
                <c:otherwise>
                    <img id="preview1" src="" style="display:none;width:100%;height:100%;object-fit:cover">
                    <div class="img-ph" id="ph1">📷<br>클릭하여 업로드</div>
                </c:otherwise>
            </c:choose>
        </div>

        <input type="file" id="photo1" name="photo1"
               accept="image/*" style="display:none"
               onchange="previewImg(this,'preview1','ph1')">

        <div style="font-size:11px;color:var(--text-sub);margin-top:4px">
            현재 파일: <c:out value="${empty product.productPhoto1 ? '없음' : product.productPhoto1}"/>
        </div>
    </div>
</div>

              <!-- 상세 사진 -->
<div class="form-row top">
    <label class="form-label" style="padding-top:6px">상세 사진</label>
    <div>
        <div class="img-preview-box"
             onclick="document.getElementById('photo2').click()">

            <c:choose>
                <c:when test="${not empty product.productPhoto2}">
                    <img id="preview2"
                         src="${contextPath}${product.productPhoto2}"
                         style="display:block;width:100%;height:100%;object-fit:cover">
                    <div class="img-ph" id="ph2" style="display:none;">📷<br>클릭하여 업로드</div>
                </c:when>
                <c:otherwise>
                    <img id="preview2" src="" style="display:none;width:100%;height:100%;object-fit:cover">
                    <div class="img-ph" id="ph2">📷<br>클릭하여 업로드</div>
                </c:otherwise>
            </c:choose>
        </div>

        <input type="file" id="photo2" name="photo2"
               accept="image/*" style="display:none"
               onchange="previewImg(this,'preview2','ph2')">

        <div style="font-size:11px;color:var(--text-sub);margin-top:4px">
            현재 파일: <c:out value="${empty product.productPhoto2 ? '없음' : product.productPhoto2}"/>
        </div>
    </div>
</div>

            </div>
        </div>

        <div class="detail-card">
            <div class="detail-card-header">📝 상품 상세 설명</div>
            <div class="detail-card-body">
                <textarea name="productDetail" class="form-textarea"
                          style="min-height:200px"
                          placeholder="상품 상세 설명을 입력하세요." required>${product.productDetail}</textarea>
            </div>
        </div>

        <div class="btn-group">
            <button type="button" class="btn btn-outline"
                    onclick="location.href='${contextPath}/admin/productList?page=${param.page}&categoryId=${param.categoryId}&productActiveYn=${param.productActiveYn}&keyword=${param.keyword}'">
                취소
            </button>
            <button type="submit" class="btn btn-primary">수정</button>
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
        const companyPhone = document.getElementById("companyPhone");
        const companyAddress = document.getElementById("companyAddress");

        if (mode === "select") {
            companySelectRow.style.display = "flex";
            newCompanyArea.style.display = "none";
            companyCode.disabled = false;

            newCompanyName.disabled = true;
            companyPhone.disabled = true;
            companyAddress.disabled = true;

            newCompanyName.value = "";
            companyPhone.value = "";
            companyAddress.value = "";
        } else {
            companySelectRow.style.display = "none";
            newCompanyArea.style.display = "block";
            companyCode.disabled = true;
            companyCode.value = "";

            newCompanyName.disabled = false;
            companyPhone.disabled = false;
            companyAddress.disabled = false;
        }
    }

    function validateForm() {
        const mode = document.querySelector('input[name="companyMode"]:checked').value;
        const companyCode = document.getElementById('companyCode');
        const newCompanyName = document.getElementById('newCompanyName');
        const companyPhone = document.getElementById('companyPhone');
        const companyAddress = document.getElementById('companyAddress');
        const petType = document.getElementById('petType');
        const categoryId = document.getElementById('categoryId');
        const ageGroup = document.getElementById('ageGroup');

        if (mode === 'select' && (!companyCode.value || companyCode.value.trim() === '')) {
            alert('기존 업체를 선택해주세요.');
            companyCode.focus();
            return false;
        }

        if (mode === 'new') {
            if (!newCompanyName.value || newCompanyName.value.trim() === '') {
                alert('새 업체명을 입력해주세요.');
                newCompanyName.focus();
                return false;
            }
            if (!companyPhone.value || companyPhone.value.trim() === '') {
                alert('전화번호를 입력해주세요.');
                companyPhone.focus();
                return false;
            }
            if (!companyAddress.value || companyAddress.value.trim() === '') {
                alert('주소를 입력해주세요.');
                companyAddress.focus();
                return false;
            }
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

        return confirm('상품을 수정하시겠습니까?');
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