package com.spring.usMarket.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminHomeController { // 관리자 메인 페이지 출력
	private static final Logger logger = LoggerFactory.getLogger(AdminHomeController.class);
	
	@GetMapping("/home")
	public void main() throws Exception {
		logger.info("admin index!");
	}

}
