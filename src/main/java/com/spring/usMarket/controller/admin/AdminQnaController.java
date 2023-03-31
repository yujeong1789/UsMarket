package com.spring.usMarket.controller.admin;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/qna")
public class AdminQnaController {
	private static final Logger logger = LoggerFactory.getLogger(AdminQnaController.class);
	
	@GetMapping("/list")
	public void qnaList(Model model) {
		logger.info("qna/list");
	}
	
	@PostMapping("/info")
	public void qnaInfo(Model model, String qna_no) {
		logger.info("qna_no = {}", qna_no);
	}
}
