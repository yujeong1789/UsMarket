package com.spring.usMarket.controller.admin;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/report")
public class AdminReportController {
	private static final Logger logger = LoggerFactory.getLogger(AdminReportController.class);
	
	@GetMapping("/list")
	public void reportList(Model model) {
		logger.info("report/list");
	}
	
	@GetMapping("/info")
	public void reportInfo(Model model, String report_no) {
		logger.info("report_no = {}", report_no);
	}

}
