package com.kh.jipshop.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/product")
public class AdminProductController {
    /**
     * 상품 등록 페이지 이동
     * URL : /admin/product/regist
     */
    @GetMapping("/regist")
    public String productRegistForm() {
        return "admin/productRegist";
    }
}