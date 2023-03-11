package com.spring.usMarket.dao.report;

import java.util.List;
import java.util.Map;

import com.spring.usMarket.domain.report.ReportInsertDto;

public interface ReportDao {
	int insertReport(ReportInsertDto dto) throws Exception;
	List<Map<String, Object>> selectReportCategory2(Integer report_category2_no) throws Exception;
}
