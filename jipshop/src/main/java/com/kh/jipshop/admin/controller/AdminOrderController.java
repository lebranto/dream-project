package com.kh.jipshop.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.jipshop.admin.model.service.AdminOrderService;
import com.kh.jipshop.admin.model.vo.AdminOrderSearch;
import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.common.template.Pagination;

@Controller
@RequestMapping("/admin/order")
public class AdminOrderController {

    @Autowired
    private AdminOrderService adminOrderService;

    @GetMapping("/list")
    public String selectOrderList(
            @RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
            AdminOrderSearch search,
            Model model) {

        int listCount = adminOrderService.selectOrderListCount(search);
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);

        model.addAttribute("pi", pi);
        model.addAttribute("orderList", adminOrderService.selectOrderList(pi, search));
        model.addAttribute("search", search);

        return "admin/adminOrderList";
    }

    @PostMapping("/delete")
    public String deleteOrders(
            @RequestParam(value = "orderIds", required = false) List<Integer> orderIds,
            RedirectAttributes ra) {

        int result = adminOrderService.deleteOrders(orderIds);

        if (result > 0) {
            ra.addFlashAttribute("alertMsg", "주문 삭제가 완료되었습니다.");
        } else {
            ra.addFlashAttribute("alertMsg", "삭제할 주문이 없거나 삭제에 실패했습니다.");
        }

        return "redirect:/admin/order/list";
    }

    @ResponseBody
    @PostMapping(value = "/updateDeliveryYn", produces = "text/plain; charset=UTF-8")
    public String updateDeliveryYn(
            @RequestParam("orderId") int orderId,
            @RequestParam("deliveryYn") String deliveryYn) {

        int result = adminOrderService.updateDeliveryYn(orderId, deliveryYn);
        return result > 0 ? "success" : "fail";
    }
}