package com.kh.jipshop.orders.controller;

import java.util.List;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
			   @RequestParam Map<String,Object> paramMap
			   ) {
		  
		  String memberName = ((MemberExt)auth.getPrincipal()).getMemberName();
		  String phone = ((MemberExt)auth.getPrincipal()).getPhone();
		  int memberNo = ((MemberExt)auth.getPrincipal()).getMemberNo();
		  
		  paramMap.put("memberNo",memberNo);
		  
		  List<Product> list = oService.productList(paramMap);
		  
		  for(Product p : list ) {
			  
			  System.out.println(p.getPrice());
			  
		  }
		  
		  model.addAttribute("productList", list);
		  model.addAttribute("phone",phone);
		  model.addAttribute("memberName",memberName);
		  model.addAttribute("memberNo",memberNo);
		  
		  
		  
		  return "orders/orderNew";
	  }
	  
	  
		/*
		 * @PostMapping("/orderNew") public String insertOrder(OrderRequest
		 * orderRequest, Model model) {
		 * 
		 * int result = orderService.insertOrder(orderRequest);
		 * 
		 * if(result > 0) { model.addAttribute("orderId", orderRequest.getOrderId());
		 * return "order/orderComplete"; } else { model.addAttribute("msg",
		 * "주문 처리에 실패했습니다."); return "common/errorPage"; } }
		 */
	
	
	
	
	
	
	
	
	
	
	
	
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
