package com.spring.usMarket.service.admin;

import java.util.List;
import java.util.Map;

import com.spring.usMarket.domain.admin.QnaReplyInsertDto;
import com.spring.usMarket.domain.admin.ReportHistoryDto;
import com.spring.usMarket.utils.AdminSearchCondition;

public interface AdminService {
	// home
	Map<String, Object> getAdmin(String admin_id, String admin_password) throws Exception;
	
	
	// member
	List<Map<String, Object>> getMemberStatsByDate(String startDate, String endDate) throws Exception;
	List<Map<String, Object>> getMemberStatsByMonth(String startDate, String endDate) throws Exception;
	List<Map<String, Object>> getMemberList(AdminSearchCondition sc) throws Exception;
	int getMemberCnt(String startDate, String endDate, String condition) throws Exception;
	Map<String, Object> getMemberInfo(AdminSearchCondition sc) throws Exception;
	List<Map<String, Object>> getMemberProductList(AdminSearchCondition sc) throws Exception;
	int getMemberProductCnt(String member_no, String condition) throws Exception;
	
	
	// deal
	List<Map<String, Object>> getDealStatsByDate(String startDate, String endDate) throws Exception;
	List<Map<String, Object>> getDealStatsByMonth(String startDate, String endDate) throws Exception;
	List<Map<String, Object>> getDealList(AdminSearchCondition sc) throws Exception;
	int getDealCnt(String startDate, String endDate, String condition) throws Exception;
	Map<String, Object> getDealInfo(String deal_no) throws Exception;
	Map<String, Object> getReviewInfo(String deal_no) throws Exception;
	
	// report
	List<Map<String, Object>> getReportList(AdminSearchCondition sc) throws Exception;
	int getReportCnt(String condition, String complete) throws Exception;
	Map<String, Object> getReportInfo(String report_no) throws Exception;
	List<Map<String, Object>> getChatLog(String room_no) throws Exception;
	String getReportEndDate(String member_no) throws Exception;
	int addReportHistory(ReportHistoryDto dto) throws Exception;
	Map<String, Object> getReportHistory(String report_no) throws Exception;
	
	// qna
	List<Map<String, Object>> getQnaList(AdminSearchCondition sc) throws Exception;
	int getQnaCnt(String condition) throws Exception;
	Map<String, Object> getQnaInfo(String qna_no) throws Exception;
	int addQnaReply(QnaReplyInsertDto dto) throws Exception;
	Map<String, Object> getQnaReply(String qna_no) throws Exception;
	
	// notice
	List<Map<String, Object>> getNoticeList(AdminSearchCondition sc) throws Exception;
	int getNoticeCnt(String condition) throws Exception;
	Map<String, Object> getNoticeInfo(String notice_no) throws Exception;
}
