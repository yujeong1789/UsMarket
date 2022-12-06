package com.spring.usMarket.product.dao;

import java.util.List;

import com.spring.usMarket.common.SearchCondition;
import com.spring.usMarket.product.domain.ProductCategoryDto;
import com.spring.usMarket.product.domain.ProductDto;
import com.spring.usMarket.product.domain.ProductPageHandler;

public interface ProductDao {
	List<ProductDto> searchMainProduct() throws Exception;
	List<ProductDto> searchProductByCategory(ProductPageHandler ph) throws Exception;

}
