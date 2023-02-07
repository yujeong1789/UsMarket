package com.spring.usMarket.dao.deal;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.usMarket.domain.deal.DealInsertDto;

@Repository
public class DealDaoImpl implements DealDao{
	@Autowired
	private SqlSession session;
	private static String namespace = "com.mybatis.mapper.deal.";
	
	@Override
	public int insertDeal(DealInsertDto dto) throws Exception {
		return session.insert(namespace+"insertDeal", dto);
	}

	@Override
	public int updateAddress(String member_zipcode, String member_address, String member_address_detail, Integer customer_no)
			throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("member_zipcode", member_zipcode);
		map.put("member_address", member_address);
		map.put("member_address_detail", member_address_detail);
		map.put("member_no", customer_no);
		
		return session.update(namespace+"updateAddress", map);
	}

}
