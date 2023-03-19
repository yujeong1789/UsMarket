package com.spring.usMarket.dao.admin;

import java.util.List;
import java.util.Map;

public interface AdminReportDao {
	List<Map<String, Object>> searchReportList(String startPage, String endPage) throws Exception;
	List<Map<String, Object>> searchQnaList(String startPage, String endPage) throws Exception;
}
