package com.kh.jipshop.community.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
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
import com.kh.jipshop.member.model.vo.Member;

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
            @RequestParam("categoryCode") int categoryCode,
            @RequestParam("boardTitle") String boardTitle,
            @RequestParam("boardContent") String boardContent,
            @RequestParam(value = "imageFiles", required = false) List<MultipartFile> imageFiles,
            HttpSession session) {

        Member loginUser = (Member) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/member/login";
        }

        Board board = new Board();
        board.setMemberNo(loginUser.getMemberNo());
        board.setBoardCode(boardCode);
        board.setCategoryCode(categoryCode);
        board.setBoardTitle(boardTitle);
        board.setBoardContent(boardContent);

        int result = boardService.insertBoard(board);

        if (result > 0) {

            // ⭐ 중요: 방금 생성된 boardNo 가져와야 함
            int boardNo = board.getBoardNo();

            if (imageFiles != null) {
                int level = 1;

                for (MultipartFile file : imageFiles) {

                    if (!file.isEmpty()) {

                        String originName = file.getOriginalFilename();
                        String changeName = System.currentTimeMillis() + "_" + originName;

                        String filePath = "/resources/uploadFiles/";

                        // 실제 파일 저장
                        try {
                            file.transferTo(new File(
                                    session.getServletContext().getRealPath(filePath) + changeName
                            ));
                        } catch (Exception e) {
                            e.printStackTrace();
                        }

                        BoardImage img = new BoardImage();
                        img.setBoardNo(boardNo);
                        img.setOriginName(originName);
                        img.setChangeName(changeName);
                        img.setFilePath(filePath);
                        img.setFileLevel(level++);

                        boardService.insertBoardImage(img);
                    }
                }
            }

            return "redirect:/community/main";

        } else {
            return "redirect:/community/writeBoard";
        }
    }
    @GetMapping("/rewrite")
    public String rewriteForm(@RequestParam("boardNo") int boardNo,
                              Model model,
                              HttpSession session) {

        Member loginUser = (Member) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/member/login";
        }

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
                          @RequestParam(value = "imageFiles", required = false) List<MultipartFile> imageFiles,
                          @RequestParam(value = "deleteImageNos", required = false) List<Integer> deleteImageNos,
                          HttpSession session) {

        Member loginUser = (Member) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/member/login";
        }

        board.setMemberNo(loginUser.getMemberNo());

        int updateResult = boardService.updateBoard(board);

        if (updateResult <= 0) {
            return "redirect:/community/rewrite?boardNo=" + board.getBoardNo();
        }

        if (deleteImageNos != null && !deleteImageNos.isEmpty()) {
            boardService.deleteBoardImageList(deleteImageNos);
        }

        if (imageFiles != null && !imageFiles.isEmpty()) {

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
                String changeName = System.currentTimeMillis() + "_" + originName;

                try {
                    file.transferTo(new File(savePath + File.separator + changeName));

                    BoardImage img = new BoardImage();
                    img.setBoardNo(board.getBoardNo());
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

        return "redirect:/community/detail?boardNo=" + board.getBoardNo();
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