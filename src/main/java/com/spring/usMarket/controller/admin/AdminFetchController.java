package com.spring.usMarket.controller.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.usMarket.service.admin.AdminService;
import com.spring.usMarket.utils.AdminSearchCondition;

@RestController
@RequestMapping("/fetch/admin")
public class AdminFetchController {
	private static final Logger logger = LoggerFactory.getLogger(AdminFetchController.class);
	
	@Autowired AdminService adminService;
	
	@PostMapping("/memberstats")
	public List<Map<String, Object>> memberStats(@RequestBody AdminSearchCondition searchCondition){
		
		logger.info("searchCondition = {}", searchCondition.toString());
		
		List<Map<String, Object>> resultMap = new ArrayList<>();
		try {
			resultMap = adminService.getMemberStatsPreview(searchCondition);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultMap;	
	}
	
	@PostMapping("/dealstats")
	public List<Map<String, Object>> dealStats(@RequestBody AdminSearchCondition searchCondition){
		
		logger.info("searchCondition = {}", searchCondition.toString());
		
		List<Map<String, Object>> resultMap = new ArrayList<>();
		try {
			resultMap = adminService.getDealStatsPreview(searchCondition);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultMap;	
	}
}
