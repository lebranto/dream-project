package com.kh.jipshop.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.jipshop.member.model.service.MemberService;
import com.kh.jipshop.member.model.vo.Member;


@Controller
@RequestMapping("/member")
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

	    @RequestMapping("/privacy")
	    public String privacy() {
	        return "privacy";
	    }
	    
	    @GetMapping("/insert")
		public String enrollForm() {
			return "member/memberEnrollForm";
		}
	    @PostMapping("/insert")
		public String insertMember(
				Member m,
				Model model, 
				RedirectAttributes ra
				) {
			int result = mService.insertMember(m);
			
			if(result > 0) {
				ra.addFlashAttribute("alertMsg", "회원가입 성공");
				return "redirect:/member/login";
			}else {
				throw new RuntimeException();
//				model.addAttribute("errorMsg", "화원가입에 실패했습니다..");
//				return "common/errorPage";
				
			}
		}
		
		// 비동기 요청 처리
		@ResponseBody // 반환값을 jsp가 아닌, 반환해야할 값으로 처리하게 하는 주석
		@GetMapping("/idCheck")
		public int idCheck(String memberId) {
			int result = mService.idCheck(memberId);
			
			return result;
		}
		

}



