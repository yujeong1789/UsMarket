package com.spring.usMarket.controller.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.usMarket.service.admin.AdminService;
import com.spring.usMarket.utils.AdminPageHandler;
import com.spring.usMarket.utils.AdminSearchCondition;

@RestController
@RequestMapping("/fetch/admin")
public class AdminFetchController {
	private static final Logger logger = LoggerFactory.getLogger(AdminFetchController.class);
	
	@Autowired AdminService adminService;
	
	@PostMapping("/memberstats")
	public List<Map<String, Object>> memberStats(@RequestBody Map<String, Object> map){
		
		logger.info("startDate = {}, endDate = {}, mode = {}"
				, map.get("startDate")
				, map.get("endDate")
				, map.get("mode"));
		
		String startDate = map.get("startDate").toString();
		String endDate = map.get("endDate").toString();
		String mode = map.get("mode").toString();
		
		List<Map<String, Object>> resultMap = new ArrayList<>();
		try {
			if(mode == "date" || mode.equals("date")) {
				resultMap = adminService.getMemberStatsByDate(startDate, endDate);				
			}else {
				startDate = startDate.substring(0, 8)+"01";
				resultMap = adminService.getMemberStatsByMonth(startDate, endDate);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		logger.info("startDate = {}, endDate = {}", startDate, endDate);
		
		return resultMap;	
	}
	
	
	@PostMapping("/memberlist")
	public void memberList(@RequestBody AdminSearchCondition sc, Model model){
		
		sc.setPageSize(10);
		logger.info("adminSearchCondition = {}", sc.toString());
		
		List<Map<String, Object>> memberList = new ArrayList<>();
		int totalCnt = 0;
		try {
			 memberList = adminService.getMemberList(sc);
			 totalCnt = adminService.getMemberCnt(sc.getStartDate(), sc.getEndDate(), sc.getCondition());
			 AdminPageHandler pageHandler = new AdminPageHandler(totalCnt, sc);
			 
			 model.addAttribute("memberList", memberList);
			 model.addAttribute("page", sc.getPage());
			 model.addAttribute("pageSize", sc.getPageSize());
			 model.addAttribute("ph", pageHandler);
			 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@PostMapping("/dealstats")
	public List<Map<String, Object>> dealStats(@RequestBody Map<String, Object> map){
		
		logger.info("startDate = {}, endDate = {}, mode = {}"
				, map.get("startDate")
				, map.get("endDate")
				, (map.get("mode") == "month" ? "month" : "date"));
		
		String startDate = map.get("startDate").toString();
		String endDate = map.get("endDate").toString();
		
		List<Map<String, Object>> resultMap = new ArrayList<>();
		try {
			if(map.get("mode") == "month") {
				startDate = startDate.substring(0, 8)+"01";
				resultMap = adminService.getDealStatsByMonth(startDate, endDate);				
			}else {				
				resultMap = adminService.getDealStatsByDate(startDate, endDate);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultMap;	
	}
}
