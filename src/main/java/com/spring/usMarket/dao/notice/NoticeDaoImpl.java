package com.spring.usMarket.dao.notice;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.usMarket.utils.NoticeSearchCondition;

@Repository
public class NoticeDaoImpl implements NoticeDao{
	@Autowired
	private SqlSession session;
	private static String namespace = "com.mybatis.mapper.notice.";
	
	@Override
	public List<Map<String, Object>> searchNoticeList(NoticeSearchCondition sc) throws Exception {
		return session.selectList(namespace+"searchNoticeList", sc);
	}

	@Override
	public int searchNoticeCnt(String notice_status) throws Exception {
		return session.selectOne(namespace+"searchNoticeCnt", notice_status);
	}

	@Override
	public Map<String, Object> searchNoticeInfo(String notice_no) throws Exception {
		return session.selectOne(namespace+"searchNoticeInfo", notice_no);
	}

	@Override
	public int updateNoticeView(String notice_no) throws Exception {
		return session.update(namespace+"updateNoticeView", notice_no);
	}
}
