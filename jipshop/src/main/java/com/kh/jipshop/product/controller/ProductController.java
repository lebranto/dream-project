package com.kh.jipshop.product.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.common.template.Pagination;
import com.kh.jipshop.product.model.service.ProductServiceImpl;
import com.kh.jipshop.product.model.vo.ProductSearch;
import com.kh.jipshop.product.model.vo.Products;

@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductServiceImpl productService;

    @GetMapping("/detail")
    public String productDetail(@RequestParam("productId") int productId, Model model) {

        System.out.println("=== productDetail controller 진입 ===");
        System.out.println("productId : " + productId);

        Products product = productService.selectProductDetail(productId);

        System.out.println("조회된 product : " + product);

        if (product == null) {
            model.addAttribute("errorMsg", "상품 정보를 찾을 수 없습니다.");
            return "common/errorPage";
        }

        model.addAttribute("product", product);

        // 아직 리뷰기능 전이라 임시값
        model.addAttribute("reviewCount", 0);

        return "product/productDetail";
    }

    @PostMapping("/cart")
    public String addCart(@RequestParam("productId") int productId,
                          @RequestParam("qty") int qty,
                          HttpSession session) {

        System.out.println("=== addCart controller 진입 ===");
        System.out.println("productId : " + productId);
        System.out.println("qty : " + qty);

        session.setAttribute("alertMsg", "장바구니 기능은 연결 전입니다. 현재는 버튼 동작만 확인용입니다.");
        return "redirect:/product/detail?productId=" + productId;
    }

    @PostMapping("/buyNow")
    public String buyNow(@RequestParam("productId") int productId,
                         @RequestParam("qty") int qty,
                         HttpSession session) {

        System.out.println("=== buyNow controller 진입 ===");
        System.out.println("productId : " + productId);
        System.out.println("qty : " + qty);

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
            @RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
            Model model) {

        ProductSearch search = new ProductSearch();
        search.setPetType(petType);
        search.setCategoryName(categoryName);
        search.setSort(sort);

        int listCount = productService.selectProductListCount(search);

        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 12, 5);

        List<Products> productList = productService.selectProductList(search, pi);

        model.addAttribute("productList", productList);
        model.addAttribute("listCount", listCount);
        model.addAttribute("pi", pi);

        model.addAttribute("petType", petType);
        model.addAttribute("categoryName", categoryName);
        model.addAttribute("sort", sort);

        return "product/productList";
    }
}