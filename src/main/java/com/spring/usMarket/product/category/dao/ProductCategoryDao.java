package com.spring.usMarket.product.category.dao;

import java.util.List;
import java.util.Map;

import com.spring.usMarket.product.category.domain.ProductCategoryDto;

public interface ProductCategoryDao {
	public List<ProductCategoryDto> searchProductCategory1() throws Exception;
	public List<ProductCategoryDto> searchProductCategory2(Integer product_category1_no) throws Exception;
}
