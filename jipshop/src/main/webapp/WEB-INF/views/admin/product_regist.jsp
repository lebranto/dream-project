<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>집사상점 관리자 - 상품 등록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin.css">
    
    <style>
        /* 기본 레이아웃 설정 */
        body, html { margin: 0; padding: 0; height: 100%; font-family: 'Malgun Gothic', sans-serif; }
        .admin-wrapper { display: flex; width: 100%; min-height: 100vh; }
        
        /* 메인 본문 영역 */
        .admin-content { 
            flex-grow: 1; 
            padding: 40px 60px; 
            background-color: #fff;
            min-width: 900px;
        }

        /* 페이지 제목 스타일 */
        .content-header h2 { font-size: 28px; font-weight: bold; margin: 0 0 15px 0; }
        .content-header hr { border: 0; border-top: 1px solid #333; margin-bottom: 50px; }

        /* 상품 등록 폼 디자인 */
        .reg-form { width: 100%; max-width: 850px; }
        .form-group { display: flex; align-items: flex-start; margin-bottom: 25px; }
        
        /* 라벨 (항목명) */
        .form-label { 
            width: 160px; 
            font-size: 19px; 
            font-weight: bold; 
            display: flex; 
            align-items: center;
            padding-top: 5px;
        }
        /* 필수 항목 별표(*) */
        .required::before { content: "*"; color: #333; margin-right: 2px; }

        /* 입력 요소 공통 */
        .input-wrap { flex: 1; display: flex; gap: 15px; align-items: center; }
        .form-control { 
            height: 35px; width: 320px;
            padding: 0 10px; border: 1px solid #999;
            font-size: 14px; color: #ccc;
        }
        .form-select {
            height: 35px; width: 230px;
            padding: 0 10px; border: 1px solid #ccc;
            font-size: 14px; color: #ccc;
            background: #fff url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path d="M7 10l5 5 5-5z" fill="%23ccc"/></svg>') no-repeat right 10px center;
            appearance: none;
        }

        /* 사진 등록 영역 */
        .file-upload-section { display: flex; flex-direction: column; gap: 10px; }
        .file-input-box { 
            display: flex; width: 450px; height: 35px; border: 1px solid #999; align-items: center; 
        }
        .file-name { flex: 1; padding-left: 10px; font-size: 13px; color: #ccc; }
        .file-btn { 
            width: 80px; height: 100%; background: #d9d9d9; border: none; 
            border-left: 1px solid #999; cursor: pointer; font-size: 13px;
        }

        /* 이미지 미리보기 박스 */
        .image-preview { 
            width: 180px; height: 120px; border: 1px solid #eee; overflow: hidden; 
            background-color: #f9f9f9; display: flex; justify-content: center; align-items: center;
        }
        .image-preview img { width: 100%; height: 100%; object-fit: cover; }

        /* 상세 정보 (큰 텍스트 영역) */
        .form-textarea {
            width: 550px; height: 250px; border: 1px solid #999; padding: 20px;
            font-size: 15px; color: #ccc; resize: none; display: flex;
            align-items: center; justify-content: center; text-align: center;
        }

        /* 하단 등록 버튼 */
        .form-footer { margin-top: 50px; display: flex; justify-content: flex-end; padding-right: 50px; }
        .btn-submit {
            background-color: #d9d9d9; border: none; padding: 12px 65px;
            font-size: 18px; font-weight: bold; cursor: pointer; border-radius: 4px;
        }
        .btn-submit:hover { background-color: #ccc; }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/admin/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/admin/header.jsp"/>

    <div class="admin-wrapper">

        <main class="admin-content">
            <section class="content-header">
                <h2>상품 등록</h2>
                <hr>
            </section>

            <form action="productReg.do" method="post" enctype="multipart/form-data" class="reg-form">
                
                <div class="form-group">
                    <label class="form-label required">카테고리 :</label>
                    <div class="input-wrap">
                        <select name="petType" class="form-select">
                            <option value="">반려동물 종류 선택</option>
                        </select>
                        <select name="pCategory" class="form-select">
                            <option value="">상품 카테고리 선택</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label required">상품명 :</label>
                    <div class="input-wrap">
                        <input type="text" name="pName" class="form-control" placeholder="상품 이름 적기">
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">업체명 :</label>
                    <div class="input-wrap">
                        <input type="text" name="company" class="form-control" placeholder="업체명 적기">
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label required">판매가 :</label>
                    <div class="input-wrap">
                        <input type="text" name="price" class="form-control" placeholder="판매가격 적기">
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label required">수량 :</label>
                    <div class="input-wrap">
                        <input type="text" name="stock" class="form-control" placeholder="상품 수량 적기">
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label required">사진 등록 :</label>
                    <div class="file-upload-section">
                        <div class="file-input-box">
                            <div class="file-name" id="fileName1"></div>
                            <button type="button" class="file-btn" onclick="document.getElementById('file1').click()">첨부</button>
                            <input type="file" id="file1" name="file1" style="display:none;" onchange="showName(this, 'fileName1')">
                        </div>
                        <div class="image-preview">
                            <img src="${pageContext.request.contextPath}/resources/images/강아지.png" alt="강아지 미리보기">
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label required">사진 등록 :</label>
                    <div class="file-upload-section">
                        <div class="file-input-box">
                            <div class="file-name" id="fileName2"></div>
                            <button type="button" class="file-btn" onclick="document.getElementById('file2').click()">첨부</button>
                            <input type="file" id="file2" name="file2" style="display:none;" onchange="showName(this, 'fileName2')">
                        </div>
                        <div class="image-preview">
                            <img src="${pageContext.request.contextPath}/resources/images/고양이.png" alt="고양이 미리보기">
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">상세 정보 :</label>
                    <div class="input-wrap">
                        <textarea name="pDetail" class="form-textarea" placeholder="상품 상세 설명"></textarea>
                    </div>
                </div>

                <div class="form-footer">
                    <button type="submit" class="btn-submit">등록</button>
                </div>

            </form>
        </main>
    </div>

    <script>
        // 파일 선택 시 파일명 표시 로직
        function showName(input, targetId) {
            if(input.files && input.files[0]) {
                document.getElementById(targetId).innerText = input.files[0].name;
                document.getElementById(targetId).style.color = "#333";
            }
        }
    </script>
</body>
</html>