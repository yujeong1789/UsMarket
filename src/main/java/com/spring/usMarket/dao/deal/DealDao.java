package com.spring.usMarket.dao.deal;

import com.spring.usMarket.domain.deal.DealInsertDto;

public interface DealDao {
	int insertDeal(DealInsertDto dto) throws Exception;
	int updateAddress(String member_zipcode, String member_address, String member_address_detail, Integer customer_no) throws Exception;
}
