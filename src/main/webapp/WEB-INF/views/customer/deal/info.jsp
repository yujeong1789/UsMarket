<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/deal_info.css'/>" type="text/css">
<c:if test="${empty dealInfo }">
	<script type="text/javascript">
		alert("잘못된 접근입니다.");
		location.href = '${pageContext.request.contextPath}/deal/list';
	</script>
</c:if>

<div class="deal-info-container">
	<div class="row">
		<div class="container">
			<div class="deal-info-layout">
				<div class="title">
					<span>거래내역</span>
				</div>
				<div class="deal-info">
					<div class="info">
						<div class="info-title">구매상품</div>
						<div class="info-info">
							<a href="<c:url value='/product/info?product_no=${dealInfo.PRODUCT_NO }'/>">
								${dealInfo.PRODUCT_NAME }
								<img src="<c:url value='/resources/admin/img/icon/redirect.png'/>">
							</a>
						</div>
					</div>
					<div class="info">
						<div class="info-title">주문번호</div>
						<div class="info-info">${dealInfo.DEAL_NO }</div>
					</div>
					<div class="info">
						<div class="info-title">${mode eq 'buy' ? '판매자' : '구매자' }</div>
						<div class="info-info">
							<a href="<c:url value='/member/mypage?member_no=${mode eq "buy" ? dealInfo.SELLER_NO : dealInfo.CUSTOMER_NO }'/>">
								${mode eq 'buy' ? dealInfo.SELLER_NICKNAME : dealInfo.CUSTOMER_NICKNAME  }
								<img src="<c:url value='/resources/admin/img/icon/redirect.png'/>">
							</a>
						</div>
					</div>
					<div class="info">
						<div class="info-title">결제금액</div>
						<div class="info-info"><fmt:formatNumber type="number" value="${dealInfo.PRODUCT_PRICE }"/>원</div>
					</div>
					<div class="info">
						<div class="info-title">주문일시</div>
						<div class="info-info"><fmt:formatDate value="${dealInfo.DEAL_START_DATE }" pattern="yyyy.MM.dd (a hh:mm)" /></div>
					</div>
					<c:if test="${mode eq 'buy' and dealInfo.DEAL_STATE eq '0'}">
						<div class="alert-message">판매자의 승인을 기다리고 있습니다.</div>
					</c:if>
					<c:if test="${mode eq 'sell' and dealInfo.DEAL_STATE eq '0'}">
						<div class="deal-accept">
							<div onclick="setAccept(this)" data-no="1">승인</div>
							<div onclick="setAccept(this)" data-no="3">취소</div>
						</div>
					</c:if>
					<c:if test="${dealInfo.DEAL_STATE eq '3'}">
						<div class="alert-message">취소된 거래입니다.</div>
					</c:if>
				</div> <!-- deal-info -->
			</div>
		</div>
	</div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function(){
	var socket = null;
	connectWs();
});

let setAccept = function(el){
	if(confirm('거래를 '+el.textContent+'하시겠습니까?')){
		let params = new FormData();
		params.append('deal_state', el.dataset.no);
		params.append('deal_no', `${dealInfo.DEAL_NO}`);
		
		fetch('/usMarket/fetch/deal/modify', {
			method: 'POST',
			body: params,
		})
		.then((response) => response.text())
		.then((text) => {
				console.log(text);
		}).catch((error) => console.log('error: '+error));
	}
};

let connectWs = function(){
	sock = new SockJS('${pageContext.request.contextPath}/echo');
	socket = sock;
	
	sock.onopen = function(){
		console.log('info: connection opened.');
	};
};
</script>