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
						<c:if test="${mode eq 'sell' and dealInfo.DEAL_DELIVERY_STATE != '3' and dealInfo.DEAL_DELIVERY_STATE != '4'  and empty dealInfo.DEAL_CANCEL}">
							<div class="state-dropdown">
								<span>배송상태 변경</span>
								<div class="dropdown-content">
									<ul>
										<li data-current="${dealInfo.DEAL_DELIVERY_STATE eq '1' ? '배송준비중' : '배송중' }" data-state="${dealInfo.DEAL_DELIVERY_STATE eq '1' ? '2' : '3' }" onclick="setSellerDeliveryState(this)">${dealInfo.DEAL_DELIVERY_STATE eq '1' ? '배송중' : '배송완료' }</li>					
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
							<c:if test="${empty dealInfo.DEAL_CANCEL and dealInfo.DEAL_DELIVERY_STATE != '4'}">
								<div class="deal-cancel">
									<div onclick="setCancel(this)" data-no="${dealInfo.DEAL_DELIVERY_STATE eq '1' ? '3' : '0' }">주문취소</div>
								</div>
							</c:if>
							<c:if test="${dealInfo.DEAL_CANCEL eq '0' }">
								<div class="alert-message">판매자의 취소 승인을 기다리고 있습니다.</div>
							</c:if>
							<c:if test="${dealInfo.DEAL_DELIVERY_STATE eq '3' }">
								<div class="deal-receive">
									<div onclick="setDeliveryReceive(this)" data-state="4">구매확정</div>
								</div>
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
				<c:if test="${dealInfo.DEAL_STATE eq '2' }">
					<div class="title">
						<span>리뷰</span>
					</div>
					<div class="deal-info">
						<c:if test="${dealInfo.DEAL_REVIEW eq 'N' }">
							<c:if test="${mode eq 'buy' }">
								<div class="review-textarea">
									<textarea class="not-pass" id="review-content" data-alert="내용을 입력해 주세요." maxlength="200"></textarea>
									<div class="current-count"><p>0</p><p>/200</p></div>
								</div>
								<div class="review-btn">등록하기</div>
							</c:if>
							<c:if test="${mode eq 'sell' }">
								<div class="alert-message">작성된 리뷰가 없습니다.</div>
							</c:if>
						</c:if>
					</div>
				</c:if>
			</div>
		</div>
	</div>
	<form id="dealInfoForm" action="<c:url value='/deal/info'/>" method="post">
		<input type="hidden" id="deal_no" name="deal_no">
	</form>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script type="text/javascript">
/*
	// 아임포트 결제 취소 기능 추가할 것
	
	// socket.send() 예시
	let params = new FormData(document.getElementById('buyProductForm'));
	params.append('message', '등록하신 '+`${productOrderInfo.PRODUCT_NAME}`+'상품이 판매되었습니다. 판매 여부 확인 후 판매 승인을 눌러주세요.');
	let msg = {
			type: 'chat',
			body: json
		};
	socket.send(JSON.stringify(msg));
*/

document.addEventListener('DOMContentLoaded', function(){
	var socket = null;
	connectWs();
});

let setAccept = function(el){
	dealStateModify(confirm('거래를 '+el.textContent+'하시겠습니까?'), el.dataset.no);
};

// 거래상태 변경
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
				if(text == 1){
					// 채팅 알림 발송 기능 추가할 것
					getDealInfo(`${dealInfo.DEAL_NO}`);
				}
		}).catch((error) => console.log('error: '+error));
	}
};

// 거래취소 (배송준비중이면 즉시 취소, 배송중 또는 배송완료일 경우 취소신청)
let setCancel = function(el){
	let alert = (el.dataset.no == '3' ? '결제금액은 즉시 환불됩니다.' : '결제금액은 판매자 승인 후 환불됩니다.');
	if(confirm('주문을 취소하시겠습니까? ' + alert)){
		if(el.dataset.no == 3){
			dealStateModify(true, 3);
		}else{
			dealCancel(true, el.dataset.no);
		}
	}
};

// 판매자 취소신청 승인 및 거절
let setSellerCancel = function(el){
	let cancelMessage = el.dataset.no == 1 ? '거래 취소 요청을 승인하시겠습니까?\n해당 작업은 되돌릴 수 없으므로 반드시 취소된 상품을 수령한 후에 승인해 주세요.' : '거래 취소 요청을 거절하시겠습니까?\n해당 작업은 되돌릴 수 없습니다.';
	dealCancel(confirm(cancelMessage), el.dataset.no);
};

// 즉시 거래취소
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
				if(text == 1){
					// 채팅 알림 발송 기능 추가할 것
					getDealInfo(`${dealInfo.DEAL_NO}`);
				}
		}).catch((error) => console.log('error: '+error));
	}
};

// 배송상태 변경
let setDeliveryState = function(confirm, deal_delivery_state){
	if(confirm){
		let params = new FormData();
		params.append('deal_delivery_state', deal_delivery_state);
		params.append('deal_no', `${dealInfo.DEAL_NO}`);
		
		fetch('/usMarket/fetch/delivery/modify', {
			method: 'POST',
			body: params,
		})
		.then((response) => response.text())
		.then((text) => {
				if(text == 1){
					// 채팅 알림 발송 기능 추가할 것
					getDealInfo(`${dealInfo.DEAL_NO}`);
				}
		}).catch((error) => console.log('error: '+error));
	}
};

let setDeliveryReceive = function(el){
	setDeliveryState(confirm('구매확정하신 뒤에는 취소신청이 불가하며, 취소신청이 진행중일 경우 취소신청이 철회됩니다.\n반드시 상품을 수령하신 뒤에 구매확정해 주세요.'), el.dataset.state);
};

let setSellerDeliveryState = function(el){
	setDeliveryState(confirm('배송상태를 '+el.dataset.current+'에서 '+el.textContent+'(으)로 변경하시겠습니까?'), el.dataset.state);
};

// 페이지 새로고침
let getDealInfo = function(deal_no){
	document.getElementById('deal_no').value = deal_no;
	document.getElementById('dealInfoForm').submit();
};

// 리뷰 작성, 등록 이벤트
if(document.getElementById('review-content') != null){
	document.getElementById('review-content').addEventListener('input', function(){
		// 높이 조절
		this.style.height = 'auto';
		this.style.height = this.scrollHeight + 'px';
		
		if(this.value.length > 0){
			this.classList.remove('not-pass');
			this.classList.add('pass');
		}else{		
			this.classList.remove('pass');
			this.classList.add('not-pass');
		}
		
		this.nextElementSibling.firstElementChild.textContent = this.value.length;
	});
	
	document.querySelector('.review-btn').addEventListener('click', function(){
		if(document.querySelector('.not-pass') != null){
			alert(document.querySelector('.not-pass').dataset.alert);
			document.querySelector('.not-pass').focus();
			
			return;
		}
		
		// 리뷰 등록, 채팅 알람 발송 기능 구현할 것
	});
}

let connectWs = function(){
	sock = new SockJS('${pageContext.request.contextPath}/echo');
	socket = sock;
	
	sock.onopen = function(){
		console.log('info: connection opened.');
	};
};
</script>