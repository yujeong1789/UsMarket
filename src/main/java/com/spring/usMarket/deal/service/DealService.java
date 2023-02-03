package com.spring.usMarket.deal.service;

import com.spring.usMarket.deal.domain.DealInsertDto;

public interface DealService {
	boolean addDeal(DealInsertDto dto, String isUpdate) throws Exception;
}
