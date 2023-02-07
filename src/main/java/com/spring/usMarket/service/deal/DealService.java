package com.spring.usMarket.service.deal;

import com.spring.usMarket.domain.deal.DealInsertDto;

public interface DealService {
	boolean addDeal(DealInsertDto dto, String isUpdate) throws Exception;
}
