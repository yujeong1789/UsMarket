package com.spring.usMarket.product.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.usMarket.common.SearchCondition;
import com.spring.usMarket.controller.IndexController;
import com.spring.usMarket.product.domain.ProductCategoryDto;
import com.spring.usMarket.product.domain.ProductDto;
import com.spring.usMarket.product.domain.ProductPageHandler;
import com.spring.usMarket.product.service.ProductService;

@Controller
@RequestMapping("/product")
public class ProductController {
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	@Autowired
	ProductService productService;
	
	
	@GetMapping("/list")
	public String list(ProductPageHandler pc, Model model) throws Exception {
		logger.info("ProductSearchCondition= "+pc.toString());
		
		// 1. 전체 카테고리 뽑기
		List<ProductCategoryDto>categoryList=productService.getProductCategory1();
		logger.info("categoryList.size()= "+categoryList.size());
		model.addAttribute("categoryList", categoryList);
		
		// 2. 선택된 카테고리의 하위 카테고리 뽑기
		List<ProductCategoryDto>categoryList2=productService.getProductCategory2(pc.getCategory1());
		model.addAttribute("categoryList2", categoryList2);
		
		// 3. 해당 분류에 속하는 상품 뽑기
		List<ProductDto> productList=productService.getProductByCategory(pc);
		model.addAttribute("productList", productList);
		
		return "product.list";
	}
}
