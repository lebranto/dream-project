package com.kh.jipshop.cart.controller;

import org.springframework.web.bind.annotation.*;

import com.kh.jipshop.cart.model.vo.CartDTO;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/wishList")
public class WishController {

    @PostMapping("/toggle")
    public String toggleWish(
            @RequestParam int productId,
            @RequestParam String productName,
            @RequestParam int productPrice,
            @RequestParam String productPhoto,
            HttpSession session){

        List<CartDTO> wishList = (List<CartDTO>) session.getAttribute("wishList");

        if(wishList == null){
            wishList = new ArrayList<>();
        }

        for(CartDTO w : wishList){
            if(w.getProductId() == productId){
                wishList.remove(w);
                session.setAttribute("wishList", wishList);
                return "remove";
            }
        }

        CartDTO dto = new CartDTO();
        dto.setProductId(productId);
        dto.setProductName(productName);
        dto.setProductPrice(productPrice);
        dto.setProductPhoto1(productPhoto);

        wishList.add(dto);

        session.setAttribute("wishList", wishList);

        return "add";
    }


    @PostMapping("/delete")
    @ResponseBody
    public void delete(@RequestParam int productId, HttpSession session){
        List<CartDTO> wishList = (List<CartDTO>) session.getAttribute("wishList");
        if(wishList != null){
            wishList.removeIf(w -> w.getProductId() == productId);
        }
    }

    @PostMapping("/deleteAll")
    @ResponseBody
    public void deleteAll(@RequestParam String ids, HttpSession session){
        List<CartDTO> wishList = (List<CartDTO>) session.getAttribute("wishList");

        if(wishList != null){
            for(String id : ids.split(",")){
                int pid = Integer.parseInt(id);
                wishList.removeIf(w -> w.getProductId() == pid);
            }
        }
    }
    
 // ===============================
 // ✅ 찜 목록 조회 (AJAX)
 // ===============================
 @ResponseBody
 @GetMapping("/getIds")
 public List<Integer> getWishIds(HttpSession session){

     List<CartDTO> wishList = (List<CartDTO>) session.getAttribute("wishList");

     List<Integer> ids = new ArrayList<>();

     if(wishList != null){
         for(CartDTO c : wishList){
             ids.add(c.getProductId());
         }
     }

     return ids;
 }
}
