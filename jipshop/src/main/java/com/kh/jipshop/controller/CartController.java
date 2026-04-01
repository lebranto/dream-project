package com.kh.jipshop.controller;

import com.kh.jipshop.dto.CartDTO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/cartList")
public class CartController {

    // ===============================
    // ✅ 장바구니 추가
    // ===============================
    @PostMapping("/add")
    public String addCart(
            @RequestParam int productId,
            @RequestParam String productName,
            @RequestParam int productPrice,
            @RequestParam String productPhoto,
            @RequestParam int qty,
            HttpSession session) {

        List<CartDTO> cartList = (List<CartDTO>) session.getAttribute("cartList");

        if (cartList == null) {
            cartList = new ArrayList<>();
        }

        boolean isExist = false;

        for (CartDTO c : cartList) {
            if (c.getProductId() == productId) {
                c.setCartQty(c.getCartQty() + qty);
                isExist = true;
                break;
            }
        }

        if (!isExist) {
            CartDTO dto = new CartDTO();
            dto.setProductId(productId);
            dto.setProductName(productName);
            dto.setProductPrice(productPrice);
            dto.setProductPhoto1(productPhoto);
            dto.setCartQty(qty);

            cartList.add(dto);
        }

        session.setAttribute("cartList", cartList);

        return "redirect:/cartList";
    }


    // ===============================
    // ✅ 장바구니 페이지
    // ===============================
    @GetMapping("")
    public String cartList() {
        return "orders/cartList";
    }


    // ===============================
    // ✅ 삭제 기능 (🔥 수정 완료)
    // ===============================
    // ✅ 선택 삭제 (여러개)
    @GetMapping("/deleteAll")
    public String deleteAll(@RequestParam String ids, HttpSession session){

        List<CartDTO> cartList = (List<CartDTO>) session.getAttribute("cartList");

        if(cartList != null && ids != null && !ids.isEmpty()){

            String[] idArr = ids.split(",");

            for(String id : idArr){
                try{
                    int cartId = Integer.parseInt(id.trim());

                    cartList.removeIf(c -> c.getCartId() == cartId);

                }catch(Exception e){
                    e.printStackTrace(); // 혹시 잘못된 값 방지
                }
            }
        }

        session.setAttribute("cartList", cartList);

        return "redirect:/cartList";
    }
}