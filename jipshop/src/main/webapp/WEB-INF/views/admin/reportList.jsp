<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>집사상점 관리자 - 신고 사항</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css">
    
    <style>
        /* 레이아웃 구조 */
        .admin-wrapper { display: flex; min-height: calc(100vh - 100px); }
        .admin-content { flex-grow: 1; padding: 40px; background-color: #fff; min-width: 1000px; }

        /* 콘텐츠 헤더 */
        .content-header h2 { font-size: 28px; font-weight: bold; margin-bottom: 15px; }
        .content-header hr { border: 0; border-top: 1px solid #333; margin-bottom: 30px; }

        /* 검색 필터 영역 (기간, 조회, 초기화) */
        .filter-section {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 15px;
        }
        .filter-group { display: flex; align-items: center; gap: 15px; font-size: 14px; }
        .date-input {
            padding: 8px 30px;
            border: 1px solid #999;
            background: #d9d9d9;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            min-width: 120px;
            text-align: center;
        }
        .filter-btn {
            padding: 8px 20px;
            border: 1px solid #666;
            background: #f0f0f0;
            cursor: pointer;
            font-size: 14px;
            border-radius: 4px;
        }

        /* 삭제 버튼 영역 */
        .action-row { display: flex; justify-content: flex-end; margin-bottom: 15px; }
        .btn-delete {
            padding: 6px 25px;
            border: 1px solid #666;
            background: #f0f0f0;
            cursor: pointer;
            font-size: 14px;
        }

        /* 테이블 스타일 (이미지의 노란색 헤더 반영) */
        .table-container { width: 100%; }
        .admin-table { width: 100%; border-collapse: collapse; text-align: center; }
        .admin-table th {
            background: #f0c674; /* 이미지의 황금색 */
            border: 1px solid #999;
            padding: 12px;
            font-weight: normal;
            font-size: 14px;
        }
        .admin-table td { border: 1px solid #ccc; padding: 10px; height: 45px; font-size: 14px; }
        .text-left { text-align: left !important; padding-left: 15px !important; }
        
        /* 체크박스 스타일 */
        .chk-box { width: 18px; height: 18px; cursor: pointer; }
        
        /* 상세페이지 이동 링크 커서 */
        .clickable { cursor: pointer; }
        .clickable:hover { text-decoration: underline; background-color: #f9f9f9; }

        /* 페이징 디자인 (민트색 화살표) */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 50px;
        }
        .page-list {
            display: flex;
            list-style: none;
            border: 1px solid #999;
            padding: 0;
            margin: 0;
        }
        .page-list li {
            padding: 8px 15px;
            border-right: 1px solid #999;
            background: #fdf5e6; /* 이미지의 미색 */
            cursor: pointer;
            font-size: 14px;
        }
        .page-list li:last-child { border-right: none; }
        .page-list li.active { background: #fff; font-weight: bold; }

        /* 민트색 삼각형 화살표 */
        .arrow-prev { border-top: 10px solid transparent; border-bottom: 10px solid transparent; border-right: 18px solid #48c9b0; cursor: pointer; margin-right: 20px; }
        .arrow-next { border-top: 10px solid transparent; border-bottom: 10px solid transparent; border-left: 18px solid #48c9b0; cursor: pointer; margin-left: 20px; }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/adminHeader.jsp" />

    <div class="admin-wrapper">
        <jsp:include page="/WEB-INF/views/common/adminSidebar.jsp" />

        <main class="admin-content">
            <section class="content-header">
                <h2>신고 사항</h2>
                <hr>
            </section>

            <div class="filter-section">
                <div class="filter-group">
                    <strong>기간 :</strong>
                    <button type="button" class="date-input">시작 날짜</button>
                    <span>~</span>
                    <button type="button" class="date-input">끝 날짜</button>
                    <button type="button" class="filter-btn">조회</button>
                    <button type="button" class="filter-btn">초기화</button>
                </div>
            </div>

            <div class="action-row">
                <button type="button" class="btn-delete">삭제</button>
            </div>

            <div class="table-container">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th style="width: 60px;">(체크칸)</th>
                            <th style="width: 80px;">번호</th>
                            <th style="width: 120px;">신고자</th>
                            <th style="width: 150px;">신고 유형</th>
                            <th>신고 사유</th>
                            <th style="width: 150px;">작성일</th>
                            <th style="width: 100px;">처리여부</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="clickable" onclick="location.href='report_detail.jsp?no=1'">
                            <td onclick="event.stopPropagation();"><input type="checkbox" class="chk-box"></td>
                            <td>1</td>
                            <td>오리양</td>
                            <td>부적절한 댓글</td>
                            <td class="text-left">부적절한 언어를 사용을 한 댓글 입니다.</td>
                            <td>2026-01-03</td>
                            <td>Y/N</td>
                        </tr>
                        
                        <c:forEach var="i" begin="2" end="10">
                            <tr>
                                <td><input type="checkbox" class="chk-box"></td>
                                <td>${i}</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="pagination">
                <div class="arrow-prev" title="이전"></div>
                <ul class="page-list">
                    <c:forEach var="p" begin="1" end="10">
                        <li class="${p == 1 ? 'active' : ''}">${p}</li>
                    </c:forEach>
                </ul>
                <div class="arrow-next" title="다음"></div>
            </div>
        </main>
    </div>

</body>
</html>