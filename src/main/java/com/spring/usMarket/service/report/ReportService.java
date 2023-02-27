package com.spring.usMarket.service.report;

import java.util.List;
import java.util.Map;

public interface ReportService {
	int addReport(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> getReportCategory2(Integer report_category2_no) throws Exception;
}
