package com.kh.jipshop.community.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.community.model.vo.Board;
import com.kh.jipshop.community.model.vo.BoardComment;
import com.kh.jipshop.community.model.vo.BoardImage;
import com.kh.jipshop.community.model.vo.BoardLike;

public interface CommunityService {


	    Board selectBoard(int boardNo);

	    List<BoardImage> selectBoardImageList(int boardNo);

	    List<BoardComment> selectCommentList(int boardNo);

		int insertBoard(Board board);

		 List<Board> selectLatestBoardList(Map<String, String> paramMap);

		    List<Board> selectPopularBoardList(Map<String, String> paramMap);

		    List<Board> selectBoardListByBoardCode(int boardCode);

		int updateBoard(Board board);

		int deleteBoardImageList(List<Integer> deleteImageNos);

		int selectBoardImageCount(int boardNo);

		int insertBoardImage(BoardImage boardImage);

		int checkBoardLike(BoardLike boardLike);

		int deleteBoardLike(BoardLike boardLike);

		int insertBoardLike(BoardLike boardLike);

		int selectLikeCount(int boardNo);

		int increaseReadCount(int boardNo);

		List<Board> selectBoardListBySearch(Map<String, Object> paramMap);

		int deleteBoard(Board board);

		int insertComment(BoardComment comment);

		int insertCommentReport(int memberNo, int commentId);

		int selectBoardListCount(Map<String, Object> paramMap);

		List <Board> selectBoardList(PageInfo pi, Map<String, Object> paramMap);

		int insertCommentReport(HashMap<String, Object> paramMap);
		
	
}
