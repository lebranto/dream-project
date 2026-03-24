<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>집사상점 관리자 - 신고 사항 상세</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css">
    
    <style>
        /* 상세 페이지 레이아웃 구조 */
        .admin-wrapper { 
            display: flex; 
            min-height: calc(100vh - 100px); 
            background-color: #f4f4f4;
        }

        .admin-content { 
            flex-grow: 1; 
            padding: 40px; 
            background-color: #fff; 
            min-width: 900px; 
        }

        /* 콘텐츠 헤더 */
        .content-header h2 { font-size: 28px; font-weight: bold; margin-bottom: 15px; }
        .content-header hr { border: 0; border-top: 1px solid #333; margin-bottom: 30px; }

        /* 이미지 상단 미색(연노랑) 요약 바 */
        .summary-bar {
            background-color: #fdf5e6;
            border: 1px solid #999;
            padding: 15px;
            text-align: center;
            font-weight: bold;
            font-size: 16px;
            margin-bottom: 25px;
            border-radius: 4px;
        }

        /* 메인 컨테이너 (상세 내용 박스) */
        .detail-container {
            border: 1px solid #999;
            padding: 40px;
            background: #fff;
            border-radius: 4px;
        }

        /* 상단 정보 (유형, 작성일) */
        .detail-info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 14px;
        }
        .info-item label { font-weight: bold; margin-right: 15px; }
        .detail-divider { border: 0; border-top: 1px solid #ccc; margin-bottom: 25px; }

        /* 신고 내용 섹션 (이미지의 회색 배경 영역) */
        .report-body {
            display: flex;
            gap: 20px;
            background-color: #e0e0e0;
            padding: 25px;
            margin-bottom: 30px;
            border-radius: 4px;
        }
        
        /* 사진 영역 */
        .photo-area {
            width: 130px;
            height: 160px;
            background: #fff;
            border: 1px solid #999;
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            font-size: 12px;
            color: #777;
            flex-shrink: 0;
            line-height: 1.5;
        }

        /* 텍스트 내용 영역 */
        .text-area {
            flex-grow: 1;
            background: #fff;
            border: 1px solid #999;
            padding: 20px;
            min-height: 160px;
            font-size: 14px;
            line-height: 1.6;
            color: #333;
        }

        /* 관리자 답변/처리 영역 */
        .reply-section { margin-bottom: 30px; }
        .reply-header { margin-bottom: 10px; }
        .reply-header h3 { font-size: 16px; font-weight: bold; margin: 0; }
        
        .reply-body {
            background-color: #e0e0e0;
            padding: 25px;
            border-radius: 4px;
        }
        .reply-body textarea {
            width: 100%;
            height: 120px;
            border: 1px solid #999;
            padding: 20px;
            font-size: 14px;
            resize: none;
            box-sizing: border-box;
            outline: none;
        }

        /* 하단 컨트롤 영역 (상태 선택 + 버튼) */
        .detail-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .status-group {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .status-group label { font-size: 14px; font-weight: bold; }

        /* 커스텀 셀렉트 박스 (민트색 화살표 포인트) */
        .select-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }
        .select-wrapper select {
            padding: 8px 40px 8px 15px;
            border: 1px solid #999;
            background-color: #fdf5e6;
            cursor: pointer;
            appearance: none; /* 기본 화살표 제거 */
            -webkit-appearance: none;
            font-size: 13px;
            border-radius: 4px;
        }
        .arrow-mint {
            width: 0; height: 0;
            border-left: 8px solid transparent;
            border-right: 8px solid transparent;
            border-top: 10px solid #48c9b0; /* 민트색 포인트 */
            position: absolute;
            right: 12px;
            pointer-events: none;
        }

        /* 버튼 스타일 */
        .btn-group { display: flex; gap: 10px; }
        .btn {
            padding: 10px 35px;
            border: 1px solid #999;
            cursor: pointer;
            font-size: 14px;
            border-radius: 4px;
            font-weight: bold;
        }
        .btn-submit { background-color: #f0c674; color: #333; } /* 황금색 */
        .btn-delete { background-color: #f2f2f2; color: #333; font-weight: normal; }
        .btn:hover { opacity: 0.8; }
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

            <div class="summary-bar">
                # {USER} 님의 신고 사항
            </div>

            <form action="updateReport.do" method="post" class="detail-container">
                <div class="detail-info-row">
                    <div class="info-item">
                        <label>신고 유형 :</label>
                        <span>부적절한 댓글</span>
                    </div>
                    <div class="info-item">
                        <label>작성일 :</label>
                        <span>2026-03-10</span>
                    </div>
                </div>
                <hr class="detail-divider">

                <div class="report-body">
                    <div class="photo-area">
                        신고 대상<br>사진<br>(선택사항)
                    </div>
                    <div class="text-area">
                        부적절한 언어를 사용을 한 댓글 입니다.
                    </div>
                </div>

                <div class="reply-section">
                    <div class="reply-header">
                        <h3>처리 내역 및 답변</h3>
                    </div>
                    <div class="reply-body">
                        <textarea name="adminComment" placeholder="처리 내용 및 답변자 작성글 적기"></textarea>
                    </div>
                </div>

                <div class="detail-footer">
                    <div class="status-group">
                        <label>처리 상태 :</label>
                        <div class="select-wrapper">
                            <select name="reportStatus">
                                <option value="wait">처리 대기</option>
                                <option value="done">처리 완료</option>
                                <option value="cancel">반려</option>
                            </select>
                            <div class="arrow-mint"></div>
                        </div>
                    </div>
                    
                    <div class="btn-group">
                        <button type="submit" class="btn btn-submit">처리 등록</button>
                        <button type="button" class="btn btn-delete" onclick="history.back();">취소</button>
                    </div>
                </div>
            </form>
        </main>
    </div>

</body>
</html>