package com.spring.usMarket.product.dao;

import java.util.List;
import java.util.Map;

import com.spring.usMarket.common.SearchCondition;
import com.spring.usMarket.product.domain.ProductDto;

public interface ProductDao {
	List<ProductDto> searchMainProduct() throws Exception;
	
	List<ProductDto> searchProductByCategory(SearchCondition sc) throws Exception;
	
	int searchProductCount(SearchCondition sc) throws Exception;
	
	Map<String, Object> searchProductInfo(Integer product_no) throws Exception;
	
	int updateProductView(Integer product_no) throws Exception;
	
	Map<String, Object> searchSellerInfo(Integer seller_no) throws Exception;
	
	List<Map<String, Object>> searchReviewByInfo(Integer seller_no) throws Exception;
	
	int searchBookmarkByInfo(Integer current_no, Integer product_no) throws Exception;
	
	int deleteBookmark(Integer member_no, Integer product_no) throws Exception;
	
	int insertBookmark(Integer member_no, Integer product_no) throws Exception;
	
	int searchMemberNo(String member_id) throws Exception;
}
