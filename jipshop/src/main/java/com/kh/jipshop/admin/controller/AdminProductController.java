package com.kh.jipshop.admin.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.jipshop.admin.model.service.AdminProductService;
import com.kh.jipshop.admin.model.vo.AdminProduct;
import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.common.template.Pagination;
import com.kh.jipshop.common.util.Utils;

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
        
        List<Map<String, Object>> categoryList = adminProductService.getCategoryList();
        System.out.println("=== categoryList: " + categoryList);  // ← 추가
        model.addAttribute("categoryList", categoryList);
        
        return "admin/product/productList";
    }
	

    // 상품 등록 화면 /admin/productRegist

    @GetMapping("/productRegist")
    public String productRegistForm(Model model) {
        model.addAttribute("categoryList", adminProductService.getCategoryList());
        model.addAttribute("companyList",  adminProductService.getCompanyList());
        return "admin/product/productRegist";
    }
    
 
    // 3. 상품 등록 처리   
    @PostMapping("/productRegist")
    public String productRegist(
            AdminProduct product,
            @RequestParam(value = "photo1", required = false) MultipartFile photo1,
            @RequestParam(value = "photo2", required = false) MultipartFile photo2,
            RedirectAttributes ra) {
 
    	 // 신규 회사 처리
    	if ("new".equals(product.getCompanyMode())) {

    	    int companyCode = adminProductService.insertCompany(
    	        product.getNewCompanyName(),
    	        product.getCompanyPhone(),
    	        product.getCompanyAddress()
    	    );

    	    product.setCompanyCode(companyCode);
    	}

        // 사진1 업로드 (필수)
        if (photo1 != null && !photo1.isEmpty()) {
            String savedName = Utils.saveFile(photo1, application, "product");
            product.setProductPhoto1(savedName);
        } else {
            ra.addFlashAttribute("errorMsg", "대표 사진은 필수입니다.");
            return "redirect:/admin/productRegist";
        }
 
        // 사진2 업로드 (선택)
        if (photo2 != null && !photo2.isEmpty()) {
            String savedName = Utils.saveFile(photo2, application, "product");
            product.setProductPhoto2(savedName);
        }
 
        int result = adminProductService.insertProduct(product);
 
        if (result > 0) {
            ra.addFlashAttribute("successMsg", "상품이 등록되었습니다.");
            return "redirect:/admin/productList";
        } else {
            ra.addFlashAttribute("errorMsg", "상품 등록에 실패했습니다.");
            return "redirect:/admin/productRegist";
        }
    }
    
}