package com.kh.jipshop.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import com.kh.jipshop.member.model.service.MemberService;


@Controller
@RequestMapping("/member")
@SessionAttributes({"loginUser"})
public class MemberController {
	@Autowired //의존성주입
	private MemberService mService;
	
  @RequestMapping("/")
  public String home() {
      return "home";
  }
  @RequestMapping("/terms")
	public String terms() {
		return "terms";
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
	
    @RequestMapping("/privacy")
    public String privacy() {
        return "privacy";
    }
    
    @GetMapping("/login")
    public String loginMember() {
		return "member/login";
	}
	
	// 비동기 요청 처리
	@ResponseBody // 반환값을 jsp가 아닌, 반환해야할 값으로 처리하게 하는 주석
	@GetMapping("/idCheck")
	public int idCheck(String memberId) {
		int result = mService.idCheck(memberId);
		
		return result;
	}
		
		
}



