package com.spring.usMarket.dao.deal;

import java.util.List;
import java.util.Map;

import com.spring.usMarket.domain.deal.DealInsertDto;

public interface DealDao {
	int insertDeal(DealInsertDto dto) throws Exception;
	int updateAddress(String member_zipcode, String member_address, String member_address_detail, Integer customer_no) throws Exception;
	List<Map<String, Object>> searchDealList(String state, String condition, String member_no) throws Exception;
	Map<String, Object> searchDealInfo(String deal_no) throws Exception;
	int updateDealState(String deal_state, String deal_no) throws Exception;
}
