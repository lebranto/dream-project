package com.kh.jipshop.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.jipshop.main.model.service.MainService;
import com.kh.jipshop.member.model.vo.Pet;
import com.kh.jipshop.product.model.vo.Products;
import com.kh.jipshop.security.model.vo.MemberExt;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class MainPageController {

    private final MainService mainService;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(Model model, HttpSession session) {
        log.info("메인 페이지 요청");

        // Security 로그인 유저 세션 저장
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated()
                && !(auth.getPrincipal() instanceof String)) {
            MemberExt loginUser = (MemberExt) auth.getPrincipal();
            session.setAttribute("loginUser", loginUser);
        }

        // 신상품 / 꿀템
        model.addAttribute("newProducts",   mainService.selectNewProducts());
        model.addAttribute("honeyProducts", mainService.selectHoneyProducts());

        // 펫 정보 (추천템용)
        MemberExt loginUser = (MemberExt) session.getAttribute("loginUser");
        if (loginUser != null) {
            Pet pet = mainService.selectPetByMemberNo(loginUser.getMemberNo());
            model.addAttribute("myPet", pet);
        }

        return "home";
    }

    // 추천상품 탭 Ajax
    @ResponseBody
    @RequestMapping(value = "/main/recommend", method = RequestMethod.GET)
    public Map<String, Object> getRecommend(
            @RequestParam("tab") String tab,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();
        List<Products> products;

        if ("dog".equals(tab)) {
            products = mainService.selectDogRecommend();
            result.put("imgType", "dog");

        } else if ("cat".equals(tab)) {
            products = mainService.selectCatRecommend();
            result.put("imgType", "cat");

        } else {
            // 추천템
            MemberExt loginUser = (MemberExt) session.getAttribute("loginUser");

            if (loginUser == null) {
                products = mainService.selectDefaultRecommend();
                result.put("imgType", "dog");
                result.put("petPhoto", null);
            } else {
                Pet pet = mainService.selectPetByMemberNo(loginUser.getMemberNo());

                if (pet == null) {
                    products = mainService.selectDefaultRecommend();
                    result.put("imgType", "dog");
                    result.put("petPhoto", null);
                } else {
                	String petType   = pet.getPetType();
                	String ageGroup  = pet.getAgeGroup();
                	String dbPetType = "cat".equals(petType) ? "고양이" : "강아지"; 

                	result.put("imgType",  "cat".equals(petType) ? "cat" : "dog");  
                	result.put("petPhoto", pet.getPetPhoto());

                    if (ageGroup != null) {
                        Map<String, String> params = new HashMap<>();
                        params.put("petType",  dbPetType);
                        params.put("ageGroup", ageGroup);
                        products = mainService.selectPetRecommend(params);
                    } else {
                        products = "강아지".equals(petType)
                                ? mainService.selectDogRecommend()
                                : mainService.selectCatRecommend();
                    }
                }	
            }
        }

        result.put("products", products);
        return result;
    }
}