package com.spring.usMarket.controller.admin;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/member")
public class AdminMemberController {
	private static final Logger logger = LoggerFactory.getLogger(AdminMemberController.class);

	@GetMapping("/list")
	public void memberList(Model model) {
		logger.info("member/list");
	}
	
	@GetMapping("/info")
	public void memberInfo(Model model) {
		logger.info("member/info");
	}
}
