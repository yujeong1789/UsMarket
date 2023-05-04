package com.spring.usMarket.service.product;

import java.util.List;
import java.util.Map;

import com.spring.usMarket.domain.product.ProductCategoryDto;
import com.spring.usMarket.domain.product.ProductDto;
import com.spring.usMarket.domain.product.ProductFileDto;
import com.spring.usMarket.domain.product.ProductInsertDto;
import com.spring.usMarket.utils.SearchCondition;

public interface ProductService {
	List<Map<String, Object>> getProductCategory1() throws Exception;
	
	List<ProductCategoryDto> getProductCategory2(String product_category1_no) throws Exception;
	
	List<Map<String, Object>> getCategory2(String product_category1_no) throws Exception;
	
	List<ProductDto> getBestProduct() throws Exception;
	
	List<ProductDto> getMainProduct() throws Exception;
	
	List<ProductDto> getProductByCategory(SearchCondition sc) throws Exception;
	
	int getProductCount(SearchCondition sc) throws Exception;
	
	Map<String, Object> getProductInfo(String product_no) throws Exception;
	
	int modifyProductView(String product_no) throws Exception;
	
	Map<String, Object> getSellerInfo(Integer seller_no) throws Exception;
	
	List<Map<String, Object>> getReviewByInfo(Integer seller_no) throws Exception;
	
	int getBookmarkByInfo(String bookmark_no) throws Exception;
	
	int removeBookmark(String bookmark_no) throws Exception;
	
	int addBookmark(Integer member_no, String product_no) throws Exception;
	
	int addProduct(ProductInsertDto productInsertDto) throws Exception;
	
	int addProductFile(List<ProductFileDto> productFileList) throws Exception;
	
	List<String> getProductImage(String product_no) throws Exception;
	
	int modifyProductState(Integer product_state_no, String seller_no, String product_no) throws Exception;
	
	int removeProductImage(String product_no) throws Exception;
	
	Map<String, Object> getProductOrderInfo(String product_no) throws Exception;
	
	Map<String, Object> getCustomerInfo(String customer_no) throws Exception;
}
