package com.spring.usMarket.dao.product;

import java.util.List;
import java.util.Map;

import com.spring.usMarket.domain.product.ProductCategoryDto;

public interface ProductCategoryDao {
	List<Map<String, Object>> searchProductCategory1() throws Exception;
	List<ProductCategoryDto> searchProductCategory2(Integer product_category1_no) throws Exception;
	List<Map<String, Object>> searchCategory2(Integer product_category1_no) throws Exception;
}
