package com.spring.usMarket.controller;

import java.util.List;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.spring.usMarket.product.domain.ProductDto;
import com.spring.usMarket.product.service.ProductService;

@Controller
public class IndexController { // 메인 페이지 출력
	private static final Logger logger = LoggerFactory.getLogger(IndexController.class);
	@Autowired
	private ProductService productService;

	@GetMapping("/")
	public String main(Model m) throws Exception {

		List<ProductDto> mainProductList = productService.getMainProduct();
		logger.info("mainProductList.size()= " + mainProductList.size());

		m.addAttribute("mainProductList", mainProductList);

		return "index";
	}
}
