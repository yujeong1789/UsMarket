package com.spring.usMarket.controller.admin;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/faq")
public class AdminFaqController {
	private static final Logger logger = LoggerFactory.getLogger(AdminFaqController.class);
	
	@GetMapping("/list")
	public void faqList(Model model) {
		logger.info("faq/list");
	}
	
	@GetMapping("/info")
	public void faqInfo(Model model) {
		logger.info("faq/info");
	}
}
