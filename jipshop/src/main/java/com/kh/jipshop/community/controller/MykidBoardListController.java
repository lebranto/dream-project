package com.kh.jipshop.community.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.common.template.Pagination;
import com.kh.jipshop.community.model.service.CommunityService;
import com.kh.jipshop.community.model.vo.Board;

@Controller
public class MykidBoardListController {

    @Autowired
    private CommunityService communityService;

    @GetMapping("/community/myKidBoard")
    public String mykidBoardList(
            @RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
            @RequestParam(value = "searchType", defaultValue = "all") String searchType,
            @RequestParam(value = "keyword", defaultValue = "") String keyword,
            Model model) {

        int boardCode = 1; // 우리아이 자랑 게시판

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("boardCode", boardCode);
        paramMap.put("searchType", searchType);
        paramMap.put("keyword", keyword == null ? "" : keyword.trim());

        int listCount = communityService.selectBoardListCount(paramMap);
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);

        List<Board> boardList = communityService.selectBoardList(pi, paramMap);

        model.addAttribute("boardList", boardList);
        model.addAttribute("pi", pi);
        model.addAttribute("searchType", searchType);
        model.addAttribute("keyword", keyword);

        return "community/myKidBoard";
    }
}