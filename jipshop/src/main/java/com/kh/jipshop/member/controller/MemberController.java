package com.kh.jipshop.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MemberController {

	@RequestMapping("/")
	public String home() {
		return "home";
	}

	@RequestMapping("/terms")
	public String terms() {
		return "terms";
	}

	@RequestMapping("/privacy")
	public String privacy() {
		return "privacy";
	}
	
	@RequestMapping("/completed")
	public String completed() {
		return "common/completed";
	}
	
	@RequestMapping("/order")
	public String order() {
		return "common/order";
	}
	
	@RequestMapping("/cart")
	public String cart() {
		return "common/cart";
	}
	
	@RequestMapping("/cart2")
	public String cart2() {
		return "common/cart2";
	}

	@RequestMapping("/adminSidebar")
	public String adminSidebar() {
		return "common/adminSidebar";
	}
	
	@RequestMapping("/adminHeader")
	public String adminHeader() {
		return "common/adminHeader";
	}
	
	@RequestMapping("/inquiryList")
	public String inquiryList() {
		return "common/inquiryList";
	}
	
	@RequestMapping("/inquiryList_view")
	public String inquiryList_view() {
		return "common/inquiryList_view";
	}
	
	@RequestMapping("/reportList")
	public String reportList() {
		return "common/reportList";
	}
	
	@RequestMapping("/reportList_view")
	public String reportList_view() {
		return "common/reportList_view";
	}
	
	@RequestMapping("/product_reg")
	public String product_reg() {
		return "common/product_reg";
	}
	
	@RequestMapping("/favorites")
	public String favorites() {
		return "common/favorites";
	}
	
	@RequestMapping("/myPageSidebar")
	public String myPageSidebar() {
		return "common/myPageSidebar";
	}
	
	@RequestMapping("/FAQ")
	public String FAQ() {
		return "common/FAQ";
	}
	
}
