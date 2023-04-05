package com.spring.usMarket.service.qna;

import java.util.List;
import java.util.Map;

import com.spring.usMarket.domain.qna.QnaInsertDto;
import com.spring.usMarket.utils.QnaSearchCondition;

public interface QnaService {
	int addQna(QnaInsertDto dto) throws Exception;
	Map<String, Object> getQnaInfo(String qna_no) throws Exception;
	List<Map<String, Object>> getQnaList(QnaSearchCondition sc) throws Exception;
	int getQnaCnt(String member_no) throws Exception;
}
