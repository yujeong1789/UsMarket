package com.spring.usMarket.service.notice;

import java.util.List;
import java.util.Map;

import com.spring.usMarket.utils.NoticeSearchCondition;

public interface NoticeService {
	List<Map<String, Object>> getNoticeList(NoticeSearchCondition sc) throws Exception;
	int gethNoticeCnt(String notice_status) throws Exception;
	Map<String, Object> getNoticeInfo (String notice_no) throws Exception;
	int modifyNoticeView (String notice_no) throws Exception;
}
