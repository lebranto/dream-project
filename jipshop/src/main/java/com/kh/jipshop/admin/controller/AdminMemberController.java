package com.kh.jipshop.admin.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.jipshop.admin.model.service.AdminMemberService;
import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.common.template.Pagination;
import com.kh.jipshop.member.model.vo.Member;


//import com.kh.jipshop.admin.model.service.AdminMemberService;


@Controller
@RequestMapping("/admin")
public class AdminMemberController {
	
	
	@Autowired private AdminMemberService adminMemberService;
    @Autowired private PasswordEncoder    passwordEncoder;

    // 1. 회원 목록
    @GetMapping("/memberList")
    public String memberList(
            @RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
            @RequestParam Map<String, Object> paramMap,
            Model model) {
 
        // 통계
        model.addAttribute("activeCount", adminMemberService.getActiveCount());
        model.addAttribute("bannedCount", adminMemberService.getBannedCount());
 
        // 페이징 정보 생성
        int boardLimit = 10;  // 페이지당 행 수
        int pageLimit  = 10;  // 페이지네이션 블록 크기
        int totalCount = adminMemberService.getMemberCount(paramMap);
 
        PageInfo pi = Pagination.getPageInfo(totalCount, currentPage, pageLimit, boardLimit);
        paramMap.put("pi", pi);
 
        model.addAttribute("memberList",  adminMemberService.getMemberList(paramMap));
        model.addAttribute("totalCount",  totalCount);
        model.addAttribute("pi",          pi);
        model.addAttribute("param",       paramMap);
 
        return "admin/member/memberList";
    }
    
    // 2. 회원 상세
    @GetMapping("/memberDetail")
    public String memberDetail(@RequestParam int memberNo, Model model) {
 
        Member member = adminMemberService.getMemberByNo(memberNo);
        if (member == null) return "redirect:/admin/memberList";
 
        model.addAttribute("member", member);
 
        // 반려동물 목록 — PetService 주입 후 연동
        // model.addAttribute("petList",      petService.getPetListByMemberNo(memberNo));
 
 
        return "admin/member/memberDetail";
    }


}
