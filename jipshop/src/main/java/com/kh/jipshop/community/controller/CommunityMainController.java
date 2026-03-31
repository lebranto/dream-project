package com.kh.jipshop.community.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.jipshop.community.model.service.CommunityService;
import com.kh.jipshop.community.model.vo.Board;
import com.kh.jipshop.community.model.vo.BoardComment;
import com.kh.jipshop.community.model.vo.BoardImage;
import com.kh.jipshop.community.model.vo.BoardLike;
import com.kh.jipshop.security.model.vo.MemberExt;

@Controller
@RequestMapping("/community")
public class CommunityMainController {

    @Autowired
    private CommunityService communityService;

    // 게시글 상세 + 조회수(작성자 제외 / 쿠키 중복 방지)
    @GetMapping("/detail")
    public String detail(@RequestParam("boardNo") int boardNo,
                         Model model,
                         Authentication auth,
                         HttpServletRequest request,
                         HttpServletResponse response) throws Exception {

        // 1. 게시글 먼저 조회
        Board board = communityService.selectBoard(boardNo);

        if (board == null) {
            return "redirect:/community/main";
        }

        // 2. 로그인 회원번호 확인
        int loginMemberNo = 0;

        if (auth != null && auth.isAuthenticated() && auth.getPrincipal() instanceof MemberExt) {
            MemberExt loginUser = (MemberExt) auth.getPrincipal();
            loginMemberNo = loginUser.getMemberNo();
        }

        // 3. 작성자 여부 확인
        boolean isWriter = (loginMemberNo > 0 && board.getMemberNo() == loginMemberNo);

        // 4. 작성자가 아니면 쿠키 확인 후 조회수 증가
        if (!isWriter) {

            Cookie[] cookies = request.getCookies();
            Cookie readBoardCookie = null;

            if (cookies != null) {
                for (Cookie c : cookies) {
                    if ("readBoardNo".equals(c.getName())) {
                        readBoardCookie = c;
                        break;
                    }
                }
            }

            boolean alreadyRead = false;

            if (readBoardCookie != null) {
                String cookieValue = URLDecoder.decode(readBoardCookie.getValue(), "UTF-8");

                if (cookieValue.contains("|" + boardNo + "|")) {
                    alreadyRead = true;
                }
            }

            // 5. 처음 보는 글이면 조회수 증가 + 쿠키 저장
            if (!alreadyRead) {
                int result = communityService.increaseReadCount(boardNo);

                if (result > 0) {
                    board.setReadCount(board.getReadCount() + 1);
                }

                String newValue = "";

                if (readBoardCookie != null) {
                    newValue = URLDecoder.decode(readBoardCookie.getValue(), "UTF-8");
                }

                newValue += "|" + boardNo + "|";

                Cookie newCookie = new Cookie("readBoardNo", URLEncoder.encode(newValue, "UTF-8"));
                newCookie.setPath(request.getContextPath());
                newCookie.setMaxAge(60 * 60 * 24); // 1일

                response.addCookie(newCookie);
            }
        }

        // 6. 나머지 상세 데이터 조회
        List<BoardImage> imageList = communityService.selectBoardImageList(boardNo);
        List<BoardComment> commentList = communityService.selectCommentList(boardNo);

        int likeCount = communityService.selectLikeCount(boardNo);
        int likeCheck = 0;

        if (loginMemberNo > 0) {
            BoardLike boardLike = new BoardLike();
            boardLike.setBoardNo(boardNo);
            boardLike.setMemberNo(loginMemberNo);
            boardLike.setLikeType("L");

            likeCheck = communityService.checkBoardLike(boardLike);
        }

        model.addAttribute("board", board);
        model.addAttribute("imageList", imageList);
        model.addAttribute("commentList", commentList);
        model.addAttribute("likeCount", likeCount);
        model.addAttribute("likeCheck", likeCheck);
        model.addAttribute("loginMemberNo", loginMemberNo);

        return "community/boardDetail";
    }

    // 좋아요
    @ResponseBody
    @PostMapping(value="/like", produces="application/json; charset=UTF-8")
    public String boardLike(@RequestParam("boardNo") int boardNo, Authentication auth) {

        if (auth == null || !auth.isAuthenticated() || !(auth.getPrincipal() instanceof MemberExt)) {
            return "{\"result\":\"loginRequired\"}";
        }

        MemberExt loginUser = (MemberExt) auth.getPrincipal();

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

    // 댓글 등록
    @PostMapping("/insertComment")
    public String insertComment(@RequestParam("boardNo") int boardNo,
                                @RequestParam("commentContent") String commentContent,
                                Authentication auth) {

        if (auth == null || !auth.isAuthenticated() || !(auth.getPrincipal() instanceof MemberExt)) {
            return "redirect:/member/login";
        }

        MemberExt loginUser = (MemberExt) auth.getPrincipal();

        if (commentContent == null || commentContent.trim().isEmpty()) {
            return "redirect:/community/detail?boardNo=" + boardNo;
        }

        BoardComment comment = new BoardComment();
        comment.setBoardNo(boardNo);
        comment.setMemberNo(loginUser.getMemberNo());
        comment.setCommentContent(commentContent.trim());

        int result = communityService.insertComment(comment);

        return "redirect:/community/detail?boardNo=" + boardNo;
    }

    // 댓글 신고
    @PostMapping("/reportComment")
    public String reportComment(@RequestParam(value = "commentId", required = false) Integer commentId,
                                @RequestParam(value = "reportTypeId", required = false) Integer reportTypeId,
                                @RequestParam(value = "reportReason", required = false) String reportReason,
                                @RequestParam("boardNo") int boardNo,
                                Authentication auth,
                                RedirectAttributes ra) {

    	 if (auth == null || !auth.isAuthenticated() || !(auth.getPrincipal() instanceof MemberExt)) {
    	        ra.addFlashAttribute("alertMsg", "로그인 후 사용 가능합니다.");
    	        return "redirect:/member/login";
    	    }

        if (commentId == null) {
            ra.addFlashAttribute("alertMsg", "신고 대상 댓글 정보가 없습니다.");
            return "redirect:/community/detail?boardNo=" + boardNo;
        }

        if (reportTypeId == null) {
            ra.addFlashAttribute("alertMsg", "신고 유형을 선택해주세요.");
            return "redirect:/community/detail?boardNo=" + boardNo;
        }

        MemberExt loginUser = (MemberExt) auth.getPrincipal();

        HashMap<String, Object> paramMap = new HashMap<>();
        paramMap.put("reporterMemberNo", loginUser.getMemberNo());
        paramMap.put("commentId", commentId);
        paramMap.put("reportTypeId", reportTypeId);
        paramMap.put("reportReason", reportReason);

        int result = communityService.insertCommentReport(paramMap);

        if (result > 0) {
            ra.addFlashAttribute("alertMsg", "신고되었습니다.");
        } else {
            ra.addFlashAttribute("alertMsg", "신고에 실패했습니다.");
        }

        return "redirect:/community/detail?boardNo=" + boardNo;
    }
}