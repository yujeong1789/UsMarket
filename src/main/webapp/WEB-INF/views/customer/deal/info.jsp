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
				
				<c:if test="${dealInfo.DEAL_STATE eq '1' }">
					<div class="title">
						<span>배송정보</span>
						<c:if test="${mode eq 'sell' and dealInfo.DEAL_DELIVERY_STATE != '3' and empty dealInfo.DEAL_CANCEL}">
							<div class="state-dropdown">
								<span>배송상태 변경</span>
								<div class="dropdown-content">
									<ul>
										<li data-current="${dealInfo.DEAL_DELIVERY_STATE eq '1' ? '배송준비중' : '배송중' }" data-state="${dealInfo.DEAL_DELIVERY_STATE eq '1' ? '2' : '3' }">${dealInfo.DEAL_DELIVERY_STATE eq '1' ? '배송중' : '배송완료' }</li>					
									</ul>
								</div>
							</div>
						</c:if>
					</div>
					<div class="deal-info">
						<div class="info">
							<div class="info-title">배송상태</div>
							<div class="info-info">${dealInfo.DEAL_DELIVERY_STATE eq '1' ? '배송준비중' : (dealInfo.DEAL_DELIVERY_STATE eq '2' ? '배송중' : '배송완료') }</div>
						</div>
						<div class="info">
							<div class="info-title">수령인</div>
							<div class="info-info">${dealInfo.CUSTOMER_NAME }</div>
						</div>
						<div class="info">
							<div class="info-title">연락처</div>
							<div class="info-info">${dealInfo.CUSTOMER_HP }</div>
						</div>
						<div class="info">
							<div class="info-title">주소</div>
							<div class="info-info">${'(' += dealInfo.CUSTOMER_ZIPCODE += ') ' += dealInfo.CUSTOMER_ADDRESS += ' ' += dealInfo.CUSTOMER_ADDRESS_DETAIL }</div>
						</div>
						
						<c:if test="${mode eq 'buy'}">
							<c:if test="${empty dealInfo.DEAL_CANCEL }">
								<div class="deal-cancel">
									<div onclick="setCancel(this)" data-no="${dealInfo.DEAL_DELIVERY_STATE eq '1' ? '3' : '0' }">주문취소</div>
								</div>
							</c:if>
							<c:if test="${dealInfo.DEAL_CANCEL eq '0' }">
								<div class="alert-message">판매자의 취소 승인을 기다리고 있습니다.</div>
							</c:if>
						</c:if>
						<c:if test="${mode eq 'sell' and not empty dealInfo.DEAL_CANCEL}">
							<div class="deal-accept">
								<div onclick="setSellerCancel(this)" data-no="1">주문취소 승인</div>
								<div onclick="setSellerCancel(this)" data-no="2">주문취소 거절</div>
							</div>
						</c:if>
						
					</div>
				</c:if>
			</div>
		</div>
	</div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script type="text/javascript">
// 아임포트 결제 취소 기능 추가할 것

document.addEventListener('DOMContentLoaded', function(){
	var socket = null;
	connectWs();
});

let setAccept = function(el){
	dealStateModify(confirm('거래를 '+el.textContent+'하시겠습니까?'), el.dataset.no);
};


let dealStateModify = function(confirm, deal_state){
	if(confirm){
		let params = new FormData();
		params.append('deal_state', deal_state);
		params.append('deal_no', `${dealInfo.DEAL_NO}`);
		
		fetch('/usMarket/fetch/deal/modify', {
			method: 'POST',
			body: params,
		})
		.then((response) => response.text())
		.then((text) => {
				console.log(text);
				// 채팅 알림 발송 기능 추가할 것
		}).catch((error) => console.log('error: '+error));
	}
};


let setCancel = function(el){
	let alert = (el.dataset.no == '3' ? '결제금액은 즉시 환불됩니다.' : '결제금액은 판매자 승인 후 환불됩니다.');
	if(confirm('주문을 취소하시겠습니까? '+alert)){
		if(el.dataset.no == 3){
			dealStateModify(true, 3);
		}else{
			dealCancel(true, el.dataset.no);
		}
	}
};

let setSellerCancel = function(el){
	let cancelMessage = el.dataset.no == 1 ? '거래 취소 요청을 승인하시겠습니까?\n해당 작업은 되돌릴 수 없으므로 반드시 상품을 수령한 후에 취소해 주세요.' : '거래 취소 요청을 거절하시겠습니까?\n해당 작업은 되돌릴 수 없습니다.';
	dealCancel(confirm(cancelMessage), el.dataset.no);
};

let dealCancel = function(confirm, deal_cancel){
	if(confirm){
		let params = new FormData();
		params.append('deal_cancel', deal_cancel);
		params.append('deal_no', `${dealInfo.DEAL_NO}`);
		
		fetch('/usMarket/fetch/deal/cancel', {
			method: 'POST',
			body: params,
		})
		.then((response) => response.text())
		.then((text) => {
				console.log(text);
				// 채팅 알림 발송 기능 추가할 것
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