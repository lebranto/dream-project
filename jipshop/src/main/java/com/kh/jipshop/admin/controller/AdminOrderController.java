package com.kh.jipshop.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.jipshop.admin.model.service.AdminOrderService;
import com.kh.jipshop.admin.model.vo.AdminOrder;
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

        List<AdminOrder> orderList = adminOrderService.selectOrderList(pi, search);

        int shippingCount = 0;
        int deliveredCount = 0;
        int cancelReqCount = 0;
        int outCount = 0;

        if (orderList != null) {
            for (AdminOrder order : orderList) {
                if ("배송 중".equals(order.getOrderStatusLabel())) {
                    shippingCount++;
                } else if ("배송완료".equals(order.getOrderStatusLabel())) {
                    deliveredCount++;
                } else if ("취소 요청".equals(order.getOrderStatusLabel())) {
                    cancelReqCount++;
                } else if ("출고 완료".equals(order.getOrderStatusLabel())) {
                    outCount++;
                }
            }
        }

        model.addAttribute("pi", pi);
        model.addAttribute("orderList", orderList);
        model.addAttribute("shippingCount", shippingCount);
        model.addAttribute("deliveredCount", deliveredCount);
        model.addAttribute("cancelReqCount", cancelReqCount);
        model.addAttribute("outCount", outCount);

        return "admin/orderList";
    }

    @PostMapping("/delete")
    public String deleteOrders(
            @RequestParam(value = "orderIds", required = false) List<Integer> orderIds,
            RedirectAttributes ra) {

        int result = adminOrderService.deleteOrders(orderIds);

        if (result > 0) {
            ra.addFlashAttribute("successMsg", "주문 삭제가 완료되었습니다.");
        } else {
            ra.addFlashAttribute("successMsg", "삭제할 주문이 없거나 삭제에 실패했습니다.");
        }

        return "redirect:/admin/order/list";
    }

    @GetMapping("/orderDetail")
    public String selectOrderDetail(@RequestParam("orderId") int orderId, Model model) {

        AdminOrder order = adminOrderService.selectOrderDetail(orderId);
        List<AdminOrder> detailList = adminOrderService.selectOrderDetailList(orderId);

        if (order == null) {
            model.addAttribute("errorMsg", "주문 상세 조회 실패");
            return "common/errorPage";
        }

        model.addAttribute("order", order);
        model.addAttribute("detailList", detailList);
        return "admin/orderDetail";
    }

    @PostMapping("/deliveryStatusUpdate")
    public String updateDeliveryStatus(
            @RequestParam("orderId") int orderId,
            @RequestParam("deliveryStatus") String deliveryStatus,
            RedirectAttributes ra) {

        if (!"PAY".equals(deliveryStatus)
                && !"OUT".equals(deliveryStatus)
                && !"SHIP".equals(deliveryStatus)
                && !"DONE".equals(deliveryStatus)) {
            ra.addFlashAttribute("successMsg", "잘못된 배송 상태 요청입니다.");
            return "redirect:/admin/order/orderDetail?orderId=" + orderId;
        }

        int result = adminOrderService.updateOrderStatus(orderId, deliveryStatus);

        if (result > 0) {
            ra.addFlashAttribute("successMsg", "배송 상태 변경이 완료되었습니다.");
        } else {
            ra.addFlashAttribute("successMsg", "배송 상태 변경에 실패했습니다.");
        }

        return "redirect:/admin/order/orderDetail?orderId=" + orderId;
    }

    @PostMapping("/approveCancel")
    public String approveCancel(
            @RequestParam("orderId") int orderId,
            @RequestParam("detailId") int detailId,
            RedirectAttributes ra) {

        int result = adminOrderService.updateCancelStatusApproved(detailId);

        if (result > 0) {
            ra.addFlashAttribute("successMsg", "개별 취소 승인이 완료되었습니다.");
        } else {
            ra.addFlashAttribute("successMsg", "개별 취소 승인에 실패했습니다.");
        }

        return "redirect:/admin/order/orderDetail?orderId=" + orderId;
    }

    @PostMapping("/rejectCancel")
    public String rejectCancel(
            @RequestParam("orderId") int orderId,
            @RequestParam("detailId") int detailId,
            RedirectAttributes ra) {

        int result = adminOrderService.updateCancelStatusRejected(detailId);

        if (result > 0) {
            ra.addFlashAttribute("successMsg", "개별 취소 반려가 완료되었습니다.");
        } else {
            ra.addFlashAttribute("successMsg", "개별 취소 반려에 실패했습니다.");
        }

        return "redirect:/admin/order/orderDetail?orderId=" + orderId;
    }

    @PostMapping("/resetCancel")
    public String resetCancel(
            @RequestParam("orderId") int orderId,
            @RequestParam("detailId") int detailId,
            RedirectAttributes ra) {

        int result = adminOrderService.clearCancelStatus(detailId);

        if (result > 0) {
            ra.addFlashAttribute("successMsg", "개별 취소 상태 초기화가 완료되었습니다.");
        } else {
            ra.addFlashAttribute("successMsg", "개별 취소 상태 초기화에 실패했습니다.");
        }

        return "redirect:/admin/order/orderDetail?orderId=" + orderId;
    }
}