package com.kh.jipshop.orders.controller;

import java.util.ArrayList;
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
	            @RequestParam(name = "qty", defaultValue = "1") int qty,
	            @RequestParam(name = "productId", required = false) Integer productId,
	            @RequestParam(name = "cartIds", required = false) String cartIds,
	            @RequestParam Map<String, Object> paramMap
	    ) {
	        MemberExt loginMember = (MemberExt) auth.getPrincipal();
	        int memberNo = loginMember.getMemberNo();

	        List<CartDTO> list = new ArrayList<>();

	        // 장바구니에서 온 경우
	        if (cartIds != null && !cartIds.isEmpty()) {
	            list = cartService.selectCartItemsByIds(cartIds, memberNo);
	        }
	        // 바로구매에서 온 경우
	        else {
	            paramMap.put("productId", productId);
	            paramMap.put("memberNo", memberNo);
	            paramMap.put("qty", qty);

	            List<Product> productList = oService.productList(paramMap);
	            for (Product p : productList) {
	                CartDTO dto = new CartDTO();
	                dto.setProductId(p.getProductId());
	                dto.setProductName(p.getProductName());
	                dto.setProductPrice(p.getPrice());      
	                dto.setProductPhoto1(p.getPhoto1());  
	                dto.setCartQty(qty);
	                list.add(dto);
	            }
	        }

	        int totalPrice = 0;
	        for (CartDTO c : list) {
	            totalPrice += c.getProductPrice() * c.getCartQty();
	        }

	        int totalDelivery = (totalPrice == 0 || totalPrice >= 30000) ? 0 : 3000;
	        int finalPrice = totalPrice + totalDelivery;

	        model.addAttribute("productList", list);
	        model.addAttribute("memberName", loginMember.getMemberName());
	        model.addAttribute("phone", loginMember.getPhone());
	        model.addAttribute("email", loginMember.getEmail());
	        model.addAttribute("memberNo", memberNo);
	        model.addAttribute("totalPrice", totalPrice);
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
