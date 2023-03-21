package com.spring.usMarket.dao.admin;

import java.util.List;
import java.util.Map;

import com.spring.usMarket.utils.AdminSearchCondition;

public interface AdminDao {
	Map<String, Object> searchAdmin(String admin_id, String admin_password) throws Exception;
	
	List<Map<String, Object>> searchMemberStatsByDate(String startDate, String endDate) throws Exception;
	List<Map<String, Object>> searchMemberStatsByMonth(String startDate, String endDate) throws Exception;
	
	List<Map<String, Object>> searchDealStatsByDate(String startDate, String endDate) throws Exception;
	List<Map<String, Object>> searchDealStatsByMonth(String startDate, String endDate) throws Exception;
	
	List<Map<String, Object>> searchReportList(String startPage, String endPage) throws Exception;
	
	List<Map<String, Object>> searchQnaList(String startPage, String endPage) throws Exception;
}
