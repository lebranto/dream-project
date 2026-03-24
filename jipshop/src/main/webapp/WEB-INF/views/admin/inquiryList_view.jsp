<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 - 문의 상세 보기</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css">
    
    <style>
        /* 상세 페이지 전용 레이아웃 */
        .admin-wrapper { display: flex; min-height: calc(100vh - 100px); }
        .admin-content { flex-grow: 1; padding: 40px; background-color: #fff; min-width: 900px; }

        /* 콘텐츠 헤더 */
        .content-header h2 { font-size: 28px; font-weight: bold; margin-bottom: 15px; }
        .content-header hr { border: 0; border-top: 1px solid #333; margin-bottom: 30px; }

        /* 이미지 상단 미색 요약 바 */
        .summary-bar {
            background-color: #fdf5e6;
            border: 1px solid #999;
            padding: 15px;
            text-align: center;
            font-weight: bold;
            font-size: 16px;
            margin-bottom: 25px;
        }

        /* 메인 컨테이너 박스 */
        .detail-container {
            border: 1px solid #999;
            padding: 40px;
            background: #fff;
        }

        /* 제목 및 작성일 정보 */
        .detail-info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 14px;
        }
        .info-item label { font-weight: bold; margin-right: 10px; }
        .detail-divider { border: 0; border-top: 1px solid #ccc; margin-bottom: 25px; }

        /* 문의 내용 영역 (회색 배경) */
        .inquiry-body {
            display: flex;
            gap: 20px;
            background-color: #e0e0e0;
            padding: 25px;
            margin-bottom: 30px;
        }
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
        }
        .text-area {
            flex-grow: 1;
            background: #fff;
            border: 1px solid #999;
            padding: 20px;
            min-height: 160px;
            font-size: 14px;
            line-height: 1.6;
        }

        /* 답변 작성 영역 */
        .reply-body {
            background-color: #e0e0e0;
            padding: 25px;
            margin-bottom: 30px;
        }
        .reply-body textarea {
            width: 100%;
            height: 150px;
            border: 1px solid #999;
            padding: 20px;
            font-size: 14px;
            resize: none;
            box-sizing: border-box;
        }

        /* 하단 푸터 (상태선택 + 버튼) */
        .detail-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .status-select-wrap {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .status-select-wrap select {
            padding: 8px 15px;
            border: 1px solid #999;
            background-color: #fdf5e6;
            cursor: pointer;
        }
        /* 민트색 화살표 포인트 */
        .arrow-mint {
            width: 0; height: 0;
            border-left: 10px solid transparent;
            border-right: 10px solid transparent;
            border-top: 12px solid #48c9b0;
        }

        .submit-btn {
            background-color: #e0e0e0;
            border: 1px solid #999;
            padding: 8px 30px;
            cursor: pointer;
            font-size: 14px;
        }
        .submit-btn:hover { background-color: #d0d0d0; }
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

            <div class="summary-bar">
                # {USER} 님의 문의 내역
            </div>

            <div class="detail-container">
                <div class="detail-info-row">
                    <div class="info-item">
                        <label>제목 :</label>
                        <span>상품교환</span>
                    </div>
                    <div class="info-item">
                        <label>작성일 :</label>
                        <span>2026-03-10</span>
                    </div>
                </div>
                <hr class="detail-divider">

                <div class="inquiry-body">
                    <div class="photo-area">
                        사진<br>(선택사항)
                    </div>
                    <div class="text-area">
                        상품에 이상이 있는 것 같습니다. 빠른 반품 부탁드리겠습니다.
                    </div>
                </div>

                <div class="reply-body">
                    <textarea placeholder="답변자 작성글 적기"></textarea>
                </div>

                <div class="detail-footer">
                    <div class="status-select-wrap">
                        <select>
                            <option>답변 완료</option>
                            <option>처리 중</option>
                            <option>대기 중</option>
                        </select>
                        <div class="arrow-mint"></div>
                    </div>
                    <button type="button" class="submit-btn">등록</button>
                </div>
            </div>
        </main>
    </div>

</body>
</html>