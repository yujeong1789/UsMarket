package com.spring.usMarket.deal.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.usMarket.deal.domain.DealInsertDto;

@Repository
public class DealDaoImpl implements DealDao{
	@Autowired
	private SqlSession session;
	private static String namespace = "com.mybatis.mapper.deal.";
	
	@Override
	public int insertDeal(DealInsertDto dto) throws Exception {
		return session.insert(namespace+"insertDeal", dto);
	}

}
