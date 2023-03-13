package com.spring.usMarket.service.admin;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.usMarket.dao.admin.AdminDao;

@Service
public class AdminServiceImpl implements AdminService{
	private static final Logger logger = LoggerFactory.getLogger(AdminService.class);
	
	@Autowired AdminDao adminDao;
	
	
	public String getResult(int rowCnt) {
		return rowCnt == 1 ? "OK" : "NOT_OK";
	}
	
	@Override
	public Map<String, Object> getAdmin(String admin_id, String admin_password) throws Exception {
		
		Map<String, Object> map = adminDao.searchAdmin(admin_id, admin_password);
		logger.info("관리자 정보 조회 결과 = {}", (map == null ? "NOT_OK" : "OK"));
		
		return map;
	}

}
