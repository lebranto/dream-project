package com.kh.jipshop.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.jipshop.admin.model.service.AdminDashboardService;

@Controller
@RequestMapping("/admin")
public class AdminDashboardController {

    @Autowired
    private AdminDashboardService adminDashboardService;

    @GetMapping("/dashboard")
    public String dashboard(Model model) {

        // 미처리 카운트
//        model.addAttribute("unprocessedInquiryCount", adminDashboardService.getUnprocessedInquiryCount());
//        model.addAttribute("unprocessedReportCount",  adminDashboardService.getUnprocessedReportCount());
        model.addAttribute("todayOrderCount", adminDashboardService.getTodayOrderCount());

        // 최근 목록
        //model.addAttribute("recentInquiryList", adminDashboardService.getRecentInquiryList());
        //model.addAttribute("recentReportList",  adminDashboardService.getRecentReportList());
        model.addAttribute("recentOrderList",   adminDashboardService.getRecentOrderList());

        return "admin/dashboard";
    }
}