package com.usMarket.test.customer;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;

import com.spring.usMarket.dao.qna.QnaDao;
import com.spring.usMarket.domain.qna.QnaInsertDto;
import com.spring.usMarket.utils.QnaSearchCondition;

@Transactional
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class QnaTest {

	@Autowired private QnaDao qnaDao;
	
	private final int MEMBER_NO = 2;
	private final String QNA_NO = "dummy";
	
	@Test
	public void qnaTest() throws Exception{
		// insertQna
		int insertQnaResult = qnaDao.insertQna(new QnaInsertDto(QNA_NO, MEMBER_NO, 1, "dummy_title", "", "dummy_content"));
		assertEquals(insertQnaResult, 1);
		
		// searchQnaInfo
		Map<String, Object> qnaInfo = qnaDao.searchQnaInfo(QNA_NO);
		assertNotNull(qnaInfo);
		
		// searchQnaList
		List<Map<String, Object>> qnaList = qnaDao.searchQnaList(new QnaSearchCondition(1, 30, String.valueOf(MEMBER_NO)));
		assertEquals(qnaList.size(), 1);
		
		// searchQnaCnt
		int qnaCnt = qnaDao.searchQnaCnt(String.valueOf(MEMBER_NO));
		assertEquals(qnaCnt, 1);
		
		// searchQnaReply
		Map<String, Object> qnaReply = qnaDao.searchQnaReply(QNA_NO);
		assertNull(qnaReply);
	}
}
