package com.kh.jipshop.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.jipshop.admin.model.service.AdminCommentReportService;
import com.kh.jipshop.admin.model.vo.AdminCommentReport;
import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.common.template.Pagination;

@Controller
public class AdminCommentReportController {

    @Autowired
    private AdminCommentReportService adminCommentReportService;

    @GetMapping("/admin/reportList.do")
    public String reportList(
            @RequestParam(value = "page", defaultValue = "1") int currentPage,
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate,
            @RequestParam(value = "reportStatus", required = false) String reportStatus,
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model) {

        HashMap<String, Object> paramMap = new HashMap<>();
        paramMap.put("startDate", startDate);
        paramMap.put("endDate", endDate);
        paramMap.put("reportStatus", reportStatus);
        paramMap.put("keyword", keyword);

        int listCount = adminCommentReportService.selectReportListCount(paramMap);

        int pageLimit = 10;
        int boardLimit = 10;

        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);

        ArrayList<AdminCommentReport> reportList = adminCommentReportService.selectReportList(pi, paramMap);

        model.addAttribute("reportList", reportList);
        model.addAttribute("totalCount", listCount);
        model.addAttribute("pi", pi);

        model.addAttribute("currentPage", pi.getCurrentPage());
        model.addAttribute("startPage", pi.getStartPage());
        model.addAttribute("endPage", pi.getEndPage());
        model.addAttribute("totalPages", pi.getMaxPage());
        model.addAttribute("pageSize", pi.getBoardLimit());

        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("reportStatus", reportStatus);
        model.addAttribute("keyword", keyword);

        return "admin/reportList";
    }

    @GetMapping("/admin/reportDetail.do")
    public String reportDetail(@RequestParam("reportId") int reportId,
                               Model model) {

        AdminCommentReport report = adminCommentReportService.selectReportDetail(reportId);
        model.addAttribute("report", report);

        return "admin/reportDetail";
    }

    @PostMapping("/admin/reportProcess.do")
    public String reportProcess(@RequestParam("reportId") int reportId,
                                RedirectAttributes ra) {

        int result = adminCommentReportService.updateReportProcess(reportId);

        if (result > 0) {
            ra.addFlashAttribute("alertMsg", "신고가 처리 완료되었습니다.");
        } else {
            ra.addFlashAttribute("alertMsg", "처리에 실패했습니다.");
        }

        return "redirect:/admin/reportList.do";
    }

    @PostMapping("/admin/reportBulkAction.do")
    public String reportBulkAction(@RequestParam("action") String action,
                                   @RequestParam(value = "reportIds", required = false) List<Integer> reportIds,
                                   RedirectAttributes ra) {

        if (reportIds == null || reportIds.isEmpty()) {
            ra.addFlashAttribute("alertMsg", "선택된 신고가 없습니다.");
            return "redirect:/admin/reportList.do";
        }

        int result = 0;

        if ("done".equals(action)) {
            result = adminCommentReportService.updateBulkReportProcess(reportIds);

            if (result > 0) {
                ra.addFlashAttribute("alertMsg", "선택한 신고가 처리 완료되었습니다.");
            } else {
                ra.addFlashAttribute("alertMsg", "일괄 처리에 실패했습니다.");
            }

        } else if ("delete".equals(action)) {
            result = adminCommentReportService.deleteBulkReport(reportIds);

            if (result > 0) {
                ra.addFlashAttribute("alertMsg", "선택한 신고가 삭제되었습니다.");
            } else {
                ra.addFlashAttribute("alertMsg", "일괄 삭제에 실패했습니다.");
            }
        }

        return "redirect:/admin/reportList.do";
    }
}