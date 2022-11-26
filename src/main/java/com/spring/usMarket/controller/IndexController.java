package com.spring.usMarket.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.spring.usMarket.product.category.domain.ProductCategoryDto;
import com.spring.usMarket.product.category.service.ProductCategoryService;

@Controller
public class IndexController { // 메인 페이지 출력
	private static final Logger logger=LoggerFactory.getLogger(IndexController.class);
	
	@Autowired
	private ProductCategoryService productCategoryService;
	
	@GetMapping("/")
	public String main(Model m) throws Exception {
		List<ProductCategoryDto>list=productCategoryService.searchProductCategory1();
		System.out.println("productCategory.size= "+list.size());
		m.addAttribute("productCategory", list);
		
		return "index";
		
	}
}
