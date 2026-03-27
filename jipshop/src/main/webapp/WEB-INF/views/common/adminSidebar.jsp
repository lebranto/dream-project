<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 페이지 - 사이드바 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css">
    
    <style>
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
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: background 0.3s;
        }

        .menu-title:hover { background: #adadad; }

        /* ★수정: span 제거하고 ::after로 화살표 생성 */
        .menu-title.toggle::after {
            content: "";
            width: 8px;
            height: 8px;
            border-top: 2px solid #666;
            border-right: 2px solid #666;
            transform: rotate(135deg);
            transition: transform 0.3s ease;
        }

        /* ★수정: 활성화 시 화살표 회전 */
        .menu-item.active .menu-title.toggle::after {
            transform: rotate(-45deg); 
            border-color: #fff;
        }

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

        .menu-item.active .sub-menu { 
            display: block; 
        }

        .menu-item.active .menu-title {
            background: #a0a0a0;
            color: #fff;
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
    <div class="sidebar-header" style="padding: 20px 15px; font-size: 16px; font-weight: bold; text-align: center; background: #c0c0c0;">
        관리자 메뉴
    </div>

    <ul class="menu-list">
        <li class="menu-item">
            <div class="menu-title" onclick="location.href='member_list.jsp'">회원 관리</div>
        </li>

        <li class="menu-item">
            <!-- ★수정: span.icon-arrow 완전 삭제 -->
            <div class="menu-title toggle">
                상품 관리
            </div>
            <ul class="sub-menu">
                <li onclick="location.href='product_reg.jsp'">상품 등록</li>
                <li onclick="location.href='product_list.jsp'">상품내역</li>
            </ul>
        </li>

        <li class="menu-item">
            <!-- ★수정 -->
            <div class="menu-title toggle">
                매출 관리
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
            <!-- ★수정 -->
            <div class="menu-title toggle">
                고객센터 관리
            </div>
            <ul class="sub-menu">
                <li class="active-item" onclick="location.href='inquiry_list.jsp'">문의 조회</li>
                <li onclick="location.href='report_list.jsp'">신고 사항</li>
            </ul>
        </li>
    </ul>
</aside>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const toggles = document.querySelectorAll('.menu-title.toggle');
        
        toggles.forEach(title => {
            title.addEventListener('click', function(e) {
                e.preventDefault();
                const parent = this.parentElement;
                parent.classList.toggle('active');
            });
        });
    });
</script>

</body>
</html>