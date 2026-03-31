package com.kh.jipshop.inquiry.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.common.template.Pagination;
import com.kh.jipshop.inquiry.model.service.InquiryService;
import com.kh.jipshop.inquiry.model.vo.Inquiry;

@Controller
@RequestMapping("/product")
public class InquiryController {

    @Autowired
    private InquiryService inquiryService;

    @GetMapping("/inquiryList")
    public String inquiryList(
            @RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
            Model model) {

        int listCount = inquiryService.selectInquiryListCount();

        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);

        ArrayList<Inquiry> list = inquiryService.selectInquiryList(pi);

        model.addAttribute("list", list);
        model.addAttribute("pi", pi);

        return "product/inquiryList";
    }
}