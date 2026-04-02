package com.kh.jipshop.mypage.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.common.template.Pagination;
import com.kh.jipshop.member.model.vo.Member;
import com.kh.jipshop.member.model.vo.Pet;
import com.kh.jipshop.mypage.model.dto.OrderDetailResponse;
import com.kh.jipshop.mypage.model.service.MypageService;
import com.kh.jipshop.mypage.model.vo.MyInqury;
import com.kh.jipshop.mypage.model.vo.Orders;
import com.kh.jipshop.security.model.vo.MemberExt;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/mypage")
@RequiredArgsConstructor
public class MypageController {

	private final MypageService mService;
	

	@GetMapping("/purchase")
	public String orderList(
			@RequestParam(required = false) Integer period,
			@RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
			@RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDate,
			@RequestParam(value = "cpage", defaultValue = "1") int currentPage,
			Authentication auth,
			@RequestParam Map<String, Object> paramMap, Model model) {

		/*
		 * @RequestParam Map<String,Object> - 클라이언트가 전달한 파라미터의 key, value값을 Map형태로 만들어
		 * 바인딩 - 현재메서드로 전달할 파라미터의 개수가 "정해지지 않은 경우" 혹은 일반적인 VO클래스로 바인딩되지 않는 경우
		 * 사용한다.(검색파라미터) - 반드시 @RequestParam을 추가해줘야 바인딩해준다.
		 */

		/*
		 * 업무로직 1. 페이징처리 1) 현재 요청한 게시판 코드와 검색정보와 일치하는 게시글의 "총 개수" 조회 2) 게시글 갯수, 페이지 번호,
		 * 기본 파라미터들을 추출하여 페이징정보를 가진 객체 생성 2. 현재 요청한 게시판 코드와 일치하면서, 현재 요청한 페이지에 맞는 게시글
		 * 정보를 조회 3. 게시글정보, 페이징정보, 검색정보를 담아서 forward
		 */

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
		Integer memberNo = ((MemberExt)auth.getPrincipal()).getMemberNo();
		String memberName = ((MemberExt)auth.getPrincipal()).getMemberName();
		// 실제로는 로그인 유저 번호 사용 권장
		// memberNo = loginUser.getMemberNo();

		paramMap.put("memberNo", memberNo);
		paramMap.put("period", period);
		paramMap.put("startDate", startDate);
		paramMap.put("endDate", endDate);

		int boardLimit = 6;
		int pageLimit = 10;

		// 이걸 해주는 이유는 전체 행의 수를 파악하여 페이지 처리를 해주기 위함
		// 10행이 카운트 됐으면 1페이지 11행이 카운트 됐으면 1,2 페이지 나누는 경우
		int listCount = mService.orderListCount(paramMap);

		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		paramMap.put("pi", pi);

		List<OrderDetailResponse> list = mService.selectListOrder(paramMap);

		model.addAttribute("orderlist", list);
		model.addAttribute("pi", pi);
		model.addAttribute("memberName", memberName);

		return "mypage/purchase";
	}

	@GetMapping("/recent")
	public String recentlyList(@RequestParam(required = false) Integer memberNo,
			@RequestParam(required = false) Integer period,
			@RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
			@RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDate,
			@RequestParam(value = "cpage", defaultValue = "1") int currentPage,
			Authentication auth,
			@RequestParam Map<String, Object> paramMap, Model model) {

		Integer memberNo2 = ((MemberExt)auth.getPrincipal()).getMemberNo();
		String memberName = ((MemberExt)auth.getPrincipal()).getMemberName();
		
		
		paramMap.put("memberNo", memberNo2);
		paramMap.put("period", period);
		paramMap.put("startDate", startDate);
		paramMap.put("endDate", endDate);

		int boardLimit = 6;
		int pageLimit = 10;

		int listCount = mService.recentlyListCount(paramMap);

		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		paramMap.put("pi", pi);

		List<OrderDetailResponse> list = mService.selectListrecently(paramMap);

		model.addAttribute("recentlyList", list);
		model.addAttribute("pi", pi);
		model.addAttribute("memberName", memberName);
		
		return "mypage/recent";
	}

	@GetMapping("/inquiry")
	public String inquiryList(@RequestParam(required = false) Integer memberNo,
			@RequestParam(value = "cpage", defaultValue = "1") int currentPage,
			@RequestParam Map<String, Object> paramMap, 
			Authentication auth,
			Model model) {

		Integer memberNo3 = ((MemberExt)auth.getPrincipal()).getMemberNo();
		String memberName = ((MemberExt)auth.getPrincipal()).getMemberName();

		paramMap.put("memberNo", memberNo3);

		int boardLimit = 6;
		int pageLimit = 10;

		int listCount = mService.inquiryListCount(paramMap);

		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		paramMap.put("pi", pi);

		List<MyInqury> list = mService.selectListinquiry(paramMap);

		model.addAttribute("inquiryList", list);
		model.addAttribute("pi", pi);
		model.addAttribute("memberName", memberName);
		
		return "mypage/inquiry";
	}

	@GetMapping("/inquirydetail")
	public String inquirydetail(@RequestParam(required = false) Integer inquiryId, Model model) {

		MyInqury mi = mService.inquiryDetail(inquiryId);
		model.addAttribute("myinquiry", mi);

		return "mypage/inquirydetail";
	}

	@PostMapping("/delete")
	public String delectInquiry(MyInqury mi, Model model) {

		int result = mService.delectInquiry(mi);

		model.addAttribute("myinquiry", mi);

		if (result == 0) {
			System.out.println("삭제 안됨");
		} else {
			System.out.println("삭제 완료");
		}

		return "redirect:/mypage/inquiry";

	}
		
	
	// 구매 취소 관련

	@GetMapping("/cancle")
	public String canclePage(
			@RequestParam("orderId") int orderId,
		    @RequestParam("detailId") int detailId,
	        Model model
	) {
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("orderId", orderId);
	    paramMap.put("detailId", detailId);

	    OrderDetailResponse od = mService.canclePage(paramMap);
	    model.addAttribute("orderList", od);

	    return "mypage/cancle";
	}

	@PostMapping("/cancle")
	public String canclePurchase(
	        @RequestParam("userPwd") String check,
	        @RequestParam("cancelReason") String cancelReason,
	        Orders orders,
	        Authentication auth
	) {

	    String password = ((MemberExt) auth.getPrincipal()).getPassword();
	    int memberNo = ((MemberExt) auth.getPrincipal()).getMemberNo();

	    orders.setMemberNo(memberNo);
	    orders.setCancelReason(cancelReason);

	    PasswordEncoder pe = new BCryptPasswordEncoder();
	    boolean ch = pe.matches(check, password);

	    if (!ch) {
	        return "redirect:/mypage/cancle?orderId="
	                + orders.getOrderId()
	                + "&detailId="
	                + orders.getDetailId();
	    }

	    int result = mService.requestCancel(orders);

	    if (result > 0) {
	        return "redirect:/mypage/purchase";
	    } else {
	        return "redirect:/mypage/cancle?orderId="
	                + orders.getOrderId()
	                + "&detailId="
	                + orders.getDetailId();
	    }
	}

	 
	 
// 회원 정보 수정	 
	 
	 @GetMapping("/checkMember") 
	 public String checkMember() {
		 
		 return "mypage/checkMember";
	 }
	 
	 
	@PostMapping("/checkMember")
	public String checkMember(
			@RequestParam("userPwd") String check,
			Authentication auth,
			Model model
			) {
		
		String password = ((MemberExt)auth.getPrincipal()).getPassword();
	     
	     
	     
	     // 암호화된 코드를 비교해 일치하는지 보는 코드
	     PasswordEncoder pe = new BCryptPasswordEncoder();
	     
	     boolean ch = pe.matches(check, password);
	     
	     
	     // memberName 가져오기
	     model.addAttribute("memberName",((MemberExt)auth.getPrincipal()).getMemberName());
	     model.addAttribute("memberEmail",((MemberExt)auth.getPrincipal()).getEmail());
	   
	     // 주소 나누기

	     model.addAttribute("phone",((MemberExt)auth.getPrincipal()).getPhone());
	     
	     
	     if(ch) {
	    	return "mypage/updateMember"; 
	     }else{
	    
	      model.addAttribute("errorMsg", "비밀번호가 틀렸습니다.");
    	  return "mypage/checkMember";
	    	 
	     }
	       	
	}

	@PostMapping("/updateMember")
	public String updateMember(
	        Member m,
	        RedirectAttributes ra,
	        Authentication auth,
	        Model model
	) {
	    m.setMemberNo(((MemberExt)auth.getPrincipal()).getMemberNo());

	    if (m.getEmail() == null || m.getEmail().trim().isEmpty()
	            || m.getMemberName() == null || m.getMemberName().trim().isEmpty()
	            || m.getAddress() == null || m.getAddress().trim().isEmpty()
	            || m.getPhone() == null || m.getPhone().trim().isEmpty()) {
	    	
	    	System.out.println(m.getAddress());
	    	
	        model.addAttribute("msg", "모든 정보를 입력해주세요.");
	        model.addAttribute("memberName", m.getMemberName());
	        model.addAttribute("memberEmail", m.getEmail());
	        model.addAttribute("phone", m.getPhone());
	        return "mypage/updateMember";
	    }

	    int result = mService.updateMember(m);

	    if (result > 0) {
	    	ra.addAttribute("msg","수정이 완료되었습니다.");
	        return "redirect:/mypage/purchase";
	        
	    } else {
	        model.addAttribute("msg", "수정에 실패했습니다.");
	        model.addAttribute("memberName", m.getMemberName());
	        model.addAttribute("memberEmail", m.getEmail());
	        model.addAttribute("phone", m.getPhone());
	        return "mypage/updateMember";
	    }
	}
	
	
	
// 반려동물 정보 수정	
	
	 @GetMapping("/checkPet")
	    public String checkPet() {
	        return "mypage/checkPet";
	    }

	    @PostMapping("/checkPet")
	    public String checkPet(String userPwd, Authentication auth, Model model) {

	        String password = ((MemberExt) auth.getPrincipal()).getPassword();
	        PasswordEncoder pe = new BCryptPasswordEncoder();

	        boolean ch = pe.matches(userPwd, password);

	        if (ch) {
	            int memberNo = ((MemberExt) auth.getPrincipal()).getMemberNo();

	            Pet pet = mService.selectPetByMemberNo(memberNo);
	            model.addAttribute("pet", pet);

	            return "mypage/updatePet";
	        } else {
	            model.addAttribute("errorMsg", "비밀번호를 다시 입력해주세요");
	            return "mypage/checkPet";
	        }
	    }

	    @PostMapping("/updatePet")
	    public String updatePet(Pet p,
	                            MultipartFile petPhotoFile,
	                            Authentication auth,
	                            HttpSession session,
	                            Model model) {

	        try {
	            int memberNo = ((MemberExt) auth.getPrincipal()).getMemberNo();
	            p.setMemberNo(memberNo);

	            if (petPhotoFile != null && !petPhotoFile.isEmpty()) {
	                String savePath = session.getServletContext().getRealPath("/resources/upload/pet/");

	                File folder = new File(savePath);
	                if (!folder.exists()) {
	                    folder.mkdirs();
	                }

	                String originName = petPhotoFile.getOriginalFilename();
	                String ext = "";

	                if (originName != null && originName.lastIndexOf(".") != -1) {
	                    ext = originName.substring(originName.lastIndexOf("."));
	                }

	                String time = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
	                int random = (int)(Math.random() * 90000 + 10000);
	                String changeName = time + random + ext;

	                petPhotoFile.transferTo(new File(savePath, changeName));
	                p.setPetPhoto("/resources/upload/pet/" + changeName);
	            }

	            int result = mService.saveOrUpdatePet(p);

	            if (result > 0) {
	                return "redirect:/mypage/checkPet";
	            } else {
	                model.addAttribute("errorMsg", "반려동물 정보 저장 실패");
	                model.addAttribute("pet", p);
	                return "mypage/updatePet";
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	            model.addAttribute("errorMsg", "서버 오류로 저장에 실패했습니다.");
	            model.addAttribute("pet", p);
	            return "mypage/updatePet";
	        }
	    }

	

	
	
// 회원 삭제 관련	
	
	@GetMapping("/memberDelete")
     public String memberDelete() {
		
		return "mypage/memberDelete";
	}
	
	@PostMapping("/memberDelete")
	public String memberDeleteOk(
			@RequestParam("userPwd") String check,
			Member m,
			Authentication auth,
			Model model,
		    HttpSession session
			) {
		 
		
		String password = ((MemberExt)auth.getPrincipal()).getPassword();
	     
	     
	     // post 형식 때문에 numberNo 를 받지 않았기 때문에 memberNo를 추가하는 코드
	     int numberNo = ((MemberExt)auth.getPrincipal()).getMemberNo();
	     m.setMemberNo(numberNo);
	     
	     
	     // 암호화된 코드를 비교해 일치하는지 보는 코드
	     PasswordEncoder pe = new BCryptPasswordEncoder();
	     
	     boolean ch = pe.matches(check, password);
	     
	   
	     
	     if(ch) {
	    	 int result = mService.memberDeleteOk(m);
	    	 
	    	 if(result!=0) {
	    		 
	    		 // 로그아웃후 홈으로
	    		 session.invalidate();
	    		 return "redirect:/";
	    		 
	    	 }else{
	    		
	 
	    		 model.addAttribute("errorMsg", "비밀번호가 틀렸습니다.");
	    		 return "mypage/memberDelete";
	    	 }
	    	 
	     } else {
	    	
	    	 model.addAttribute("errorMsg", "비밀번호가 틀렸습니다.");
	    	 return "mypage/memberDelete";
	   	 
	     	} 
	}
		
	
	
	// 배송 상세 관련

   @GetMapping("/orderDetail")
   public String orderDetail(
		   Model model,
		   Authentication auth,
		   @RequestParam int orderId,
		   @RequestParam int detailId,
		   @RequestParam Map<String,Object> paramMap
		   ) {
	   
	   int memberNo = ((MemberExt)auth.getPrincipal()).getMemberNo();
	   
	   paramMap.put("memberNo",memberNo);
	   paramMap.put("orderId",orderId);
	   paramMap.put("detailId",detailId);
	   
	   OrderDetailResponse od = mService.orderDetail(paramMap);
	   
	   model.addAttribute("od",od);
	   
	   
	   return "mypage/orderDetail";
	   
   }

}
