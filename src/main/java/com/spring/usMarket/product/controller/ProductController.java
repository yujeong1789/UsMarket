package com.spring.usMarket.product.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	
	@GetMapping("/printAllCategory")
	@ResponseBody
	public List<Map<String, Object>> getAllCategory(){
		List<Map<String, Object>> allCategory = new ArrayList<>();
		
		try {
			allCategory = productService.getProductCategory1();
			logger.info("category1.size()= "+allCategory.size());
		} catch (Exception e) {
			e.printStackTrace();
		} // try-catch
		
		return allCategory;
	}
	
	
	@GetMapping("/list")
	public void list(HttpServletRequest req, SearchCondition sc, Model model){
		sc.setPageSize(30);
		logger.info("SearchCondition= "+sc.toString());
		logger.info("queryString= "+sc.getQueryString(sc.getPage()));
		
		try {
			if(sc.getKeyword()==null || sc.getKeyword()=="") {
				// 검색 아닐시 하위 카테고리 출력
				List<ProductCategoryDto>categoryList2 = productService.getProductCategory2(sc.getCategory1());
				String category1_name = categoryList2.get(0).getProduct_category1_name();
				
				logger.info("category2= "+categoryList2.toString());
				
				model.addAttribute("categoryList2", categoryList2);
				model.addAttribute("category1_name", category1_name);
			} // if
			
			List<ProductDto> productList = productService.getProductByCategory(sc);
			int totalCnt = productService.getProductCount(sc);
			
			logger.info("productList.size()= "+productList.size());
			logger.info("totalCnt= "+totalCnt);
			PageHandler pageHandler = new PageHandler(totalCnt, sc);
			
			model.addAttribute("productList", productList);
			model.addAttribute("page", sc.getPage());
			model.addAttribute("pageSize", sc.getPageSize());
			model.addAttribute("ph", pageHandler);
			
		} catch (Exception e) {
			e.printStackTrace();
		} // try-catch
	}
	
	
	@GetMapping("/info")
	public void info(Integer product_no, Model model) {
		try {
			Map<String, Object> productInfo = productService.getProductInfo(product_no);
			logger.info("productInfo= "+productInfo);
			
			model.addAttribute("productInfo", productInfo);
			
		} catch (Exception e) {
			e.printStackTrace();
		} // try-catch
	}
	
	
    private boolean loginCheck(HttpServletRequest request) {
        // 1. 세션을 얻어서
        HttpSession session = request.getSession();
        // 2. 세션에 id가 있는지 확인, 있으면 true를 반환
        return session.getAttribute("id") != null;
    }
}
