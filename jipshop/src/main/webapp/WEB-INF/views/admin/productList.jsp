<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% request.setAttribute("currentMenu", "productList"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상품 관리 - 집사상점</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/productList.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp"/>

<main class="main">
    <div class="page-title">
        상품 관리
        <span class="page-title-badge">총 ${totalCount}건</span>
    </div>

    <%-- 검색 필터 --%>
    <form action="/admin/productList.do" method="get">
        <div class="filter-bar">
            <select name="categoryId" class="filter-select">
                <option value="">전체 카테고리</option>
                <c:forEach var="cat" items="${categoryList}">
                    <option value="${cat.categoryId}" <c:if test="${param.categoryId==cat.categoryId}">selected</c:if>>${cat.categoryName}</option>
                </c:forEach>
            </select>
            <input type="text" name="keyword" class="filter-input"
                   placeholder="상품명 검색" value="${param.keyword}" style="flex:1; min-width:160px;">
            <button type="submit" class="btn btn-primary">조회</button>
            <button type="button" class="btn btn-outline" onclick="location.href='/admin/productList.do'">초기화</button>
        </div>
    </form>

    <div class="toolbar">
        <div class="toolbar-left">
            <span class="bulk-info" id="bulkInfo">0건 선택됨</span>
            <button type="button" class="btn btn-danger btn-sm" id="btnBulkDel"
                    style="display:none" onclick="bulkDelete()">🗑 일괄 삭제</button>
        </div>
        <div class="toolbar-right">
            <button class="btn btn-primary btn-sm" onclick="location.href='${contextPath}/jipshop/admin/productRegist'">+ 상품 등록</button>
        </div>
    </div>

    <form id="bulkForm" action="/admin/productBulkDelete.do" method="post">
        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th class="center"><input type="checkbox" id="checkAll" onchange="toggleAll()"></th>
                        <th>번호</th>
                        <th>판매자</th>
                        <th>상품명</th>
                        <th class="center">가격(원)</th>
                        <th class="center">재고</th>
                        <th class="center">상태</th>
                        <th class="center">액션</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty productList}">
                            <tr class="empty-row"><td colspan="8">등록된 상품이 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="p" items="${productList}" varStatus="s">
                                <tr>
                                    <td class="center">
                                        <input type="checkbox" name="productIds" value="${p.productId}"
                                               class="rowCheck" onchange="updateBulk()">
                                    </td>
                                    <td>${totalCount - (currentPage-1)*pageSize - s.index}</td>
                                    <td>${p.sellerName}</td>
                                    <td><strong>${p.productName}</strong></td>
                                    <td class="td-num">
                                        <fmt:formatNumber value="${p.productPrice}" pattern="#,###"/>
                                    </td>
                                    <td class="center">${p.productStock}</td>
                                    <td class="center">
                                        <c:choose>
                                            <c:when test="${p.productStatus=='Y'}">
                                                <span class="badge badge-done">판매중</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-inactive">판매중지</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="center" style="display:flex;gap:5px;justify-content:center">
                                        <button type="button" class="btn btn-outline btn-sm"
                                                onclick="location.href='/admin/productEdit.do?productId=${p.productId}'">수정</button>
                                        <button type="button" class="btn btn-danger btn-sm"
                                                onclick="deleteOne(${p.productId})">삭제</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a class="page-num" href="?page=${currentPage-1}&categoryId=${param.categoryId}&keyword=${param.keyword}">◀</a>
                </c:if>
                <c:forEach begin="${startPage}" end="${endPage}" var="p">
                    <a class="page-num ${p==currentPage?'active':''}" href="?page=${p}&categoryId=${param.categoryId}&keyword=${param.keyword}">${p}</a>
                </c:forEach>
                <c:if test="${currentPage < totalPages}">
                    <a class="page-num" href="?page=${currentPage+1}&categoryId=${param.categoryId}&keyword=${param.keyword}">▶</a>
                </c:if>
            </div>
        </div>
    </form>
</main>

<form id="deleteOneForm" action="/admin/productDelete.do" method="post">
    <input type="hidden" name="productId" id="deleteProductId">
</form>

<div class="toast" id="toast"></div>
<script>
    function toggleAll(){
        const m=document.getElementById('checkAll');
        document.querySelectorAll('.rowCheck').forEach(c=>c.checked=m.checked);
        updateBulk();
    }
    function updateBulk(){
        const n=document.querySelectorAll('.rowCheck:checked').length;
        const info=document.getElementById('bulkInfo');
        info.textContent=n+'건 선택됨';
        info.classList.toggle('visible',n>0);
        document.getElementById('btnBulkDel').style.display=n>0?'':'none';
    }
    function bulkDelete(){
        const n=document.querySelectorAll('.rowCheck:checked').length;
        if(!confirm(n+'건을 삭제하시겠습니까?'))return;
        document.getElementById('bulkForm').submit();
    }
    function deleteOne(id){
        if(!confirm('해당 상품을 삭제하시겠습니까?'))return;
        document.getElementById('deleteProductId').value=id;
        document.getElementById('deleteOneForm').submit();
    }
    function showToast(msg){const t=document.getElementById('toast');t.textContent=msg;t.classList.add('show');setTimeout(()=>t.classList.remove('show'),2400);}
    <c:if test="${not empty successMsg}">window.onload=()=>showToast('✅ ${successMsg}');</c:if>
</script>
</body>
</html>
