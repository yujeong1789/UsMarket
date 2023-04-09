package com.spring.usMarket.controller;

import java.util.ArrayList;
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

import com.spring.usMarket.service.notice.NoticeService;
import com.spring.usMarket.utils.NoticePageHandler;
import com.spring.usMarket.utils.NoticeSearchCondition;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired NoticeService noticeService;
	
	@GetMapping("/list")
	public void noticeList(Model model) {
		
		NoticeSearchCondition sc = new NoticeSearchCondition();

		sc.setStatus("0");
		sc.setPageSize(10);
		
		logger.info("NoticeSearchCondition = {}", sc.toString());
		
		List<Map<String, Object>> noticeList = new ArrayList<>();
		int totalCnt = 0;
		
		try {
			noticeList = noticeService.getNoticeList(sc);
			totalCnt = noticeService.gethNoticeCnt(sc.getStatus());
			NoticePageHandler pageHandler = new NoticePageHandler(totalCnt, sc);
			
			model.addAttribute("noticeList", noticeList);
			model.addAttribute("status", sc.getStatus());
			model.addAttribute("page", sc.getPage());
			model.addAttribute("pageSize", sc.getPageSize());
			model.addAttribute("ph", pageHandler);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@GetMapping("/faq/list")
	public String noticeFaqList(Model model) {
		
		NoticeSearchCondition sc = new NoticeSearchCondition();
		
		sc.setStatus("1");
		sc.setPageSize(10);
		
		logger.info("NoticeSearchCondition = {}", sc.toString());
		
		List<Map<String, Object>> noticeList = new ArrayList<>();
		int totalCnt = 0;
		
		try {
			noticeList = noticeService.getNoticeList(sc);
			totalCnt = noticeService.gethNoticeCnt(sc.getStatus());
			NoticePageHandler pageHandler = new NoticePageHandler(totalCnt, sc);
			
			model.addAttribute("noticeList", noticeList);
			model.addAttribute("status", sc.getStatus());
			model.addAttribute("page", sc.getPage());
			model.addAttribute("pageSize", sc.getPageSize());
			model.addAttribute("ph", pageHandler);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/notice/list";
	}
	
	@PostMapping("/list")
	public String noticeListPost(@RequestBody NoticeSearchCondition sc, HttpServletRequest request, RedirectAttributes ratt) {
		
		logger.info("NoticeSearchCondition = {}", sc.toString());
		
		List<Map<String, Object>> noticeList = new ArrayList<>();
		int totalCnt = 0;
		
		try {
			noticeList = noticeService.getNoticeList(sc);
			totalCnt = noticeService.gethNoticeCnt(sc.getStatus());
			NoticePageHandler pageHandler = new NoticePageHandler(totalCnt, sc);
			
			ratt.addFlashAttribute("noticeList", noticeList);
			ratt.addFlashAttribute("page", sc.getPage());
			ratt.addFlashAttribute("pageSize", sc.getPageSize());
			ratt.addFlashAttribute("status", sc.getStatus());
			ratt.addFlashAttribute("ph", pageHandler);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/notice/listform";
	}
	
	@GetMapping("/listform")
	public void listform() {
		logger.info("listform");
	}
	
	@GetMapping("/info")
	public void noticeInfo(String notice_no, Model model) {
		logger.info("notice/info");
	}
	
	@PostMapping("/info")
	public void noticeInfoPost(String notice_no, String notice_status, Model model) {
		logger.info("notice_no = {}, notice_status = {}", notice_no, (notice_status == "0" ? "공지사항" : "자주묻는질문"));
	}
	
}
