package com.spring.usMarket.dao.qna;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.usMarket.domain.qna.QnaInsertDto;
import com.spring.usMarket.utils.QnaSearchCondition;

@Repository
public class QnaDaoImpl implements QnaDao {
	@Autowired
	private SqlSession session;
	private static String namespace = "com.mybatis.mapper.qna.";
	
	@Override
	public int insertQna(QnaInsertDto dto) throws Exception {
		return session.insert(namespace+"insertQna", dto);
	}

	@Override
	public Map<String, Object> searchQnaInfo(String qna_no) throws Exception {
		return session.selectOne(namespace+"searchQnaInfo", qna_no);
	}

	@Override
	public List<Map<String, Object>> searchQnaList(QnaSearchCondition sc) throws Exception {
		return session.selectList(namespace+"searchQnaList", sc);
	}

	@Override
	public int searchQnaCnt(String member_no) throws Exception {
		return session.selectOne(namespace+"searchQnaCnt", member_no);
	}

	@Override
	public Map<String, Object> searchQnaReply(String qna_no) throws Exception {
		return session.selectOne(namespace+"searchQnaReply", qna_no);
	}

}
