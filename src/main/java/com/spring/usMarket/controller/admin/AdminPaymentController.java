package com.spring.usMarket.controller.admin;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/payment")
public class AdminPaymentController {
	private static final Logger logger = LoggerFactory.getLogger(AdminPaymentController.class);
			
	@GetMapping("/list")
	public void paymentList(Model model) {
		logger.info("payment/list");
	}
	
	@GetMapping("/info")
	public void paymentInfo(Model model) {
		logger.info("payment/info");
	}
}
