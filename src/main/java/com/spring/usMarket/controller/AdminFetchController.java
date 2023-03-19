package com.spring.usMarket.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.usMarket.service.admin.AdminReportService;
import com.spring.usMarket.service.admin.AdminService;

@RestController
@RequestMapping("/fetch/admin")
public class AdminFetchController {
	private static final Logger logger = LoggerFactory.getLogger(AdminFetchController.class);
	
	@Autowired AdminService adminService;
	@Autowired AdminReportService adminReportService;
	
	@GetMapping("/memberstats/{startDate}/{endDate}")
	public List<Map<String, Object>> memberStats(@PathVariable String startDate, @PathVariable String endDate){
		
		logger.info("startDate = {}, endDate = {}", startDate, endDate);
		
		List<Map<String, Object>> resultMap = new ArrayList<>();
		try {
			resultMap = adminService.getMemberStatsPreview(startDate, endDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultMap;	
	}
	
	@GetMapping("/dealstats/{startDate}/{endDate}")
	public List<Map<String, Object>> deatStats(@PathVariable String startDate, @PathVariable String endDate){
		
		logger.info("startDate = {}, endDate = {}", startDate, endDate);
		
		List<Map<String, Object>> resultMap = new ArrayList<>();
		try {
			resultMap = adminService.getDealStatsPreview(startDate, endDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultMap;	
	}
	
	@GetMapping("/reportlist")
	public List<Map<String, Object>> reportPreview(){
		
		List<Map<String, Object>> resultMap = new ArrayList<>();
		try {
			resultMap = adminReportService.getReportList("1", "5");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultMap;
	}
	
	@GetMapping("/qnalist")
	public List<Map<String, Object>> qnaPreview(){
		
		List<Map<String, Object>> resultMap = new ArrayList<>();
		try {
			resultMap = adminReportService.getQnaList("1", "5");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultMap;
	}
}
