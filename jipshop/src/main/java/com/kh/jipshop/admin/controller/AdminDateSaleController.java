package com.kh.jipshop.admin.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.jipshop.admin.model.service.AdminDateSaleService;
import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.common.template.Pagination;
import com.kh.jipshop.mypage.model.dto.OrderDetailResponse;
import com.kh.jipshop.security.model.vo.MemberExt;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminDateSaleController {
	
	public final AdminDateSaleService aService;
	
	
	@GetMapping("/salesDaily")
	public String salesDaily(
			@RequestParam(required = false) Integer period,
			@RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
			@RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDate,
			@RequestParam(value = "cpage", defaultValue = "1") int currentPage,
			Authentication auth,
			@RequestParam Map<String, Object> paramMap, 
			Model model
			) {
		    // 테스트용
				Integer memberNo = ((MemberExt)auth.getPrincipal()).getMemberNo();
				String memberName = ((MemberExt)auth.getPrincipal()).getMemberName();
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
				int listCount = aService.salesListCount(paramMap);

				PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
				paramMap.put("pi", pi);

				List<OrderDetailResponse> list = aService.selectListSales(paramMap);

				model.addAttribute("orderlist", list);
				model.addAttribute("pi", pi);
				model.addAttribute("memberName", memberName);

				return "admin/salesDaily/salesDaily";
		
		
	     }
	

}
