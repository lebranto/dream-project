package com.kh.jipshop.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.jipshop.member.model.service.MemberService;
import com.kh.jipshop.member.model.vo.Member;


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

	    @RequestMapping("/privacy")
	    public String privacy() {
	        return "privacy";
	    }
	    
	    @GetMapping("/login")
	    public String loginMember() {
			return "member/login";
		}
	    
//	    @GetMapping("/insert")
//		public String enrollForm() {
//			return "member/memberEnrollForm";
//		}
	    
//	    @PostMapping("/login")
//		public ModelAndView login(
//				@ModelAttribute Member m,
//				ModelAndView mv,
//				Model model,
//				HttpSession session, 
//				RedirectAttributes ra) {
//			// 로그인 요청 처리
//			Member loginUser = mService.loginMember(m);
//			if(loginUser != null) {
//				// 인증된 사용자 정보를 session에 보관
//				//session.setAttribute("loginUser", loginUser);
//				model.addAttribute("loginUser", loginUser);
//				
//			}else {
//				//session.setAttribute("alertMsg", "로그인 실패");
//				ra.addFlashAttribute("alertMsg", "로그인 실패");
//				/*
//				 * RedirectAttributes의 flashAttribute는 데이터를 우선
//				 * SessionScope에 담았다가, 리다이렉트가 완료되면 SessionScope
//				 * 의 데이터를 request Scope로 변경된다.
//				 * 
//				 */
//			}
//			mv.setViewName("redirect:/");// 메인페이지로 리다이렉트.
//			
//			return mv;
//		}
	    
	    // 로그아웃
//	    @PostMapping("/logout")
//		public String logout(HttpSession session, SessionStatus status) {
//			// - 현재 세션의 "인증"정보를 만료시키는 행위
//			session.invalidate();
//			status.setComplete(); // model로 sessionScope에 이관된 데이터를 삭제하는 메서드
//			
//			return "redirect:/";
//		}
	    
//	    @PostMapping("/insert")
//		public String insertMember(
//				Member m,
//				Model model, 
//				RedirectAttributes ra
//				) {
//	    
//			int result = mService.insertMember(m);
//			
//			if(result > 0) {
//				ra.addFlashAttribute("alertMsg", "회원가입 성공");
//				return "redirect:/member/login";
//			}else {
//				throw new RuntimeException();
////				model.addAttribute("errorMsg", "화원가입에 실패했습니다..");
////				return "common/errorPage";
//				
//			}
//		}
		
		// 비동기 요청 처리
		@ResponseBody // 반환값을 jsp가 아닌, 반환해야할 값으로 처리하게 하는 주석
		@GetMapping("/idCheck")
		public int idCheck(String memberId) {
			int result = mService.idCheck(memberId);
			
			return result;
		}
		
		
}



