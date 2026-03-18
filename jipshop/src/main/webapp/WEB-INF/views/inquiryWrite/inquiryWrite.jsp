<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/inquiry.css">

</head>
<body>

<div class="inquiry-page">
    <h2 class="page-title">1:1문의</h2>

    <div class="inquiry-wrap">
        <form action="${pageContext.request.contextPath}/inquiry/insert" 
              method="post" 
              enctype="multipart/form-data">

            <!-- 문의내용 -->
            <div class="section">
                <label class="section-title">문의내용</label>
                <div class="section-content">
                    <select name="inquiryCategory" class="input-select" required>
                        <option value="">문의 유형 선택</option>
                        <option value="교환반품">교환반품</option>
                        <option value="상품문의">상품문의</option>
                        <option value="배송문의">배송문의</option>
                        <option value="주문결제">주문/결제</option>
                        <option value="기타">기타</option>
                    </select>
                </div>
            </div>

            <!-- 본문 -->
            <div class="section">
                <label class="section-title">본문</label>
                <div class="section-content">
                    <div class="editor-toolbar">
                        <button type="button">문단</button>
                        <button type="button">굵게</button>
                        <button type="button">기울임</button>
                        <button type="button">밑줄</button>
                        <button type="button">목록</button>
                        <button type="button">정렬</button>
                    </div>

                    <textarea name="inquiryContent" class="input-textarea" required>
양식에 맞춰 내용 작성해주시면 빠른 답변을 받으실 수 있습니다.
주문 번호 : (주문 번호를 꼭 입력해주셔야 문의 내용에 대한 확인이 가능합니다.)

문의 내용 :
                    </textarea>
                </div>
            </div>

            <!-- 첨부파일 / 비밀번호 -->
            <div class="section">
                <label class="section-title">첨부파일</label>
                <div class="section-content file-password-box">
                    <div class="file-area">
                        <label class="sub-title">Attachment1</label>
                        <input type="file" name="uploadFile" class="input-file">
                    </div>

                    <div class="password-area">
                        <label class="sub-title">Password</label>
                        <input type="password" name="inquiryPassword" class="input-password" maxlength="20">
                    </div>
                </div>
            </div>

            <!-- 버튼 -->
            <div class="btn-area">
                <button type="submit" class="submit-btn">등록</button>
            </div>
        </form>
    </div>
</div>

</body>
</html>