package com.kh.jipshop.admin.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.kh.jipshop.admin.model.vo.AdminCommentReport;
import com.kh.jipshop.common.model.vo.PageInfo;

public interface AdminCommentReportService {

    int selectReportListCount(HashMap<String, Object> paramMap);

    ArrayList<AdminCommentReport> selectReportList(PageInfo pi, HashMap<String, Object> paramMap);

    AdminCommentReport selectReportDetail(int reportId);

    int updateReportProcess(int reportId);

    int updateBulkReportProcess(List<Integer> reportIds);

    int deleteBulkReport(List<Integer> reportIds);
}