<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의 등록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/inquiryWrite.css">
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="inquiry-write-wrap">
        <div class="inquiry-write-container">
            <h2 class="page-title">1:1 문의</h2>

            <!-- 🔥 핵심: action / method / enctype -->
            <form action="${pageContext.request.contextPath}/product/inquiryWrite"
                  method="post"
                  enctype="multipart/form-data">

                <!-- 문의 유형 -->
                <div class="write-section">
                    <div class="section-title">문의 유형</div>
                    <div class="section-box">
                        <select name="inquiryType" class="inquiry-select">
                            <option value="교환반품">교환반품</option>
                            <option value="상품문의">상품문의</option>
                            <option value="배송문의">배송문의</option>
                            <option value="주문문의">주문문의</option>
                        </select>
                    </div>
                </div>

                <!-- 문의 내용 -->
                <div class="write-section">
                    <div class="section-title">본문</div>
                    <div class="section-box">
                        <textarea name="inquiryContent"
                                  class="inquiry-textarea"
                                  placeholder="문의 내용을 입력해주세요."></textarea>
                    </div>
                </div>

                <!-- 첨부파일 + 비밀번호 -->
                <div class="write-section">
                    <div class="section-title">첨부파일</div>
                    <div class="section-box">

                        <div class="file-box">
                            <label class="file-label">파일 선택</label>
                            <input type="file" name="uploadFile" class="file-input">
                        </div>

                        <div class="password-box">
                            <label>비밀번호</label>
                            <input type="password" name="inquiryPw" class="password-input">
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

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>