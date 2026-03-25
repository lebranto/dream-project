package com.kh.jipshop.inquiry;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/inquiry")
public class InquiryController {

    // 메모리 저장용 문의 리스트
    private static final List<InquiryDTO> inquiryStorage = new ArrayList<>();

    // 문의 번호 증가용
    private static int nextInquiryNo = 1;

    @RequestMapping("/list")
    public String inquiryList(
            @RequestParam(value = "page", defaultValue = "1") int currentPage,
            Model model) {

        List<InquiryDTO> allInquiryList = new ArrayList<>(inquiryStorage);

        // 최신 글이 위로 오게 뒤집기
        Collections.reverse(allInquiryList);

        int listCount = allInquiryList.size();
        int boardLimit = 6;
        int pageLimit = 5;

        int maxPage = (int) Math.ceil((double) listCount / boardLimit);

        if (maxPage == 0) {
            maxPage = 1;
        }

        if (currentPage < 1) {
            currentPage = 1;
        }
        if (currentPage > maxPage) {
            currentPage = maxPage;
        }

        int startPage = ((currentPage - 1) / pageLimit) * pageLimit + 1;
        int endPage = startPage + pageLimit - 1;

        if (endPage > maxPage) {
            endPage = maxPage;
        }

        int startIndex = (currentPage - 1) * boardLimit;
        int endIndex = Math.min(startIndex + boardLimit, listCount);

        List<InquiryDTO> pageList = new ArrayList<>();
        if (listCount > 0) {
            pageList = allInquiryList.subList(startIndex, endIndex);
        }

        model.addAttribute("inquiryList", pageList);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("maxPage", maxPage);

        return "inquiryList";
    }

    @RequestMapping(value = "/write", method = RequestMethod.GET)
    public String inquiryWriteForm() {
        return "inquiryWrite";
    }

    @RequestMapping(value = "/write", method = RequestMethod.POST)
    public String inquiryWriteSubmit(InquiryWriteDTO inquiryWriteDTO) {

        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        InquiryDTO inquiry = new InquiryDTO();
        inquiry.setInquiryNo(nextInquiryNo++);
        inquiry.setTitle(inquiryWriteDTO.getCategory());
        inquiry.setContent(inquiryWriteDTO.getContent());
        inquiry.setEnrollDate(today);
        inquiry.setAnswerStatus("답변 대기");

        inquiryStorage.add(inquiry);

        return "redirect:/inquiry/list";
    }
}