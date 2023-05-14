package com.usMarket.test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;

import com.spring.usMarket.domain.product.ProductCategoryDto;
import com.spring.usMarket.domain.product.ProductDto;
import com.spring.usMarket.domain.product.ProductInsertDto;
import com.spring.usMarket.service.product.ProductService;
import com.spring.usMarket.utils.SearchCondition;

@Transactional
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class ProductServiceTest {
	
	private static int DUMMY_MEMBER_NO = 3;
	private static String RANDOM_CATEGORY_1 = String.valueOf((int)((Math.random()*15)+1)); // product_category1 범위 내 난수 생성
	
	@Autowired private ProductService productService;
	
	@Test
	public void getCategoryTest() throws Exception{
		// getProductCategory1
		List<Map<String, Object>> category1 = productService.getProductCategory1();
		assertEquals(category1.size(), 15);
		
		// getProductCategory2
		List<ProductCategoryDto> category2 = productService.getProductCategory2(RANDOM_CATEGORY_1);
		assertNotNull(category2);
	}
	
	@Test
	public void getMainProductTest() throws Exception{
		// getMainProduct
		List<ProductDto> list = productService.getMainProduct();
		assertEquals(list.size(), 15);
	}
	
	@Test
	public void getBestProductTest() throws Exception{
		// getBestProduct
		List<ProductDto> list = productService.getBestProduct();
		assertEquals(list.size(), 5);
	}
	
	@Test
	public void setBookmarkTest() throws Exception{
		SearchCondition sc = new SearchCondition(1, 30, "", "", "1", "1");
		
		// getProductByCategory
		List<ProductDto> productList = productService.getProductByCategory(sc);
		
		List<String> productNoList = new ArrayList<>();
		for (ProductDto dto : productList) {
			productNoList.add(dto.getProduct_no());
		}
		
		String randomProductNo = productNoList.get((int)((Math.random()*productNoList.size()))).toString();
		
		// getBookmarkByInfo
		int bookmarkStatus = productService.getBookmarkByInfo(DUMMY_MEMBER_NO+randomProductNo);
		
		int result = 0;
		if(bookmarkStatus == 0) {
			// addBookmark
			result = productService.addBookmark(DUMMY_MEMBER_NO, randomProductNo);
		}else if(bookmarkStatus == 1) {
			// removeBookmark
			result = productService.removeBookmark(DUMMY_MEMBER_NO+randomProductNo);
		}
		
		assertEquals(result, 1);
	}
	
	@Test
	public void productTest() throws Exception{
		String product_no = "9999999";
		ProductInsertDto dto = new ProductInsertDto(product_no, DUMMY_MEMBER_NO, 1, 1, "test title", "N", "N", 150000, "test content", "t a g");
		
		// addProduct
		int addResult = productService.addProduct(dto);
		assertEquals(addResult, 1);
		
		// modifyProductState (= removeProduct)
		int modifyResult = productService.modifyProductState(3, String.valueOf(DUMMY_MEMBER_NO), product_no);
		assertEquals(modifyResult, 1);
		
		// getProductInfo
		Map<String, Object> productInfo = productService.getProductInfo(product_no);
		assertNotNull(productInfo.size());
		
		// modifyProductView
		int modifyViewCount = productService.modifyProductView(product_no);
		assertEquals(modifyViewCount, 1);
		
		// getSellerInfo
		Map<String, Object> sellerInfo = productService.getSellerInfo(DUMMY_MEMBER_NO);
		assertNotNull(sellerInfo);
	}
	
	public void getReviewTest() throws Exception{
		// getReviewByInfo
		List<Map<String, Object>> reviewInfo = productService.getReviewByInfo(212);
		assertNotNull(reviewInfo);
	}
	
	public void getCustomerTest() throws Exception{
		// getCustomerInfo
		Map<String, Object> customerInfo = productService.getCustomerInfo("243");
		assertNotNull(customerInfo);
	}
	
	public void getProductOrderTest() throws Exception{
		// getProductOrderInfo
		Map<String, Object> orderInfo = productService.getProductOrderInfo("230209204428375");
		assertNotNull(orderInfo);
	}

}
