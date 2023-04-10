package com.spring.usMarket.dao.notice;

import java.util.List;
import java.util.Map;

import com.spring.usMarket.utils.NoticeSearchCondition;

public interface NoticeDao {
	List<Map<String, Object>> searchNoticeList(NoticeSearchCondition sc) throws Exception;
	int searchNoticeCnt(String notice_status) throws Exception;
	Map<String, Object> searchNoticeInfo (String notice_no) throws Exception;
	int updateNoticeView (String notice_no) throws Exception;
}
