package com.spring.usMarket.service.report;

import java.util.List;
import java.util.Map;

import com.spring.usMarket.domain.report.ReportInsertDto;

public interface ReportService {
	int addReport(ReportInsertDto dto) throws Exception;
	List<Map<String, Object>> getReportCategory2(Integer report_category2_no) throws Exception;
}
