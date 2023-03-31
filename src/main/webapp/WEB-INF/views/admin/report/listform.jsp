<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    
<!DOCTYPE html>
<html>
			<div class="report-list">
				<c:if test="${empty reportList }">
					<span>신고내역이 존재하지 않습니다.</span>
					<input id="pageValue" type="hidden">
				</c:if>
				<c:if test="${not empty reportList }">
					<table>
						<thead>
							<tr class="head">
								<th>신고번호</th>
								<th>대분류</th>
								<th>소분류</th>
								<th>처리여부</th>
								<th>접수일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="report" items="${reportList }">
								<tr class="body" id="${report.REPORT_NO }" data-num="${report.NUM }" onclick="reportInfoSubmit(this)">
									<td>${report.REPORT_NO }</td>
									<td>${report.REPORT_CATEGORY1_NAME }</td>
									<td>${report.REPORT_CATEGORY2_NAME }</td>
									<c:if test="${report.REPORT_COMPLETE  eq 'N'}">
										<td data-status="${report.REPORT_COMPLETE }" style="color: #FF0028">미처리</td>
									</c:if>
									<c:if test="${report.REPORT_COMPLETE  eq 'Y'}">
										<td data-status="${report.REPORT_COMPLETE }" style="color: #822AFF">처리완료</td>
									</c:if>
									<td><fmt:formatDate value="${report.REPORT_REGDATE }" pattern="yyyy년 MM월 dd일 HH:mm"/></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<form id="reportInfoForm" name="dealInfoForm" action="<c:url value='/admin/report/info'/>" method="post">
						<input type="hidden" id="report_no" name="report_no">
					</form>
					<div class="paging">
						<c:if test="${ph.totalCnt != null}">
							<c:if test="${ph.showPrev }">
								<div class="paging-prev">
									&lt;&lt;
								</div>
							</c:if>
							<c:forEach var="i" begin="${ph.beginPage }" end="${ph.endPage }">
								<div class="paging-box ${i eq ph.sc.page ? 'current-page' : 'not-current-page' }" onclick="${i eq ph.sc.page ? '' : 'getReportList(' += i += ')'}">
									<input id="pageValue" type="hidden" value="${i }">
									${i}
								</div>
							</c:forEach>
							<c:if test="${ph.showNext }">
								<div class="paging-next">
									&gt;&gt;
								</div>
							</c:if>
						</c:if>
					</div>
					
				</c:if>
			</div> <!-- report-list -->
</html>