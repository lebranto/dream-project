package com.kh.jipshop.inquiry.model.service;

import java.util.ArrayList;

import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.inquiry.model.vo.Inquiry;

public interface InquiryService {

    int selectInquiryListCount();

    ArrayList<Inquiry> selectInquiryList(PageInfo pi);

    // 🔥 추가
    int insertInquiry(Inquiry inquiry);
}