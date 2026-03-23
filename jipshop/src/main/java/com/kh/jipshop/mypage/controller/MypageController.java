package com.kh.jipshop.mypage.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.jipshop.mypage.model.service.MypageService;
import com.kh.jipshop.mypage.model.vo.Orders;
import com.kh.jipshop.mypage.model.vo.RecentlyViewed;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/mypage")
@RequiredArgsConstructor
public class MypageController {
    
    private final MypageService mService;

    @GetMapping("/purchase")
    public String orderList(
            @RequestParam(required = false) Integer memeberId,
            Model model
            ) {
        
            if(memeberId==null) {
            	memeberId=0;
                return "mypage/purchase";
            }
            
            List<Orders> list = mService.orderList(memeberId); 
            model.addAttribute("orderlist",list);
            
            return "mypage/purchase";
    }
    
    @GetMapping("/recent") 
    public String recentlyList(@RequestParam(required = false) Integer viewId,
            Model model) {
    	   if(viewId==null) {
               viewId=0;
               return "mypage/purchase";
           }
    	
            List<RecentlyViewed> list = mService.recentlyList(viewId);
            model.addAttribute("recentlyList",list);
        
            return "mypage/recent";
    }
	
	@GetMapping("/inquiry")
	public String inquiryList(@RequestParam(required = false) Integer inquiryId,
			Model model) {
		
		 if(inquiryId==null) {
             inquiryId=0;
             return "mypage/inquiry";
         }
  	
		 List<RecentlyViewed> list = mService.inquiryList(inquiryId);
          model.addAttribute("inquiryList",list);
	
			return "mypage/inquiry";
	}
	
	
	
	
	@GetMapping("/updateMemberCheck")
	public String updateMemberCheck() {
	
			return "mypage/updateMemberCheck";
	}
	
	
	@GetMapping("/memberDelete")
	public String memberDelete() {
		
		return "mypage/memberDelete";
	}
	
	
	
	
}
