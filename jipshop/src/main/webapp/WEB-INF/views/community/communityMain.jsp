<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="isLogin" value="${not empty pageContext.request.userPrincipal}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community/communityMain.css">

<style type="text/css">
@charset "UTF-8";

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
    font-family: "맑은 고딕", "Malgun Gothic", sans-serif;
}

body {
    background: #f7f4ee;
    color: #3f3127;
}

a {
    text-decoration: none;
    color: inherit;
}

button {
    border: none;
    background: none;
    cursor: pointer;
}

.community-wrap {
    width: min(1320px, 94%);
    max-width: 1320px;
    margin: 0 auto;
    padding: 20px 0 56px;
    background: transparent;
}

/* 상단 타이틀 카드 */
.community-title {
    width: 100%;
    max-width: 1160px;
    min-height: 128px;
    margin: 0 auto 18px;
    padding: 18px 30px 16px;
    border: 1px solid #ead7d7;
    border-radius: 30px;
    background: #fff4f4;
    box-shadow: 0 8px 20px rgba(120, 82, 92, 0.03);
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 4px;
    text-align: center;
    font-size: 30px;
    font-weight: 700;
    line-height: 1.2;
    color: #47363a;
}

.community-title::before {
    content: "🐾 강아지와 고양이 이야기";
    display: block;
    font-size: 13px;
    font-weight: 700;
    color: #c58f8f;
    margin-bottom: 2px;
}

/* 이모지 after 제거 */
.community-title::after {
    content: none !important;
    display: none !important;
}

/* 게시판 탭 */
.category-area {
    width: 100%;
    max-width: 1160px;
    margin: 0 auto 16px;
    display: flex;
    gap: 12px;
    border: none !important;
    outline: none !important;
    background: transparent !important;
    box-shadow: none !important;
}

.category-area * {
    box-shadow: none !important;
}

.category-btn {
    flex: 1;
    height: 56px;
    border: 1px solid #e3d6ca !important;
    border-radius: 20px;
    background: #fffaf6 !important;
    color: #5b4a3f;
    font-size: 19px;
    font-weight: 800;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: 0.18s ease;
    box-shadow: none !important;
}

.category-btn:hover {
    background: #fbf2e8 !important;
    transform: translateY(-1px);
}

.category-btn.active {
    background: #f4ece4 !important;
    border-color: #dac9b7 !important;
    color: #45362b !important;
}

/* 검색영역 */
.community-search-area {
    width: 100%;
    max-width: 1160px;
    margin: 0 auto 28px;
    padding: 12px 14px;
    border: 1px solid #e3d1c5;
    border-radius: 24px;
    background: #f0e3d7;
    display: grid;
    grid-template-columns: 180px minmax(0, 1fr) 140px;
    gap: 10px;
    align-items: center;
}

.community-search-select-wrap {
    position: relative;
    width: 100%;
    height: 46px;
    border: 1px solid #d9c9bb;
    border-radius: 16px;
    background: #fffaf6;
    overflow: hidden;
}

.community-search-select {
    width: 100%;
    height: 100%;
    border: none;
    background: transparent;
    padding: 0 35px 0 14px;
    font-size: 14px;
    color: #5a4b40;
    outline: none;
    appearance: none;
    cursor: pointer;
}

.community-search-select-wrap::after {
    content: "▼";
    position: absolute;
    right: 12px;
    top: 14px;
    font-size: 10px;
    color: #aa9685;
    pointer-events: none;
}

.community-search-input-wrap {
    width: 100%;
    height: 46px;
    display: flex;
    align-items: center;
    border: 1px solid #d9c9bb;
    border-radius: 16px;
    background: #fffaf6;
    overflow: hidden;
    min-width: 0;
}

.community-search-input {
    flex: 1;
    height: 100%;
    border: none;
    background: transparent;
    padding: 0 14px;
    font-size: 14px;
    color: #4f4036;
    outline: none;
}

.community-search-input::placeholder {
    color: #a08d80;
}

.community-search-btn {
    width: 48px;
    height: 100%;
    border-left: 1px solid #d9c9bb;
    background: #ead8ca;
    font-size: 22px;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
}

.community-write-btn,
a.community-write-btn,
button.community-write-btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 140px;
    min-width: 140px;
    height: 46px;
    border: none;
    border-radius: 18px;
    background: linear-gradient(180deg, #f1d36f 0%, #e8c04a 100%);
    color: #4b3a27;
    font-size: 15px;
    font-weight: 700;
    white-space: nowrap;
    box-shadow: 0 8px 18px rgba(226, 184, 70, 0.18);
}

/* 섹션 제목 */
.section-title {
    width: 100%;
    max-width: 1160px;
    margin: 0 auto 10px;
    font-size: 18px;
    font-weight: 800;
    color: #3f3026;
}

/* 테이블 */
.board-table {
    width: 100%;
    max-width: 1160px;
    margin: 0 auto 26px;
    border-collapse: separate;
    border-spacing: 0;
    table-layout: fixed;
    overflow: hidden;
    background: #fff;
    border: 1px solid #e7d8cb;
    border-radius: 28px;
}

.board-table thead tr {
    background: #faf5ef;
}

.board-table th,
.board-table td {
    padding: 16px 10px;
    font-size: 14px;
    text-align: center;
    border-bottom: 1px solid #efe5dc;
    color: #57473b;
}

.board-table th {
    font-weight: 700;
    color: #7a6554;
}

.board-table tbody tr:last-child td {
    border-bottom: none;
}

.board-table tbody tr:hover td {
    background: #fffaf7;
}

.board-table .col-no {
    width: 90px;
}

.board-table .col-title {
    width: auto;
}

.board-table .col-writer {
    width: 120px;
}

.board-table .col-view {
    width: 100px;
}

.board-table .col-like {
    width: 100px;
}

.board-table .col-date {
    width: 130px;
}

.board-table td.title-cell {
    text-align: left;
    padding-left: 18px;
    font-size: 16px;
    font-weight: 600;
    color: #3f3127;
}

/* 모달 */
.write-modal-overlay {
    position: fixed;
    inset: 0;
    background: rgba(0, 0, 0, 0.35);
    display: none;
    justify-content: center;
    align-items: center;
    z-index: 9999;
}

.write-modal-overlay.show {
    display: flex;
}

.write-modal {
    position: relative;
    width: 560px;
    max-width: 92vw;
    background: #fffdf8;
    border: 1px solid #e3d2c7;
    border-radius: 32px;
    padding: 44px 40px 36px;
    box-shadow: 0 20px 50px rgba(50, 38, 18, 0.2);
    text-align: center;
}

.write-modal-close {
    position: absolute;
    top: 16px;
    right: 22px;
    font-size: 34px;
    line-height: 1;
    color: #6b573b;
    cursor: pointer;
}

.write-modal-title {
    font-size: 32px;
    font-weight: 900;
    margin-bottom: 30px;
    color: #3f3123;
}

.write-modal-btn-wrap {
    display: flex;
    flex-direction: column;
    gap: 18px;
}

.write-modal-btn {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    min-height: 64px;
    background: #fbf4e3;
    border: 2px solid #e3d2ad;
    border-radius: 22px;
    color: #4a3927;
    font-size: 24px;
    font-weight: 800;
    transition: 0.18s ease;
}

.write-modal-btn:hover {
    background: #f0d98f;
    transform: translateY(-2px);
}

/* 반응형 */
@media (max-width: 900px) {
    .community-title {
        min-height: 118px;
        padding: 16px 20px 14px;
        font-size: 26px;
    }

    .category-area {
        flex-direction: column;
    }

    .category-btn {
        width: 100%;
        height: 54px;
        font-size: 18px;
    }

    .community-search-area {
        grid-template-columns: 1fr;
    }

    .community-write-btn,
    a.community-write-btn,
    button.community-write-btn {
        width: 100%;
    }

    .write-modal {
        width: 92vw;
        padding: 34px 24px 28px;
    }

    .write-modal-title {
        font-size: 26px;
    }

    .write-modal-btn {
        min-height: 56px;
        font-size: 20px;
    }
}

@media (max-width: 640px) {
    .community-wrap {
        width: 94%;
        padding: 16px 0 44px;
    }

    .community-title {
        border-radius: 24px;
        font-size: 24px;
    }

    .community-title::before {
        font-size: 12px;
    }

    .category-btn {
        height: 52px;
        font-size: 17px;
        border-radius: 18px;
    }

    .board-table {
        border-radius: 20px;
    }

    .board-table th,
    .board-table td {
        font-size: 13px;
        padding: 14px 8px;
    }

    .board-table td.title-cell {
        font-size: 14px;
        padding-left: 12px;
    }

    .write-modal-title {
        font-size: 22px;
    }

    .write-modal-btn {
        min-height: 52px;
        font-size: 18px;
        border-radius: 18px;
    }
}
</style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="community-wrap">
    <h1 class="community-title">커뮤니티</h1>

    <div class="category-area">
        <a href="${contextPath}/community/myKidBoard"
           class="category-btn"
           onclick="return moveCommunityBoard(event, this.href);">
           우리아이 자랑 게시판
        </a>

        <a href="${contextPath}/community/tipFreeBoard?boardType=tip"
           class="category-btn"
           onclick="return moveCommunityBoard(event, this.href);">
           육아 꿀팁
        </a>

        <a href="${contextPath}/community/tipFreeBoard?boardType=free"
           class="category-btn"
           onclick="return moveCommunityBoard(event, this.href);">
           자유 게시판
        </a>
    </div>

    <form class="community-search-area"
          action="${contextPath}/community/main" method="get">
        <div class="community-search-select-wrap">
            <select name="searchType" class="community-search-select">
                <option value="all"
                    ${empty searchType || searchType == 'all' ? 'selected' : ''}>제목 / 작성자 / 내용</option>
                <option value="title" ${searchType == 'title' ? 'selected' : ''}>제목</option>
                <option value="writer" ${searchType == 'writer' ? 'selected' : ''}>작성자</option>
                <option value="content" ${searchType == 'content' ? 'selected' : ''}>내용</option>
            </select>
        </div>

        <div class="community-search-input-wrap">
            <input type="text" name="keyword" class="community-search-input"
                   placeholder="검색어를 입력해주세요" value="${keyword}">
            <button type="submit" class="community-search-btn">🔍</button>
        </div>

        <a href="#" class="community-write-btn" id="openWriteModal">게시글 작성</a>
    </form>

    <h2 class="section-title">인기게시글 top 5</h2>
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
                        <tr onclick="location.href='${contextPath}/community/detail?boardNo=${board.boardNo}'"
                            style="cursor: pointer;">
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
                        <tr onclick="location.href='${contextPath}/community/detail?boardNo=${board.boardNo}'"
                            style="cursor: pointer;">
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

            <div class="write-modal-title">게시판을 선택해주세요</div>

            <div class="write-modal-btn-wrap">
                <a href="${pageContext.request.contextPath}/community/writeBoard?boardType=myKidBoard"
                   class="write-modal-btn"
                   onclick="return checkCommunityLogin(event, this.href);">
                   우리아이 자랑 게시판
                </a>

                <a href="${pageContext.request.contextPath}/community/writeBoard?boardType=tip"
                   class="write-modal-btn"
                   onclick="return checkCommunityLogin(event, this.href);">
                   육아 꿀팁
                </a>

                <a href="${pageContext.request.contextPath}/community/writeBoard?boardType=free"
                   class="write-modal-btn"
                   onclick="return checkCommunityLogin(event, this.href);">
                   자유게시판
                </a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
    const isLogin = ${isLogin ? 'true' : 'false'};

    const openWriteModal = document.getElementById("openWriteModal");
    const writeModal = document.getElementById("writeModal");
    const closeWriteModal = document.getElementById("closeWriteModal");
    const writeModalBtns = document.querySelectorAll(".write-modal-btn");

    if (openWriteModal) {
        openWriteModal.addEventListener("click", function (e) {
            e.preventDefault();

            if (!isLogin) {
                alert("로그인이 필요합니다.");
                location.href = "${contextPath}/member/login";
                return;
            }

            if (writeModal) {
                writeModal.classList.add("show");
            }
        });
    }

    if (closeWriteModal) {
        closeWriteModal.addEventListener("click", function () {
            if (writeModal) {
                writeModal.classList.remove("show");
            }
        });
    }

    if (writeModal) {
        writeModal.addEventListener("click", function (e) {
            if (e.target === writeModal) {
                writeModal.classList.remove("show");
            }
        });
    }

    writeModalBtns.forEach(function (btn) {
        btn.addEventListener("click", function (e) {
            if (!isLogin) {
                e.preventDefault();
                alert("로그인이 필요합니다.");
                location.href = "${contextPath}/member/login";
            }
        });
    });

    function moveCommunityBoard(event, boardUrl) {
        if (!isLogin) {
            event.preventDefault();
            alert("로그인이 필요합니다.");
            location.href = "${contextPath}/member/login";
            return false;
        }

        location.href = boardUrl;
        return false;
    }

    function checkCommunityLogin(event, boardUrl) {
        if (!isLogin) {
            event.preventDefault();
            alert("로그인이 필요합니다.");
            location.href = "${contextPath}/member/login";
            return false;
        }
        return true;
    }
</script>

<c:if test="${not empty alertMsg}">
    <script>
        alert("${alertMsg}");
    </script>
</c:if>

</body>
</html>