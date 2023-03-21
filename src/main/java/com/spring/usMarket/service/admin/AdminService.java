package com.spring.usMarket.service.admin;

import java.util.List;
import java.util.Map;

import com.spring.usMarket.utils.AdminSearchCondition;

public interface AdminService {
	Map<String, Object> getAdmin(String admin_id, String admin_password) throws Exception;
	
	List<Map<String, Object>> getMemberStatsByDate(String startDate, String endDate) throws Exception;
	List<Map<String, Object>> getMemberStatsByMonth(String startDate, String endDate) throws Exception;
	
	List<Map<String, Object>> getDealStatsByDate(String startDate, String endDate) throws Exception;
	List<Map<String, Object>> getDealStatsByMonth(String startDate, String endDate) throws Exception;
	
	List<Map<String, Object>> getReportList(String startPage, String endPage) throws Exception;
	
	List<Map<String, Object>> getQnaList(String startPage, String endPage) throws Exception;
}
