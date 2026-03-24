<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community/communityMain.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="community-wrap">
    <h1 class="community-title">커뮤니티</h1>

    <div class="category-area">
        <a class="category-btn" href="${pageContext.request.contextPath}/community/myKidBoard">우리아이 자랑 게시판</a>
        <a class="category-btn" href="${pageContext.request.contextPath}/community/tipFreeBoard?boardType=tip">육아 꿀팁</a>
        <a class="category-btn" href="${pageContext.request.contextPath}/community/tipFreeBoard?boardType=free">자유 게시판</a>
    </div>

    <form class="community-search-area" action="${contextPath}/community/main" method="get">
        <div class="community-search-select-wrap">
            <select name="searchType" class="community-search-select">
                <option value="all" ${empty searchType || searchType == 'all' ? 'selected' : ''}>제목 / 작성자 / 내용</option>
                <option value="title" ${searchType == 'title' ? 'selected' : ''}>제목</option>
                <option value="writer" ${searchType == 'writer' ? 'selected' : ''}>작성자</option>
                <option value="content" ${searchType == 'content' ? 'selected' : ''}>내용</option>
            </select>
        </div>

        <div class="community-search-input-wrap">
            <input type="text"
                   name="keyword"
                   class="community-search-input"
                   placeholder="검색어를 입력해주세요"
                   value="${keyword}">
            <button type="submit" class="community-search-btn">🔍</button>
        </div>

        <a href="#" class="community-write-btn" id="openWriteModal">게시글 작성</a>
    </form>

    <h2 class="section-title">인기게시글 top 6</h2>
    <table class="board-table">
        <thead>
            <tr>
                <th class="col-no">순번</th>
                <th class="col-title">제목</th>
                <th class="col-writer">작성자</th>
                <th class="col-view">조회수</th>
                <th class="col-like">좋아요수</th>
                <th class="col-date">작성날</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty popularBoardList}">
                    <c:forEach var="board" items="${popularBoardList}" varStatus="status">
                        <tr onclick="location.href='${contextPath}/community/detail?boardNo=${board.boardNo}'" style="cursor:pointer;">
                            <td>${status.count}</td>
                            <td class="title-cell">${board.boardTitle}</td>
                            <td>${board.memberId}</td>
                            <td>${board.readCount}</td>
                            <td>${board.likeCount}</td>
                            <td>${board.createDate}</td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="6">등록된 인기 게시글이 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <h2 class="section-title">최신등록 게시글</h2>
    <table class="board-table">
        <thead>
            <tr>
                <th class="col-no">순번</th>
                <th class="col-title">제목</th>
                <th class="col-writer">작성자</th>
                <th class="col-view">조회수</th>
                <th class="col-like">좋아요수</th>
                <th class="col-date">작성날</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty latestBoardList}">
                    <c:forEach var="board" items="${latestBoardList}" varStatus="status">
                        <tr onclick="location.href='${contextPath}/community/detail?boardNo=${board.boardNo}'" style="cursor:pointer;">
                            <td>${status.count}</td>
                            <td class="title-cell">${board.boardTitle}</td>
                            <td>${board.memberId}</td>
                            <td>${board.readCount}</td>
                            <td>${board.likeCount}</td>
                            <td>${board.createDate}</td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="6">등록된 최신 게시글이 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <div class="write-modal-overlay" id="writeModal">
        <div class="write-modal">
            <button type="button" class="write-modal-close" id="closeWriteModal">×</button>

            <div class="write-modal-title">
                게시판을 선택해주세요
            </div>

            <div class="write-modal-btn-wrap">
                <a href="${pageContext.request.contextPath}/community/writeBoard?boardType=myKidBoard" class="write-modal-btn">
                    우리 아이 자랑 게시판
                </a>

                <a href="${pageContext.request.contextPath}/community/writeBoard?boardType=tip" class="write-modal-btn">
                    육아 꿀팁 게시판
                </a>

                <a href="${pageContext.request.contextPath}/community/writeBoard?boardType=free" class="write-modal-btn">
                    자유 게시판
                </a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
    const openWriteModal = document.getElementById("openWriteModal");
    const writeModal = document.getElementById("writeModal");
    const closeWriteModal = document.getElementById("closeWriteModal");

    openWriteModal.addEventListener("click", function(e) {
        e.preventDefault();
        writeModal.classList.add("show");
    });

    closeWriteModal.addEventListener("click", function() {
        writeModal.classList.remove("show");
    });

    writeModal.addEventListener("click", function(e) {
        if (e.target === writeModal) {
            writeModal.classList.remove("show");
        }
    });
</script>

</body>
</html>