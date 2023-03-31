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
@RequestMapping("/admin/payment")
public class AdminPaymentController {
	private static final Logger logger = LoggerFactory.getLogger(AdminPaymentController.class);
	
	@Autowired AdminService adminService;
	
	@GetMapping("/list")
	public void paymentList(Model model) {
		
		AdminSearchCondition sc = new AdminSearchCondition();
		sc.setPageSize(10);
		
		logger.info("adminSearchCondition = {}", sc.toString());
		
		List<Map<String, Object>> dealList = new ArrayList<>();
		int totalCnt = 0;
		
		try {			
			dealList = adminService.getDealList(sc);
			totalCnt = adminService.getDealCnt(sc.getStartDate(), sc.getEndDate(), sc.getCondition());
			AdminPageHandler pageHandler = new AdminPageHandler(totalCnt, sc);
			 
			model.addAttribute("dealList", dealList);
			model.addAttribute("page", sc.getPage());
			model.addAttribute("pageSize", sc.getPageSize());
			model.addAttribute("ph", pageHandler);
			 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@PostMapping("list")
	public String dealListPost(@RequestBody AdminSearchCondition sc, RedirectAttributes ratt) {
		sc.setPageSize(10);
		logger.info("post adminSearchCondition = {}", sc.toString());
		
		List<Map<String, Object>> dealList = new ArrayList<>();
		int totalCnt = 0;
		
		try {
			dealList = adminService.getDealList(sc);
			 
			 totalCnt = adminService.getDealCnt(sc.getStartDate(), sc.getEndDate(), sc.getCondition());
			 AdminPageHandler pageHandler = new AdminPageHandler(totalCnt, sc);
			 
			 ratt.addFlashAttribute("dealList", dealList);
			 ratt.addFlashAttribute("page", sc.getPage());
			 ratt.addFlashAttribute("pageSize", sc.getPageSize());
			 ratt.addFlashAttribute("condition", sc.getOrder());
			 ratt.addFlashAttribute("order", sc.getOrder());
			 ratt.addFlashAttribute("ph", pageHandler);
			 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/admin/payment/listform";
	}
	
	
	@GetMapping("/listform")
	public void listform() throws Exception{
		logger.info("listform");
	}
	
	@GetMapping("/info")
	public void paymentInfo(Model model) {
		logger.info("payment/info");
	}
	
	@PostMapping("/info")
	public void paymentInfoPost(String deal_no, Model model) {
		
		logger.info("deal_no = {}", deal_no);
		
		Map<String, Object> infoMap = new HashMap<>(); 
		try {
			infoMap = adminService.getDealInfo(deal_no);
			model.addAttribute("infoMap", infoMap);
			
			String deal_state = infoMap.get("DEAL_STATE").toString();
			String deal_review = infoMap.get("DEAL_REVIEW").toString();
			if((deal_state == "2" || deal_state.equals("2")) && (deal_review == "Y" || deal_review.equals("Y"))) {
				Map<String, Object> reviewMap = adminService.getReviewInfo(deal_no);
				model.addAttribute("reviewMap", reviewMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
