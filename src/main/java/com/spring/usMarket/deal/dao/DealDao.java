package com.spring.usMarket.deal.dao;

import com.spring.usMarket.deal.domain.DealInsertDto;

public interface DealDao {
	int insertDeal(DealInsertDto dto) throws Exception;
}
