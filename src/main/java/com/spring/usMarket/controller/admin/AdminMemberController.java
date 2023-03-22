package com.spring.usMarket.controller.admin;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
	@GetMapping("/info")
	public void memberInfo(Model model) {
		logger.info("member/info");
	}
}
