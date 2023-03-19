package com.spring.usMarket.service.admin;

import java.util.List;
import java.util.Map;

public interface AdminReportService {
	List<Map<String, Object>> getReportList(String startPage, String endPage) throws Exception;
	List<Map<String, Object>> getQnaList(String startPage, String endPage) throws Exception;
}
