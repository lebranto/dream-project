<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% request.setAttribute("currentMenu", "productList"); %>
<!DOCTYPE html>
<html lang="ko">
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<head>
    <meta charset="UTF-8">
    <title>상품 관리 - 집사상점</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/admin.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/product/productList.css">
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
    <form action="${contextPath}/admin/productList" method="get">
        <div class="filter-bar">
            <select name="categoryId" class="filter-select">
                <option value="">전체 카테고리</option>
                <c:set var="curParent" value=""/>
                <c:forEach var="cat" items="${categoryList}">
                    <c:if test="${cat.PARENTNAME != curParent}">
                        <c:if test="${curParent != ''}"></optgroup></c:if>
                        <optgroup label="${cat.PARENTNAME}">
                        <c:set var="curParent" value="${cat.PARENTNAME}"/>
                    </c:if>
                    <option value="${cat.CATEGORYID}"
                        <c:if test="${param.categoryId == cat.CATEGORYID}">selected</c:if>>
                        ${cat.CATEGORYNAME}
                    </option>
                </c:forEach>
                <c:if test="${curParent != ''}"></optgroup></c:if>
            </select>
            <select name="productActiveYn" class="filter-select">
                <option value="">전체 상태</option>
                <option value="Y" <c:if test="${param.productActiveYn == 'Y'}">selected</c:if>>판매중</option>
                <option value="N" <c:if test="${param.productActiveYn == 'N'}">selected</c:if>>판매중지</option>
            </select>
            <input type="text" name="keyword" class="filter-input"
                   placeholder="상품명 / 업체명 검색"
                   value="${param.keyword}" style="flex:1; min-width:160px;">
            <button type="submit" class="btn btn-primary">조회</button>
            <button type="button" class="btn btn-outline"
                    onclick="location.href='${contextPath}/admin/productList'">초기화</button>
        </div>
    </form>

    <div class="toolbar">
        <div class="toolbar-left"></div>
        <div class="toolbar-right">
            <button class="btn btn-primary btn-sm"
                    onclick="location.href='${contextPath}/admin/productRegist'">+ 상품 등록</button>
        </div>
    </div>

    <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>카테고리</th>
                    <th>업체명</th>
                    <th>상품명</th>
                    <th class="td-num">가격</th>
                    <th class="td-num">재고</th>
                    <th>등록일</th>
                    <th class="center">상태</th>
                    <th class="center">액션</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty productList}">
                        <tr class="empty-row"><td colspan="9">등록된 상품이 없습니다.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="p" items="${productList}" varStatus="s">
                            <tr>
                                <td>${totalCount - (pi.currentPage-1)*pi.boardLimit - s.index}</td>
                                <td><span class="badge badge-waiting">${p.categoryName}</span></td>
                                <td style="color:var(--text-sub)">${p.companyName}</td>
                                <td><strong>${p.productName}</strong></td>
                                <td class="td-num font-bold">
                                    <fmt:formatNumber value="${p.productPrice}" pattern="#,###"/>원
                                </td>
                                <td class="td-num
                                    <c:if test="${p.productStock == 0}"> text-red font-bold</c:if>">
                                    ${p.productStock}
                                </td>
                                <td style="color:var(--text-sub)">
                                    <fmt:formatDate value="${p.productRegDate}" pattern="yyyy-MM-dd"/>
                                </td>
                                <td class="center">
                                    <c:choose>
                                        <c:when test="${p.productActiveYn == 'Y'}">
                                            <span class="badge badge-active">판매중</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-banned">판매중지</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="td-actions">
                                    <button type="button" class="btn btn-outline btn-sm"
                                            onclick="location.href='${contextPath}/admin/productUpdate?productId=${p.productId}'">
                                        수정
                                    </button>
                                    <form action="${contextPath}/admin/productActiveYn" method="post" style="display:inline">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        <input type="hidden" name="productId" value="${p.productId}">
                                        <c:choose>
                                            <c:when test="${p.productActiveYn == 'Y'}">
                                                <input type="hidden" name="action" value="stop">
                                                <button type="submit" class="btn btn-warning btn-sm"
                                                        onclick="return confirm('판매 중지하시겠습니까?')">중지</button>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="hidden" name="action" value="active">
                                                <button type="submit" class="btn btn-success btn-sm"
                                                        onclick="return confirm('판매를 재개하시겠습니까?')">재개</button>
                                            </c:otherwise>
                                        </c:choose>
                                    </form>
                                    <form action="${contextPath}/admin/productDelete" method="post" style="display:inline">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        <input type="hidden" name="productId" value="${p.productId}">
                                        <button type="submit" class="btn btn-danger btn-sm"
                                                onclick="return confirm('정말 삭제하시겠습니까?\n삭제된 상품은 복구되지 않습니다.')">삭제</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <%-- 페이지네이션 --%>
        <div class="pagination">
            <c:if test="${pi.currentPage > 1}">
                <a class="page-num"
                   href="?page=${pi.currentPage-1}&categoryId=${param.categoryId}&productActiveYn=${param.productActiveYn}&keyword=${param.keyword}">◀</a>
            </c:if>
            <c:forEach begin="${pi.startPage}" end="${pi.endPage}" var="pg">
                <a class="page-num <c:if test="${pg == pi.currentPage}">active</c:if>"
                   href="?page=${pg}&categoryId=${param.categoryId}&productActiveYn=${param.productActiveYn}&keyword=${param.keyword}">${pg}</a>
            </c:forEach>
            <c:if test="${pi.currentPage < pi.maxPage}">
                <a class="page-num"
                   href="?page=${pi.currentPage+1}&categoryId=${param.categoryId}&productActiveYn=${param.productActiveYn}&keyword=${param.keyword}">▶</a>
            </c:if>
        </div>
    </div>

</main>

<div class="toast" id="toast"></div>
<script>
    function showToast(msg) {
        const t = document.getElementById('toast');
        t.textContent = msg;
        t.classList.add('show');
        setTimeout(() => t.classList.remove('show'), 2400);
    }
    <c:if test="${not empty successMsg}">
        window.onload = () => showToast('✅ ${successMsg}');
    </c:if>
    <c:if test="${not empty errorMsg}">
        window.onload = () => showToast('⚠️ ${errorMsg}');
    </c:if>
</script>
</body>
</html>
