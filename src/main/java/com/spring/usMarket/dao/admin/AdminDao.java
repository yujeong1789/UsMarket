package com.spring.usMarket.dao.admin;

import java.util.List;
import java.util.Map;

import com.spring.usMarket.domain.admin.ReportHistoryDto;
import com.spring.usMarket.utils.AdminSearchCondition;

public interface AdminDao {
	// home
	Map<String, Object> searchAdmin(String admin_id, String admin_password) throws Exception;
	
	
	// member
	List<Map<String, Object>> searchMemberStatsByDate(String startDate, String endDate) throws Exception;
	List<Map<String, Object>> searchMemberStatsByMonth(String startDate, String endDate) throws Exception;
	List<Map<String, Object>> searchMemberList(AdminSearchCondition sc) throws Exception;
	int searchMemberCnt(String startDate, String endDate, String condition) throws Exception;
	Map<String, Object> searchMemberInfo(String member_no) throws Exception;
	List<Map<String, Object>> searchMemberProductList(AdminSearchCondition sc) throws Exception;
	int searchMemberProductCnt(String member_no, String condition) throws Exception;
	
	// deal
	List<Map<String, Object>> searchDealStatsByDate(String startDate, String endDate) throws Exception;
	List<Map<String, Object>> searchDealStatsByMonth(String startDate, String endDate) throws Exception;
	List<Map<String, Object>> searchDealList(AdminSearchCondition sc) throws Exception;
	int searchDealCnt(String startDate, String endDate, String condition) throws Exception;
	Map<String, Object> searchDealInfo(String deal_no) throws Exception;
	Map<String, Object> searchReviewInfo(String deal_no) throws Exception;
	
	// report
	List<Map<String, Object>> searchReportList(AdminSearchCondition sc) throws Exception;
	int searchReportCnt(String condition, String complete) throws Exception;
	Map<String, Object> searchReportInfo(String report_no) throws Exception;
	List<Map<String, Object>> searchChatLog(String room_no) throws Exception;
	String searchReportEndDate(String member_no) throws Exception;
	int updateReport(String report_no) throws Exception;
	int insertReportHistory(ReportHistoryDto dto) throws Exception;
	Map<String, Object> searchReportHistory(String report_no) throws Exception;
	
	// qna
	List<Map<String, Object>> searchQnaList(AdminSearchCondition sc) throws Exception;
}
