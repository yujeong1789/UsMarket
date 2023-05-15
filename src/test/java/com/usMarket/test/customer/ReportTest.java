package com.usMarket.test.customer;

import static org.junit.Assert.assertEquals;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;

import com.spring.usMarket.domain.report.ReportInsertDto;
import com.spring.usMarket.service.report.ReportService;

@Transactional
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class ReportTest {

	@Autowired private ReportService reportService;
	
	@Test
	public void addreportTest() throws Exception{
		int addReportResult = reportService.addReport(new ReportInsertDto("dummy", 2, 3, 1, 1, "dummy_content", "", ""));
		assertEquals(addReportResult, 1);
	}
	
	@Test
	public void getReportCategory2Test() throws Exception{
		List<Map<String, Object>> reportCategory2 = reportService.getReportCategory2(1);
		assertEquals(reportCategory2.size(), 3);
	}
}
