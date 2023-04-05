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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.usMarket.service.qna.QnaService;
import com.spring.usMarket.utils.QnaPageHandler;
import com.spring.usMarket.utils.QnaSearchCondition;
import com.spring.usMarket.utils.SessionParameters;

@Controller
@RequestMapping("/qna")
public class QnaController {
	private static final Logger logger = LoggerFactory.getLogger(QnaController.class);
	
	@Autowired QnaService qnaService;
	
	@GetMapping("/list")
	public void qnaList(Model model, HttpServletRequest request) {
		
		QnaSearchCondition sc = new QnaSearchCondition();
		sc.setMember_no(SessionParameters.getUserNo(request));
		sc.setPageSize(10);
		
		logger.info("qnaSearchCondition = {}", sc.toString());
		
		List<Map<String, Object>> qnaList = new ArrayList<>();
		int totalCnt = 0;
		
		try {
			qnaList = qnaService.getQnaList(sc);
			totalCnt = qnaService.getQnaCnt(sc.getMember_no());
			QnaPageHandler pageHandler = new QnaPageHandler(totalCnt, sc);
			
			model.addAttribute("qnaList", qnaList);
			model.addAttribute("page", sc.getPage());
			model.addAttribute("pageSize", sc.getPageSize());
			model.addAttribute("ph", pageHandler);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@PostMapping("/list")
	public String qnaListPost(@RequestBody QnaSearchCondition sc, HttpServletRequest request, RedirectAttributes ratt) {
		
		sc.setMember_no(SessionParameters.getUserNo(request));
		logger.info("qnaSearchCondition = {}", sc.toString());
		
		List<Map<String, Object>> qnaList = new ArrayList<>();
		int totalCnt = 0;
		
		try {
			qnaList = qnaService.getQnaList(sc);
			totalCnt = qnaService.getQnaCnt(sc.getMember_no());
			QnaPageHandler pageHandler = new QnaPageHandler(totalCnt, sc);
			
			 ratt.addFlashAttribute("qnaList", qnaList);
			 ratt.addFlashAttribute("page", sc.getPage());
			 ratt.addFlashAttribute("pageSize", sc.getPageSize());
			 ratt.addFlashAttribute("ph", pageHandler);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/qna/listform";
	}
	
	@GetMapping("/listform")
	public void listform() throws Exception{
		logger.info("listform");
	}
	
	@GetMapping("/new")
	public String qnaWrite(Model model) {
		
		model.addAttribute("mode", "new");
		
		return "/qna/info";
	}
	
	@GetMapping("/read")
	public String qnaInfo(String qna_no, Model model) {
		
		logger.info("qna_no = {}", qna_no);
		model.addAttribute("mode", "read");
		Map<String, Object> qnaInfo = new HashMap<>();
		try {
			qnaInfo = qnaService.getQnaInfo(qna_no);
			model.addAttribute("qnaInfo", qnaInfo);
			
			String qna_complete = qnaInfo.get("QNA_COMPLETE").toString();
			if(qna_complete == "Y" || qna_complete.equals("Y")) {
				Map<String, Object> qnaReply = new HashMap<>();
				model.addAttribute("qnaReply", qnaReply);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/qna/info";
	}
}
