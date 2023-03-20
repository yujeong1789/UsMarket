package com.spring.usMarket.service.admin;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.usMarket.dao.admin.AdminDao;
import com.spring.usMarket.utils.AdminSearchCondition;

@Service
public class AdminServiceImpl implements AdminService{
	private static final Logger logger = LoggerFactory.getLogger(AdminService.class);
	
	@Autowired AdminDao adminDao;
	
	
	public String getResult(int rowCnt) {
		return rowCnt == 1 ? "OK" : "NOT_OK";
	}
	
	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public Map<String, Object> getAdmin(String admin_id, String admin_password) throws Exception {
		
		Map<String, Object> map = adminDao.searchAdmin(admin_id, admin_password);
		logger.info("관리자 정보 조회 결과 = {}", (map == null ? "NOT_OK" : "OK"));
		
		return map;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getMemberStatsPreview(AdminSearchCondition adminSearchCondition) throws Exception {
		
		List<Map<String, Object>> listMap = adminDao.searchMemberStatsPreview(adminSearchCondition);
		logger.info("월별 신규 가입자 추이 조회 결과 = {}", listMap.toString());
		
		return listMap;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getDealStatsPreview(String startDate, String endDate) throws Exception {
		
		List<Map<String, Object>> listMap = adminDao.searchDealStatsPreview(startDate, endDate);
		logger.info("일별 결제 추이 조회 결과 = {}", listMap.toString());
		
		return listMap;
	}
	
	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getReportList(String startPage, String endPage) throws Exception {
		
		List<Map<String, Object>> listMap = adminDao.searchReportList(startPage, endPage);
		logger.info("신고 목록 조회 결과 = {}", listMap.size());
		
		return listMap;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getQnaList(String startPage, String endPage) throws Exception {
		
		List<Map<String, Object>> listMap = adminDao.searchQnaList(startPage, endPage);
		logger.info("문의 목록 조회 결과 = {}", listMap.size());
		
		return listMap;
	}

}
