package com.spring.usMarket.controller.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.usMarket.service.admin.AdminService;
import com.spring.usMarket.utils.AdminPageHandler;
import com.spring.usMarket.utils.AdminSearchCondition;

@Controller
@RequestMapping("/admin/report")
public class AdminReportController {
	private static final Logger logger = LoggerFactory.getLogger(AdminReportController.class);

	@Autowired AdminService adminService;
	
	@GetMapping("/list")
	public void reportList(Model model) {
		
		AdminSearchCondition sc = new AdminSearchCondition();
		
		sc.setPageSize(10);
		sc.setOrder("regdate_desc");
		
		logger.info("adminSearchCondition = {}", sc.toString());
		
		List<Map<String, Object>> reportList = new ArrayList<>();
		int totalCnt = 0;
		
		try {			
			reportList = adminService.getReportList(sc);
			totalCnt = adminService.getReportCnt(sc.getCondition(), sc.getComplete());
			AdminPageHandler pageHandler = new AdminPageHandler(totalCnt, sc);
			 
			model.addAttribute("reportList", reportList);
			model.addAttribute("page", sc.getPage());
			model.addAttribute("pageSize", sc.getPageSize());
			model.addAttribute("ph", pageHandler);
			 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	

	@PostMapping("list")
	public String reportListPost(@RequestBody AdminSearchCondition sc, RedirectAttributes ratt) {
		
		sc.setPageSize(10);
		
		logger.info("post adminSearchCondition = {}", sc.toString());
		
		List<Map<String, Object>> reportList = new ArrayList<>();
		int totalCnt = 0;
		
		try {
			reportList = adminService.getReportList(sc);
			 
			 totalCnt = adminService.getReportCnt(sc.getCondition(), sc.getComplete());
			 AdminPageHandler pageHandler = new AdminPageHandler(totalCnt, sc);
			 
			 ratt.addFlashAttribute("reportList", reportList);
			 ratt.addFlashAttribute("page", sc.getPage());
			 ratt.addFlashAttribute("pageSize", sc.getPageSize());
			 ratt.addFlashAttribute("condition", sc.getOrder());
			 ratt.addFlashAttribute("order", sc.getOrder());
			 ratt.addFlashAttribute("ph", pageHandler);
			 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/admin/report/listform";
	}
	
	@GetMapping("/listform")
	public void listform() throws Exception{
		logger.info("listform");
	}
	
	@PostMapping("/info")
	public void reportInfo(String report_no, Model model) {
		
		logger.info("report_no = {}", report_no);
		
		Map<String, Object> infoMap = new HashMap<>();
		
		model.addAttribute("infoMap", infoMap);
	}

}
