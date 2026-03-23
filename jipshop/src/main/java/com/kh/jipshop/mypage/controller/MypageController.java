package com.kh.jipshop.mypage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/mypage")
public class MypageController {

	@GetMapping("/purchase")
	public String orderList() {
		
			return "mypage/order";
	}
	
	@GetMapping("/recent")
	public String recent() {
		
			return "mypage/recent";
	}
	
	@GetMapping("/inquiry")
	public String inquiry() {
	
			return "mypage/inquiry";
	}
	
	@GetMapping("/updateMemberCheck")
	public String updateMemberCheck() {
		
			return "mypage/updateMemberCheck";
	}
	
	
	@GetMapping("/memberDelete")
	public String memberDelete() {
		
		return "mypage/memberDelete";
	}
	
	
	
	
}
