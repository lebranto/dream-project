package com.kh.jipshop.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class adminController {
	
	@RequestMapping("/product_reg")
	public String product_reg() {
		return "admin/product_reg";
	}
	
	@RequestMapping("/adminCommentReport")
	public String adminCommentReport() {
		return "admin/adminCommentReport";
	}
	
	@RequestMapping("/adminOrderCancel")
	public String adminOrderCancel() {
		return "admin/adminOrderCancel";
	}
	
	@RequestMapping("/adminOrderList")
	public String adminOrderList() {
		return "admin/adminOrderList";
	}
	
	@RequestMapping("/inquiryList_view")
	public String inquiryList_view() {
		return "admin/inquiryList_view";
	}
	
	@RequestMapping("/inquiryList")
	public String inquiryList() {
		return "admin/inquiryList";
	}
	
	@RequestMapping("/reportList_view")
	public String reportList_view() {
		return "admin/reportList_view";
	}
	
	@RequestMapping("/reportList")
	public String reportList() {
		return "admin/reportList";
	}
	
	/* 아래 부터 새로 추가한 관리자 파일 */
	
	@RequestMapping("/dashboard")
	public String dashboard() {
		return "admin/dashboard";
	}
	
	@RequestMapping("/productRegist")
	public String productRegist() {
		return "admin/productRegist";
	}
	
	@RequestMapping("/product_regist")
	public String product_regist() {
		return "admin/product_regist";
	}
	
	@RequestMapping("/memberList")
	public String memberList() {
		return "admin/memberList";
	}
	
	@RequestMapping("/productList")
	public String productList() {
		return "admin/productList";
	}
	
	@RequestMapping("/salesDaily")
	public String salesDaily() {
		return "admin/salesDaily";
	}
	
	@RequestMapping("/salesMonthly")
	public String salesMonthly() {
		return "admin/salesMonthly";
	}

}
