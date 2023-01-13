package com.spring.usMarket.product.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.usMarket.product.domain.ProductCategoryDto;

@Repository
public class ProductCategoryDaoImpl implements ProductCategoryDao{
	@Autowired 
	private SqlSession session;
	private static String namespace="com.mybatis.mapper.product.";
	
	@Override
	public List<Map<String, Object>> searchProductCategory1() throws Exception {
		return session.selectList(namespace+"searchProductCategory1");
	}

	@Override
	public List<ProductCategoryDto> searchProductCategory2(Integer product_category1_no) throws Exception {
		return session.selectList(namespace+"searchProductCategory2", product_category1_no);
	}

	@Override
	public List<Map<String, Object>> searchCategory2(Integer product_category1_no) throws Exception {
		return session.selectList(namespace+"searchCategory2", product_category1_no);
	}

}
