package com.kh.jipshop.orders.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/orders")
public class ordersController {
	
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
