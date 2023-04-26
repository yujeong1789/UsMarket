package com.spring.usMarket.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.spring.usMarket.domain.product.ProductDto;
import com.spring.usMarket.service.notice.NoticeService;
import com.spring.usMarket.service.product.ProductService;
import com.spring.usMarket.utils.NoticeSearchCondition;

@Controller
public class IndexController { // 메인 페이지 출력
	private static final Logger logger = LoggerFactory.getLogger(IndexController.class);
	
	@Autowired private ProductService productService;
	@Autowired private NoticeService noticeService;
	
	@GetMapping("/")
	public String main(Model m) throws Exception {

		List<ProductDto> mainProductList = productService.getMainProduct();
		logger.info("mainProductList.size()= " + mainProductList.size());

		m.addAttribute("mainProductList", mainProductList);

		return "index";
	}
	
	@GetMapping("/help")
	public String help(Model model) {
		
		NoticeSearchCondition sc = new NoticeSearchCondition();
		sc.setPageSize(5);
		
		logger.info("NoticeSearchCondition = {}", sc.toString());
		
		List<Map<String, Object>> noticeList = new ArrayList<>();
		List<Map<String, Object>> faqList = new ArrayList<>();
		try {
			sc.setStatus("0");
			noticeList = noticeService.getNoticeList(sc);

			sc.setStatus("1");
			faqList = noticeService.getNoticeList(sc);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("faqList", faqList);
		
		return "/help/help";
	}
}
