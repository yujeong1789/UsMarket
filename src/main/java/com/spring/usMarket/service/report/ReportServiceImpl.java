package com.spring.usMarket.service.report;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.usMarket.dao.report.ReportDao;
import com.spring.usMarket.domain.report.ReportInsertDto;

@Service
public class ReportServiceImpl implements ReportService{
	private static final Logger logger = LoggerFactory.getLogger(ReportService.class);
	
	@Autowired ReportDao reportDao;

	public String getResult(int rowCnt) {
		return rowCnt == 1 ? "SUCCESS" : "FAIL";
	}
	
	@Override
	@Transactional(rollbackFor = SQLException.class)
	public int addReport(ReportInsertDto dto) throws Exception {
		
		int rowCnt = reportDao.insertReport(dto);
		logger.info("신고 등록 결과 = {}", getResult(rowCnt));
		
		return rowCnt;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getReportCategory2(Integer report_category2_no) throws Exception {
		
		List<Map<String, Object>> reportCategory = reportDao.selectReportCategory2(report_category2_no);
		logger.info("reportCategory.toString() = {}", reportCategory.toString());
		
		return reportCategory;
	}

}
