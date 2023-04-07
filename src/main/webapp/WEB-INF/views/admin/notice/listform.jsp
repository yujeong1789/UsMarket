<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
			<div class="notice-list">
				<c:if test="${empty noticeList }">
					<span>공지사항이 존재하지 않습니다.</span>
					<input id="pageValue" type="hidden">
				</c:if>
				<c:if test="${not empty noticeList }">
					<table>
						<thead>
							<tr class="head">
								<th>번호</th>
								<th>제목</th>
								<th>분류</th>
								<th>조회수</th>
								<th>등록일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="notice" items="${noticeList }">
								<tr class="body" id="${notice.NOTICE_NO }" data-num="${notice.NUM }" onclick="noticeInfoSubmit(this)">
									<td>${notice.NOTICE_NO }</td>
									<td>${notice.NOTICE_TITLE }</td>
									<c:if test="${notice.NOTICE_STATUS  eq '0'}">
										<td>공지사항</td>
									</c:if>
									<c:if test="${notice.NOTICE_STATUS  eq '1'}">
										<td>자주묻는질문</td>
									</c:if>
									<td>${notice.NOTICE_VIEW }</td>
									<td><fmt:formatDate value="${notice.NOTICE_REGDATE }" pattern="yyyy년 MM월 dd일 HH:mm"/></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<form id="noticeInfoForm" name="noticeInfoForm" action="<c:url value='/admin/notice/info'/>" method="post">
						<input type="hidden" id="notice_no" name="notice_no">
					</form>
					<div class="paging">
						<c:if test="${ph.totalCnt != null}">
							<c:if test="${ph.showPrev }">
								<div class="paging-prev">
									&lt;&lt;
								</div>
							</c:if>
							<c:forEach var="i" begin="${ph.beginPage }" end="${ph.endPage }">
								<div class="paging-box ${i eq ph.sc.page ? 'current-page' : 'not-current-page' }" onclick="${i eq ph.sc.page ? '' : 'getNoticeList(' += i += ')'}">
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
			</div> <!-- notice-list -->
</html>