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
import com.spring.usMarket.utils.SessionParameters;

@Controller
@RequestMapping("/admin/qna")
public class AdminQnaController {
	private static final Logger logger = LoggerFactory.getLogger(AdminQnaController.class);
	
	@Autowired AdminService adminService;
	
	@GetMapping("/list")
	public void qnaList(Model model) {
		
		AdminSearchCondition sc = new AdminSearchCondition();
		
		sc.setPageSize(10);
		sc.setOrder("regdate_desc");
		
		logger.info("adminSearchCondition = {}", sc.toString());
		
		List<Map<String, Object>> qnaList = new ArrayList<>();
		int totalCnt = 0;
		
		try {
			qnaList = adminService.getQnaList(sc);
			totalCnt = adminService.getQnaCnt(sc.getComplete());
			AdminPageHandler pageHandler = new AdminPageHandler(totalCnt, sc);
			 
			model.addAttribute("qnaList", qnaList);
			model.addAttribute("page", sc.getPage());
			model.addAttribute("pageSize", sc.getPageSize());
			model.addAttribute("ph", pageHandler);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@PostMapping("/list")
	public String qnaListPost(@RequestBody AdminSearchCondition sc, HttpServletRequest request, RedirectAttributes ratt) {
		
		sc.setMember_no(SessionParameters.getUserNo(request));
		logger.info("qnaSearchCondition = {}", sc.toString());
		
		List<Map<String, Object>> qnaList = new ArrayList<>();
		int totalCnt = 0;
		
		try {
			qnaList = adminService.getQnaList(sc);
			totalCnt = adminService.getQnaCnt(sc.getComplete());
			AdminPageHandler pageHandler = new AdminPageHandler(totalCnt, sc);
			
			ratt.addFlashAttribute("qnaList", qnaList);
			ratt.addFlashAttribute("page", sc.getPage());
			ratt.addFlashAttribute("pageSize", sc.getPageSize());
			ratt.addFlashAttribute("complete", sc.getComplete());
			ratt.addFlashAttribute("ph", pageHandler);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/admin/qna/listform";
	}
	
	@GetMapping("/listform")
	public void listform() throws Exception{
		logger.info("listform");
	}
	
	@GetMapping("/info")
	public void qnaInfo() {
		logger.info("qna/info");
	}
	
	@PostMapping("/info")
	public void qnaInfoPost(Model model, String qna_no) {
		
		logger.info("qna_no = {}", qna_no);
		
		Map<String, Object> infoMap = new HashMap<>();
		
		try {
			infoMap = adminService.getQnaInfo(qna_no);
			
			String qna_complete = infoMap.get("QNA_COMPLETE").toString();
			if(qna_complete == "Y" || qna_complete.equals("Y")) {
				Map<String, Object> replyMap = adminService.getQnaReply(qna_no);
				model.addAttribute("replyMap", replyMap);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("infoMap", infoMap);
	}
}
