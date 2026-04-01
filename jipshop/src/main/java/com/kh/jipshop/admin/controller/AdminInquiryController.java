package com.kh.jipshop.admin.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.jipshop.admin.model.service.AdminInquiryService;
import com.kh.jipshop.admin.model.vo.AdminInquiry;
import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.common.template.Pagination;
import com.kh.jipshop.inquiry.model.vo.Inquiry;

@Controller
@RequestMapping("/admin")
public class AdminInquiryController {
	
	@Autowired
    private AdminInquiryService adminInquiryService;
 
    // 1. 문의 목록
    @GetMapping("/inquiryList")
    public String inquiryList(
            @RequestParam(value = "page", defaultValue = "1") int currentPage,
            @RequestParam Map<String, Object> paramMap,
            Model model) {
 
        paramMap.remove("page");
        paramMap.entrySet().removeIf(e ->
            e.getValue() == null || e.getValue().toString().trim().isEmpty()
        );
 
        int boardLimit = 10;
        int pageLimit  = 10;
        int totalCount = adminInquiryService.getInquiryCount(paramMap);
 
        PageInfo pi = Pagination.getPageInfo(totalCount, currentPage, pageLimit, boardLimit);
        paramMap.put("pi",       pi);
        paramMap.put("startRow", (currentPage - 1) * boardLimit);
        paramMap.put("endRow",   currentPage * boardLimit);
 
        List<AdminInquiry> inquiryList = adminInquiryService.getInquiryList(paramMap);
 
        model.addAttribute("inquiryList", inquiryList);
        model.addAttribute("totalCount",  totalCount);
        model.addAttribute("pi",          pi);
        model.addAttribute("param",       paramMap);
 
        return "admin/inquiry/inquiryList";
    }
}
