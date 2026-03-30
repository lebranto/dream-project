package com.kh.jipshop.admin.controller;

import java.time.LocalDate;
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
import com.kh.jipshop.mypage.model.vo.Orders;
import com.kh.jipshop.security.model.vo.MemberExt;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminDateSaleController {
	
	public final AdminDateSaleService aService;
	
	//월별 조회
	
	@GetMapping("/salesDaily")
	public String salesDaily(
			@RequestParam(required = false) Integer searchYear,
	        @RequestParam(required = false) Integer searchMonth,
			@RequestParam(value = "cpage", defaultValue = "1") int currentPage,
			Authentication auth,
			@RequestParam Map<String, Object> paramMap, 
			Model model
			) {
				
		   // 기본값: 현재 연/월
        LocalDate now = LocalDate.now();
        if (searchYear == null) {
            searchYear = now.getYear();
        }
        if (searchMonth == null) {
            searchMonth = now.getMonthValue();
        }

        // 월 시작일 / 다음달 시작일
        LocalDate startDate = LocalDate.of(searchYear, searchMonth, 1);
        LocalDate nextMonthStartDate = startDate.plusMonths(1);

        int boardLimit = 10;
        int pageLimit = 10;

        int offset = (currentPage - 1) * boardLimit + 1;
        int limit = currentPage * boardLimit;

        Integer memberNo = ((MemberExt) auth.getPrincipal()).getMemberNo();

        // mapper 실행 전에 전부 넣어야 함
        paramMap.put("memberNo", memberNo);
        paramMap.put("startDate", java.sql.Date.valueOf(startDate));
        paramMap.put("nextMonthStartDate", java.sql.Date.valueOf(nextMonthStartDate));
        paramMap.put("offset", offset);
        paramMap.put("limit", limit);

        int listCount = aService.monthListCount(paramMap);

        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);

        List<Orders> list = aService.selectListMonth(paramMap);
        
        
        int totalSales = aService.selectTotalMonth(paramMap);
        int totalOrderCount = aService.selectTotalCountMonth(paramMap);
        int totalFee = aService.totalFeeMonth(paramMap);  // 수수료  
        int totalDeposit = aService.totalDepositMonth(paramMap);  // 입금
        int totalpayable = aService.totalPayableMonth(paramMap);  // 지급 예정액
        
        model.addAttribute("orderlist", list);
        model.addAttribute("pi", pi);
        model.addAttribute("searchYear", searchYear);
        model.addAttribute("searchMonth", searchMonth);
        model.addAttribute("totalSales", totalSales);
        model.addAttribute("totalOrderCount", totalOrderCount);
        model.addAttribute("totalFee",totalFee);
        model.addAttribute("totalDeposit",totalDeposit);
        model.addAttribute("totalpayable",totalpayable);

        return "admin/salesDaily";
    }
		
	    
	
	
	
	// 일별 조회
	
	@GetMapping("/salesMonthly")
	public String salesMonthly(
			  @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
	            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDate,
			@RequestParam(value = "cpage", defaultValue = "1") int currentPage,
			Authentication auth,
			@RequestParam Map<String, Object> paramMap, 
			Model model
			) {
				

        int boardLimit = 10;
        int pageLimit = 10;

        int offset = (currentPage - 1) * boardLimit + 1;
        int limit = currentPage * boardLimit;

        paramMap.put("startDate", startDate);
        paramMap.put("endDate", endDate);
        paramMap.put("offset", offset);
        paramMap.put("limit", limit);
        	

        int listCount = aService.dateListCount(paramMap);

        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);

        List<Orders> list = aService.selectListDate(paramMap);
        
        int totalSales = aService.selectTotalDate(paramMap);
        int totalOrderCount = aService.selectTotalCountDate(paramMap);

        model.addAttribute("orderlist", list);
        model.addAttribute("pi", pi);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("totalSales", totalSales);
        model.addAttribute("totalOrderCount", totalOrderCount);

		return "admin/salesMonthly";
		
		
	     }
	
	

}
