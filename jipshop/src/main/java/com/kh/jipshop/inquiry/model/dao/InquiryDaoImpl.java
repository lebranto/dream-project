package com.kh.jipshop.inquiry.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.inquiry.model.vo.Inquiry;

@Repository
public class InquiryDaoImpl implements InquiryDao {

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public int selectInquiryListCount() {
        return sqlSession.selectOne("inquiryMapper.selectInquiryListCount");
    }

    @Override
    public ArrayList<Inquiry> selectInquiryList(PageInfo pi) {

        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        int limit = pi.getBoardLimit();

        RowBounds rowBounds = new RowBounds(offset, limit);

        List<Inquiry> list = sqlSession.selectList("inquiryMapper.selectInquiryList", null, rowBounds);

        return new ArrayList<>(list);
    }
}