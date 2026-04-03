package com.kh.jipshop.security.model.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.kh.jipshop.cart.model.service.CartService;
import com.kh.jipshop.security.model.vo.MemberExt;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

    // 장바구니 서비스를 주입받는다고 가정합니다.
    private final CartService cartService;

    public LoginSuccessHandler(CartService cartService) {
        this.cartService = cartService;
    }
    
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, 
                                        HttpServletResponse response, 
                                        Authentication authentication) throws IOException, ServletException {
    	
        // 1. 사용자 정보 가져오기 (Principal)
        int userId = ((MemberExt)authentication.getPrincipal()).getMemberNo();

        // 2. 장바구니 상품 갯수 조회
        int cartCount = cartService.selectCount(userId);

        // 3. 세션에 저장
        HttpSession session = request.getSession();
        session.setAttribute("cartCount", cartCount);
        log.debug("cartCount {}", cartCount);
        
        // 3. 로그인 성공 후 이동할 페이지 (기본값 "/")
        response.sendRedirect(request.getContextPath() + "/");
    }
}