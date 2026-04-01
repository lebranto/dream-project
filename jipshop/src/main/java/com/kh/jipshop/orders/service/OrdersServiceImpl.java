package com.kh.jipshop.orders.service;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.jipshop.mypage.model.vo.OrderDetail;
import com.kh.jipshop.mypage.model.vo.Orders;
import com.kh.jipshop.mypage.model.vo.Product;
import com.kh.jipshop.orders.dao.OrdersDao;
import com.kh.jipshop.orders.model.vo.Delivery;
import com.kh.jipshop.orders.model.vo.Status;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrdersServiceImpl implements OrdersService{

	private final OrdersDao oDao;
	
	@Override
	public List<Product> productList(Map<String, Object> paramMap) {
		
		return oDao.productList(paramMap);
	}

	@Override
    @Transactional
    public int insertOrder(Orders order) {

        int result = oDao.insertOrders(order);
        if (result <= 0) {
            return 0;
        }

        if (order.getDetailList() != null && !order.getDetailList().isEmpty()) {
            for (OrderDetail detail : order.getDetailList()) {
                detail.setOrderId(order.getOrderId());

                int detailResult = oDao.insertOrderDetail(detail);
                if (detailResult <= 0) {
                    throw new RuntimeException("주문 상세 저장 실패");
                }
            }
        }

        Delivery delivery = new Delivery();
        delivery.setOrderId(order.getOrderId());
        delivery.setCourier("멍냥이");

		
		 Calendar cal = Calendar.getInstance(); 
		 cal.add(Calendar.DATE, 3);
		 delivery.setExpectedDate(cal.getTime());
		 

        int deliveryResult = oDao.insertDelivery(delivery);
        if (deliveryResult <= 0) {
            throw new RuntimeException("배송 정보 저장 실패");
        }

        Status status = new Status();
        status.setDnum("D" + String.format("%04d", delivery.getDeliveryId()));
        status.setDeliveryYn("N");
        status.setDeliveryStatus("배송진행중");
        status.setDeliveryId(delivery.getDeliveryId());

        int statusResult = oDao.insertStatus(status);
        if (statusResult <= 0) {
            throw new RuntimeException("배송 상태 저장 실패");
        }

        return 1;
    }
}
