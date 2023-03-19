package com.spring.usMarket.service.admin;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.usMarket.dao.admin.AdminReportDao;

@Service
public class AdminReportServiceImpl implements AdminReportService{
	private static final Logger logger = LoggerFactory.getLogger(AdminReportService.class);
	
	@Autowired AdminReportDao adminReportDao;

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getReportList(String startPage, String endPage) throws Exception {
		
		List<Map<String, Object>> listMap = adminReportDao.searchReportList(startPage, endPage);
		logger.info("신고 목록 조회 결과 = {}", listMap.size());
		
		return listMap;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getQnaList(String startPage, String endPage) throws Exception {
		
		List<Map<String, Object>> listMap = adminReportDao.searchQnaList(startPage, endPage);
		logger.info("문의 목록 조회 결과 = {}", listMap.size());
		
		return listMap;
	}
}
