package com.spring.usMarket.deal.service;

import com.spring.usMarket.deal.domain.DealInsertDto;

public interface DealService {
	int addDeal(DealInsertDto dto) throws Exception;
}
