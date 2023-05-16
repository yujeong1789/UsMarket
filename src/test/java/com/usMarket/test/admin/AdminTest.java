package com.usMarket.test.admin;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;

import com.spring.usMarket.domain.admin.AdminNoticeInsertDto;
import com.spring.usMarket.domain.admin.QnaReplyInsertDto;
import com.spring.usMarket.domain.admin.ReportHistoryDto;
import com.spring.usMarket.service.admin.AdminService;
import com.spring.usMarket.utils.AdminSearchCondition;

@Transactional
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class AdminTest {

	@Autowired private AdminService adminService;
	
	private final String ADMIN_NO = "21";
	private final String MEMBER_NO = "224";
	
	@Test
	public void getAdminTest() throws Exception{
		// getAdmin
		Map<String, Object> adminMap = adminService.getAdmin("admin1", "admin1");
		assertEquals(adminMap.size(), 3);
	}
	
	@Test
	public void adminMemberTest() throws Exception{
		AdminSearchCondition asc = new AdminSearchCondition(1, 10, "2022-11-01", "2022-11-30", "", "", "", "");
		
		// getMemberStatsByMonth
		List<Map<String, Object>> memberListByMonth = adminService.getMemberStatsByMonth("2022-11-01", "2022-11-30");
		assertEquals(memberListByMonth.size(), 1);
		
		// getMemberStatsByDate
		List<Map<String, Object>> memberListByDate = adminService.getMemberStatsByDate("2022-11-01", "2022-11-30");
		assertEquals(memberListByDate.size(), 30);
		
		// getMemberList
		List<Map<String, Object>> memberList = adminService.getMemberList(asc);
		assertEquals(memberList.size(), 3);
		
		// getMemberCnt
		int memberCnt = adminService.getMemberCnt(asc.getStartDate(), asc.getEndDate(), asc.getCondition());
		assertEquals(memberCnt, 3);
		
		// getMemberInfo
		asc.setMember_no(MEMBER_NO);
		Map<String, Object> memberInfo = adminService.getMemberInfo(asc);
		assertNotNull(memberInfo);
		
		// getMemberProductList, getMemberProductCnt
		List<Map<String, Object>> memberProductList = adminService.getMemberProductList(asc);
		int memberProductCnt = adminService.getMemberProductCnt(MEMBER_NO, asc.getCondition());
		assertEquals(memberProductList.size(), memberProductCnt);
	}
	
	@Test
	public void adminDealTest() throws Exception{
		AdminSearchCondition asc = new AdminSearchCondition(1, 10, "2023-03-01", "2023-03-31", "", "", "", "");
		
		// getDealStatsByDate
		List<Map<String, Object>> dealListByDate = adminService.getDealStatsByDate(asc.getStartDate(), asc.getEndDate());
		assertEquals(dealListByDate.size(), 31);
		
		// getDealStatsByMonth
		List<Map<String, Object>> dealListByMonth = adminService.getDealStatsByMonth(asc.getStartDate(), asc.getEndDate());
		assertEquals(dealListByMonth.size(), 1);
		
		
		// getDealList, getDealCnt 
		List<Map<String, Object>> dealList = adminService.getDealList(asc);
		int dealCnt = adminService.getDealCnt(asc.getStartDate(), asc.getEndDate(), asc.getCondition());
		assertEquals(dealList.size(), dealCnt);
	}
	
	@Test
	public void adminReportTest() throws Exception{
		AdminSearchCondition asc = new AdminSearchCondition();
		asc.setPage(1);
		asc.setPageSize(1000);
		
		// getReportList, getReportCnt
		List<Map<String, Object>> reportList = adminService.getReportList(asc);
		int reportCount = adminService.getReportCnt("", "");
		assertEquals(reportList.size(), reportCount);
		
		Map<String, Object> completedReport = reportList.stream()
												.filter(i -> i.get("REPORT_COMPLETE").toString().equals("Y"))
												.filter(i -> i.get("REPORT_CATEGORY1_NO").toString().equals("2"))
												.findAny()
												.get();
		
		// getReportInfo1
		Map<String, Object> reportInfo = adminService.getReportInfo(completedReport.get("REPORT_NO").toString());
		assertNotNull(reportInfo);
		
		// getChatLog
		List<Map<String, Object>> chatList = adminService.getChatLog(reportInfo.get("REPORT_INFO").toString());
		assertNotEquals(chatList.size(), 0);
		
		// getReportEndDate
		String reportEndDate = adminService.getReportEndDate(reportInfo.get("MEMBER_NO").toString());
		assertNull(reportEndDate);
		
		Map<String, Object> notCompletedReport = reportList.stream()
													.filter(i -> i.get("REPORT_COMPLETE").toString().equals("N"))
													.findAny()
													.get();
		
		// getReportInfo2
		Map<String, Object> reportInfo_ = adminService.getReportInfo(notCompletedReport.get("REPORT_NO").toString());
		assertNotNull(reportInfo_);
		
		// addReportHistory
		int addReportResult = adminService.addReportHistory(new ReportHistoryDto(reportInfo_.get("REPORT_NO").toString(), ADMIN_NO, reportInfo_.get("MEMBER_NO").toString(), 0, "", ""));
		assertEquals(addReportResult, 2);
		
		// getReportHistory
		Map<String, Object> reportHistory = adminService.getReportHistory(reportInfo_.get("REPORT_NO").toString());
		assertNotNull(reportHistory);
	}
	
	@Test
	public void adminQnaTest() throws Exception{
		AdminSearchCondition asc = new AdminSearchCondition();
		asc.setPage(1);
		asc.setPageSize(1000);
		
		// getQnaList, getQnaCnt
		List<Map<String, Object>> qnaList = adminService.getQnaList(asc);
		int qnaCount = adminService.getQnaCnt("");
		assertEquals(qnaList.size(), qnaCount);
		
		String qna_no = qnaList.stream()
							.filter(i -> i.get("QNA_COMPLETE").toString().equals("N"))
							.findAny()
							.map(i -> new String(i.get("QNA_NO").toString()))
							.get();
		
		// getQnaInfo
		Map<String, Object> qnaInfo = adminService.getQnaInfo(qna_no);
		assertNotNull(qnaInfo);
		
		// addQnaReply
		int addQnaResult = adminService.addQnaReply(new QnaReplyInsertDto(qna_no, ADMIN_NO, "dummy content"));
		assertEquals(addQnaResult, 2);
		
		// getQnaReply
		Map<String, Object> qnaReply = adminService.getQnaReply(qna_no);
		assertNotNull(qnaReply);
	}
	
	@Test
	public void adminNoticeTest() throws Exception{
		AdminSearchCondition asc = new AdminSearchCondition();
		asc.setPage(1);
		asc.setPageSize(1000);
		
		// getNoticeList, getNoticeCnt
		List<Map<String, Object>> noticeList = adminService.getNoticeList(asc);
		int noticeCount = adminService.getNoticeCnt("");
		assertEquals(noticeList.size(), noticeCount);
		
		String notice_no = noticeList.get(0).get("NOTICE_NO").toString();
		
		// modifyNotice
		Map<String, Object> modifyParameters = new HashMap<>();
		modifyParameters.put("notice_title", "dummy title");
		modifyParameters.put("notice_content", "dummy content");
		modifyParameters.put("notice_no", notice_no);
		
		int modifyResult = adminService.modifyNotice(modifyParameters);
		assertEquals(modifyResult, 1);
		
		// getNoticeInfo
		Map<String, Object> noticeInfo = adminService.getNoticeInfo(notice_no);
		assertTrue(modifyParameters.get("notice_title").toString().equals(noticeInfo.get("NOTICE_TITLE").toString())
				&& modifyParameters.get("notice_content").toString().equals(noticeInfo.get("NOTICE_CONTENT").toString()));
		
		// addNotice
		int noticeAddResult = adminService.addNotice(new AdminNoticeInsertDto("dummy", ADMIN_NO, 1, "dummy title", "dummy content"));
		assertEquals(noticeAddResult, 1);
		
		// removeNotice
		int noticeRemoveResult = adminService.removeNotice("dummy");
		assertEquals(noticeRemoveResult, 1);
	}
}
