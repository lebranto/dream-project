package com.kh.jipshop.inquiry.model.dao;

import java.util.ArrayList;

import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.inquiry.model.vo.Inquiry;

public interface InquiryDao {

    int selectInquiryListCount();

    ArrayList<Inquiry> selectInquiryList(PageInfo pi);

    // 🔥 추가 (문의 등록)
    int insertInquiry(Inquiry inquiry);
}