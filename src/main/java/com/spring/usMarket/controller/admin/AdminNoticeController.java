package com.spring.usMarket.controller.admin;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.usMarket.service.admin.AdminService;
import com.spring.usMarket.utils.AdminPageHandler;
import com.spring.usMarket.utils.AdminSearchCondition;

@Controller
@RequestMapping("/admin/notice")
public class AdminNoticeController {
	private static final Logger logger = LoggerFactory.getLogger(AdminNoticeController.class);
	
	@Autowired AdminService adminService;
	
	@GetMapping("/list")
	public void noticeList(Model model) {
		
		AdminSearchCondition sc = new AdminSearchCondition();
		
		sc.setPageSize(10);
		sc.setOrder("regdate_desc");
		
		logger.info("adminSearchCondition = {}", sc.toString());
		
		List<Map<String, Object>> noticeList = new ArrayList<>();
		int totalCnt = 0;
		
		try {
			noticeList = adminService.getNoticeList(sc);
			totalCnt = adminService.getNoticeCnt(sc.getCondition());
			AdminPageHandler pageHandler = new AdminPageHandler(totalCnt, sc);
			 
			model.addAttribute("noticeList", noticeList);
			model.addAttribute("page", sc.getPage());
			model.addAttribute("pageSize", sc.getPageSize());
			model.addAttribute("ph", pageHandler);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@PostMapping("/list")
	public String noticeListPost(@RequestBody AdminSearchCondition sc, HttpServletRequest request, RedirectAttributes ratt) {
		
		logger.info("AdminSearchCondition = {}", sc.toString());
		
		List<Map<String, Object>> noticeList = new ArrayList<>();
		int totalCnt = 0;
		
		try {
			noticeList = adminService.getNoticeList(sc);
			totalCnt = adminService.getNoticeCnt(sc.getCondition());
			AdminPageHandler pageHandler = new AdminPageHandler(totalCnt, sc);
			
			ratt.addFlashAttribute("noticeList", noticeList);
			ratt.addFlashAttribute("page", sc.getPage());
			ratt.addFlashAttribute("pageSize", sc.getPageSize());
			ratt.addFlashAttribute("condition", sc.getCondition());
			ratt.addFlashAttribute("ph", pageHandler);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/admin/notice/listform";
	}
	
	@GetMapping("/listform")
	public void listform() throws Exception{
		logger.info("listform");
	}
	
	@GetMapping("/info")
	public void noticeInfo(Model model) {
		logger.info("notice/info");
	}
	
	@PostMapping("/info")
	public void noticeInfoPost(String notice_no, String mode, Model model) {
		logger.info("notice_no = {}", notice_no);
		
		Map<String, Object> infoMap = new HashMap<>();
		
		try {
			infoMap = adminService.getNoticeInfo(notice_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("infoMap", infoMap);
	}
	
	@GetMapping("/new")
	public void noticeNew() {
		logger.info("notice/new");
	}
}
