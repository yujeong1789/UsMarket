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
import com.spring.usMarket.domain.admin.ReportHistoryDto;
import com.spring.usMarket.utils.AdminSearchCondition;

@Service
public class AdminServiceImpl implements AdminService{
	private static final Logger logger = LoggerFactory.getLogger(AdminService.class);
	
	@Autowired AdminDao adminDao;
	
	
	public String getResult(int rowCnt) {
		return rowCnt == 1 ? "OK" : "FAIL";
	}
	
	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public Map<String, Object> getAdmin(String admin_id, String admin_password) throws Exception {
		
		Map<String, Object> map = adminDao.searchAdmin(admin_id, admin_password);
		logger.info("관리자 정보 조회 결과 = {}", (map == null ? "FAIL" : "OK"));
		
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
	public List<Map<String, Object>> getMemberList(AdminSearchCondition sc) throws Exception {
		
		List<Map<String, Object>> listMap = adminDao.searchMemberList(sc);
		logger.info("회원 목록 조회 결과 = {}", listMap.toString());
		
		return listMap;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getMemberProductList(AdminSearchCondition sc) throws Exception {
		
		List<Map<String, Object>> listMap = adminDao.searchMemberProductList(sc);
		logger.info("회원 상품 조회 결과 = {}", listMap.toString());
		
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
	public Map<String, Object> getMemberInfo(AdminSearchCondition sc) throws Exception {
		
		Map<String, Object> infoMap = new HashMap<>();
		
		Map<String, Object> memberInfo = adminDao.searchMemberInfo(sc.getMember_no());
		logger.info("회원 상세조회 결과 = {}", memberInfo.toString());
		infoMap.put("memberInfo", memberInfo);
		
		List<Map<String, Object>> productList = adminDao.searchMemberProductList(sc);
		logger.info("회원 상품 리스트 조회 결과 = {}", productList.toString());
		infoMap.put("productList", productList);
		
		return infoMap;
	}
	
	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public int getMemberProductCnt(String member_no, String condition) throws Exception {
		
		int totalCnt = adminDao.searchMemberProductCnt(member_no, condition);
		logger.info("상품 수 조회 결과 = {}", totalCnt);
		
		return totalCnt;
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
	public List<Map<String, Object>> getDealList(AdminSearchCondition sc) throws Exception {
		
		List<Map<String, Object>> listMap = adminDao.searchDealList(sc);
		logger.info("결제 리스트 조회 결과 = {}", listMap.toString());
		
		return listMap;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public int getDealCnt(String startDate, String endDate, String condition) throws Exception {
		
		int totalCnt = adminDao.searchDealCnt(startDate, endDate, condition);
		logger.info("결제 수 조회 결과 = {}", totalCnt);
		
		return totalCnt;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public Map<String, Object> getDealInfo(String deal_no) throws Exception {
		
		Map<String, Object> map = adminDao.searchDealInfo(deal_no);
		logger.info("결제내역 조회 결과 = {}", map.toString());
		
		return map;
	}
	
	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public Map<String, Object> getReviewInfo(String deal_no) throws Exception {
		
		Map<String, Object> map = adminDao.searchReviewInfo(deal_no);
		logger.info("리뷰 조회 결과 = {}", map.toString());
		
		return map;
	}
	
	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getReportList(AdminSearchCondition sc) throws Exception {
		
		List<Map<String, Object>> listMap = adminDao.searchReportList(sc);
		logger.info("신고 목록 조회 결과 = {}", listMap.size());
		
		return listMap;
	}
	
	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public int getReportCnt(String condition, String complete) throws Exception {

		int totalCnt = adminDao.searchReportCnt(condition, complete);
		logger.info("신고 수 조회 결과 = {}", totalCnt);
		
		return totalCnt;
	}
	
	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public Map<String, Object> getReportInfo(String report_no) throws Exception {
		
		Map<String, Object> map = adminDao.searchReportInfo(report_no);
		logger.info("신고 내용 조회 결과 = {}", map.toString());
		
		return map;
	}
	
	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getChatLog(String room_no) throws Exception {
		
		List<Map<String, Object>> listMap = adminDao.searchChatLog(room_no);
		logger.info("채팅 로그 조회 결과 = {}", listMap.size());
		
		return listMap;
	}
	
	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public String getReportEndDate(String member_no) throws Exception {
		
		String endDate = adminDao.searchReportEndDate(member_no);
		logger.info("제재 이력 = {}", (endDate == null ? "없음" : endDate+" 종료"));
		
		return endDate;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class)
	public int addReportHistory(ReportHistoryDto dto) throws Exception {
		
		int rowCnt = adminDao.updateReport(dto.getReport_no());
		logger.info("신고 처리여부 업데이트 결과 = {}", getResult(rowCnt));
		
		rowCnt += adminDao.insertReportHistory(dto);
		logger.info("제재 등록 결과 = {}", (rowCnt == 2 ? "OK" : "FAIL"));
		
		return rowCnt;
	}
	
	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public Map<String, Object> getReportHistory(String report_no) throws Exception {
		
		Map<String, Object> map = adminDao.searchReportHistory(report_no);
		logger.info("제재내역 조회 결과 = {}", map.toString());
		
		return map;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getQnaList(AdminSearchCondition sc) throws Exception {
		
		List<Map<String, Object>> listMap = adminDao.searchQnaList(sc);
		logger.info("문의 목록 조회 결과 = {}", listMap.size());
		
		return listMap;
	}
}
