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
    // ✅ 장바구니 추가 (페이지 이동용)
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

            // ⭐ 중요 (삭제 위해)
            dto.setCartId(cartList.size() + 1);

            cartList.add(dto);
        }

        session.setAttribute("cartList", cartList);

        return "redirect:/cartList";
    }


    // ===============================
    // ✅ 장바구니 추가 (AJAX용 ⭐)
    // ===============================
    @PostMapping("/addAjax")
    @ResponseBody
    public int addCartAjax(
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

            // ⭐ 중요
            dto.setCartId(cartList.size() + 1);

            cartList.add(dto);
        }

        session.setAttribute("cartList", cartList);

        // ⭐ 핵심: 현재 장바구니 개수 반환
        return cartList.size();
    }


    // ===============================
    // ✅ 장바구니 페이지
    // ===============================
    @GetMapping("")
    public String cartList() {
        return "orders/cartList";
    }


    // ===============================
    // ✅ 선택 삭제 (페이지 이동용)
    // ===============================
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
                    e.printStackTrace();
                }
            }
        }

        session.setAttribute("cartList", cartList);

        return "redirect:/cartList";
    }


    // ===============================
    // ✅ 선택 삭제 (AJAX용 ⭐)
    // ===============================
    @PostMapping("/deleteAllAjax")
    @ResponseBody
    public int deleteAllAjax(@RequestParam String ids, HttpSession session){

        List<CartDTO> cartList = (List<CartDTO>) session.getAttribute("cartList");

        if(cartList != null && ids != null && !ids.isEmpty()){

            String[] idArr = ids.split(",");

            for(String id : idArr){
                int cartId = Integer.parseInt(id.trim());
                cartList.removeIf(c -> c.getCartId() == cartId);
            }
        }

        session.setAttribute("cartList", cartList);

        return cartList.size(); // ⭐ 최신 개수 반환
    }
}