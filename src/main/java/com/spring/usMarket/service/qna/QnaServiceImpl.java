package com.spring.usMarket.service.qna;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.usMarket.dao.qna.QnaDao;
import com.spring.usMarket.domain.qna.QnaInsertDto;
import com.spring.usMarket.utils.QnaSearchCondition;

@Service
public class QnaServiceImpl implements QnaService{
	private static final Logger logger = LoggerFactory.getLogger(QnaService.class);
	
	@Autowired QnaDao qnaDao;

	public String getResult(int rowCnt) {
		return rowCnt == 1 ? "SUCCESS" : "FAIL";
	}
	
	@Override
	@Transactional(rollbackFor = SQLException.class)
	public int addQna(QnaInsertDto dto) throws Exception{
		
		int rowCnt = qnaDao.insertQna(dto);
		logger.info("문의 등록 결과 = {}", getResult(rowCnt));
		
		return rowCnt;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public Map<String, Object> getQnaInfo(String qna_no) throws Exception {
		
		Map<String, Object> map = qnaDao.searchQnaInfo(qna_no);
		logger.info("문의 조회 결과 = {}", map.toString());
		
		return map;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getQnaList(QnaSearchCondition sc) throws Exception {
		
		List<Map<String, Object>> listMap = qnaDao.searchQnaList(sc);
		logger.info("문의 목록 조회 결과 = {}", listMap.size());
		
		return listMap;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public int getQnaCnt(String member_no) throws Exception {
		
		int totalCnt = qnaDao.searchQnaCnt(member_no);
		logger.info("문의 수 조회 결과 = {}", totalCnt);
		
		return totalCnt;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public Map<String, Object> getQnaReply(String qna_no) throws Exception {
		
		Map<String, Object> map = qnaDao.searchQnaReply(qna_no);
		logger.info("문의 답변 조회 결과 = {}", map.toString());
		
		return map;
	}

}
