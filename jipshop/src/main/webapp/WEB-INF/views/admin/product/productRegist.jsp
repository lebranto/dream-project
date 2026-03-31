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

                <div class="form-row">
                    <label class="form-label required">카테고리</label>
                    <select name="categoryId" class="form-select" required>
                        <option value="">카테고리 선택</option>
                        <c:set var="curParent" value=""/>
                        <c:forEach var="cat" items="${categoryList}">
                            <c:if test="${cat.PARENTNAME != curParent}">
                                <c:if test="${curParent != ''}"></optgroup></c:if>
                                <optgroup label="${cat.PARENTNAME}">
                                <c:set var="curParent" value="${cat.PARENTNAME}"/>
                            </c:if>
                            <option value="${cat.CATEGORYID}">${cat.CATEGORYNAME}</option>
                        </c:forEach>
                        <c:if test="${curParent != ''}"></optgroup></c:if>
                    </select>
                </div>

                <div class="form-row">
                    <label class="form-label required">업체</label>
                    <select name="companyCode" class="form-select" required>
                        <option value="">업체 선택</option>
                        <c:forEach var="com" items="${companyList}">
                            <option value="${com.COMPANYCODE}">${com.COMPANYNAME}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-row">
                    <label class="form-label required">상품명</label>
                    <input type="text" name="productName" class="form-input"
                           placeholder="상품명을 입력하세요." required>
                </div>

                <div class="form-row">
                    <label class="form-label required">가격</label>
                    <input type="number" name="productPrice" class="form-input w-md"
                           placeholder="0" min="0" required>
                    <span style="font-size:13px;color:var(--text-sub)">원</span>
                </div>

                <div class="form-row">
                    <label class="form-label required">재고</label>
                    <input type="number" name="productStock" class="form-input w-md"
                           placeholder="0" min="0" required>
                </div>

                <div class="form-row">
                    <label class="form-label">펫 유형</label>
                    <select name="petType" class="form-select" style="width:140px">
                        <option value="">전체</option>
                        <option value="강아지">강아지</option>
                        <option value="고양이">고양이</option>
                        <option value="기타">기타</option>
                    </select>
                </div>

                <div class="form-row">
                    <label class="form-label">연령대</label>
                    <select name="ageGroup" class="form-select" style="width:140px">
                        <option value="">전체</option>
                        <option value="유아기">유아기</option>
                        <option value="성장기">성장기</option>
                        <option value="성체">성체</option>
                        <option value="노령기">노령기</option>
                    </select>
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

    function validateForm() {
        const photo1 = document.getElementById('photo1');
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

    <c:if test="${not empty errorMsg}">
        window.onload = () => showToast('⚠️ ${errorMsg}');
    </c:if>
</script>
</body>
</html>
