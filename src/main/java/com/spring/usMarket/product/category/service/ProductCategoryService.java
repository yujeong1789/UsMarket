package com.spring.usMarket.product.category.service;

import java.util.List;

import com.spring.usMarket.product.category.domain.ProductCategoryDto;

public interface ProductCategoryService {
	public List<ProductCategoryDto> searchProductCategory1() throws Exception;
	public List<ProductCategoryDto> searchProductCategory2(Integer product_category1_no) throws Exception;
}
