package com.spring.usMarket.dao.report;

import java.util.List;
import java.util.Map;

public interface ReportDao {
	int insertReport(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> selectReportCategory2(Integer report_category2_no) throws Exception;
}
