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
	    
	    @GetMapping("/orderNew")
	    public String orderNew(
	            Authentication auth,
	            Model model,
	            @RequestParam(defaultValue = "1") int qty,
	            @RequestParam(required = false) Integer productId,
	            @RequestParam Map<String, Object> paramMap
	    ) {
	        String memberName = ((MemberExt) auth.getPrincipal()).getMemberName();
	        String phone = ((MemberExt) auth.getPrincipal()).getPhone();
	        int memberNo = ((MemberExt) auth.getPrincipal()).getMemberNo();
	        String email = ((MemberExt) auth.getPrincipal()).getEmail();
	        
	        paramMap.put("productId",productId);
	        paramMap.put("memberNo", memberNo);
	        paramMap.put("qty", qty);
	        
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
	    	 MemberExt loginMember = (MemberExt) auth.getPrincipal();

	    	
	    	order.setMemberNo(loginMember.getMemberNo());
	    	order.setOrdererName(loginMember.getMemberName());
	    	order.setOrdererPhone(loginMember.getPhone());
	    	order.setOrdererEmail(loginMember.getEmail());


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
	
	@RequestMapping("/favorites")
	public String favorites() {
		return "orders/favorites";
	}
	
	@RequestMapping("/order")
	public String order() {
		return "orders/order";
	}
	
	@RequestMapping("/FAQ")
	public String FAQ() {
		return "orders/FAQ";
	}
}
