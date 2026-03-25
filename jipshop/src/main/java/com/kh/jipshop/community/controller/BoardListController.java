package com.kh.jipshop.community.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.jipshop.community.model.service.CommunityService;
import com.kh.jipshop.community.model.vo.Board;
import com.kh.jipshop.community.model.vo.BoardImage;
import com.kh.jipshop.security.model.vo.MemberExt;

@Controller
@RequestMapping("/community")
public class BoardListController {

    @Autowired
    private CommunityService boardService;

    @GetMapping("/writeBoard")
    public String writeBoard() {
        return "community/writeBoard";
    }

    @PostMapping("/insertBoard")
    public String insertBoard(
            @RequestParam("boardCode") int boardCode,
            @RequestParam(value="categoryCode", required=false, defaultValue="0") int categoryCode,
            @RequestParam("boardTitle") String boardTitle,
            @RequestParam("boardContent") String boardContent,
            @RequestParam(value="imageFiles", required=false) List<MultipartFile> imageFiles,
            Authentication auth,
            HttpSession session) {

        System.out.println("🔥 insertBoard 들어옴");

        MemberExt loginUser = (MemberExt) auth.getPrincipal();

        System.out.println("loginUser = " + loginUser);
        System.out.println("memberNo = " + loginUser.getMemberNo());

        Board board = new Board();
        board.setMemberNo(loginUser.getMemberNo());
        board.setBoardCode(boardCode);
        board.setCategoryCode(categoryCode);
        board.setBoardTitle(boardTitle);
        board.setBoardContent(boardContent);

        int result = boardService.insertBoard(board);

        if (result <= 0) {
            return "redirect:/community/writeBoard";
        }

        int boardNo = board.getBoardNo();
        saveBoardImages(boardNo, imageFiles, session);

        return "redirect:/community/main";
    }

    @GetMapping("/rewrite")
    public String rewriteForm(@RequestParam("boardNo") int boardNo,
                              Model model,
                              Authentication auth) {

        if (auth == null || !auth.isAuthenticated() || !(auth.getPrincipal() instanceof MemberExt)) {
            return "redirect:/member/login";
        }

        MemberExt loginUser = (MemberExt) auth.getPrincipal();

        Board board = boardService.selectBoard(boardNo);

        if (board == null) {
            return "redirect:/community/main";
        }

        if (board.getMemberNo() != loginUser.getMemberNo()) {
            return "redirect:/community/detail?boardNo=" + boardNo;
        }

        List<BoardImage> imageList = boardService.selectBoardImageList(boardNo);

        model.addAttribute("board", board);
        model.addAttribute("imageList", imageList);

        return "community/rewrite";
    }

    @PostMapping("/rewrite")
    public String rewrite(Board board,
                          @RequestParam(value = "categoryCode", required = false, defaultValue = "0") int categoryCode,
                          @RequestParam(value = "imageFiles", required = false) List<MultipartFile> imageFiles,
                          @RequestParam(value = "deleteImageNos", required = false) List<Integer> deleteImageNos,
                          Authentication auth,
                          HttpSession session) {

        if (auth == null || !auth.isAuthenticated() || !(auth.getPrincipal() instanceof MemberExt)) {
            return "redirect:/member/login";
        }

        MemberExt loginUser = (MemberExt) auth.getPrincipal();

        Board originBoard = boardService.selectBoard(board.getBoardNo());
        if (originBoard == null) {
            return "redirect:/community/main";
        }

        if (originBoard.getMemberNo() != loginUser.getMemberNo()) {
            return "redirect:/community/detail?boardNo=" + board.getBoardNo();
        }

        board.setMemberNo(loginUser.getMemberNo());
        board.setCategoryCode(categoryCode);

        int updateResult = boardService.updateBoard(board);

        if (updateResult <= 0) {
            return "redirect:/community/rewrite?boardNo=" + board.getBoardNo();
        }

        if (deleteImageNos != null && !deleteImageNos.isEmpty()) {
            boardService.deleteBoardImageList(deleteImageNos);
        }

        saveBoardImages(board.getBoardNo(), imageFiles, session);

        return "redirect:/community/detail?boardNo=" + board.getBoardNo();
    }
    
    @GetMapping("/delete")
    public String deleteBoard(@RequestParam("boardNo") int boardNo,
                              Authentication auth) {

        if (auth == null || !auth.isAuthenticated() || !(auth.getPrincipal() instanceof MemberExt)) {
            return "redirect:/member/login";
        }

        MemberExt loginUser = (MemberExt) auth.getPrincipal();

        Board originBoard = boardService.selectBoard(boardNo);
        if (originBoard == null) {
            return "redirect:/community/main";
        }

        // 작성자 본인만 삭제 가능
        if (originBoard.getMemberNo() != loginUser.getMemberNo()) {
            return "redirect:/community/detail?boardNo=" + boardNo;
        }

        Board board = new Board();
        board.setBoardNo(boardNo);
        board.setMemberNo(loginUser.getMemberNo());

        int result = boardService.deleteBoard(board);

        if (result <= 0) {
            return "redirect:/community/detail?boardNo=" + boardNo;
        }

        return "redirect:/community/main";
    }
    private void saveBoardImages(int boardNo, List<MultipartFile> imageFiles, HttpSession session) {

        if (imageFiles == null || imageFiles.isEmpty()) {
            return;
        }

        String filePath = "/resources/uploadFiles/";
        String savePath = session.getServletContext().getRealPath(filePath);

        File folder = new File(savePath);
        if (!folder.exists()) {
            folder.mkdirs();
        }

        int level = 1;

        for (MultipartFile file : imageFiles) {

            if (file == null || file.isEmpty()) {
                continue;
            }

            String originName = file.getOriginalFilename();
            String changeName = changeFileName(originName);

            try {
                File dest = new File(savePath + File.separator + changeName);
                file.transferTo(dest);

                BoardImage img = new BoardImage();
                img.setBoardNo(boardNo);
                img.setOriginName(originName);
                img.setChangeName(changeName);
                img.setFilePath(filePath);
                img.setFileLevel(level++);

                boardService.insertBoardImage(img);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private String changeFileName(String originName) {
        String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        String uuid = UUID.randomUUID().toString().replace("-", "");

        int dotIndex = originName.lastIndexOf(".");
        String ext = "";

        if (dotIndex != -1) {
            ext = originName.substring(dotIndex);
        }

        return currentTime + "_" + uuid + ext;
    }
   
}