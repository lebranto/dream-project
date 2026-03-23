<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 - 문의 내역</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css">
    <style>
        /* 메인 레이아웃 구성 */
        .admin-wrapper { display: flex; min-height: calc(100vh - 100px); }
        .admin-content { flex-grow: 1; padding: 40px; background-color: #fff; min-width: 900px; }

        /* 이미지 UI 상세 구현 */
        .content-header h2 { font-size: 28px; font-weight: bold; margin-bottom: 15px; }
        .content-header hr { border: 0; border-top: 1px solid #333; margin-bottom: 30px; }
        
        .search-filter { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .date-btn { padding: 8px 35px; border: 1px solid #999; background: #d9d9d9; border-radius: 8px; cursor: pointer; }
        .action-btn { padding: 6px 20px; border: 1px solid #666; background: #f0f0f0; cursor: pointer; margin-left: 5px; }
        
        .admin-table { width: 100%; border-collapse: collapse; text-align: center; }
        .admin-table th { background: #f0c674; border: 1px solid #999; padding: 12px; font-weight: normal; }
        .admin-table td { border: 1px solid #ccc; padding: 10px; height: 45px; }
        .text-left { text-align: left !important; padding-left: 15px !important; }

        /* 페이징 */
        .pagination { display: flex; justify-content: center; align-items: center; margin-top: 50px; }
        .page-list { display: flex; list-style: none; border: 1px solid #999; padding: 0; margin: 0; }
        .page-list li { padding: 8px 15px; border-right: 1px solid #999; background: #fdf5e6; cursor: pointer; }
        .page-list li.active { background: #fff; font-weight: bold; }
        .arrow-prev { border-top: 10px solid transparent; border-bottom: 10px solid transparent; border-right: 18px solid #48c9b0; cursor: pointer; margin: 0 20px; }
        .arrow-next { border-top: 10px solid transparent; border-bottom: 10px solid transparent; border-left: 18px solid #48c9b0; cursor: pointer; margin: 0 20px; }
    </style>
</head>
<body>

        <jsp:include page="/WEB-INF/views/common/adminHeader.jsp" />

    <div class="admin-wrapper">
        <jsp:include page="/WEB-INF/views/common/adminSidebar.jsp" />

        <main class="admin-content">
            <section class="content-header">
                <h2>문의 내역</h2>
                <hr>
            </section>

            <div class="search-filter">
                <div class="date-picker-group" style="display:flex; align-items:center; gap:15px;">
                    <strong>작성일 :</strong>
                    <button type="button" class="date-btn">시작 날짜</button>
                    <span>~</span>
                    <button type="button" class="date-btn">끝 날짜</button>
                </div>
                <div class="btn-group">
                    <button type="button" class="action-btn">조회</button>
                    <button type="button" class="action-btn">삭제</button>
                </div>
            </div>

            <div class="table-container">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th style="width: 80px;">(체크칸)</th>
                            <th style="width: 80px;">번호</th>
                            <th style="width: 120px;">작성자</th>
                            <th style="width: 120px;">제목</th>
                            <th>내용..</th>
                            <th style="width: 150px;">작성일</th>
                            <th style="width: 150px;">처리일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><input type="checkbox"></td>
                            <td>1</td>
                            <td>오리양</td>
                            <td>상품교환</td>
                            <td class="text-left">상품에 이상이 생긴것 같습니다 빠른 처리를...</td>
                            <td>2026-01-03</td>
                            <td>2026-01-03</td>
                        </tr>
                        <c:forEach var="i" begin="2" end="10">
                            <tr>
                                <td><input type="checkbox"></td>
                                <td>${i}</td>
                                <td>오리양</td>
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
                <div class="arrow-prev"></div>
                <ul class="page-list">
                    <li class="active">1</li>
                    <c:forEach var="p" begin="2" end="10"><li>${p}</li></c:forEach>
                </ul>
                <div class="arrow-next"></div>
            </div>
        </main>
    </div>
</body>
</html>