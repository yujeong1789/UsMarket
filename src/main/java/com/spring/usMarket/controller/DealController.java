package com.spring.usMarket.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.usMarket.service.deal.DealService;
import com.spring.usMarket.utils.SessionParameters;

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
	
	@GetMapping("/list")
	public void list(Model model, HttpServletRequest request) {
		
		String member_no = SessionParameters.getUserNo(request);
		String state = "";
		String condition = "buy";
		
		logger.info("member_no = {}", member_no);
		
		List<Map<String, Object>> dealList = new ArrayList<>();
		try {
			dealList = dealService.getDealList("", "buy", member_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("dealList", dealList);
		model.addAttribute("state", state);
		model.addAttribute("condition", condition);
	}
	
	@PostMapping("/list")
	public String list(String state, String condition, RedirectAttributes ratt, HttpServletRequest request) {
		
		String member_no = SessionParameters.getUserNo(request);
		logger.info("state = {}, condition = {}, member_no = {}", state, condition, member_no);
		
		List<Map<String, Object>> dealList = new ArrayList<>();
		try {
			dealList = dealService.getDealList(state, condition, member_no);
			ratt.addFlashAttribute("dealList", dealList);
			ratt.addFlashAttribute("state", state);
			ratt.addFlashAttribute("condition", condition);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return "redirect:/deal/listform";
	}
	
	@GetMapping("/listform")
	public void listform() {
		logger.info("listform");
	}
	
	@GetMapping("/info")
	public void info() {
		logger.info("deal/info");
	}
	
	@PostMapping("/info")
	public void info(String deal_no, Model model, HttpServletRequest request) {
		
		String member_no = SessionParameters.getUserNo(request);
		logger.info("deal_no = {}, member_no = {}", deal_no, member_no);
		
		Map<String, Object> dealInfo = new HashMap<>();
		String mode = "buy";
		try {
			dealInfo = dealService.getDealInfo(deal_no);
			if(dealInfo.get("SELLER_NO").toString().equals(member_no)) mode = "sell";
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("dealInfo", dealInfo);
		model.addAttribute("mode", mode);
	}
}
