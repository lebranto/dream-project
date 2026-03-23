<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>마이페이지 최근 본 상품</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}" />

  <link rel="stylesheet" href="${contextPath}/resources/css/mypage/recent.css"> 
<!--   <link rel="stylesheet" href="/resources/css/mypage/recent.css"> -->
  
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />
   <aside class="sidebar">
   <div class="menu-group">
      <div class="menu-title">my 쇼핑</div>
      <ul class="menu-list">
        <a href="${contextPath}/mypage/purchase">구매 내역 보기</a><br>
        <a href="${contextPath}/mypage/recent">최근 본 상품</a>
      </ul>
    </div>

    <div class="menu-group">
      <div class="menu-title">문의</div>
      <ul class="menu-list">
        <a href="${contextPath}/mypage/inquiry">문의 내역</a>
      </ul>
    </div>

    <div class="menu-group">
      <div class="menu-title">회원 정보</div>
      <ul class="menu-list">
        <a href="${contextPath}/mypage/updateMemberCheck">회원 정보 수정</a><br>
        <a href="${contextPath}/mypage/updateMemberCheck">반려동물 정보 수정</a><br>
        <a href="${contextPath}/mypage/memberDelete">회원 탈퇴</a>
      </ul>
    </div>
    
     <div class="menu-group">
      <div class="menu-title">고객 센터</div>
      <ul class="menu-list">
        <a href="${contextPath}/mypage/purchase">1:1문의</a><br>
        <a href="${contextPath}/mypage/recent">FAQ</a><br>
      </ul>
    </div>
  </aside>


  <div class="content-wrap">
    <main class="content">
      <div class="page-title">마이페이지</div>

      <div class="recent-summary">
        ${loginUser.userName} 님의 조회 내역
      </div>

      <div class="filter-row">
        <button class="period-btn" type="button">1주일</button>
        <button class="period-btn" type="button">1개월</button>
        <button class="period-btn" type="button">3개월</button>
        <button class="period-btn" type="button">6개월</button>

        <div class="date-group">
          <input type="date" class="date-input">
          <span>~</span>
          <input type="date" class="date-input">
          <button class="search-btn" type="button">조회</button>
        </div>
      </div>

      <div class="table-header">
        <div>상품명/가격</div>
        <div>조회일</div>
        <div></div>
      </div>

      <div class="empty-box" id="recentEmptyBox">
        최근 본 상품이 없습니다
      </div>

      <div class="recent-list" id="recentList" style="display:none;"></div>
      <div class="pagination" id="recentPagination" style="display:none;"></div>
    </main>
  </div>

  <script>
    const recentViewData = [
      // <c:forEach var="item" items="${recentViewList}" varStatus="status">
      //   {
      //     image: "${item.image}",
      //     productName: "${item.productName}",
      //     price: "${item.price}",
      //     viewDate: "${item.viewDate}",
      //     productNo: "${item.productNo}"
      //   }<c:if test="${!status.last}">,</c:if>
      // </c:forEach>
    ];

    const recentItemsPerPage = 6;
    let recentCurrentPage = 1;

    const recentEmptyBox = document.getElementById("recentEmptyBox");
    const recentList = document.getElementById("recentList");
    const recentPagination = document.getElementById("recentPagination");

    function renderRecentList(page = 1) {
      recentList.innerHTML = "";

      if (!recentViewData || recentViewData.length === 0) {
        recentEmptyBox.style.display = "flex";
        recentList.style.display = "none";
        recentPagination.style.display = "none";
        return;
      }

      recentEmptyBox.style.display = "none";
      recentList.style.display = "flex";
      recentPagination.style.display = "flex";

      const startIndex = (page - 1) * recentItemsPerPage;
      const endIndex = startIndex + recentItemsPerPage;
      const pageItems = recentViewData.slice(startIndex, endIndex);

      pageItems.forEach(item => {
        const card = document.createElement("div");
        card.className = "recent-card";
        card.innerHTML = `
          <div class="product-cell">
            <img class="product-thumb" src="${item.image}" alt="${item.productName}">
            <div class="product-info">
              <div class="product-name">${item.productName}</div>
              <div>${item.price}</div>
            </div>
          </div>
          <div class="view-cell">${item.viewDate}</div>
          <div class="go-cell">
            <button class="go-btn" type="button" onclick="location.href='${pageContext.request.contextPath}/product/detail?productNo=${item.productNo}'">
              상품 보러가기
            </button>
          </div>
        `;
        recentList.appendChild(card);
      });

      renderRecentPagination();
    }

    function renderRecentPagination() {
      recentPagination.innerHTML = "";

      const totalPages = Math.ceil(recentViewData.length / recentItemsPerPage);
      const pageGroupSize = 10;

      if (totalPages <= 0) {
        recentPagination.style.display = "none";
        return;
      }

      recentPagination.style.display = "flex";

      const startPage =
        Math.floor((recentCurrentPage - 1) / pageGroupSize) * pageGroupSize + 1;
      const endPage = Math.min(startPage + pageGroupSize - 1, totalPages);

      const prevBtn = document.createElement("button");
      prevBtn.className = "page-arrow";
      prevBtn.type = "button";
      prevBtn.textContent = "◀";
      prevBtn.style.visibility = startPage === 1 ? "hidden" : "visible";

      prevBtn.addEventListener("click", () => {
        if (startPage > 1) {
          recentCurrentPage = startPage - 1;
          renderRecentList(recentCurrentPage);
        }
      });

      recentPagination.appendChild(prevBtn);

      for (let i = startPage; i <= endPage; i++) {
        const btn = document.createElement("button");
        btn.className = "page-btn";
        btn.type = "button";
        btn.textContent = i;

        if (i === recentCurrentPage) {
          btn.classList.add("active");
        }

        btn.addEventListener("click", () => {
          recentCurrentPage = i;
          renderRecentList(recentCurrentPage);
        });

        recentPagination.appendChild(btn);
      }

      const nextBtn = document.createElement("button");
      nextBtn.className = "page-arrow";
      nextBtn.type = "button";
      nextBtn.textContent = "▶";
      nextBtn.style.visibility = endPage === totalPages ? "hidden" : "visible";

      nextBtn.addEventListener("click", () => {
        if (endPage < totalPages) {
          recentCurrentPage = endPage + 1;
          renderRecentList(recentCurrentPage);
        }
      });

      recentPagination.appendChild(nextBtn);
    }

    renderRecentList(recentCurrentPage);
  </script>
  
  <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>