<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${boardTypeName}</title>
<link rel="stylesheet" href="./tipFree.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community/tipFree.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<div class="board-wrap">

    <!-- 게시판 제목 -->
    

<div class="board-title-box">
    <h1 class="community-title">
        <c:choose>
            <c:when test="${param.boardType eq 'tip'}">육아 꿀팁 게시판</c:when>
            <c:when test="${param.boardType eq 'free'}">자유 게시판</c:when>
            <c:otherwise>게시판</c:otherwise>
        </c:choose>
    </h1>
</div>

    <!-- 검색 영역 : 기존과 동일 형식 -->
    <form class="bsearch-area" action="${contextPath}/community/tipFreeBoard" method="get">
        <input type="hidden" name="boardType" value="${boardType}">

        <div class="bsearch-select-wrap">
            <select name="searchType" class="bsearch-select">
                <option value="all">제목 / 작성자 / 내용</option>
                <option value="title" ${param.searchType == 'title' ? 'selected' : ''}>제목</option>
                <option value="writer" ${param.searchType == 'writer' ? 'selected' : ''}>작성자</option>
                <option value="content" ${param.searchType == 'content' ? 'selected' : ''}>내용</option>
               
            </select>
        </div>

        <div class="bsearch-input-wrap">
            <input type="text"
                   name="keyword"
                   class="bsearch-input"
                   placeholder="검색어를 입력해주세요"
                   value="${param.keyword}">
            <button type="submit" class="search-btn">🔍</button>
        </div>

        <a href="${pageContext.request.contextPath}/community/writeBoard?boardType=${param.boardType}" class="bwrite-btn">게시글 작성</a>
    </form>

    <h2 class="section-title">최신게시물목록</h2>

    <!-- 목록 -->
    <div class="board-list-box">

        <div class="board-list-header">
            <div class="col-no">순번</div>
            <div class="col-category">카테고리</div>
            <div class="col-title">글 제목</div>
            <div class="col-writer">작성자</div>
            <div class="col-view">조회수</div>
            <div class="col-like">좋아요</div>
            <div class="col-date">작성날</div>
        </div>

        <c:choose>
            <c:when test="${not empty boardList}">
                <c:forEach var="board" items="${boardList}" varStatus="status">
                    <div class="board-list-row"
                         onclick="location.href='${contextPath}/community/detail?boardNo=${board.boardNo}'">

                 <div class="col-no">${(pagination.currentPage - 1) * 10 + status.count}</div>
                        <div class="col-category">
                            <span class="category-badge">${board.categoryName}</span>
                        </div>

                        <div class="col-title title-ellipsis">${board.boardTitle}</div>
                        <div class="col-writer">${board.memberId}</div>
                        <div class="col-view">${board.readCount}</div>
                        <div class="col-like">${board.likeCount}</div>
                        <div class="col-date">${board.createDate}</div>
                    </div>
                </c:forEach>
            </c:when>

            <c:otherwise>
                <div class="empty-board-row">등록된 게시글이 없습니다.</div>
            </c:otherwise>
        </c:choose>

    </div>

    <!-- 페이징 : 기존 형식 동일 -->
    <c:if test="${pagination != null && pagination.maxPage > 0}">
        <div class="pet-paging">

            <!-- 이전 -->
            <c:choose>
                <c:when test="${pagination.currentPage > 1}">
                    <a class="pet-page-nav"
                       href="${contextPath}/board/common/list?boardType=${boardType}&cp=${pagination.currentPage - 1}&searchType=${param.searchType}&keyword=${param.keyword}">
                        &lt;
                    </a>
                </c:when>
                <c:otherwise>
                    <span class="pet-page-nav disabled">&lt;</span>
                </c:otherwise>
            </c:choose>

            <!-- 숫자 -->
            <div class="pet-page-num-wrap">
                <c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}">
                    <c:choose>
                        <c:when test="${i == pagination.currentPage}">
                            <span class="pet-page-num current">${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a class="pet-page-num"
                               href="${contextPath}/board/common/list?boardType=${boardType}&cp=${i}&searchType=${param.searchType}&keyword=${param.keyword}">
                                ${i}
                            </a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>

            <!-- 다음 -->
            <c:choose>
                <c:when test="${pagination.currentPage < pagination.maxPage}">
                    <a class="pet-page-nav"
                       href="${contextPath}/board/common/list?boardType=${boardType}&cp=${pagination.currentPage + 1}&searchType=${param.searchType}&keyword=${param.keyword}">
                        &gt;
                    </a>
                </c:when>
                <c:otherwise>
                    <span class="pet-page-nav disabled">&gt;</span>
                </c:otherwise>
            </c:choose>

        </div>
    </c:if>

</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>