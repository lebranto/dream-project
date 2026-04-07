package com.kh.jipshop.product.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.common.template.Pagination;
import com.kh.jipshop.product.model.service.ProductServiceImpl;
import com.kh.jipshop.product.model.vo.ProductSearch;
import com.kh.jipshop.product.model.vo.Products;
import com.kh.jipshop.review.model.service.ReviewService;
import com.kh.jipshop.review.model.vo.Review;
import com.kh.jipshop.security.model.vo.MemberExt;


@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductServiceImpl productService;

    @Autowired
    private ReviewService reviewService;

    @GetMapping("/detail")
    public String productDetail(@RequestParam("productId") int productId, Model model) {


        Products product = productService.selectProductDetail(productId);


        if (product == null) {
            model.addAttribute("errorMsg", "상품 정보를 찾을 수 없습니다.");
            return "common/errorPage";
        }

        List<Review> reviewList = reviewService.selectReviewListByProductId(productId);

        

        model.addAttribute("product", product);
        model.addAttribute("reviewList", reviewList);
        model.addAttribute("reviewCount", reviewList == null ? 0 : reviewList.size());

        return "product/productDetail";
    }

    @PostMapping("/cart")
    public String addCart(@RequestParam("productId") int productId,
                          @RequestParam("qty") int qty,
                          HttpSession session) {

      

        session.setAttribute("alertMsg", "장바구니 기능은 연결 전입니다. 현재는 버튼 동작만 확인용입니다.");
        return "redirect:/product/detail?productId=" + productId;
    }

    @PostMapping("/buyNow")
    public String buyNow(@RequestParam("productId") int productId,
                         @RequestParam("qty") int qty,
                         HttpSession session) {

       

        session.setAttribute("alertMsg", "구매하기 기능은 연결 전입니다. 현재는 버튼 동작만 확인용입니다.");
        return "redirect:/product/detail?productId=" + productId;
    }

    @RequestMapping("/")
    public String home() {
        return "product/home";
    }

    @RequestMapping("/terms")
    public String terms() {
        return "product/terms";
    }

    @RequestMapping("/privacy")
    public String privacy() {
        return "product/privacy";
    }

    @GetMapping("/list")
    public String productList(
            @RequestParam(value = "petType", required = false) String petType,
            @RequestParam(value = "categoryName", required = false) String categoryName,
            @RequestParam(value = "sort", defaultValue = "latest") String sort,
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
            Model model) {

        ProductSearch search = new ProductSearch();
        search.setPetType(petType);
        search.setCategoryName(categoryName);
        search.setSort(sort);
        search.setKeyword(keyword);

        int listCount = productService.selectProductListCount(search);

        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 12);

        List<Products> productList = productService.selectProductList(search, pi);

        model.addAttribute("productList", productList);
        model.addAttribute("listCount", listCount);
        model.addAttribute("pi", pi);

        model.addAttribute("petType", petType);
        model.addAttribute("categoryName", categoryName);
        model.addAttribute("sort", sort);
        model.addAttribute("keyword", keyword);

        return "product/productList";
    }
    
    // 최근 본 상품

    @PostMapping("/view/insert")
    @ResponseBody
    public String insertView(
            @RequestParam("productId") int productId,
            @RequestParam Map<String, Object> param, 
            Authentication auth
    ) {
        System.out.println("=== 최근 본 상품 insert 진입 ===");
        System.out.println("productId : " + productId);

        if (auth == null || !(auth.getPrincipal() instanceof MemberExt)) {
            System.out.println("로그인 안됨");
            return "fail";
        }

        int memberNo = ((MemberExt) auth.getPrincipal()).getMemberNo();
        System.out.println("memberNo : " + memberNo);
        
        param.put("memberNo", memberNo);
        param.put("productId", productId);
        

        productService.insertView(param);

        return "ok";
    }
}