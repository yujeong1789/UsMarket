package com.spring.usMarket.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/qna")
public class QnaController {

	@GetMapping("/list")
	public void qnaList(Model model) {
		
	}
	
	@GetMapping("/new")
	public String qnaWrite(Model model) {
		
		model.addAttribute("mode", "new");
		
		return "/qna/info";
	}
	
	@GetMapping("/read")
	public String qnaInfo(Model model) {
		
		model.addAttribute("mode", "read");
		
		return "/qna/info";
	}
}
