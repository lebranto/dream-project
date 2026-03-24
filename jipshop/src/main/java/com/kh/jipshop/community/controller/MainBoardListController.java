package com.kh.jipshop.community.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.jipshop.community.model.service.CommunityService;
import com.kh.jipshop.community.model.vo.Board;

@Controller
public class MainBoardListController {

    @Autowired
    private CommunityService communityService;

    @GetMapping("/community/main")
    public String communityMain(String searchType, String keyword, Model model) {

        Map<String, String> paramMap = new HashMap<>();
        paramMap.put("searchType", searchType);
        paramMap.put("keyword", keyword);

        List<Board> popularBoardList = communityService.selectPopularBoardList(paramMap);
        List<Board> latestBoardList = communityService.selectLatestBoardList(paramMap);

        model.addAttribute("popularBoardList", popularBoardList);
        model.addAttribute("latestBoardList", latestBoardList);

        model.addAttribute("searchType", searchType);
        model.addAttribute("keyword", keyword);

        return "community/communityMain";
    }
}