<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="<c:url value='/resources/admin/css/payment_info.css'/>" type="text/css">

<div class="payment-info-container">
	<c:if test="${empty infoMap}">
		<script type="text/javascript">
			alert('결제내역을 찾을 수 없습니다.');
			location.href = '${pageContext.request.contextPath}/admin/payment/list';
		</script>
	</c:if>
	<c:if test="${not empty infoMap}">
	
		<div class="title">
			<span>결제내역</span>
		</div> <!-- title -->
		
		<div class="dashboard">
			<div>
				<div class="payment-info">
					<div class="sub-title">
						<div>거래정보</div>
						<div>
							<c:choose>
								<c:when test="${infoMap.DEAL_STATE eq 0 }">거래대기중</c:when>
								<c:when test="${infoMap.DEAL_STATE eq 1 }">거래진행중</c:when>
								<c:when test="${infoMap.DEAL_STATE eq 2 }">거래완료</c:when>
								<c:when test="${infoMap.DEAL_STATE eq 3 }">거래취소</c:when>
							</c:choose>
						</div>
					</div>
					
					<div class="info">
						<div class="info-title">주문번호</div>
						<div class="info-info">${infoMap.DEAL_NO }</div>
					</div>
					<div class="info">
						<div class="info-title">주문일시</div>
						<div class="info-info"><fmt:formatDate value="${infoMap.DEAL_START_DATE }" pattern="yyyy/MM/dd (HH:mm:ss)" /></div>
					</div>
					<div class="info">
						<div class="info-title">판매자</div>
						<div class="info-info">
							<span class="frm" data-no="${infoMap.SELLER_NO }">
								${infoMap.SELLER_NAME }
								<img src="<c:url value='/resources/admin/img/icon/redirect.png'/>">
							</span>
						</div>
					</div>
					<div class="info">
						<div class="info-title">구매자</div>
						<div class="info-info">
							<span class="frm" data-no="${infoMap.CUSTOMER_NO }">
								${infoMap.CUSTOMER_NAME }
								<img src="<c:url value='/resources/admin/img/icon/redirect.png'/>">
							</span>
						</div>
					</div>
					<div class="info">
						<div class="info-title">구매상품</div>
						<div class="info-info">
							<a href="<c:url value='/product/info?product_no=${infoMap.PRODUCT_NO}' />">
								<span>
									${infoMap.PRODUCT_NAME }
									<img src="<c:url value='/resources/admin/img/icon/redirect.png'/>">
								</span>
							</a>
						</div>
					</div>
					<div class="info">
						<div class="info-title">결제금액</div>
						<div class="info-info"><fmt:formatNumber type="number" value="${infoMap.PRODUCT_PRICE }"/>원</div>
					</div>
					<form id="memberInfoForm" action="<c:url value='/admin/member/info'/>" method="post">
						<input type="hidden" id="member_no" name="member_no">
					</form>
				</div> <!-- payment-info -->
				
				
				<div class="delivery-info">
					<div class="sub-title">
						<div>배송정보</div>
						<div>
							<c:choose>
								<c:when test="${empty infoMap.DEAL_DELIVERY_STATE }">거래대기중</c:when>
								<c:when test="${infoMap.DEAL_DELIVERY_STATE eq 1 }">배송준비중</c:when>
								<c:when test="${infoMap.DEAL_DELIVERY_STATE eq 2 }">배송중</c:when>
								<c:when test="${infoMap.DEAL_DELIVERY_STATE eq 3 }">배송완료</c:when>
							</c:choose>
						</div>
					</div>
					
					<div class="info">
						<div class="info-title">수령인</div>
						<div class="info-info">${infoMap.CUSTOMER_NAME }</div>
					</div>
					<div class="info">
						<div class="info-title">연락처</div>
						<div class="info-info">${infoMap.CUSTOMER_HP }</div>
					</div>
					<div class="info">
						<div class="info-title">우편번호</div>
						<div class="info-info">${infoMap.CUSTOMER_ZIPCODE }</div>
					</div>
					<div class="info">
						<div class="info-title">주소</div>
						<div class="info-info">${infoMap.CUSTOMER_ADDRESS}</div>
					</div>
					<div class="info">
						<div class="info-title">상세주소</div>
						<div class="info-info">${infoMap.CUSTOMER_ADDRESS_DETAIL }</div>
					</div>
				</div> <!-- delivery-info -->
				<div class="payment-btn">
					<div onclick="location.href='<c:url value="/admin/payment/list"/>'">목록</div>
				</div>
			</div>
			<c:if test="${not empty reviewMap}">
				<div class="payment-review">
					<div class="sub-title">작성 리뷰</div>
					<div class="review-info">
						<div class="left frm" data-no="${reviewMap.CUSTOMER_NO }">
							<c:if test="${reviewMap.MEMBER_IMAGE eq '/resources/customer/img/default_profile.png' }">
								<img src="<c:url value='${reviewMap.MEMBER_IMAGE }'/>">
							</c:if>
							<c:if test="${reviewMap.MEMBER_IMAGE ne '/resources/customer/img/default_profile.png' }">
								<img src="${reviewMap.MEMBER_IMAGE }">
							</c:if>
						</div>
						<div class="right">
							<div class="review-nickname">
								<span class="frm" data-no="${reviewMap.CUSTOMER_NO }">
									${reviewMap.MEMBER_NICKNAME }
									<img src="<c:url value='/resources/admin/img/icon/redirect.png'/>">
								</span>
							</div>
							<div class="review-score">
								<c:forEach begin="0" end="4" step="1" varStatus="status">
									<c:if test="${reviewMap.REVIEW_SCORE ge status.count}">
										<img src="<c:url value='/resources/customer/img/star.png'/>">
									</c:if>
									<c:if test="${reviewMap.REVIEW_SCORE lt status.count}">
										<img src="<c:url value='/resources/customer/img/star_blank.png'/>">
									</c:if>
								</c:forEach>
							</div>
							<div class="review-content"><c:out value='${reviewMap.REVIEW_CONTENT }'/></div>
						</div>
					</div>
				</div>
			</c:if>
		</div> <!-- dashboard -->
		
	</c:if>
 
</div> <!-- payment-info-container -->

<script type="text/javascript">
document.querySelectorAll('.frm').forEach(el => {
	el.addEventListener('click', function(e){
		document.getElementById('member_no').value = this.dataset.no;
		document.getElementById('memberInfoForm').submit();
	});
});
</script>