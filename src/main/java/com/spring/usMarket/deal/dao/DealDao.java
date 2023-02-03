package com.spring.usMarket.deal.dao;

import com.spring.usMarket.deal.domain.DealInsertDto;

public interface DealDao {
	int insertDeal(DealInsertDto dto) throws Exception;
	int updateAddress(String member_zipcode, String member_address, String member_address_detail, Integer customer_no) throws Exception;
}
