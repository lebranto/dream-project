package com.kh.jipshop.community.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.jipshop.community.model.service.CommunityService;
import com.kh.jipshop.community.model.vo.Board;

@Controller
public class MykidBoardListController {

    @Autowired
    private CommunityService communityService;

    @GetMapping("/community/myKidBoard")
    public String mykidBoardList(
            @RequestParam(value = "searchType", defaultValue = "all") String searchType,
            @RequestParam(value = "keyword", defaultValue = "") String keyword,
            Model model) {

        int boardCode = 1; // 우리아이 게시판
        List<Board> boardList;

        if (keyword != null && !keyword.trim().isEmpty()) {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("boardCode", boardCode);
            paramMap.put("searchType", searchType);
            paramMap.put("keyword", keyword.trim());

            boardList = communityService.selectBoardListBySearch(paramMap);
        } else {
            boardList = communityService.selectBoardListByBoardCode(boardCode);
        }

        model.addAttribute("boardList", boardList);
        model.addAttribute("searchType", searchType);
        model.addAttribute("keyword", keyword);

        return "community/myKidBoard";
    }
}