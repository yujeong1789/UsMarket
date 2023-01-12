package com.spring.usMarket.product.service;

import java.util.List;
import java.util.Map;

import com.spring.usMarket.common.SearchCondition;
import com.spring.usMarket.product.domain.ProductCategoryDto;
import com.spring.usMarket.product.domain.ProductDto;

public interface ProductService {
	List<Map<String, Object>> getProductCategory1() throws Exception;
	
	List<ProductCategoryDto> getProductCategory2(Integer product_category1_no) throws Exception;
	
	List<ProductDto> getMainProduct() throws Exception;
	
	List<ProductDto> getProductByCategory(SearchCondition sc) throws Exception;
	
	int getProductCount(SearchCondition sc) throws Exception;
	
	Map<String, Object> getProductInfo(Integer product_no) throws Exception;
	
	int modifyProductView(Integer product_no) throws Exception;
	
	Map<String, Object> getSellerInfo(Integer seller_no) throws Exception;
	
	List<Map<String, Object>> getReviewByInfo(Integer seller_no) throws Exception;
	
	int getBookmarkByInfo(Integer current_no, Integer product_no) throws Exception;
	
	int removeBookmark(Integer member_no, Integer product_no) throws Exception;
	
	int addBookmark(Integer member_no, Integer product_no) throws Exception;
}
