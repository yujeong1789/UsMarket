package com.spring.usMarket.product.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.usMarket.common.PageHandler;
import com.spring.usMarket.common.SearchCondition;
import com.spring.usMarket.product.domain.ProductCategoryDto;
import com.spring.usMarket.product.domain.ProductDto;
import com.spring.usMarket.product.domain.ProductFileDto;
import com.spring.usMarket.product.domain.ProductInsertDto;
import com.spring.usMarket.product.service.ProductFileService;
import com.spring.usMarket.product.service.ProductService;

@Controller
@RequestMapping("/product")
public class ProductController {
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	
	private static final int ADDED = 1;
	private static final int NOT_ADDED = 0;
	
	@Autowired
	ProductService productService;
	
	@Autowired
	ProductFileService fileService;
	
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
	public void info(String product_no, HttpServletRequest request, Model model) {
		try {
			Map<String, Object> productInfo = productService.getProductInfo(product_no);
			List<String> productImage = productService.getProductImage(product_no);			
			model.addAttribute("productImage", productImage);
			model.addAttribute("productInfo", productInfo);
			
		} catch (Exception e) {
			e.printStackTrace();
		} // try-catch
	}
	
	
	@GetMapping("/buy")
	public void buy() {
		logger.info("product/buy");
	}
	
	
	@GetMapping("/like")
	public String like(HttpServletRequest request, String product_no, Integer status) {
		
		Integer member_no = Integer.parseInt(String.valueOf(request.getSession().getAttribute("userNo")));
		
		logger.info("like, member_id = {}, member_no = {}", request.getSession().getAttribute("userId").toString(), member_no);
		
		try {
			if(status == ADDED) {
				// 이미 북마크 추가된 상태면 삭제
				productService.removeBookmark(member_no, product_no);
			}else if(status == NOT_ADDED) {
				// 추가되지 않은 상태면 북마크 추가
				productService.addBookmark(member_no, product_no);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} // try-catch
		
		return "redirect:/product/info?product_no="+product_no;
	}
	
	
	@GetMapping("/sell")
	public void sell(){
		logger.info("product/sell");
	}
	
	
	@PostMapping("/sell")
	public String addProduct(MultipartHttpServletRequest request, ProductInsertDto dto){
		try {
			// 1. 상품 등록
			logger.info("productInsertDto = {}", dto.toString());
			int result = productService.addProduct(dto);
			
			if(result != 1) return "redirect:/product/sell";
			
			// 2. 파일 업로드
			List<ProductFileDto> list = fileService.upload(request.getFiles("product_img"), dto.getProduct_no());
			
			// 3. 파일 db에 insert
			int rowCnt = productService.addProductFile(list);
			logger.info("addProductFile result = {}", (list.size() == rowCnt ? "SUCCESS" : "FAIL"));
			
		} catch (Exception e) {
			e.printStackTrace();
		} // try-catch
				
		return "redirect:/product/info?product_no="+dto.getProduct_no();
	}
	
	
	
/*	
    private boolean loginCheck(HttpServletRequest request) {
        // 1. 세션을 얻어서
        HttpSession session = request.getSession();
        // 2. 세션에 id가 있는지 확인, 있으면 true를 반환
        return session.getAttribute("userId") != null;
    }
*/
}
