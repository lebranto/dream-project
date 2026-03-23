package com.kh.jipshop.admin.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.kh.jipshop.admin.model.service.AdminCommentReportService;
import com.kh.jipshop.admin.model.vo.AdminCommentReport;

@Controller
@RequestMapping("/admin/report/comment")
public class AdminCommentReportController {

    @Autowired
    private AdminCommentReportService adminCommentReportService;

    // 🔥 1. 신고 목록
    @GetMapping("/list")
    public String selectReportList(Model model) {

        ArrayList<AdminCommentReport> list = adminCommentReportService.selectReportList();

        model.addAttribute("list", list);

        return "admin/AdminCommentReport";
    }

    // 🔥 2. 신고 상세
    @GetMapping("/detail")
    public String selectDetail(@RequestParam("reportId") int reportId, Model model) {

        AdminCommentReport report = adminCommentReportService.selectDetail(reportId);

        model.addAttribute("report", report);

        return "admin/AdminCommentReportDetail"; // 상세 JSP 따로 만들었을 경우
        // 만약 하나로 쓸거면 "admin/AdminCommentReport" 로 바꿔도 됨
    }

    // 🔥 3. 댓글 삭제 + 신고 처리
    @PostMapping("/delete")
    public String deleteComment(
            @RequestParam("commentId") int commentId,
            @RequestParam("reportId") int reportId) {

        adminCommentReportService.deleteComment(commentId, reportId);

        return "redirect:/admin/report/comment/list";
    }
}