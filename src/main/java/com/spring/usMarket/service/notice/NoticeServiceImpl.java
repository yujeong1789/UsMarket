package com.spring.usMarket.service.notice;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.usMarket.dao.notice.NoticeDao;
import com.spring.usMarket.utils.NoticeSearchCondition;

@Service
public class NoticeServiceImpl implements NoticeService{
	private static final Logger logger = LoggerFactory.getLogger(NoticeService.class);
	
	@Autowired NoticeDao noticeDao;

	public String getResult(int rowCnt) {
		return rowCnt == 1 ? "SUCCESS" : "FAIL";
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getNoticeList(NoticeSearchCondition sc) throws Exception {
		
		List<Map<String, Object>> listMap = noticeDao.searchNoticeList(sc);
		logger.info("공지사항 목록 조회 결과 = {}", listMap.size());
		
		return listMap;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public int gethNoticeCnt(String notice_status) throws Exception {
		
		int totalCnt = noticeDao.searchNoticeCnt(notice_status);
		logger.info("공지사항 수 조회 결과 = {}", totalCnt);
		
		return totalCnt;
	}

}
