package com.spring.usMarket.deal.service;

import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.usMarket.deal.dao.DealDao;
import com.spring.usMarket.deal.domain.DealInsertDto;

@Service
public class DealServiceImpl implements DealService{
	private static final Logger logger = LoggerFactory.getLogger(DealService.class);
	
	@Autowired DealDao dealDao;

	@Override
	@Transactional(rollbackFor = SQLException.class)
	public int addDeal(DealInsertDto dto) throws Exception {
		int rowCnt = dealDao.insertDeal(dto);
		logger.info("거래내역 등록 결과 = {}", rowCnt);
		return rowCnt;
	}

}
