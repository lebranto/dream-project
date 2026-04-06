package com.kh.jipshop.review.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
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
     * UI 확인용 테스트 페이지
     */
    @GetMapping("/write/test")
    public String reviewWriteTest(Model model) {

        ReviewableOrderDetail reviewTarget = new ReviewableOrderDetail();
        reviewTarget.setDetailId(999);
        reviewTarget.setOrderId(1);
        reviewTarget.setProductId(1);
        reviewTarget.setMemberNo(10000);
        reviewTarget.setProductName("UI 테스트용 상품");
        reviewTarget.setProductPhoto1(null);
        reviewTarget.setProductPrice(12500);
        reviewTarget.setCompanyName("냥냥컴퍼니");
        reviewTarget.setCategoryName("사료");
        reviewTarget.setPetType("강아지");
        reviewTarget.setAgeGroup("전연령");

        model.addAttribute("reviewTarget", reviewTarget);

        return "review/reviewWrite";
    }

    /**
     * 상품 상세페이지에서 리뷰작성 버튼 클릭
     * 구매 여부 / 미작성 여부 확인 후 리뷰작성 페이지로 이동
     */
    @GetMapping("/write/check")
    public String checkWritableReview(@RequestParam("productId") int productId,
                                      Authentication auth,
                                      RedirectAttributes ra) {

        MemberExt loginUser = getLoginUser(auth);
        if (loginUser == null) {
            ra.addFlashAttribute("alertMsg", "로그인 후 리뷰를 작성할 수 있습니다.");
            return "redirect:/member/login";
        }

        int memberNo = loginUser.getMemberNo();

        System.out.println("=== 리뷰작성 가능 여부 체크 ===");
        System.out.println("loginUser = " + loginUser);
        System.out.println("loginUser.getMemberId() : " + loginUser.getMemberId());
        System.out.println("loginUser.getMemberNo() : " + loginUser.getMemberNo());
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
                                  Authentication auth,
                                  RedirectAttributes ra,
                                  Model model) {

        MemberExt loginUser = getLoginUser(auth);
        if (loginUser == null) {
            ra.addFlashAttribute("alertMsg", "로그인 후 리뷰를 작성할 수 있습니다.");
            return "redirect:/member/login";
        }

        int memberNo = loginUser.getMemberNo();

        System.out.println("=== 리뷰작성 페이지 진입 ===");
        System.out.println("memberId : " + loginUser.getMemberId());
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
                               Authentication auth,
                               HttpSession session,
                               RedirectAttributes ra) {

        MemberExt loginUser = getLoginUser(auth);
        if (loginUser == null) {
            ra.addFlashAttribute("alertMsg", "로그인 후 리뷰를 작성할 수 있습니다.");
            return "redirect:/member/login";
        }

        int memberNo = loginUser.getMemberNo();

        System.out.println("=== 리뷰 등록 ===");
        System.out.println("memberId : " + loginUser.getMemberId());
        System.out.println("memberNo : " + memberNo);
        System.out.println("detailId : " + detailId);
        System.out.println("productId : " + productId);

        ReviewableOrderDetail target = reviewService.selectWritableDetailByDetailId(memberNo, detailId);

        if (target == null) {
            ra.addFlashAttribute("alertMsg", "리뷰 등록 권한이 없습니다.");
            return "redirect:/mypage/purchase";
        }

        reviewContent = reviewContent == null ? "" : reviewContent.trim();

        if (reviewRating < 1 || reviewRating > 5) {
            ra.addFlashAttribute("alertMsg", "별점을 올바르게 선택해주세요.");
            return "redirect:/review/write?detailId=" + detailId;
        }

        if (reviewContent.length() < 5) {
            ra.addFlashAttribute("alertMsg", "상세리뷰를 5자 이상 입력해주세요.");
            return "redirect:/review/write?detailId=" + detailId;
        }

        String reviewPhoto = extractSingleUpload(uploadFiles, ra);
        if ("__INVALID__".equals(reviewPhoto)) {
            return "redirect:/review/write?detailId=" + detailId;
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

    /**
     * 로그인 사용자 꺼내기
     */
    private MemberExt getLoginUser(Authentication auth) {
        if (auth == null || auth.getPrincipal() == null) {
            return null;
        }

        if (!(auth.getPrincipal() instanceof MemberExt)) {
            return null;
        }

        return (MemberExt) auth.getPrincipal();
    }

    /**
     * 업로드 파일 1개만 허용
     * 업로드 실패/다중 업로드 시 "__INVALID__" 반환
     */
    private String extractSingleUpload(MultipartFile[] uploadFiles, RedirectAttributes ra) {
        if (uploadFiles == null || uploadFiles.length == 0) {
            return null;
        }

        MultipartFile selectedFile = null;
        int fileCount = 0;

        for (MultipartFile file : uploadFiles) {
            if (file != null && !file.isEmpty()) {
                fileCount++;
                selectedFile = file;
            }
        }

        if (fileCount == 0) {
            return null;
        }

        if (fileCount > 1) {
            ra.addFlashAttribute("alertMsg", "사진은 1장만 업로드 가능합니다.");
            return "__INVALID__";
        }

        return saveFile(selectedFile);
    }

    /**
     * 실제 파일 저장
     */
    private String saveFile(MultipartFile upfile) {

        String savePath = application.getRealPath("/resources/upload/review/");

        File dir = new File(savePath);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        String originName = upfile.getOriginalFilename();

        if (originName == null || originName.lastIndexOf(".") == -1) {
            originName = "review.jpg";
        }

        String ext = originName.substring(originName.lastIndexOf("."));
        String changeName = UUID.randomUUID().toString() + ext;

        try {
            File saveFile = new File(savePath, changeName);
            upfile.transferTo(saveFile);
        } catch (IllegalStateException | IOException e) {
            e.printStackTrace();
        }

        return "/resources/upload/review/" + changeName;
    }
}