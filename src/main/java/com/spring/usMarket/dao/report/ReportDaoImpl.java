package com.spring.usMarket.dao.report;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReportDaoImpl implements ReportDao{
	@Autowired
	private SqlSession session;
	private static String namespace = "com.mybatis.mapper.report.";

	@Override
	public int insertReport(Map<String, Object> map) throws Exception {
		return session.insert(namespace+"insertReport", map);
	}
	
	@Override
	public List<Map<String, Object>> selectReportCategory2(Integer report_category2_no) throws Exception{
		return session.selectList(namespace+"selectReportCategory2", report_category2_no);
	}

}
