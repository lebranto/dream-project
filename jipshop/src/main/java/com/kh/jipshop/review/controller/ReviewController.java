package com.kh.jipshop.review.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.jipshop.review.model.service.ReviewService;
import com.kh.jipshop.review.model.vo.Review;
import com.kh.jipshop.review.model.vo.ReviewableOrderDetail;
import com.kh.jipshop.security.model.vo.MemberExt;

@Controller
@RequestMapping("/review")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private ServletContext application;

    /**
     * UI 확인 전용 테스트 페이지
     */
    @GetMapping("/write/test")
    public String reviewWriteTest(Model model) {

        ReviewableOrderDetail reviewTarget = new ReviewableOrderDetail();
        reviewTarget.setDetailId(999);
        reviewTarget.setProductId(1);
        reviewTarget.setProductName("UI 테스트용 상품");
        reviewTarget.setProductPhoto1(null);
        reviewTarget.setCategoryName("사료");
        reviewTarget.setPetType("강아지");
        reviewTarget.setAgeGroup("전연령");

        model.addAttribute("reviewTarget", reviewTarget);

        return "review/reviewWrite";
    }

    /**
     * 상품상세에서 리뷰작성 버튼 클릭
     */
    @GetMapping("/write/check")
    public String checkWritableReview(@RequestParam("productId") int productId,
                                      @AuthenticationPrincipal MemberExt loginUser,
                                      RedirectAttributes ra) {

        if (loginUser == null) {
            ra.addFlashAttribute("alertMsg", "로그인 후 리뷰를 작성할 수 있습니다.");
            return "redirect:/member/login";
        }

        int memberNo = loginUser.getMemberNo();

        System.out.println("=== 리뷰작성 가능 여부 체크 ===");
        System.out.println("memberNo : " + memberNo);
        System.out.println("productId : " + productId);

        ReviewableOrderDetail target = reviewService.selectWritableDetailByProduct(memberNo, productId);

        System.out.println("조회된 target : " + target);

        if (target == null) {
            ra.addFlashAttribute("alertMsg", "구매한 회원만 리뷰를 작성할 수 있거나 이미 리뷰를 작성한 상품입니다.");
            return "redirect:/product/detail?productId=" + productId;
        }

        return "redirect:/review/write?detailId=" + target.getDetailId();
    }

    /**
     * 실제 리뷰작성 페이지 진입
     */
    @GetMapping("/write")
    public String reviewWriteForm(@RequestParam("detailId") int detailId,
                                  @AuthenticationPrincipal MemberExt loginUser,
                                  RedirectAttributes ra,
                                  Model model) {

        if (loginUser == null) {
            ra.addFlashAttribute("alertMsg", "로그인 후 리뷰를 작성할 수 있습니다.");
            return "redirect:/member/login";
        }

        int memberNo = loginUser.getMemberNo();

        System.out.println("=== 리뷰작성 페이지 진입 ===");
        System.out.println("memberNo : " + memberNo);
        System.out.println("detailId : " + detailId);

        ReviewableOrderDetail target = reviewService.selectWritableDetailByDetailId(memberNo, detailId);

        System.out.println("조회된 reviewTarget : " + target);

        if (target == null) {
            ra.addFlashAttribute("alertMsg", "리뷰 작성 권한이 없습니다.");
            return "redirect:/mypage/purchase";
        }

        model.addAttribute("reviewTarget", target);

        return "review/reviewWrite";
    }

    /**
     * 리뷰 등록
     */
    @PostMapping("/insert")
    public String insertReview(@RequestParam("detailId") int detailId,
                               @RequestParam("productId") int productId,
                               @RequestParam("reviewRating") int reviewRating,
                               @RequestParam("reviewContent") String reviewContent,
                               @RequestParam(value = "uploadFiles", required = false) MultipartFile[] uploadFiles,
                               @AuthenticationPrincipal MemberExt loginUser,
                               HttpSession session,
                               RedirectAttributes ra) {

      if (loginUser == null) {
           ra.addFlashAttribute("alertMsg", "로그인 후 리뷰를 작성할 수 있습니다.");
           return "redirect:/member/login";
      }

      int memberNo = loginUser.getMemberNo();

        ReviewableOrderDetail target = reviewService.selectWritableDetailByDetailId(memberNo, detailId);

      if (target == null) {
           ra.addFlashAttribute("alertMsg", "리뷰 등록 권한이 없습니다.");
           return "redirect:/mypage/purchase";
      }

        String reviewPhoto = null;

        if (uploadFiles != null) {
            if (uploadFiles.length > 3) {
                session.setAttribute("alertMsg", "사진은 최대 3장까지 업로드 가능합니다.");
                return "redirect:/review/write?detailId=" + detailId;
            }

            for (MultipartFile file : uploadFiles) {
                if (file != null && !file.isEmpty()) {
                    reviewPhoto = saveFile(file);
                    break;
                }
            }
        }

        Review review = new Review();
        review.setMemberNo(memberNo);
        review.setDetailId(detailId);
        review.setReviewRating(reviewRating);
        review.setReviewContent(reviewContent);
        review.setReviewPhoto(reviewPhoto);

        int result = reviewService.insertReview(review);

        if (result > 0) {
            session.setAttribute("alertMsg", "리뷰가 등록되었습니다.");
        } else {
            session.setAttribute("alertMsg", "리뷰 등록에 실패했습니다.");
        }

        return "redirect:/product/detail?productId=" + productId;
    }

    private String saveFile(MultipartFile upfile) {

        String savePath = application.getRealPath("/resources/upload/review/");

        File dir = new File(savePath);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        String originName = upfile.getOriginalFilename();
        String ext = originName.substring(originName.lastIndexOf("."));
        String changeName = UUID.randomUUID().toString() + ext;

        try {
            upfile.transferTo(new File(savePath + changeName));
        } catch (IllegalStateException | IOException e) {
            e.printStackTrace();
        }

        return "/resources/upload/review/" + changeName;
    }
}
