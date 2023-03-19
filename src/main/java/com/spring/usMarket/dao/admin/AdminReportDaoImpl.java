package com.spring.usMarket.dao.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminReportDaoImpl implements AdminReportDao{
	
	@Autowired
	private SqlSession session;
	private static String namespace = "com.mybatis.mapper.adminReport.";
	
	
	@Override
	public List<Map<String, Object>> searchReportList(String startPage, String endPage) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		
		return session.selectList(namespace+"searchReportList", map);
	}


	@Override
	public List<Map<String, Object>> searchQnaList(String startPage, String endPage) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		
		return session.selectList(namespace+"searchQnaList", map);
	}
}
