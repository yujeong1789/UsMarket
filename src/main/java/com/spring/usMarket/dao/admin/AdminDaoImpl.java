package com.spring.usMarket.dao.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	public List<Map<String, Object>> searchMemberStatsPreview(String startDate, String endDate) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		
		return session.selectList(namespace+"searchMemberStatsPreview", map);
	}
	
}
