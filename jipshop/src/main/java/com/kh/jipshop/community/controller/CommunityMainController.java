package com.kh.jipshop.community.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.jipshop.community.model.service.CommunityService;
import com.kh.jipshop.community.model.vo.Board;
import com.kh.jipshop.community.model.vo.BoardComment;
import com.kh.jipshop.community.model.vo.BoardImage;
import com.kh.jipshop.community.model.vo.BoardLike;
import com.kh.jipshop.member.model.vo.Member;

@Controller
@RequestMapping("/community")
public class CommunityMainController {

    @Autowired
    private CommunityService communityService;

    @GetMapping("/detail")
    public String detail(@RequestParam("boardNo") int boardNo, Model model, HttpSession session) {

        communityService.increaseReadCount(boardNo);

        Board board = communityService.selectBoard(boardNo);
        List<BoardImage> imageList = communityService.selectBoardImageList(boardNo);
        List<BoardComment> commentList = communityService.selectCommentList(boardNo);

        int likeCount = communityService.selectLikeCount(boardNo);

        Member loginUser = (Member) session.getAttribute("loginUser");
        int likeCheck = 0;

        if(loginUser != null) {
            BoardLike boardLike = new BoardLike();
            boardLike.setBoardNo(boardNo);
            boardLike.setMemberNo(loginUser.getMemberNo());
            boardLike.setLikeType("L");

            likeCheck = communityService.checkBoardLike(boardLike);
        }

        model.addAttribute("board", board);
        model.addAttribute("imageList", imageList);
        model.addAttribute("commentList", commentList);
        model.addAttribute("likeCount", likeCount);
        model.addAttribute("likeCheck", likeCheck);

        return "community/boardDetail";
    }

    @ResponseBody
    @PostMapping(value="/like", produces="application/json; charset=UTF-8")
    public String boardLike(@RequestParam("boardNo") int boardNo, HttpSession session) {

        Member loginUser = (Member) session.getAttribute("loginUser");

        if(loginUser == null) {
            return "{\"result\":\"loginRequired\"}";
        }

        BoardLike boardLike = new BoardLike();
        boardLike.setBoardNo(boardNo);
        boardLike.setMemberNo(loginUser.getMemberNo());
        boardLike.setLikeType("L");

        int checkResult = communityService.checkBoardLike(boardLike);
        int result = 0;

        if(checkResult > 0) {
            result = communityService.deleteBoardLike(boardLike);
        } else {
            result = communityService.insertBoardLike(boardLike);
        }

        int likeCount = communityService.selectLikeCount(boardNo);
        int likeCheck = communityService.checkBoardLike(boardLike);

        return "{\"result\":\"success\", \"updateResult\":\"" + result + "\", \"likeCount\":\"" + likeCount + "\", \"likeCheck\":\"" + likeCheck + "\"}";
    }
}