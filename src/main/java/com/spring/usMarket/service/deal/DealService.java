package com.spring.usMarket.service.deal;

import java.util.List;
import java.util.Map;

import com.spring.usMarket.domain.deal.DealInsertDto;

public interface DealService {
	boolean addDeal(DealInsertDto dto, String isUpdate) throws Exception;
	List<Map<String, Object>> getDealList(String state, String condition, String member_no) throws Exception;
	Map<String, Object> getDealInfo(String deal_no) throws Exception;
	int modifyDealState(String deal_state, String deal_no) throws Exception;
}
