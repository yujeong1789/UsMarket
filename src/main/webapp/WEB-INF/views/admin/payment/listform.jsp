<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<div class="payment-list">
	<c:if test="${empty dealList }">
		<span>결제내역이 존재하지 않습니다.</span>
		<input id="pageValue" type="hidden">
	</c:if>
	<c:if test="${not empty dealList }">
		<table>
			<thead>
				<tr class="head">
					<th>거래번호</th>
					<th>결제금액</th>
					<th>거래상태</th>
					<th>결제일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="deal" items="${dealList }">
					<tr class="body" id="${deal.DEAL_NO }" data-num="${deal.NUM }" onclick="dealInfoSubmit(this)">
						<td>${deal.DEAL_NO }</td>
						<td><fmt:formatNumber type="number" value="${deal.PRODUCT_PRICE }"/>원</td>
						<td data-status="${deal.DEAL_STATE }">
							<c:choose>
								<c:when test="${deal.DEAL_STATE  eq 0}">거래대기중</c:when>
								<c:when test="${deal.DEAL_STATE  eq 1}">거래진행중</c:when>
								<c:when test="${deal.DEAL_STATE  eq 2}">거래완료</c:when>
								<c:when test="${deal.DEAL_STATE  eq 3}">거래취소</c:when>
							</c:choose>
						</td>
						<td><fmt:formatDate value="${deal.DEAL_START_DATE }" pattern="yyyy년 MM월 dd일 HH:mm"/></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<form id="dealInfoForm" name="dealInfoForm" action="<c:url value='/admin/payment/info'/>" method="post">
			<input type="hidden" id="deal_no" name="deal_no" value="">
		</form>
		<div class="paging">
			<input id="pageValue" type="hidden">
			<c:if test="${ph.totalCnt != null}">
				<c:if test="${ph.showPrev }">
					<div class="paging-prev">
						&lt;&lt;
					</div>
				</c:if>
				<c:forEach var="i" begin="${ph.beginPage }" end="${ph.endPage }">
					<div class="paging-box ${i eq ph.sc.page ? 'current-page' : 'not-current-page' }" onclick="${i eq ph.sc.page ? '' : 'getPaymentList(' += i += ')'}">
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
</div> <!-- payment-list -->
</html>