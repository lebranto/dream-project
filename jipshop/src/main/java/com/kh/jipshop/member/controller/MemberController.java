package com.kh.jipshop.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.jipshop.member.model.service.MemberService;
import com.kh.jipshop.member.model.vo.Member;

@Controller
@RequestMapping("/member")
@SessionAttributes({"loginUser"})
public class MemberController {
	
	@Autowired
	private MemberService mService;
	
  @RequestMapping("/")
  public String home() {
      return "home";
  }
  
  @RequestMapping("/terms")
	public String terms() {
		return "terms";
	}
 
  @GetMapping("/login")
  public String loginMember() {
		return "member/login";
	}
	
  	@ResponseBody
	@GetMapping("/idCheck")
	public int idCheck(String memberId) {
		int result = mService.idCheck(memberId);
		
		return result;
	}
		
	@ResponseBody
	@PostMapping("/findId")
	public Map<String, Object> findId(Member m) throws Exception {
	    Map<String, Object> result = new HashMap<>();
	    if (m.getPhone() != null) {
	        m.setPhone(m.getPhone().replaceAll("-", ""));
	    }
	    List<String> memberIds = mService.findMemberId(m);
	    if (memberIds != null && !memberIds.isEmpty()) {
	        result.put("success", true);
	        result.put("memberIds", memberIds); // 리스트로 반환
	    } else {
	        result.put("success", false);
	        result.put("message", "입력하신 정보와 일치하는 아이디가 없습니다.");
	    }
	    return result;
	}
  
	@GetMapping("/enrollComplete")
	public String enrollComplete() {
	    return "member/enrollComplete";
	}
}
