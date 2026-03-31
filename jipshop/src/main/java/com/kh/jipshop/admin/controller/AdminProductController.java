package com.kh.jipshop.admin.controller;

import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.jipshop.admin.model.service.AdminProductService;
import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.common.template.Pagination;

@Controller
@RequestMapping("/admin")
public class AdminProductController {
    /**
     * 상품 등록 페이지 이동
     * URL : /admin/productRegist
     */
	@Autowired
	private AdminProductService adminProductService;
	
	@Autowired
	private ServletContext application;
	
	// 상품 목록
	@GetMapping("/productList")
    public String productList(
            @RequestParam(value = "page", defaultValue = "1") int currentPage,
            @RequestParam Map<String, Object> paramMap,
            Model model) {
 
        paramMap.remove("page");
        paramMap.entrySet().removeIf(e ->
            e.getValue() == null || e.getValue().toString().trim().isEmpty()
        );
 
        int boardLimit = 10;
        int pageLimit  = 10;
        int totalCount = adminProductService.getProductCount(paramMap);
 
        PageInfo pi = Pagination.getPageInfo(totalCount, currentPage, pageLimit, boardLimit);
        paramMap.put("pi", pi);
 
        model.addAttribute("productList", adminProductService.getProductList(paramMap));
        model.addAttribute("totalCount",  totalCount);
        model.addAttribute("pi",          pi);
        model.addAttribute("param",       paramMap);
 
        // 검색 드롭다운용
        model.addAttribute("categoryList", adminProductService.getCategoryList());
 
        return "admin/product/productList";
    }
	

    // 상품 등록 화면 /admin/productRegist

    @GetMapping("/productRegist")
    public String productRegistForm(Model model) {
        model.addAttribute("categoryList", adminProductService.getCategoryList());
        model.addAttribute("companyList",  adminProductService.getCompanyList());
        return "admin/product/productRegist";
    }
}