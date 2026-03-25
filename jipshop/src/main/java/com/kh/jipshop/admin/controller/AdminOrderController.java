package com.kh.jipshop.admin.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
            @RequestParam(value="currentPage", defaultValue="1") int currentPage,
            AdminOrderSearch search,
            Model model) {

        int listCount = adminOrderService.selectOrderListCount(search);
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);

        model.addAttribute("pi", pi);
        model.addAttribute("search", search);
        model.addAttribute("orderList", adminOrderService.selectOrderList(pi, search));

        return "admin/adminOrderList";
    }

    @PostMapping("/updateDeliveryYn")
    @ResponseBody
    public String updateDeliveryYn(
            @RequestParam("orderId") int orderId,
            @RequestParam("deliveryYn") String deliveryYn) {

        int result = adminOrderService.updateDeliveryYn(orderId, deliveryYn);

        return result > 0 ? "success" : "fail";
    }

    @PostMapping("/delete")
    public String deleteOrders(
            @RequestParam(value="orderIds", required=false) ArrayList<Integer> orderIds) {

        if(orderIds != null && !orderIds.isEmpty()) {
            adminOrderService.deleteOrders(orderIds);
        }

        return "redirect:/admin/order/list";
    }
    @GetMapping("/list2")
    public String selectOrderList2() {
    	return "admin/orderList";
    }
    @GetMapping("/cancelList")
    public String CancelList() {
    	return "admin/orderCancelList";
    }
}