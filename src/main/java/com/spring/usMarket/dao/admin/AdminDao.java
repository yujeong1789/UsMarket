package com.spring.usMarket.dao.admin;

import java.util.List;
import java.util.Map;

public interface AdminDao {
	Map<String, Object> searchAdmin(String admin_id, String admin_password) throws Exception;
	List<Map<String, Object>> searchMemberStatsPreview(String startDate, String endDate) throws Exception;
	List<Map<String, Object>> searchDealStatsPreview(String startDate, String endDate) throws Exception;
}
