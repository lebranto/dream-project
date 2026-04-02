package com.kh.jipshop.inquiry.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.inquiry.model.dao.InquiryDao;
import com.kh.jipshop.inquiry.model.vo.Inquiry;

@Service
public class InquiryServiceImpl implements InquiryService {

    @Autowired
    private InquiryDao inquiryDao;

    @Override
    public int selectInquiryListCount() {
        return inquiryDao.selectInquiryListCount();
    }

    @Override
    public ArrayList<Inquiry> selectInquiryList(PageInfo pi) {
        return inquiryDao.selectInquiryList(pi);
    }

    // 🔥 추가
    @Override
    public int insertInquiry(Inquiry inquiry) {
        return inquiryDao.insertInquiry(inquiry);
    }
}