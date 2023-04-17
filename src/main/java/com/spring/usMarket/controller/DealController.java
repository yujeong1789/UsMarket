package com.spring.usMarket.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.usMarket.service.deal.DealService;

@Controller
@RequestMapping("/deal")
public class DealController {
	private static final Logger logger = LoggerFactory.getLogger(DealController.class);
	
	@Autowired
	DealService dealService;

	@GetMapping("/complete")
	public void complete (String deal_no) {
		logger.info("deal_no = {}", deal_no);
	}
	
	@PostMapping("/list")
	public void list(String member_no) {
		logger.info("member_no = {}", member_no);
	}
	
	@PostMapping("/info")
	public void info(String deal_no) {
		logger.info("deal_no = {}", deal_no);
	}
}
