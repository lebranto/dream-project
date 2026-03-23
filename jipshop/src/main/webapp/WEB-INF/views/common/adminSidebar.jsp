<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 페이지 - 사이드바 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css">
    
    <style>
        /* 1. 사이드바 필수 스타일 (admin.css에 있다면 생략 가능) */
        .admin-sidebar { 
            width: 180px; 
            background: #d0d0d0; 
            flex-shrink: 0; 
            border-right: 1px solid #bbb;
        }

        .menu-list { list-style: none; margin: 0; padding: 0; }

        .menu-title { 
            background: #bbb; 
            padding: 12px 15px; 
            border-bottom: 1px solid #aaa; 
            color: #333; 
            font-weight: bold; 
            cursor: pointer;
            display: flex; /* 가로 정렬 */
            justify-content: space-between; /* 양 끝 정렬 */
            align-items: center; /* 세로 중앙 정렬 */
            transition: background 0.3s;
        }

        .menu-title:hover { background: #adadad; }

        /* 2. 깨지는 특수문자 대신 CSS로 깔끔한 화살표 그리기 */
        .menu-title.toggle .icon-arrow {
            width: 8px; /* 화살표 크기 */
            height: 8px;
            border-top: 2px solid #666; /* 화살표 선 두께 및 색상 */
            border-right: 2px solid #666;
            transform: rotate(135deg); /* 기본 상태 (닫힘, 아래 방향) */
            transition: transform 0.3s ease; /* 회전 애니메이션 */
            display: inline-block;
            margin-right: 5px; /* 텍스트와의 간격 */
        }

        /* 3. 하위 메뉴 숨김 상태 */
        .sub-menu { 
            display: none; 
            background: #e5e5e5; 
            list-style: none; 
            padding: 5px 0; 
            margin: 0;
        }

        .sub-menu li { 
            padding: 10px 25px; 
            font-size: 13px; 
            cursor: pointer; 
            color: #555;
            transition: background 0.2s;
        }

        .sub-menu li:hover { 
            background: #f0f0f0; 
            text-decoration: underline;
        }

        /* 4. 활성화(열림) 상태의 스타일 */
        .menu-item.active .sub-menu { 
            display: block; 
        }

        .menu-item.active .menu-title {
            background: #a0a0a0;
            color: #fff;
        }

        /* 활성화 시 화살표 회전 (열림, 위 방향) */
        .menu-item.active .menu-title.toggle .icon-arrow {
            transform: rotate(-45deg); 
            border-color: #fff; /* 열렸을 때 화살표 색상 변경 (선택사항) */
        }

        .active-item { 
            font-weight: bold; 
            color: #000 !important;
            text-decoration: underline;
        }
    </style>
</head>
<body>

<aside class="admin-sidebar">
    <div class="sidebar-header" style="padding: 20px 15px; font-size: 16px; font-weight: bold; text-align: center; background: #c0c0c0;">관리자 메뉴</div>
    <ul class="menu-list">
        <li class="menu-item">
            <div class="menu-title" onclick="location.href='member_list.jsp'">회원 관리</div>
        </li>

        <li class="menu-item">
            <div class="menu-title toggle">
                상품 관리
                <span class="icon-arrow"></span> </div>
            <ul class="sub-menu">
                <li onclick="location.href='product_reg.jsp'">상품 등록</li>
                <li onclick="location.href='product_list.jsp'">상품내역</li>
            </ul>
        </li>

        <li class="menu-item">
            <div class="menu-title toggle">
                매출 관리
                <span class="icon-arrow"></span>
            </div>
            <ul class="sub-menu">
                <li onclick="location.href='sales_day.jsp'">일별조회</li>
                <li onclick="location.href='sales_month.jsp'">월별조회</li>
            </ul>
        </li>

        <li class="menu-item">
            <div class="menu-title" onclick="location.href='order_list.jsp'">주문 관리</div>
        </li>

        <li class="menu-item active">
            <div class="menu-title toggle">
                고객센터 관리
                <span class="icon-arrow"></span>
            </div>
            <ul class="sub-menu">
                <li class="active-item" onclick="location.href='inquiry_list.jsp'">문의 조회</li>
                <li onclick="location.href='report_list.jsp'">신고 사항</li>
            </ul>
        </li>
    </ul>
</aside>

<script>
    // DOM이 완전히 로드된 후 실행되도록 설정
    document.addEventListener('DOMContentLoaded', function() {
        const toggles = document.querySelectorAll('.menu-title.toggle');
        
        toggles.forEach(title => {
            title.addEventListener('click', function(e) {
                // 클릭 이벤트 전파 방지 (필요 시)
                e.preventDefault();
                
                const parent = this.parentElement;
                
                // 클릭한 메뉴 토글
                parent.classList.toggle('active');
            });
        });
    });
</script>

</body>
</html>