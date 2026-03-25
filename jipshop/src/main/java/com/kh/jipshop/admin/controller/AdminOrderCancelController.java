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
import com.kh.jipshop.admin.model.vo.AdminOrderSearch;
import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.common.template.Pagination;

@Controller
@RequestMapping("/admin/orderCancel")
public class AdminOrderCancelController {

    @Autowired
    private AdminOrderCancelService adminOrderCancelService;

    @GetMapping("/list")
    public String selectOrderCancelList(
            @RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
            AdminOrderSearch search,
            Model model) {

        int listCount = adminOrderCancelService.selectOrderCancelListCount(search);
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);

        ArrayList<AdminOrderCancel> cancelList = adminOrderCancelService.selectOrderCancelList(pi, search);

        model.addAttribute("pi", pi);
        model.addAttribute("cancelList", cancelList);
        model.addAttribute("search", search);

        return "admin/order/adminOrderCancel";
    }

    @PostMapping("/approve")
    public String approveOrderCancel(
            @RequestParam("orderIds") String orderIds,
            RedirectAttributes ra) {

        int result = adminOrderCancelService.approveOrderCancel(orderIds);

        if(result > 0) {
            ra.addFlashAttribute("alertMsg", "주문취소가 승인되었습니다.");
        } else {
            ra.addFlashAttribute("alertMsg", "승인 처리에 실패했습니다.");
        }

        return "redirect:/admin/orderCancel/list";
    }

    @PostMapping("/reject")
    public String rejectOrderCancel(
            @RequestParam("orderIds") String orderIds,
            RedirectAttributes ra) {

        int result = adminOrderCancelService.rejectOrderCancel(orderIds);

        if(result > 0) {
            ra.addFlashAttribute("alertMsg", "주문취소가 거절되었습니다.");
        } else {
            ra.addFlashAttribute("alertMsg", "거절 처리에 실패했습니다.");
        }

        return "redirect:/admin/orderCancel/list";
    }

    @PostMapping("/delete")
    public String deleteOrderCancel(
            @RequestParam("orderIds") String orderIds,
            RedirectAttributes ra) {

        int result = adminOrderCancelService.deleteOrderCancel(orderIds);

        if(result > 0) {
            ra.addFlashAttribute("alertMsg", "주문취소 내역이 삭제되었습니다.");
        } else {
            ra.addFlashAttribute("alertMsg", "삭제에 실패했습니다.");
        }

        return "redirect:/admin/orderCancel/list";
    }
}