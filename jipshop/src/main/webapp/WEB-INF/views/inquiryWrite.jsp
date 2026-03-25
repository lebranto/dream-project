<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의 등록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/inquiryWrite.css">
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="inquiry-write-wrap">
        <div class="inquiry-write-container">
            <h2 class="page-title">1:1 문의</h2>

            <form action="${pageContext.request.contextPath}/inquiry/write" 
                  method="post" 
                  enctype="multipart/form-data">

                <div class="write-section">
                    <div class="section-title">문의내용</div>
                    <div class="section-box">
                        <select name="category" class="inquiry-select">
                            <option value="교환반품">교환반품</option>
                            <option value="상품문의">상품문의</option>
                            <option value="배송문의">배송문의</option>
                            <option value="주문문의">주문문의</option>
                        </select>
                    </div>
                </div>

                <div class="write-section">
                    <div class="section-title">본문</div>
                    <div class="section-box">
                        <textarea name="content" class="inquiry-textarea" placeholder="양식에 맞춰 내용을 작성해 주세요.
주문 번호가 있는 경우 함께 입력해 주세요.
문의 내용을 자세히 적어주시면 더 빠른 답변을 받으실 수 있습니다."></textarea>
                    </div>
                </div>

                <div class="write-section">
                    <div class="section-title">첨부파일</div>
                    <div class="section-box">
                        <div class="file-box">
                            <label class="file-label">Attachment 1</label>
                            <input type="file" name="uploadFile" class="file-input">
                        </div>

                        <div class="password-box">
                            <label for="password">Password</label>
                            <input type="password" id="password" name="password" class="password-input">
                        </div>
                    </div>
                </div>

                <div class="btn-area">
                    <button type="submit" class="submit-btn">등록</button>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>