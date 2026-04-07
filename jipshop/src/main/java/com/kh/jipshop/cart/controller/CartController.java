package com.kh.jipshop.cart.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.jipshop.cart.model.service.CartService;
import com.kh.jipshop.cart.model.vo.CartDTO;
import com.kh.jipshop.member.model.vo.Member;
import com.kh.jipshop.security.model.vo.MemberExt;

@Controller
@RequestMapping("/cartList")
public class CartController {

    @Autowired
    private CartService cartService;

    @PostMapping("/add")
    public String addCart(@RequestParam int productId, 
    		@RequestParam int qty, 
    		HttpSession session,
    		Authentication auth
    		) {
    	int memberNo = ((MemberExt)auth.getPrincipal()).getMemberNo();
        if (memberNo == -1) return "redirect:/member/login";

        CartDTO check = new CartDTO();
        check.setMemberNo(memberNo);
        check.setProductId(productId);
        CartDTO existing = cartService.findByUserAndProduct(check);

        if (existing != null) {
            existing.setCartQty(existing.getCartQty() + qty);
            cartService.updateQty(existing);
        } else {
            CartDTO dto = new CartDTO();
            dto.setMemberNo(memberNo);
            dto.setProductId(productId);
            dto.setCartQty(qty);
            cartService.insertCart(dto);
        }
        return "redirect:/cartList";
    }
    
   
    @PostMapping("/addAjax")
    @ResponseBody
    public int addCartAjax(@RequestParam int productId, @RequestParam int qty, HttpSession session,Authentication auth) {
    	// ⭐ 로그인 체크 (핵심)
        if (auth == null || !auth.isAuthenticated() || auth.getPrincipal().equals("anonymousUser")) {
            return -1;
        }
    	
    	int memberNo = ((MemberExt)auth.getPrincipal()).getMemberNo();

        if (memberNo == -1) return -1;

        CartDTO check = new CartDTO();
        check.setMemberNo(memberNo);
        check.setProductId(productId);
        CartDTO existing = cartService.findByUserAndProduct(check);

        if (existing != null) {
            existing.setCartQty(existing.getCartQty() + qty);
            cartService.updateQty(existing);
        } else {
            CartDTO dto = new CartDTO();
            dto.setMemberNo(memberNo);
            dto.setProductId(productId);
            dto.setCartQty(qty);
            cartService.insertCart(dto);
        }      
        int cartCount = cartService.selectCount(memberNo);
        session.setAttribute("cartCount", cartCount);
        return cartCount;
    }

    @GetMapping("")
    public String cartList(Model model, Authentication auth) {
        // 1. 인증 정보 자체가 없는 경우 체크
        if (auth == null || !auth.isAuthenticated() || auth.getPrincipal().equals("anonymousUser")) {
            return "redirect:/member/login";
        }

        // 2. 안전하게 캐스팅하여 memberNo 추출
        int memberNo = ((MemberExt)auth.getPrincipal()).getMemberNo();
        
        // 3. 데이터 조회 및 전달
        List<CartDTO> list = cartService.selectCartList(memberNo);
        
        // 디버깅: 리스트가 정말 비어있는지 콘솔에서 확인 필수!
        System.out.println("조회된 memberNo: " + memberNo);
        System.out.println("조회된 리스트 개수: " + (list != null ? list.size() : 0));

        model.addAttribute("cartList", list);
        return "orders/cartList";
    }

    @PostMapping("/updateQty")
    @ResponseBody
    public int updateQty(@RequestParam int cartId, @RequestParam int qty, HttpSession session, Authentication auth) {
    	int memberNo = ((MemberExt)auth.getPrincipal()).getMemberNo();
        if (memberNo == -1) return -1;
        CartDTO dto = new CartDTO();
        dto.setCartId(cartId);
        dto.setCartQty(qty);
        return cartService.updateQty(dto);
    }

    @PostMapping("/deleteAjax")
    @ResponseBody
    public int deleteCart(@RequestParam int cartId, HttpSession session,Authentication auth) {
    	int memberNo = ((MemberExt)auth.getPrincipal()).getMemberNo();
        if (memberNo == -1) return -1;
        cartService.deleteCart(cartId);
        return cartService.selectCount(memberNo);
    }

    @PostMapping("/deleteAllAjax")
    @ResponseBody
    public int deleteAllAjax(
    		@RequestParam String ids, 
    		HttpSession session,
    		Authentication auth
    		) {
        int memberNo = ((MemberExt)auth.getPrincipal()).getMemberNo();
        if (memberNo == -1) return -1;
        if (ids != null && !ids.isEmpty()) {
            int[] idArr = Arrays.stream(ids.split(",")).map(String::trim).mapToInt(Integer::parseInt).toArray();
            cartService.deleteAll(idArr);
        }
        int cartCount = cartService.selectCount(memberNo);
        session.setAttribute("cartCount", cartCount);
        
        return cartCount;
    }

    private int getLoginUserNo(HttpSession session) {
    	// 1. 세션에서 "loginUser"라는 이름으로 객체를 꺼냄
        Member loginUser = (Member) session.getAttribute("loginUser"); 
        
        // 2. 만약 꺼내온 객체가 null이면 -1 리턴 -> 여기서 걸리면 println이 안 찍힘!
        if (loginUser == null) return -1; 
        
        return loginUser.getMemberNo();
    }
}