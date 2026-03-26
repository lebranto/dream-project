<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${boardTypeName}</title>
<link rel="stylesheet" href="${contextPath}/resources/css/community/tipFree.css">
<link rel="stylesheet" href="${contextPath}/resources/css/common/paging.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="board-wrap">

    <div class="board-title-box">
        <h1 class="community-title">
            <c:choose>
                <c:when test="${param.boardType eq 'tip'}">육아 꿀팁 게시판</c:when>
                <c:when test="${param.boardType eq 'free'}">자유 게시판</c:when>
                <c:otherwise>게시판</c:otherwise>
            </c:choose>
        </h1>
    </div>

    <form class="bsearch-area" action="${contextPath}/community/tipFreeBoard" method="get">
        <input type="hidden" name="boardType" value="${boardType}">

        <div class="bsearch-select-wrap">
            <select name="searchType" class="bsearch-select">
                <option value="all" ${empty param.searchType || param.searchType == 'all' ? 'selected' : ''}>제목 / 작성자 / 내용</option>
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

        <a href="${contextPath}/community/writeBoard?boardType=${boardType}" class="bwrite-btn">게시글 작성</a>
    </form>

    <h2 class="section-title">최신게시물목록</h2>

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

                        <div class="col-no">${(pi.currentPage - 1) * pi.boardLimit + status.count}</div>

                        <div class="col-category">
                            <span class="category-badge">
                                <c:out value="${board.categoryName}" default="일반" />
                            </span>
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

    <c:set var="pageUrl" value="/community/tipFreeBoard" />
    <jsp:include page="/WEB-INF/views/common/paging.jsp" />

</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>