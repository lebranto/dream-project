package com.kh.jipshop.admin.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.jipshop.admin.model.service.AdminOrderCancelService;
import com.kh.jipshop.admin.model.vo.AdminOrderCancel;
import com.kh.jipshop.admin.model.vo.AdminOrderCancelSearch;
import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.common.template.Pagination;

@Controller
@RequestMapping("/admin/orderCancel")
public class AdminOrderCancelController {

    @Autowired
    private AdminOrderCancelService adminOrderCancelService;

    @GetMapping("/list")
    public String selectOrderCancelList(
            @RequestParam(value="currentPage", defaultValue="1") int currentPage,
            AdminOrderCancelSearch search,
            Model model) {

        int listCount = adminOrderCancelService.selectOrderCancelListCount(search);
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);

        ArrayList<AdminOrderCancel> list =
                adminOrderCancelService.selectOrderCancelList(pi, search);

        int pendingCount = adminOrderCancelService.selectPendingCancelCount();

        model.addAttribute("pi", pi);
        model.addAttribute("list", list);
        model.addAttribute("search", search);
        model.addAttribute("pendingCount", pendingCount);

        return "admin/orderCancelList";
    }

    @PostMapping("/approve")
    public String approveCancel(
            @RequestParam("detailId") int detailId,
            RedirectAttributes ra) {

        int result = adminOrderCancelService.approveCancel(detailId);

        if(result > 0) {
            ra.addFlashAttribute("alertMsg", "취소 승인 처리 완료");
        } else {
            ra.addFlashAttribute("alertMsg", "취소 승인 실패");
        }

        return "redirect:/admin/orderCancel/list";
    }


    @PostMapping("/reject")
    public String rejectCancel(
            @RequestParam("detailId") int detailId,
            RedirectAttributes ra) {

        int result = adminOrderCancelService.rejectCancel(detailId);

        if(result > 0) {
            ra.addFlashAttribute("alertMsg", "취소 반려 처리 완료");
        } else {
            ra.addFlashAttribute("alertMsg", "취소 반려 실패");
        }

        return "redirect:/admin/orderCancel/list";
    }
    // 추가 : 일괄 승인
    @PostMapping("/approveSelected")
    public String approveSelectedOrderCancel(int[] detailId, RedirectAttributes ra) {

        if(detailId == null || detailId.length == 0) {
            ra.addFlashAttribute("alertMsg", "선택된 항목이 없습니다.");
            return "redirect:/admin/orderCancel/list";
        }

        int result = adminOrderCancelService.approveSelectedOrderCancel(detailId);

        if(result > 0) {
            ra.addFlashAttribute("alertMsg", detailId.length + "건 취소 승인 완료");
        } else {
            ra.addFlashAttribute("alertMsg", "일괄 취소 승인 실패");
        }

        return "redirect:/admin/orderCancel/list";
    }
}