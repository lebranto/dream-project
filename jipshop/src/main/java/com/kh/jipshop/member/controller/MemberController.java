package com.kh.jipshop.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MemberController {

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
    
}
