package com.usMarket.test.customer;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;

import com.spring.usMarket.dao.notice.NoticeDao;
import com.spring.usMarket.utils.NoticeSearchCondition;

@Transactional
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class NoticeTest {

	private final String NOTICE_NO = "N20230409JGLBVAFFC";
	
	@Autowired private NoticeDao noticeDao;
	
	@Test
	public void searchNoticeTest() throws Exception{
		// searchNoticeCnt
		int noticeCnt = noticeDao.searchNoticeCnt("0");
		assertNotEquals(noticeCnt, 0);
		
		int faqCnt = noticeDao.searchNoticeCnt("1");
		assertNotEquals(faqCnt, 0);
		
		// searchNoticeList
		List<Map<String, Object>> noticeList = noticeDao.searchNoticeList(new NoticeSearchCondition(1, 100, "0"));
		assertEquals(noticeCnt, noticeList.size());
		
		List<Map<String, Object>> faqList = noticeDao.searchNoticeList(new NoticeSearchCondition(1, 100, "1"));
		assertEquals(faqCnt, faqList.size());
	}
	
	@Test
	public void searchNoticeInfoTest() throws Exception{
		// searchNoticeInfo
		Map<String, Object> noticeInfo = noticeDao.searchNoticeInfo(NOTICE_NO);
		assertNotNull(noticeInfo);	
	}
	
	@Test
	public void updateNoticeViewTest() throws Exception{
		// updateNoticeView
		int updateNoticeView = noticeDao.updateNoticeView(NOTICE_NO);
		assertEquals(updateNoticeView, 1);
	}
	
}
