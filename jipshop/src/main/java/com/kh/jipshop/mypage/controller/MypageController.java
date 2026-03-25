package com.kh.jipshop.mypage.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.common.template.Pagination;
import com.kh.jipshop.community.model.vo.Board;
import com.kh.jipshop.mypage.model.service.MypageService;
import com.kh.jipshop.mypage.model.vo.MyInqury;
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
            @RequestParam(required = false) Integer memberNo,
            @RequestParam(required = false) Integer period,
            @RequestParam(required = false) @DateTimeFormat(pattern= "yyyy-MM-dd") Date startDate,
    		@RequestParam(required = false) @DateTimeFormat(pattern= "yyyy-MM-dd") Date endDate,
    		@RequestParam(value="cpas" , defaultValue = "1") int currentPage,
    		@RequestParam Map<String, Object> paramMap,
            Model model
            ) {
    	
    	  /* 
		  * @RequestParam Map<String,Object>
		  *  - 클라이언트가 전달한 파라미터의 key, value값을 Map형태로 만들어 바인딩
		  *  - 현재메서드로 전달할 파라미터의 개수가 "정해지지 않은 경우" 혹은 일반적인 VO클래스로
		  *  바인딩되지 않는 경우 사용한다.(검색파라미터)
		  *  - 반드시 @RequestParam을 추가해줘야 바인딩해준다.
		  * */
    	

		/* 업무로직
		 * 1. 페이징처리
		 * 	  1) 현재 요청한 게시판 코드와 검색정보와 일치하는 게시글의 "총 개수" 조회
		 *    2) 게시글 갯수, 페이지 번호, 기본 파라미터들을 추출하여 페이징정보를 가진 객체 생성 	
		 * 2. 현재 요청한 게시판 코드와 일치하면서, 현재 요청한 페이지에 맞는 게시글 정보를 조회
		 * 3. 게시글정보, 페이징정보, 검색정보를 담아서 forward
		 * */
		
		/*
		 * int boardLimit = 10; int pageLimit = 10; int listCount =
		 * mService.orderListCount(paramMap);
		 * 
		 * PageInfo pi = Pagination .getPageInfo(listCount, currentPage, pageLimit,
		 * boardLimit); paramMap.put("pi", pi);
		 * 
		 * List<Orders> list2 = mService.selectListOrder(paramMap);
		 * model.addAttribute("orde",list2); model.addAttribute("pi",pi);
		 */
    	
    	
    	  // 테스트용
        memberNo = 1;
        // 실제로는 로그인 유저 번호 사용 권장
        // memberNo = loginUser.getMemberNo();

        paramMap.put("memberNo", memberNo);
        paramMap.put("period", period);
        paramMap.put("startDate", startDate);
        paramMap.put("endDate", endDate);

        int boardLimit = 10;
        int pageLimit = 10;

        // 이걸 해주는 이유는 전체 행의 수를 파악하여 페이지 처리를 해주기 위함
        // 10행이 카운트 됐으면 1페이지 11행이 카운트 됐으면 1,2 페이지 나누는 경우
        int listCount = mService.orderListCount(paramMap);

        PageInfo pi = Pagination
        		.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
        paramMap.put("pi", pi);

        List<Orders> list = mService.selectListOrder(paramMap);

        model.addAttribute("orderlist", list);
        model.addAttribute("pi", pi);

        return "mypage/purchase";
    }
    
    
    
    
    @GetMapping("/recent") 
    public String recentlyList(
    		@RequestParam(required = false) Integer memberNo,
    		@RequestParam(required = false) Integer period,
    		@RequestParam(required = false) @DateTimeFormat(pattern= "yyyy-MM-dd") Date startDate,
    		@RequestParam(required = false) @DateTimeFormat(pattern= "yyyy-MM-dd") Date endDate,
    		@RequestParam(value="cpage" , defaultValue = "1") int currentPage,
    		@RequestParam Map<String, Object> paramMap,
            Model model) {
		
    	  memberNo=1;
		  
    	  paramMap.put("memberNo", memberNo);
          paramMap.put("period", period);
          paramMap.put("startDate", startDate);
          paramMap.put("endDate", endDate);

          int boardLimit = 10;
          int pageLimit = 10;

          int listCount = mService.recentlyListCount(paramMap);

          PageInfo pi = Pagination
        		  .getPageInfo(listCount, currentPage, pageLimit, boardLimit);
          paramMap.put("pi", pi);

          List<RecentlyViewed> list = mService.selectListrecently(paramMap);

          model.addAttribute("recentlyList", list);
          model.addAttribute("pi", pi);
    	  
    	  
            return "mypage/recent";
    }
	
	@GetMapping("/inquiry")
	public String inquiryList(@RequestParam(required = false) Integer memberNo,
			Model model) {
		
		memberNo = 1;		
  	
		List<MyInqury> list = mService.inquiryList(memberNo);
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
