package com.kh.jipshop.admin.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.jipshop.admin.model.service.AdminMemberService;
import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.common.template.Pagination;
import com.kh.jipshop.member.model.vo.Member;
import com.kh.jipshop.member.model.vo.Pet;


//import com.kh.jipshop.admin.model.service.AdminMemberService;


@Controller
@RequestMapping("/admin")
public class AdminMemberController {
	
	
	@Autowired private AdminMemberService adminMemberService;
    @Autowired private PasswordEncoder    passwordEncoder;

    // 1. 회원 목록
    @GetMapping("/memberList")
    public String memberList(
    		@RequestParam(value = "page", defaultValue = "1") int currentPage,
            @RequestParam Map<String, Object> paramMap,
            Model model) {
    	
    	// paramMap에서 currentPage 제거 (pi.currentPage로 관리)
        paramMap.remove("currentPage");
        
        paramMap.entrySet().removeIf(e ->
	        e.getValue() == null || e.getValue().toString().trim().isEmpty()
	    );
        // 통계
        model.addAttribute("activeCount", adminMemberService.getActiveCount());
        model.addAttribute("bannedCount", adminMemberService.getBannedCount());
 
        // 페이징 정보 생성
        int boardLimit = 5;  // 페이지당 행 수
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
 
     // 반려동물 목록
        List<Pet> petList = adminMemberService.getPetListByMemberNo(memberNo);
        model.addAttribute("petList",  petList);
 
 
        return "admin/member/memberDetail";
    }
    
    // 3. 회원 정보 수정
    @PostMapping("/memberUpdate")
    public String memberUpdate(Member member, RedirectAttributes ra) {
 
        int result = adminMemberService.updateMember(member);
 
        if (result > 0) {
            ra.addFlashAttribute("successMsg", "회원 정보가 수정되었습니다.");
        } else {
            ra.addFlashAttribute("errorMsg", "수정에 실패했습니다. 다시 시도해주세요.");
        }
        return "redirect:/admin/memberDetail?memberNo=" + member.getMemberNo();
    }
    // 4.  탈퇴 처리 화면

    @GetMapping("/memberStop")
    public String memberStopPage(@RequestParam int memberNo, Model model) {
 
        Member member = adminMemberService.getMemberByNo(memberNo);
        if (member == null) return "redirect:/admin/memberList";
 
        model.addAttribute("member", member);
        return "admin/member/memberStop";
    }
    
    // 5. 탈퇴 처리
    @PostMapping("/memberWithdraw")
    public String memberWithdraw(@RequestParam int    memberNo,
                                  RedirectAttributes ra) {
 
        Member member = adminMemberService.getMemberByNo(memberNo);
 
        // 이미 탈퇴된 회원 체크
        if (member == null || "N".equals(member.getActiveYn())) {
            ra.addFlashAttribute("errorMsg", "이미 탈퇴된 회원입니다.");
            return "redirect:/admin/memberStop?memberNo=" + memberNo;
        }
 
        adminMemberService.updateMemberActiveYn(memberNo);
 
        ra.addFlashAttribute("successMsg", "탈퇴 처리가 완료되었습니다.");
        return "redirect:/admin/memberList";
    }


}
