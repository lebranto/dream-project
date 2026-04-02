package com.kh.jipshop.inquiry.controller;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.common.template.Pagination;
import com.kh.jipshop.inquiry.model.service.InquiryService;
import com.kh.jipshop.inquiry.model.vo.Inquiry;
import com.kh.jipshop.member.model.vo.Member;

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
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
        ArrayList<Inquiry> inquiryList = inquiryService.selectInquiryList(pi);

        model.addAttribute("inquiryList", inquiryList);
        model.addAttribute("pi", pi);

        return "product/inquiryList";
    }

    @GetMapping("/inquiryWrite")
    public String inquiryWriteForm() {
        return "product/inquiryWrite";
    }
  

    @PostMapping("/inquiryWrite")
    public String insertInquiry(
            Inquiry inquiry,
            @RequestParam(value = "uploadFile", required = false) MultipartFile uploadFile,
            HttpSession session) {
    	
    	// 🔥 여기다가 넣어
        inquiry.setMemberNo(2);

        Member loginUser = (Member) session.getAttribute("loginUser");

        if (loginUser != null) {
            inquiry.setMemberNo(loginUser.getMemberNo());
        }

        if (uploadFile != null && !uploadFile.isEmpty()) {
            String originName = uploadFile.getOriginalFilename();
            String changeName = System.currentTimeMillis() + "_" + originName;

            String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
            File dir = new File(savePath);

            if (!dir.exists()) {
                dir.mkdirs();
            }

            try {
                uploadFile.transferTo(new File(savePath + changeName));
                inquiry.setInquiryPhoto(changeName);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        inquiry.setReplyYn("N");
        inquiryService.insertInquiry(inquiry);

        return "redirect:/product/inquiryList";
    }
}