package com.spring.usMarket.product.dao;

import java.util.List;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.usMarket.common.SearchCondition;
import com.spring.usMarket.product.domain.ProductDto;

@Repository
public class ProductDaoImpl implements ProductDao {
	@Autowired 
	private SqlSession session;
	private static String namespace="com.mybatis.mapper.product.";
	
	@Override
	public List<ProductDto> searchMainProduct() throws Exception {
		return session.selectList(namespace+"searchMainProduct");
	}

	@Override
	public List<ProductDto> searchProductByCategory(SearchCondition sc) throws Exception {
		return session.selectList(namespace+"searchProductByCategory", sc);
	}

	@Override
	public int searchProductCount(SearchCondition sc) throws Exception {
		return session.selectOne(namespace+"searchProductCount", sc);
	}

	@Override
	public Map<String, Object> searchProductInfo(Integer product_no) throws Exception {
		return session.selectOne(namespace+"searchProductInfo", product_no);
	}

	@Override
	public int updateProductView(Integer product_no) throws Exception {
		return session.update(namespace+"updateProductView", product_no);
	}

	@Override
	public Map<String, Object> searchSellerInfo(Integer seller_no) throws Exception {
		return session.selectOne(namespace+"searchSellerInfo", seller_no);
	}

	@Override
	public List<Map<String, Object>> searchReviewByInfo(Integer seller_no) throws Exception {
		return session.selectList(namespace+"searchReviewByInfo", seller_no);
	}

}
