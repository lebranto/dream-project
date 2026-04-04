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
<style type="text/css">
@charset "UTF-8";

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
    font-family: "맑은 고딕", "Malgun Gothic", sans-serif;
}

body {
    background-color: #f7f4ee;
    color: #222;
}

a {
    text-decoration: none;
    color: inherit;
}

.board-wrap {
    width: min(1320px, 94%);
    max-width: 1320px;
    min-width: 1100px;
    margin: 0 auto;
    padding: 26px 0 50px;
}

/* 제목 카드 - 자랑게시판이랑 같은 틀 */
.board-title-box {
    width: 100%;
    max-width: 1160px;
    min-height: 150px;
    margin: 0 auto 22px;
    padding: 22px 30px;
    background-color: #fff4f4;
    border: 1px solid #ead7d7;
    border-radius: 32px;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    text-align: center;
    box-shadow: 0 8px 20px rgba(120, 82, 92, 0.03);
}

.board-title-box::before {
    content: "🐾 반려생활 이야기";
    display: block;
    font-size: 13px;
    font-weight: 700;
    color: #c58f8f;
    margin-bottom: 8px;
}

.board-title-box h1 {
    font-size: 30px;
    font-weight: 700;
    color: #47363a;
}

/* 검색영역 - 자랑게시판 구조와 통일 */
.board-search-area {
    width: 100%;
    max-width: 1160px;
    margin: 0 auto 24px;
    padding: 12px 14px;
    display: grid;
    grid-template-columns: 180px minmax(0, 1fr) 150px;
    align-items: center;
    gap: 10px;
    border: 1px solid #e3d1c5;
    border-radius: 24px;
    background-color: #f0e3d7;
}

.board-search-select-wrap {
    position: relative;
    width: 100%;
    height: 46px;
    background-color: #fffaf6;
    border: 1px solid #d9c9bb;
    border-radius: 16px;
    flex-shrink: 0;
    overflow: hidden;
}

.board-search-select {
    width: 100%;
    height: 100%;
    border: none;
    background: transparent;
    padding: 0 35px 0 14px;
    font-size: 14px;
    appearance: none;
    outline: none;
    cursor: pointer;
    color: #5a4b40;
}

.board-search-select-wrap::after {
    content: "▼";
    position: absolute;
    right: 12px;
    top: 14px;
    font-size: 10px;
    color: #aa9685;
    pointer-events: none;
}

.board-search-input-wrap {
    width: 100%;
    height: 46px;
    display: flex;
    align-items: center;
    border: 1px solid #d9c9bb;
    border-radius: 16px;
    background-color: #fffaf6;
    min-width: 0;
    overflow: hidden;
}

.board-search-input {
    flex: 1;
    height: 100%;
    border: none;
    padding: 0 14px;
    font-size: 14px;
    background: transparent;
    outline: none;
    color: #4f4036;
}

.board-search-input::placeholder {
    color: #a08d80;
}

.board-search-btn {
    width: 48px;
    height: 100%;
    border: none;
    background-color: #ead8ca;
    border-left: 1px solid #d9c9bb;
    font-size: 22px;
    cursor: pointer;
    flex-shrink: 0;
    display: flex;
    align-items: center;
    justify-content: center;
}

.board-write-btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 150px;
    height: 46px;
    background: linear-gradient(180deg, #f1d36f 0%, #e8c04a 100%);
    border: none;
    color: #4b3a27;
    text-decoration: none;
    border-radius: 18px;
    font-size: 15px;
    font-weight: 700;
    cursor: pointer;
    white-space: nowrap;
    box-shadow: 0 8px 18px rgba(226, 184, 70, 0.18);
}

/* 섹션 제목 */
.section-title {
    width: 100%;
    max-width: 1160px;
    margin: 0 auto 10px;
    font-size: 16px;
    font-weight: 800;
    color: #3f3026;
}

/* 목록 */
.board-list-box {
    width: 100%;
    max-width: 1160px;
    margin: 0 auto;
    border: 1px solid #e7d8cb;
    border-radius: 28px;
    background-color: #fff;
    overflow: hidden;
}

.board-list-header,
.board-list-row {
    display: grid;
    grid-template-columns: 90px 120px 1.8fr 120px 90px 90px 120px;
    align-items: center;
    text-align: center;
}

.board-list-header {
    min-height: 50px;
    border-bottom: 1px solid #eadfd6;
    background-color: #faf5ef;
    font-size: 14px;
    font-weight: 700;
    color: #7a6554;
}

.board-list-row {
    min-height: 90px;
    border-bottom: 1px solid #efe5dc;
    font-size: 14px;
    cursor: pointer;
    background-color: #fff;
}

.board-list-row:last-child {
    border-bottom: none;
}

.board-list-row:hover {
    background-color: #fffaf7;
}

.col-no,
.col-category,
.col-writer,
.col-view,
.col-like,
.col-date {
    text-align: center;
    color: #57473b;
}

.col-title {
    padding: 0 16px;
    text-align: left;
    color: #3f3127;
    font-size: 16px;
    font-weight: 600;
}

.title-ellipsis {
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
}

.category-badge {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    min-width: 72px;
    height: 28px;
    padding: 0 12px;
    border-radius: 999px;
    background-color: #f7efe7;
    border: 1px solid #e3d5c9;
    font-size: 13px;
    color: #6d5b4d;
    font-weight: 700;
}

.empty-board-row {
    height: 120px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #877568;
    font-size: 14px;
    border-bottom: 1px solid #efe5dc;
}

/* 페이징 */
.pet-paging {
    width: 100%;
    max-width: 1160px;
    margin: 28px auto 0;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
}

.pet-page-nav {
    width: 36px;
    height: 36px;
    border: 1px solid #ded1c6;
    background-color: #faf6f2;
    color: #8a7767;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 15px;
    text-decoration: none;
}

.pet-page-nav.disabled {
    background-color: #f4efea;
    color: #c2b5a8;
}

.pet-page-num-wrap {
    display: flex;
    gap: 6px;
}

.pet-page-num {
    width: 38px;
    height: 38px;
    border: 1px solid #ded1c6;
    background-color: #faf6f2;
    color: #6b594b;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
    text-decoration: none;
}

.pet-page-num.current {
    background-color: #efd16e;
    border-color: #efd16e;
    color: #3f3124;
    font-weight: bold;
}
/* =========================
   팁/자유 게시판 길이/배경 최종 보정
========================= */

/* 페이지 안쪽 회색 느낌 제거 */
body {
    background: #f7f4ee !important;
}

.board-wrap {
    width: min(1400px, 96%) !important;
    max-width: 1400px !important;
    min-width: 1100px !important;
    background: transparent !important;
    padding: 26px 0 56px !important;
}

/* 제목 카드 자랑게시판과 같은 길이 */
.board-title-box {
    width: 100% !important;
    max-width: 1240px !important;
    min-height: 150px !important;
    margin: 0 auto 22px !important;
}

/* 검색영역도 같은 길이 */
.board-search-area,
.bsearch-area {
    width: 100% !important;
    max-width: 1240px !important;
    margin: 0 auto 24px !important;
}

/* 섹션 타이틀 / 목록 / 페이징도 동일 폭 */
.section-title {
    width: 100% !important;
    max-width: 1240px !important;
    margin: 0 auto 10px !important;
}

.board-list-box {
    width: 100% !important;
    max-width: 1240px !important;
    margin: 0 auto !important;
}

.pet-paging {
    width: 100% !important;
    max-width: 1240px !important;
    margin: 28px auto 0 !important;
}
</style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="board-wrap">

    <div class="board-title-box">
        <h1>
            <c:choose>
                <c:when test="${param.boardType eq 'tip'}">육아 꿀팁 게시판</c:when>
                <c:when test="${param.boardType eq 'free'}">자유 게시판</c:when>
                <c:otherwise>게시판</c:otherwise>
            </c:choose>
        </h1>
    </div>

    <form class="board-search-area" action="${contextPath}/community/tipFreeBoard" method="get">
        <input type="hidden" name="boardType" value="${boardType}">

        <div class="board-search-select-wrap">
            <select name="searchType" class="board-search-select">
                <option value="all" ${empty param.searchType || param.searchType == 'all' ? 'selected' : ''}>제목 / 작성자 / 내용</option>
                <option value="title" ${param.searchType == 'title' ? 'selected' : ''}>제목</option>
                <option value="writer" ${param.searchType == 'writer' ? 'selected' : ''}>작성자</option>
                <option value="content" ${param.searchType == 'content' ? 'selected' : ''}>내용</option>
            </select>
        </div>

        <div class="board-search-input-wrap">
            <input type="text"
                   name="keyword"
                   class="board-search-input"
                   placeholder="검색어를 입력해주세요"
                   value="${param.keyword}">
            <button type="submit" class="board-search-btn">🔍</button>
        </div>

        <a href="${contextPath}/community/writeBoard?boardType=${boardType}" class="board-write-btn">게시글 작성</a>
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