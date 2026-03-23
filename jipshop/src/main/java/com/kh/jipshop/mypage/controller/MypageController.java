package com.kh.jipshop.mypage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/mypage")
public class MypageController {

	@GetMapping("/purchase")
	public String purchase() {
		System.out.println("구매 내역");
			return "mypage/purchase";
	}
	
	@GetMapping("/recent")
	public String recent() {
		System.out.println("최근 본 상품");
			return "mypage/recent";
	}
	
	@GetMapping("/inquiry")
	public String inquiry() {
		System.out.println("문의 내역");
			return "mypage/inquiry";
	}
	
	@GetMapping("/updateMemberCheck")
	public String updateMemberCheck() {
		System.out.println("확인 화면");
			return "mypage/updateMemberCheck";
	}
	
	
	@GetMapping("/memberDelete")
	public String memberDelete() {
		System.out.println("확인 화면");
		return "mypage/memberDelete";
	}
	
	
	
	
}
