package com.spring.usMarket.dao.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.usMarket.domain.admin.ReportHistoryDto;
import com.spring.usMarket.utils.AdminSearchCondition;

@Repository
public class AdminDaoImpl implements AdminDao{
	
	@Autowired
	private SqlSession session;
	private static String namespace = "com.mybatis.mapper.admin.";
	
	@Override
	public Map<String, Object> searchAdmin(String admin_id, String admin_password) throws Exception {
		Map<String, String> map = new HashMap<>();
		map.put("admin_id", admin_id);
		map.put("admin_password", admin_password);
		
		return session.selectOne(namespace+"searchAdmin", map);
	}

	@Override
	public List<Map<String, Object>> searchMemberStatsByDate(String startDate, String endDate) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		
		return session.selectList(namespace+"searchMemberStatsByDate", map);
	}

	@Override
	public List<Map<String, Object>> searchMemberStatsByMonth(String startDate, String endDate) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		
		return session.selectList(namespace+"searchMemberStatsByMonth", map);
	}
	
	@Override
	public List<Map<String, Object>> searchMemberList(AdminSearchCondition sc) throws Exception {
		return session.selectList(namespace+"searchMemberList", sc);
	}
	
	@Override
	public int searchMemberCnt(String startDate, String endDate, String condition) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("condition", condition);
		
		return session.selectOne(namespace+"searchMemberCnt", map);
	}

	@Override
	public Map<String, Object> searchMemberInfo(String member_no) throws Exception {
		return session.selectOne(namespace+"searchMemberInfo", member_no);
	}
	
	@Override
	public List<Map<String, Object>> searchMemberProductList(AdminSearchCondition sc) throws Exception {
		return session.selectList(namespace+"searchMemberProductList", sc);
	}	
	
	@Override
	public int searchMemberProductCnt(String member_no, String condition) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("member_no", member_no);
		map.put("condition", condition);
		
		return session.selectOne(namespace+"searchMemberProductCnt", map);
	}
	
	@Override
	public List<Map<String, Object>> searchDealStatsByDate(String startDate, String endDate) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		
		return session.selectList(namespace+"searchDealStatsByDate", map);
	}

	@Override
	public List<Map<String, Object>> searchDealStatsByMonth(String startDate, String endDate) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		
		return session.selectList(namespace+"searchDealStatsByMonth", map);
	}

	@Override
	public List<Map<String, Object>> searchDealList(AdminSearchCondition sc) throws Exception {
		return session.selectList(namespace+"searchDealList", sc);
	}

	@Override
	public int searchDealCnt(String startDate, String endDate, String condition) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("condition", condition);
		
		return session.selectOne(namespace+"searchDealCnt", map);
	}
	
	@Override
	public Map<String, Object> searchDealInfo(String deal_no) throws Exception {
		return session.selectOne(namespace+"searchDealInfo", deal_no);
	}
	
	@Override
	public Map<String, Object> searchReviewInfo(String deal_no) throws Exception {
		return session.selectOne(namespace+"searchReviewInfo", deal_no);
	}

	@Override
	public List<Map<String, Object>> searchReportList(AdminSearchCondition sc) throws Exception {
		return session.selectList(namespace+"searchReportList", sc);
	}
	
	@Override
	public int searchReportCnt(String condition, String complete) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("condition", condition);
		map.put("complete", complete);
		
		return session.selectOne(namespace+"searchReportCnt", map);
	}
	
	@Override
	public Map<String, Object> searchReportInfo(String report_no) throws Exception {
		return session.selectOne(namespace+"searchReportInfo", report_no);
	}
	
	@Override
	public List<Map<String, Object>> searchChatLog(String room_no) throws Exception {
		return session.selectList(namespace+"searchChatLog", room_no);
	}
	
	@Override
	public String searchReportEndDate(String member_no) throws Exception {
		return session.selectOne(namespace+"searchReportEndDate", member_no);
	}

	@Override
	public int updateReport(String report_no) throws Exception {
		return session.update(namespace+"updateReport", report_no);
	}
	
	@Override
	public int insertReportHistory(ReportHistoryDto dto) throws Exception {
		return session.insert(namespace+"insertReportHistory", dto);
	}
	
	@Override
	public Map<String, Object> searchReportHistory(String report_no) throws Exception {
		return session.selectOne(namespace+"searchReportHistory", report_no);
	}

	@Override
	public List<Map<String, Object>> searchQnaList(AdminSearchCondition sc) throws Exception {
		return session.selectList(namespace+"searchQnaList", sc);
	}

}
