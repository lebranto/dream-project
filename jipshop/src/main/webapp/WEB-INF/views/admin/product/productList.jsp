<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
    request.setAttribute("currentMenu", "productList");
%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 관리 - 집사상점</title>

    <link rel="stylesheet" href="${contextPath}/resources/css/admin/admin.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/product/productList.css">
</head>
<body>

    <jsp:include page="/WEB-INF/views/admin/common/sidebar.jsp" />
    <jsp:include page="/WEB-INF/views/admin/common/header.jsp" />

    <main class="main">
        <div class="page-title">
            상품 관리
            <span class="page-title-badge">총 ${totalCount}건</span>
        </div>

        <!-- 검색 영역 -->
        <form action="${contextPath}/admin/productList" method="get">
            <div class="filter-bar">

                <!-- 카테고리 -->
                <select name="categoryId" class="filter-select">
				    <option value="">전체 카테고리</option>
				    <c:forEach var="c" items="${categoryList}">
				        <option value="${c.CATEGORYID}"
				            <c:if test="${param.categoryId == c.CATEGORYID}">selected</c:if>>
				            ${c.CATEGORYNAME}
				        </option>
				    </c:forEach>
				</select>

                <!-- 상태 -->
                <select name="productActiveYn" class="filter-select">
                    <option value="">전체 상태</option>
                    <option value="Y" <c:if test="${param.productActiveYn eq 'Y'}">selected</c:if>>판매중</option>
                    <option value="N" <c:if test="${param.productActiveYn eq 'N'}">selected</c:if>>판매중지</option>
                </select>

                <!-- 키워드 -->
                <input type="text"
                       name="keyword"
                       class="filter-input"
                       placeholder="상품명 / 업체명 검색"
                       value="${param.keyword}"
                       style="flex:1; min-width:180px;">

                <button type="submit" class="btn btn-primary">조회</button>
                <button type="button"
                        class="btn btn-outline"
                        onclick="location.href='${contextPath}/admin/productList'">
                    초기화
                </button>
            </div>
        </form>

        <!-- 상단 버튼 -->
        <div class="toolbar">
            <div class="toolbar-left"></div>
            <div class="toolbar-right">
                <button type="button"
                        class="btn btn-primary btn-sm"
                        onclick="location.href='${contextPath}/admin/productRegist'">
                    + 상품 등록
                </button>
            </div>
        </div>

        <!-- 목록 테이블 -->
        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th class="center">상품아이디</th>
                        <th>카테고리</th>
                        <th>업체명</th>
                        <th>상품명</th>
                        <th class="td-num">가격</th>
                        <th class="td-num">재고</th>
                        <th class="center">등록일</th>
                        <th class="center">상태</th>
                        <th class="center">수정</th>
                    </tr>
                </thead>

                <tbody>
                    <c:choose>
                        <c:when test="${empty productList}">
                            <tr class="empty-row">
                                <td colspan="9">등록된 상품이 없습니다.</td>
                            </tr>
                        </c:when>

                        <c:otherwise>
                            <c:forEach var="p" items="${productList}" varStatus="status">
                                <tr>
                                    <!-- 번호 -->
                                    <td class="center">${p.productId}</td>

                                    <!-- 카테고리 -->
                                    <td>
                                        <span class="badge badge-waiting">${p.categoryName}</span>
                                    </td>

                                    <!-- 업체명 -->
                                    <td class="text-sub">${p.companyName}</td>

                                    <!-- 상품명 -->
                                    <td>
                                        <strong>${p.productName}</strong>
                                    </td>

                                    <!-- 가격 -->
                                    <td class="td-num font-bold">
                                        <fmt:formatNumber value="${p.productPrice}" pattern="#,###" />원
                                    </td>

                                    <!-- 재고 -->
                                    <td class="td-num ${p.productStock == 0 ? 'text-red font-bold' : ''}">
                                        ${p.productStock}
                                    </td>

                                    <!-- 등록일 -->
                                    <td class="center text-sub">
                                        <fmt:formatDate value="${p.productRegDate}" pattern="yyyy-MM-dd" />
                                    </td>

                                    <!-- 상태 -->
                                    <td class="center">
                                        <div class="status-box">

                                            <c:choose>
                                                <c:when test="${p.productActiveYn eq 'Y'}">
                                                    <span class="badge badge-active">판매중</span>

                                                    <form action="${contextPath}/admin/productToggleStatus" method="post" class="inline-form">
                                                        <c:if test="${not empty _csrf}">
                                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                                        </c:if>

                                                        <input type="hidden" name="productId" value="${p.productId}">
                                                        <input type="hidden" name="productActiveYn" value="N">
                                                        <input type="hidden" name="page" value="${pi.currentPage}">
                                                        <input type="hidden" name="categoryId" value="${param.categoryId}">
                                                        <input type="hidden" name="keyword" value="${param.keyword}">
                                                        <input type="hidden" name="productActiveYnSearch" value="${param.productActiveYn}">

                                                        <button type="submit"
                                                                class="btn btn-warning btn-sm"
                                                                onclick="return confirm('해당 상품을 판매중지 하시겠습니까?');">
                                                            판매중지
                                                        </button>
                                                    </form>
                                                </c:when>

                                                <c:otherwise>
                                                    <span class="badge badge-banned">판매중지</span>

                                                    <form action="${contextPath}/admin/productToggleStatus" method="post" class="inline-form">
                                                        <c:if test="${not empty _csrf}">
                                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                                        </c:if>

                                                        <input type="hidden" name="productId" value="${p.productId}">
                                                        <input type="hidden" name="productActiveYn" value="Y">
                                                        <input type="hidden" name="page" value="${pi.currentPage}">
                                                        <input type="hidden" name="categoryId" value="${param.categoryId}">
                                                        <input type="hidden" name="keyword" value="${param.keyword}">
                                                        <input type="hidden" name="productActiveYnSearch" value="${param.productActiveYn}">

                                                        <button type="submit"
                                                                class="btn btn-success btn-sm"
                                                                onclick="return confirm('해당 상품의 판매를 재개하시겠습니까?');">
                                                            판매재개
                                                        </button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>

                                        </div>
                                    </td>

                                    <!-- 수정 -->
                                    <td class="center">
                                        <button type="button"
                                                class="btn btn-outline btn-sm"
                                                onclick="location.href='${contextPath}/admin/productUpdate?productId=${p.productId}&page=${pi.currentPage}&categoryId=${param.categoryId}&productActiveYn=${param.productActiveYn}&keyword=${param.keyword}'">
                                            수정
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

            <!-- 페이징 -->
            <div class="pagination">

                <c:if test="${pi.currentPage > 1}">
                    <a class="page-num"
                       href="${contextPath}/admin/productList?page=${pi.currentPage - 1}&categoryId=${param.categoryId}&productActiveYn=${param.productActiveYn}&keyword=${param.keyword}">
                        ◀
                    </a>
                </c:if>

                <c:forEach begin="${pi.startPage}" end="${pi.endPage}" var="p">
                    <a class="page-num ${p == pi.currentPage ? 'active' : ''}"
                       href="${contextPath}/admin/productList?page=${p}&categoryId=${param.categoryId}&productActiveYn=${param.productActiveYn}&keyword=${param.keyword}">
                        ${p}
                    </a>
                </c:forEach>

                <c:if test="${pi.currentPage < pi.maxPage}">
                    <a class="page-num"
                       href="${contextPath}/admin/productList?page=${pi.currentPage + 1}&categoryId=${param.categoryId}&productActiveYn=${param.productActiveYn}&keyword=${param.keyword}">
                        ▶
                    </a>
                </c:if>

            </div>
        </div>
    </main>

    <!-- 토스트 -->
    <div class="toast" id="toast"></div>

    <script>
        function showToast(msg) {
            const toast = document.getElementById("toast");
            toast.textContent = msg;
            toast.classList.add("show");

            setTimeout(function() {
                toast.classList.remove("show");
            }, 2200);
        }
    </script>

    <c:if test="${not empty successMsg}">
        <script>
            window.addEventListener("load", function() {
                showToast("${successMsg}");
            });
        </script>
    </c:if>

    <c:if test="${not empty errorMsg}">
        <script>
            window.addEventListener("load", function() {
                showToast("${errorMsg}");
            });
        </script>
    </c:if>

</body>
</html>