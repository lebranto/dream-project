package com.kh.jipshop.orders.controller;

import java.util.List;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.jipshop.cart.model.service.CartService;
import com.kh.jipshop.cart.model.vo.CartDTO;
import com.kh.jipshop.mypage.model.vo.Orders;
import com.kh.jipshop.mypage.model.vo.Product;
import com.kh.jipshop.orders.service.OrdersService;
import com.kh.jipshop.security.model.vo.MemberExt;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

	@Controller
	@Slf4j
	@RequestMapping("/orders")
	@RequiredArgsConstructor
	public class OrdersController {
	    
	    private final OrdersService oService;
	    private final CartService cartService;
	    
	    @GetMapping("/orderNew")
	    public String orderNew(
	            Authentication auth,
	            Model model,
	            @RequestParam(required = false) Integer productId,
	            @RequestParam Map<String, Object> paramMap
	    ) {
	        String memberName = ((MemberExt) auth.getPrincipal()).getMemberName();
	        String phone = ((MemberExt) auth.getPrincipal()).getPhone();
	        int memberNo = ((MemberExt) auth.getPrincipal()).getMemberNo();
	        String email = ((MemberExt) auth.getPrincipal()).getEmail();
	        
	        paramMap.put("productId",productId);
	        paramMap.put("memberNo", memberNo);
	        
	        List<Product> list = oService.productList(paramMap);
	        
	        int totalPrice = 0;
	        int totalCount = 0;
	        
	        for (Product p : list) {
	            totalPrice += p.getPrice(); // 처음 진입 시 수량 1 기준
	            totalCount++;
	        }
	        
	        int totalDelivery = (totalPrice == 0 || totalPrice >= 30000) ? 0 : 3000;
	        int finalPrice = totalPrice + totalDelivery;
	        
	        model.addAttribute("productList", list);
	        model.addAttribute("phone", phone);
	        model.addAttribute("memberName", memberName);
	        model.addAttribute("memberNo", memberNo);
	        model.addAttribute("email",email);
	        
	        
	        model.addAttribute("totalPrice", totalPrice);
	        model.addAttribute("totalCount", totalCount);
	        model.addAttribute("totalDelivery", totalDelivery);
	        model.addAttribute("finalPrice", finalPrice);
	        
	        return "orders/orderNew";
	    }

	    
	    @PostMapping("/orderNew")
	    public String insertOrder(
	            Orders order,
	            Authentication auth,
	            RedirectAttributes ra
	    ) {
	        int memberNo = ((MemberExt)auth.getPrincipal()).getMemberNo();
	        order.setMemberNo(memberNo);

	        int result = oService.insertOrder(order);

	        if(result > 0) {
	            ra.addFlashAttribute("alertMsg", "주문이 완료되었습니다.");
	            return "redirect:/mypage/purchase";
	        } else {
	            ra.addFlashAttribute("alertMsg", "주문 처리에 실패했습니다.");
	            return "redirect:/orders/orderNew";
	        }
	    }
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping("/cart")
	public String cart() {
		return "orders/cart";
	}
	
	@RequestMapping("/cartList")
	public String cartList() {
		return "orders/cartList";
	}
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
	
	@RequestMapping("/favorites")
	public String favorites() {
		return "orders/favorites";
	}
	
	@RequestMapping("/wishList")
	public String wishList() {
		return "orders/wishList";
	}
	
	@RequestMapping("/order")
	public String order() {
		return "orders/order";
	}
	
	@RequestMapping("/orderPage")
	public String orderPage() {
		return "orders/orderPage";
	}
	
	@RequestMapping("/FAQ")
	public String FAQ() {
		return "orders/FAQ";
	}
	
	@GetMapping("/orders/orderNew")
	public String orderNew(@RequestParam("cartIds") String cartIds, Model model) {
	    // 1. cartIds 문자열을 쪼개서 DB에서 해당 장바구니/상품 정보를 조회
	    // 2. 조회된 정보를 model에 담아 orderNew.jsp로 전달
	    return "orders/orderNew"; 
	}
}
