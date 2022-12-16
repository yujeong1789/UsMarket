package com.spring.usMarket.product.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.usMarket.common.PageHandler;
import com.spring.usMarket.common.SearchCondition;
import com.spring.usMarket.product.domain.ProductCategoryDto;
import com.spring.usMarket.product.domain.ProductDto;
import com.spring.usMarket.product.service.ProductService;

@Controller
@RequestMapping("/product")
public class ProductController {
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	@Autowired
	ProductService productService;
	
	
	@GetMapping("/list")
	public void list(SearchCondition sc, Model model){
		sc.setPageSize(30);
		logger.info("SearchCondition= "+sc.toString());
		logger.info("queryString= "+sc.getQueryString(sc.getPage()));
		
		try {
			// 1. 전체 카테고리 뽑기
			List<ProductCategoryDto> categoryList = productService.getProductCategory1();
			model.addAttribute("categoryList", categoryList);
		
			
			// 2. 선택된 카테고리의 하위 카테고리 뽑기
			List<ProductCategoryDto>categoryList2=productService.getProductCategory2(sc.getCategory1());
			model.addAttribute("categoryList2", categoryList2);
			
			
			// 3. 해당 분류에 속하는 상품 뽑기
			List<ProductDto> productList=productService.getProductByCategory(sc);
			int totalCnt=productService.getProductCount(sc);
			logger.info("productList.size()= "+productList.size());
			logger.info("totalCnt= "+totalCnt);
			PageHandler pageHandler=new PageHandler(totalCnt, sc);
			
			
			model.addAttribute("productList", productList);
			model.addAttribute("page", sc.getPage());
			model.addAttribute("pageSize", sc.getPageSize());
			model.addAttribute("ph", pageHandler);
			
		} catch (Exception e) {
			e.printStackTrace();
		} // try-catch
			
		
		//return "product/list";
		
	}
}
