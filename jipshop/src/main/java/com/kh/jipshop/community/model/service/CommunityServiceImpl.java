package com.kh.jipshop.community.model.service;



import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.jipshop.community.model.dao.CommunityDao;
import com.kh.jipshop.community.model.vo.Board;
import com.kh.jipshop.community.model.vo.BoardComment;
import com.kh.jipshop.community.model.vo.BoardImage;
import com.kh.jipshop.community.model.vo.BoardLike;



@Service
public class CommunityServiceImpl implements CommunityService {

    @Autowired
    private CommunityDao communityDao;

    @Autowired
    private SqlSessionTemplate sqlSession;
    
    @Override
    public Board selectBoard(int boardNo) {
        return communityDao.selectBoard(boardNo);
    }

    @Override
    public List<BoardImage> selectBoardImageList(int boardNo) {
        return communityDao.selectBoardImageList(boardNo);
    }

    @Override
    public List<BoardComment> selectCommentList(int boardNo) {
        return communityDao.selectCommentList(boardNo);
    }   

	  @Override
	    public int insertBoard(Board board) {
	        return communityDao.insertBoard(sqlSession, board);
	    
	}

	    @Override
	    public List<Board> selectPopularBoardList(Map<String, String> paramMap) {
	        return communityDao.selectPopularBoardList(sqlSession, paramMap);
	    }

	    @Override
	    public List<Board> selectLatestBoardList(Map<String, String> paramMap) {
	        return communityDao.selectLatestBoardList(sqlSession, paramMap);
	    }

	  @Override
	  public List<Board> selectBoardListByBoardCode(int boardCode) {
	      return communityDao.selectBoardListByBoardCode(boardCode);
	  }
	  @Override
	    public int updateBoard(Board board) {
	        return communityDao.updateBoard(sqlSession, board);
	    }

	    @Override
	    public int deleteBoardImageList(List<Integer> deleteImageNos) {
	        if (deleteImageNos == null || deleteImageNos.isEmpty()) {
	            return 0;
	        }
	        return communityDao.deleteBoardImageList(sqlSession, deleteImageNos);
	    }

	    @Override
	    public int insertBoardImage(BoardImage boardImage) {
	        return communityDao.insertBoardImage(sqlSession, boardImage);
	    }

	    @Override
	    public int selectBoardImageCount(int boardNo) {
	        return communityDao.selectBoardImageCount(sqlSession, boardNo);
	    }

	    @Override
	    public int increaseReadCount(int boardNo) {
	        return communityDao.increaseReadCount(sqlSession, boardNo);
	    }

	    @Override
	    public int checkBoardLike(BoardLike boardLike) {
	        return communityDao.checkBoardLike(sqlSession, boardLike);
	    }

	    @Override
	    public int insertBoardLike(BoardLike boardLike) {
	        return communityDao.insertBoardLike(sqlSession, boardLike);
	    }

	    @Override
	    public int deleteBoardLike(BoardLike boardLike) {
	        return communityDao.deleteBoardLike(sqlSession, boardLike);
	    }

	    @Override
	    public int selectLikeCount(int boardNo) {
	        return communityDao.selectLikeCount(sqlSession, boardNo);
	    }

	    @Override
	    public List<Board> selectBoardListBySearch(Map<String, Object> paramMap) {
	        return communityDao.selectBoardListBySearch(sqlSession, paramMap);
	    }
}