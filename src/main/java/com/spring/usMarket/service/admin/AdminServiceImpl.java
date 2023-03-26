package com.spring.usMarket.service.admin;

import java.sql.SQLException;
import java.util.HashMap;
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
	public List<Map<String, Object>> getMemberStatsByDate(String startDate, String endDate) throws Exception {
		
		List<Map<String, Object>> listMap = adminDao.searchMemberStatsByDate(startDate, endDate);
		logger.info("일별 가입자 추이 조회 결과 = {}", listMap.toString());
		
		return listMap;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getMemberStatsByMonth(String startDate, String endDate) throws Exception {

		List<Map<String, Object>> listMap = adminDao.searchMemberStatsByMonth(startDate, endDate);
		logger.info("월별 가입자 추이 조회 결과 = {}", listMap.toString());
		
		return listMap;
	}	

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public int getMemberCnt(String startDate, String endDate, String condition) throws Exception {
		
		int totalCnt = adminDao.searchMemberCnt(startDate, endDate, condition);
		logger.info("회원수 조회 결과 = {}", totalCnt);
		
		return totalCnt;
	}
	
	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public Map<String, Object> getMemberInfo(String member_no) throws Exception {
		
		Map<String, Object> infoMap = new HashMap<>();
		
		Map<String, Object> memberInfo = adminDao.searchMemberInfo(member_no);
		logger.info("회원 상세조회 결과 = {}", memberInfo.toString());
		infoMap.put("memberInfo", memberInfo);
		
		List<Map<String, Object>> productList = adminDao.searchMemberProductList(member_no);
		logger.info("회원 상품 리스트 조회 결과 = {}", productList.toString());
		infoMap.put("productList", productList);
		
		
		return infoMap;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getDealStatsByDate(String startDate, String endDate) throws Exception {
		
		List<Map<String, Object>> listMap = adminDao.searchDealStatsByDate(startDate, endDate);
		logger.info("일별 결제 추이 조회 결과 = {}", listMap.toString());
		
		return listMap;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getDealStatsByMonth(String startDate, String endDate) throws Exception {

		List<Map<String, Object>> listMap = adminDao.searchDealStatsByMonth(startDate, endDate);
		logger.info("월별 결제 추이 조회 결과 = {}", listMap.toString());
		
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

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getMemberList(AdminSearchCondition sc) throws Exception {
		
		List<Map<String, Object>> listMap = adminDao.searchMemberList(sc);
		logger.info("회원 목록 조회 결과 = {}", listMap.toString());
		
		return listMap;
	}

}
