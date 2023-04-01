package com.spring.usMarket.controller.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.usMarket.domain.admin.ReportHistoryDto;
import com.spring.usMarket.service.admin.AdminService;

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

	
	@PostMapping("/dealstats")
	public List<Map<String, Object>> dealStats(@RequestBody Map<String, Object> map){
		
		logger.info("startDate = {}, endDate = {}, mode = {}"
				, map.get("startDate")
				, map.get("endDate")
				, map.get("mode"));
		
		String startDate = map.get("startDate").toString();
		String endDate = map.get("endDate").toString();
		String mode = map.get("mode").toString();
		
		List<Map<String, Object>> resultMap = new ArrayList<>();
		try {
			if(mode == "month" || mode.equals("month")) {
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
	
	@GetMapping("/chatlog/{room_no}")
	public List<Map<String, Object>> chatLog(@PathVariable String room_no){
		
		logger.info("room_no = {}", room_no);
		
		List<Map<String, Object>> chatList = new ArrayList<>();
		try {
			chatList = adminService.getChatLog(room_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return chatList;
	}
	
	@GetMapping("/report/history/{member_no}")
	public String reportHistory(@PathVariable String member_no) {
		
		logger.info("member_no = {}", member_no);
		
		String endDate = "";
		try {
			endDate = adminService.getReportHistory(member_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return endDate;
	}
	
	@PostMapping("/report/reg")
	public int reportReg(@RequestBody ReportHistoryDto dto) {
		
		logger.info("ReportHistoryDto = {}", dto.toString());
		
		int result = 0;
		try {
			result = adminService.addReportHistory(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
