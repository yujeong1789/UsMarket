<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
			<div class="deal-list">
				<div class="deal-list-header">
					<div class="${condition eq 'buy' ? 'condition-selected' : '' }" data-condition="buy" onclick="setCondition(this)">구매</div>
					<div class="${condition eq 'sell' ? 'condition-selected' : '' }" data-condition="sell" onclick="setCondition(this)">판매</div>
				</div>
				<div class="deal-states">
					<div class="${empty state or state eq '' ? 'state-selected' : '' }" data-state="" onclick="setState(this)">전체</div>
					<div class="${state eq '1' ? 'state-selected' : '' }" data-state="1" onclick="setState(this)">진행중</div>
					<div class="${state eq '2' ? 'state-selected' : '' }" data-state="2" onclick="setState(this)">완료</div>
					<div class="${state eq '3' ? 'state-selected' : '' }" data-state="3" onclick="setState(this)">취소/환불</div>
				</div>
				<div class="deal-list-body">
					<c:if test="${empty dealList }">
						<div class="empty">
							<span>${condition eq 'buy' ? '구매' : '판매' }내역이 존재하지 않습니다.</span>
						</div>
					</c:if>
					<c:if test="${not empty dealList }">
						<ul>
							<c:forEach var="deal" items="${dealList }">
								<li data-no="${deal.DEAL_NO }" onclick="getDealInfo(this)">
									<div class="deal-left">
										<img class="product-img-top" src="<c:url value='/resources/customer/img/deal${deal.DEAL_STATE }.png'/>">
										<img class="product-img" src="${'https://usmarket.s3.ap-northeast-2.amazonaws.com/' +=deal.PRODUCT_IMG_PATH }">
									</div>
									<div class="deal-right">
										<span>${deal.PRODUCT_NAME }</span>
										<span><fmt:formatNumber value="${deal.PRODUCT_PRICE }" pattern="#,###"/>원</span>
										<span>${state eq 'buy' ? deal.SELLER_NICKNAME : deal.CUSTOMER_NICKNAME }</span>
										<span><fmt:formatDate value="${deal.DEAL_START_DATE }" pattern="yyyy.MM.dd (a HH:mm)"/></span>
									</div>
								</li>
							</c:forEach>
						</ul>
					</c:if>
				</div>
			</div> <!-- deal-list -->
</html>