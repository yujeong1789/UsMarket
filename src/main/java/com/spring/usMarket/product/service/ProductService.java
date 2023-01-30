package com.spring.usMarket.product.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.spring.usMarket.common.SearchCondition;
import com.spring.usMarket.product.domain.ProductCategoryDto;
import com.spring.usMarket.product.domain.ProductDto;
import com.spring.usMarket.product.domain.ProductFileDto;
import com.spring.usMarket.product.domain.ProductInsertDto;

public interface ProductService {
	List<Map<String, Object>> getProductCategory1() throws Exception;
	
	List<ProductCategoryDto> getProductCategory2(Integer product_category1_no) throws Exception;
	
	List<Map<String, Object>> getCategory2(Integer product_category1_no) throws Exception;
	
	List<ProductDto> getMainProduct() throws Exception;
	
	List<ProductDto> getProductByCategory(SearchCondition sc) throws Exception;
	
	int getProductCount(SearchCondition sc) throws Exception;
	
	Map<String, Object> getProductInfo(String product_no) throws Exception;
	
	int modifyProductView(String product_no) throws Exception;
	
	Map<String, Object> getSellerInfo(Integer seller_no) throws Exception;
	
	List<Map<String, Object>> getReviewByInfo(Integer seller_no) throws Exception;
	
	int getBookmarkByInfo(Integer current_no, String product_no) throws Exception;
	
	int removeBookmark(Integer member_no, String product_no) throws Exception;
	
	int addBookmark(Integer member_no, String product_no) throws Exception;
	
	int addProduct(ProductInsertDto productInsertDto) throws Exception;
	
	int addProductFile(List<ProductFileDto> productFileList) throws Exception;
	
	List<String> getProductImage(String product_no) throws Exception;
	
	int modifyProductState(Integer product_state_no, String seller_no, String product_no) throws Exception;
	
	int removeProductImage(String product_no) throws Exception;
	
	Map<String, Object> getProductOrderInfo(String product_no) throws Exception;
}
