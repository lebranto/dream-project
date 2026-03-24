<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리아이 자랑 게시판</title>
<link rel="stylesheet" href="${contextPath}/resources/css/community/myKidBoard.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="pet-board-wrap">

    <div class="pet-board-title-box">
        <h1>우리 아이 자랑 게시판</h1>
    </div>

    <!-- 검색 -->
    <form class="pet-board-search-area" action="${contextPath}/community/myKidBoard" method="get">
        <div class="pet-board-search-select-wrap">
            <select name="searchType" class="pet-board-search-select">
                <option value="all">제목 / 작성자 / 내용</option>
                <option value="title" ${param.searchType == 'title' ? 'selected' : ''}>제목</option>
                <option value="writer" ${param.searchType == 'writer' ? 'selected' : ''}>작성자</option>
                <option value="content" ${param.searchType == 'content' ? 'selected' : ''}>내용</option>
            </select>
        </div>

        <div class="pet-board-search-input-wrap">
            <input type="text" name="keyword" class="pet-board-search-input"
                   placeholder="검색어를 입력해주세요" value="${param.keyword}">
            <button type="submit" class="pet-board-search-btn">🔍</button>
        </div>

        <a href="${contextPath}/community/writeBoard?boardType=myKidBoard" class="pet-board-write-btn">게시글 작성</a>
    </form>

    <h2 class="section-title">최신게시물목록</h2>

    <div class="board-list-box">

        <div class="board-list-header">
            <div class="col-no">순번</div>
            <div class="col-title">제목</div>
            <div class="col-writer">작성자</div>
            <div class="col-view">조회수</div>
            <div class="col-like">좋아요수</div>
            <div class="col-date">작성일자</div>
            <div class="col-thumb"></div>
        </div>

        <c:choose>
            <c:when test="${not empty boardList}">
                <c:forEach var="board" items="${boardList}" varStatus="status">
                    <div class="board-list-row"
                         onclick="location.href='${contextPath}/community/detail?boardNo=${board.boardNo}'">

                        <div class="col-no">${status.count}</div>
                        <div class="col-title title-ellipsis">${board.boardTitle}</div>
                        <div class="col-writer">${board.memberId}</div>
                        <div class="col-view">${board.readCount}</div>
                        <div class="col-like">${board.likeCount}</div>
                        <div class="col-date">${board.createDate}</div>

                        <div class="col-thumb">
                            <div class="thumb-box">
                                <c:choose>
                                    <c:when test="${not empty board.thumbnailPath}">
                                        <img src="${contextPath}${board.thumbnailPath}" alt="대표이미지">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="thumb-empty">이미지 없음</div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                    </div>
                </c:forEach>
            </c:when>

            <c:otherwise>
                <div class="empty-board-row">등록된 게시글이 없습니다.</div>
            </c:otherwise>
        </c:choose>

    </div>

</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>