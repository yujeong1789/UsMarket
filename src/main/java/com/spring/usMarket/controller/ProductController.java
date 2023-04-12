package com.spring.usMarket.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.usMarket.domain.product.ProductCategoryDto;
import com.spring.usMarket.domain.product.ProductDto;
import com.spring.usMarket.domain.product.ProductFileDto;
import com.spring.usMarket.domain.product.ProductInsertDto;
import com.spring.usMarket.service.product.ProductFileService;
import com.spring.usMarket.service.product.ProductService;
import com.spring.usMarket.utils.PageHandler;
import com.spring.usMarket.utils.SearchCondition;
import com.spring.usMarket.utils.SessionParameters;

@Controller
@RequestMapping("/product")
public class ProductController {
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	@Autowired ProductService productService;
	@Autowired ProductFileService fileService;
	
	@GetMapping("/list")
	public void list(SearchCondition sc, Model model){
		sc.setPageSize(30);
		logger.info("queryString = "+sc.getQueryString(sc.getPage()));
		
		try {
			if(sc.getKeyword() == null || sc.getKeyword() == "") {
				// 검색 아닐시 하위 카테고리 출력
				List<ProductCategoryDto>categoryList2 = productService.getProductCategory2(sc.getCategory1());
				String category1_name = categoryList2.get(0).getProduct_category1_name();
				
				model.addAttribute("categoryList2", categoryList2);
				model.addAttribute("category1_name", category1_name);
			} // if
			
			List<ProductDto> productList = productService.getProductByCategory(sc);
			int totalCnt = productService.getProductCount(sc);
			
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
	public String info(String product_no, HttpServletRequest request, Model model
						, HttpServletResponse response) {
		
		logger.info("product_no = {}", product_no);
		
		Cookie viewCookie = null;
		
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				if(cookie.getName().equals("product_no")) {
					viewCookie = cookie;
					logger.info("viewCookie name = {}, value = {}", viewCookie.getName(), viewCookie.getValue().toString());
				}
			}
		}
		
		Map<String, Object> productInfo = new HashMap<>();
		try {
			
			if(viewCookie != null) {
				if(!viewCookie.getValue().contains("[" + product_no + "]")) {
					productService.modifyProductView(product_no);
					
					viewCookie.setValue(viewCookie.getValue() + "_[" + product_no + "]");
					viewCookie.setPath("/");
					viewCookie.setMaxAge(60 * 60 * 24);
					
					response.addCookie(viewCookie);
				} 
			} else {
				productService.modifyProductView(product_no);
				Cookie newCookie = new Cookie("product_no", "[" + product_no + "]");
				
				newCookie.setPath("/");
				newCookie.setMaxAge(60 * 60 * 24);
				
				response.addCookie(newCookie);
			}
			
			productInfo = productService.getProductInfo(product_no);
			model.addAttribute("productInfo", productInfo);
			
			if(productInfo != null) {
				List<String> productImage = productService.getProductImage(product_no);
				ObjectMapper mapper = new ObjectMapper();
				String jsonText = mapper.writeValueAsString(productImage);
				
				model.addAttribute("jsonText", jsonText);
				
				int bookmarkStatus = 0;
				boolean isMyProduct = productInfo.get("SELLER_NO").toString().equals(SessionParameters.getUserNo(request));
				logger.info("isMyProduct = {}", isMyProduct);
				if(request.getSession().getAttribute("userNo") != null && !isMyProduct) {
					Integer member_no = Integer.parseInt(SessionParameters.getUserNo(request));
					bookmarkStatus = productService.getBookmarkByInfo(member_no + product_no);
					
				}
				
				model.addAttribute("bookmarkStatus", bookmarkStatus);
				model.addAttribute("isMyProduct", isMyProduct);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} // try-catch
		
		return "/product/info";
	}
	
	
	@GetMapping("/sell")
	public void sell(){
		logger.info("product/sell");
	}

	
	@PostMapping("/buy")
	public void buy(String product_no, HttpServletRequest request, Model model) {
		String customer_no = SessionParameters.getUserNo(request);
		
		logger.info("buy product_no = {}, customer_no = {}", product_no, customer_no);
		try {
			Map<String, Object> productOrderInfo = productService.getProductOrderInfo(product_no);
			
			model.addAttribute("product_no", product_no);
			model.addAttribute("customer_no", customer_no);
			model.addAttribute("productOrderInfo", productOrderInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
