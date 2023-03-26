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
@RequestMapping("/admin/member")
public class AdminMemberController {
	private static final Logger logger = LoggerFactory.getLogger(AdminMemberController.class);

	@Autowired AdminService adminService;
	
	@GetMapping("/list")
	public void memberList(Model model) {
		
		AdminSearchCondition sc = new AdminSearchCondition();
		sc.setPageSize(10);
		
		logger.info("adminSearchCondition = {}", sc.toString());
		
		List<Map<String, Object>> memberList = new ArrayList<>();
		int totalCnt = 0;
		
		try {			
			memberList = adminService.getMemberList(sc);
			totalCnt = adminService.getMemberCnt(sc.getStartDate(), sc.getEndDate(), sc.getCondition());
			AdminPageHandler pageHandler = new AdminPageHandler(totalCnt, sc);
			 
			model.addAttribute("memberList", memberList);
			model.addAttribute("page", sc.getPage());
			model.addAttribute("pageSize", sc.getPageSize());
			model.addAttribute("ph", pageHandler);
			 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@PostMapping("list")
	public String memberListPost(@RequestBody AdminSearchCondition sc, RedirectAttributes ratt) {
		sc.setPageSize(10);
		logger.info("post adminSearchCondition = {}", sc.toString());
		
		List<Map<String, Object>> memberList = new ArrayList<>();
		int totalCnt = 0;
		
		try {
			 memberList = adminService.getMemberList(sc);
			 
			 totalCnt = adminService.getMemberCnt(sc.getStartDate(), sc.getEndDate(), sc.getCondition());
			 AdminPageHandler pageHandler = new AdminPageHandler(totalCnt, sc);
			 
			 ratt.addFlashAttribute("memberList", memberList);
			 ratt.addFlashAttribute("page", sc.getPage());
			 ratt.addFlashAttribute("pageSize", sc.getPageSize());
			 ratt.addFlashAttribute("condition", sc.getOrder());
			 ratt.addFlashAttribute("order", sc.getOrder());
			 ratt.addFlashAttribute("ph", pageHandler);
			 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/admin/member/listform";
	}
	
	@GetMapping("/listform")
	public void listform() throws Exception{
		logger.info("listform");
	}
	
	@GetMapping("/info")
	public void memberInfo(Model model) {
		logger.info("member/info");
	}
	
	@PostMapping("/info")
	public void memberInfoPost(String member_no, Model model) {
		
		logger.info("info member_no = {}", member_no);
		
		Map<String, Object> infoMap = new HashMap<>();
		try {
			infoMap = adminService.getMemberInfo(member_no);
			model.addAttribute("infoMap", infoMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
