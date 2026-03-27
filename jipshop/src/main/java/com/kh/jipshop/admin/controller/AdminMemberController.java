package com.kh.jipshop.admin.controller;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


//import com.kh.jipshop.admin.model.service.AdminMemberService;


@Controller
@RequestMapping("/admin")
public class AdminMemberController {
	
	
    // 1. 회원 목록
    @GetMapping("/memberList")
    public String memberList(
            @RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
            @RequestParam Map<String, Object> paramMap,
            Model model) {
 
        return "admin/member/memberList";
    }
 

}
