package com.spring.usMarket.dao.qna;

import java.util.List;
import java.util.Map;

import com.spring.usMarket.domain.qna.QnaInsertDto;
import com.spring.usMarket.utils.QnaSearchCondition;

public interface QnaDao {
	int insertQna(QnaInsertDto dto) throws Exception;
	Map<String, Object> searchQnaInfo(String qna_no) throws Exception;
	List<Map<String, Object>> searchQnaList(QnaSearchCondition sc) throws Exception;
	int searchQnaCnt(String member_no) throws Exception;
	Map<String, Object> searchQnaReply(String qna_no) throws Exception;
}
