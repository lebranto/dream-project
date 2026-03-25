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
public class TipBoardListController {

    @Autowired
    private CommunityService communityService;

    @GetMapping("/community/tipFreeBoard")
    public String boardList(
            @RequestParam(value = "boardType", defaultValue = "tip") String boardType,
            @RequestParam(value = "searchType", defaultValue = "all") String searchType,
            @RequestParam(value = "keyword", defaultValue = "") String keyword,
            Model model) {

        int boardCode = 2; // tip

        if ("free".equals(boardType)) {
            boardCode = 3;
        }

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
        model.addAttribute("boardType", boardType);
        model.addAttribute("searchType", searchType);
        model.addAttribute("keyword", keyword);

        if ("tip".equals(boardType)) {
            model.addAttribute("boardTypeName", "육아 꿀팁 게시판");
        } else if ("free".equals(boardType)) {
            model.addAttribute("boardTypeName", "자유 게시판");
        } else {
            model.addAttribute("boardTypeName", "게시판");
        }

        return "community/tipFreeBoard";
    }
}