package com.kh.jipshop.community.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.jipshop.community.model.vo.Board;
import com.kh.jipshop.community.model.vo.BoardComment;
import com.kh.jipshop.community.model.vo.BoardImage;
import com.kh.jipshop.community.model.vo.BoardLike;


public interface CommunityDao {

    Board selectBoard(int boardNo);

    List<BoardImage> selectBoardImageList(int boardNo);

    List<BoardComment> selectCommentList(int boardNo);

	int insertBoard(SqlSessionTemplate sqlSession, Board board);

	  List<Board> selectPopularBoardList(SqlSessionTemplate sqlSession, Map<String, String> paramMap);

	    List<Board> selectLatestBoardList(SqlSessionTemplate sqlSession, Map<String, String> paramMap);

	    List<Board> selectBoardListByBoardCode(int boardCode);

	int updateBoard(SqlSessionTemplate sqlSession, Board board);

	int deleteBoardImageList(SqlSessionTemplate sqlSession, List<Integer> deleteImageNos);

	int insertBoardImage(SqlSessionTemplate sqlSession, BoardImage boardImage);

	int selectBoardImageCount(SqlSessionTemplate sqlSession, int boardNo);

	int increaseReadCount(SqlSessionTemplate sqlSession, int boardNo);

	int checkBoardLike(SqlSessionTemplate sqlSession, BoardLike boardLike);

	int insertBoardLike(SqlSessionTemplate sqlSession, BoardLike boardLike);

	int deleteBoardLike(SqlSessionTemplate sqlSession, BoardLike boardLike);

	int selectLikeCount(SqlSessionTemplate sqlSession, int boardNo);

	List<Board> selectBoardListBySearch(SqlSessionTemplate sqlSession, Map<String, Object> paramMap);

	int deleteBoard(SqlSessionTemplate sqlSession, Board board);

	int insertComment(SqlSessionTemplate sqlSession, BoardComment comment);

	int insertCommentReport(SqlSessionTemplate sqlSession, int reporterMemberNo, int commentId);
}
