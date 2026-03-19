<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티</title>
<style>
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        font-family: "맑은 고딕", "Malgun Gothic", sans-serif;
    }

    body {
        background-color: #efefef;
        color: #222;
    }

    .community-wrap {
        width: 800px;
        margin: 0 auto;
        background-color: #efefef;
        padding: 20px 0 40px;
    }

    .community-title {
        text-align: center;
        font-size: 56px;
        font-weight: 500;
        margin: 10px 0 20px;
    }

    .category-area {
        width: 590px;
        margin: 0 auto 20px;
        display: flex;
        border: 1px solid #d8d1c2;
    }

    .category-btn {
        flex: 1;
        height: 45px;
        border: none;
        border-right: 1px solid #d8d1c2;
        background-color: #efe6cf;
        font-size: 20px;
        cursor: pointer;
    }

    .category-btn:last-child {
        border-right: none;
    }

    .category-btn:hover {
        background-color: #e6dcc1;
    }

    .search-area {
        width: 590px;
        margin: 0 auto 25px;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .search-select-wrap {
        position: relative;
        width: 165px;
        height: 38px;
        background-color: #f8f5f2;
        border: 1px solid #ddd;
    }

    .search-select {
        width: 100%;
        height: 100%;
        border: none;
        background: transparent;
        padding: 0 35px 0 12px;
        font-size: 14px;
        appearance: none;
        outline: none;
        cursor: pointer;
    }

    .search-select-wrap::after {
        content: "▲\A▼";
        white-space: pre;
        position: absolute;
        right: 10px;
        top: 5px;
        font-size: 10px;
        color: #d6c89e;
        line-height: 10px;
        pointer-events: none;
    }

    .search-input-wrap {
        flex: 1;
        height: 38px;
        display: flex;
        border: 1px solid #ddd;
        background-color: #f8f5f2;
    }

    .search-input {
        flex: 1;
        border: none;
        padding: 0 12px;
        font-size: 14px;
        background: transparent;
        outline: none;
    }

    .search-btn {
        width: 45px;
        border: none;
        background-color: #f8f5f2;
        font-size: 24px;
        cursor: pointer;
    }

    .write-btn {
        width: 95px;
        height: 38px;
        border: 1px solid #d8d1c2;
        background-color: #efe6cf;
        font-size: 14px;
        cursor: pointer;
    }

    .section-title {
        width: 680px;
        margin: 0 auto 8px;
        font-size: 18px;
        font-weight: 500;
    }

    .board-table {
        width: 680px;
        margin: 0 auto 28px;
        border-collapse: collapse;
        background-color: transparent;
    }

    .board-table thead tr {
        border-top: 2px solid #d2b675;
        border-bottom: 1px solid #aaa;
    }

    .board-table tbody tr {
        border-bottom: 1px solid #b8b8b8;
    }

    .board-table th,
    .board-table td {
        padding: 12px 8px;
        font-size: 14px;
        text-align: center;
        font-weight: normal;
    }

    .board-table .col-no {
        width: 90px;
    }

    .board-table .col-title {
        width: 260px;
    }

    .board-table .col-writer {
        width: 90px;
    }

    .board-table .col-view {
        width: 70px;
    }

    .board-table .col-like {
        width: 80px;
    }

    .board-table .col-date {
        width: 90px;
    }

    .board-table td.title-cell {
        text-align: center;
    }
</style>
</head>
<body>

    <div class="community-wrap">
        <h1 class="community-title">커뮤니티</h1>

        <div class="category-area">
            <button type="button" class="category-btn">우리아이 자랑 게시판</button>
            <button type="button" class="category-btn">육아 꿀팁</button>
            <button type="button" class="category-btn">자유 게시판</button>
        </div>

        <form class="search-area" action="#" method="get">
            <div class="search-select-wrap">
                <select name="searchType" class="search-select">
                    <option value="all">제목 / 작성자 / 내용</option>
                    <option value="title">제목</option>
                    <option value="writer">작성자</option>
                    <option value="content">내용</option>
                </select>
            </div>

            <div class="search-input-wrap">
                <input type="text" name="keyword" class="search-input" placeholder="검색어를 입력해주세요">
                <button type="submit" class="search-btn">🔍</button>
            </div>

            <button type="button" class="write-btn">게시글 작성</button>
        </form>

        <h2 class="section-title">인기게시글 top 6</h2>
        <table class="board-table">
            <thead>
                <tr>
                    <th class="col-no">글번호</th>
                    <th class="col-title">제목</th>
                    <th class="col-writer">작성자</th>
                    <th class="col-view">조회수</th>
                    <th class="col-like">좋아요수</th>
                    <th class="col-date">작성날</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1. 글번호</td>
                    <td class="title-cell">제목</td>
                    <td>작성자</td>
                    <td>조회수</td>
                    <td>좋아요수</td>
                    <td>작성날</td>
                </tr>
                <tr>
                    <td>1. 글번호</td>
                    <td class="title-cell">제목</td>
                    <td>작성자</td>
                    <td>조회수</td>
                    <td>좋아요수</td>
                    <td>작성날</td>
                </tr>
                <tr>
                    <td>1. 글번호</td>
                    <td class="title-cell">제목</td>
                    <td>작성자</td>
                    <td>조회수</td>
                    <td>좋아요수</td>
                    <td>작성날</td>
                </tr>
                <tr>
                    <td>1. 글번호</td>
                    <td class="title-cell">제목</td>
                    <td>작성자</td>
                    <td>조회수</td>
                    <td>좋아요수</td>
                    <td>작성날</td>
                </tr>
                <tr>
                    <td>1. 글번호</td>
                    <td class="title-cell">제목</td>
                    <td>작성자</td>
                    <td>조회수</td>
                    <td>좋아요수</td>
                    <td>작성날</td>
                </tr>
                <tr>
                    <td>1. 글번호</td>
                    <td class="title-cell">제목</td>
                    <td>작성자</td>
                    <td>조회수</td>
                    <td>좋아요수</td>
                    <td>작성날</td>
                </tr>
            </tbody>
        </table>

        <h2 class="section-title">최신등록 게시글</h2>
        <table class="board-table">
            <thead>
                <tr>
                    <th class="col-no">글번호</th>
                    <th class="col-title">제목</th>
                    <th class="col-writer">작성자</th>
                    <th class="col-view">조회수</th>
                    <th class="col-like">좋아요수</th>
                    <th class="col-date">작성날</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>글번호</td>
                    <td class="title-cell">제목</td>
                    <td>작성자</td>
                    <td>조회수</td>
                    <td>좋아요수</td>
                    <td>작성날</td>
                </tr>
                <tr>
                    <td>글번호</td>
                    <td class="title-cell">제목</td>
                    <td>작성자</td>
                    <td>조회수</td>
                    <td>좋아요수</td>
                    <td>작성날</td>
                </tr>
                <tr>
                    <td>글번호</td>
                    <td class="title-cell">제목</td>
                    <td>작성자</td>
                    <td>조회수</td>
                    <td>좋아요수</td>
                    <td>작성날</td>
                </tr>
                <tr>
                    <td>글번호</td>
                    <td class="title-cell">제목</td>
                    <td>작성자</td>
                    <td>조회수</td>
                    <td>좋아요수</td>
                    <td>작성날</td>
                </tr>
                <tr>
                    <td>글번호</td>
                    <td class="title-cell">제목</td>
                    <td>작성자</td>
                    <td>조회수</td>
                    <td>좋아요수</td>
                    <td>작성날</td>
                </tr>
                <tr>
                    <td>글번호</td>
                    <td class="title-cell">제목</td>
                    <td>작성자</td>
                    <td>조회수</td>
                    <td>좋아요수</td>
                    <td>작성날</td>
                </tr>
                <tr>
                    <td>글번호</td>
                    <td class="title-cell">제목</td>
                    <td>작성자</td>
                    <td>조회수</td>
                    <td>좋아요수</td>
                    <td>작성날</td>
                </tr>
                <tr>
                    <td>글번호</td>
                    <td class="title-cell">제목</td>
                    <td>작성자</td>
                    <td>조회수</td>
                    <td>좋아요수</td>
                    <td>작성날</td>
                </tr>
                <tr>
                    <td>글번호</td>
                    <td class="title-cell">제목</td>
                    <td>작성자</td>
                    <td>조회수</td>
                    <td>좋아요수</td>
                    <td>작성날</td>
                </tr>
                <tr>
                    <td>글번호</td>
                    <td class="title-cell">제목</td>
                    <td>작성자</td>
                    <td>조회수</td>
                    <td>좋아요수</td>
                    <td>작성날</td>
                </tr>
            </tbody>
        </table>

    </div>

</body>
</html>