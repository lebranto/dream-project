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
<link rel="stylesheet" href="${contextPath}/resources/css/board/tipFreeBoardList.css">
</head>
<body>

<div class="board-wrap">

    <!-- 게시판 제목 -->
    <div class="board-title-box">
        <h1>${boardTypeName}</h1>
    </div>

    <!-- 검색 영역 : 기존과 동일 형식 -->
    <form class="search-area" action="${contextPath}/board/common/list" method="get">
        <input type="hidden" name="boardType" value="${boardType}">

        <div class="search-select-wrap">
            <select name="searchType" class="search-select">
                <option value="titleWriterContent"
                    <c:if test="${empty param.searchType or param.searchType == 'titleWriterContent'}">selected</c:if>>
                    제목 / 작성자 / 내용
                </option>
                <option value="title"
                    <c:if test="${param.searchType == 'title'}">selected</c:if>>
                    제목
                </option>
                <option value="writer"
                    <c:if test="${param.searchType == 'writer'}">selected</c:if>>
                    작성자
                </option>
                <option value="content"
                    <c:if test="${param.searchType == 'content'}">selected</c:if>>
                    내용
                </option>
            </select>
        </div>

        <div class="search-input-wrap">
            <input type="text"
                   name="keyword"
                   class="search-input"
                   placeholder="검색어를 입력해주세요"
                   value="${param.keyword}">
            <button type="submit" class="search-btn">🔍</button>
        </div>

        <button type="button"
                class="write-btn"
                onclick="location.href='${contextPath}/board/common/write?boardType=${boardType}'">
            게시글 작성
        </button>
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
                         onclick="location.href='${contextPath}/board/common/detail/${board.boardNo}?boardType=${boardType}'">

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

</body>
</html>