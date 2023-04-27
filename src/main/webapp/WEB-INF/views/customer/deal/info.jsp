<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/deal_info.css'/>" type="text/css">
<c:if test="${empty dealInfo }">
	<script type="text/javascript">
		alert("잘못된 접근입니다.");
		location.replace('${pageContext.request.contextPath}/deal/list');
	</script>
</c:if>

<!-- 신고하기 모달 -->
<input type="hidden" id="report_type">
<jsp:include page="/WEB-INF/views/customer/inc/report_modal.jsp"/>

<div class="deal-info-container">
	<div class="row">
		<div class="container">
			<div class="deal-info-layout">
				<div class="list-title">
					<a href="<c:url value='/deal/list'/>">거래내역 목록</a>
					>
					<span>거래내역 상세</span>
				</div>
				<div class="title">
					<span>거래내역</span>
					<c:if test="${dealInfo.DEAL_STATE eq '1' }">
						<div class="report-div" onclick="openReport()">
							<img alt="신고하기" src="<c:url value='/resources/customer/img/report.png'/>">
							신고하기
						</div>
					</c:if>
				</div>
				<div class="deal-info">
					<div class="info">
						<div class="info-title">${mode eq 'buy' ? '구매상품' : '판매상품' }</div>
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
						<div class="info-title">${not empty dealInfo.DEAL_COMPLETE_DATE ? '거래종료일' : '주문일시'}</div>
						<div class="info-info">
							<fmt:formatDate value="${not empty dealInfo.DEAL_COMPLETE_DATE ? dealInfo.DEAL_COMPLETE_DATE : dealInfo.DEAL_START_DATE }" pattern="yyyy.MM.dd (a hh:mm)" />
						</div>
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
						<c:if test="${mode eq 'sell' and dealInfo.DEAL_DELIVERY_STATE ne '3' and dealInfo.DEAL_DELIVERY_STATE != '4'  and dealInfo.DEAL_CANCEL ne '0'}">
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
							<c:if test="${empty dealInfo.DEAL_CANCEL and dealInfo.DEAL_DELIVERY_STATE ne '4'}">
								<div class="deal-cancel">
									<div onclick="setCancel(this)" data-no="${dealInfo.DEAL_DELIVERY_STATE eq '1' ? '3' : '0' }">주문취소</div>
								</div>
							</c:if>
							<c:if test="${dealInfo.DEAL_CANCEL eq '0' }">
								<div class="alert-message">판매자의 취소 승인을 기다리고 있습니다.</div>
							</c:if>
							<c:if test="${dealInfo.DEAL_CANCEL ne '0' and dealInfo.DEAL_DELIVERY_STATE eq '3' }">
								<div class="deal-receive">
									<div onclick="setDeliveryReceive(this)" data-state="4">구매확정</div>
								</div>
							</c:if>
						</c:if>
						<c:if test="${mode eq 'sell' and dealInfo.DEAL_CANCEL eq '0'}">
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
								<div class="score-dropdown">
									<span>별점</span>
									<div class="dropdown-content">
										<ul>
											<li data-score="5">
												<img alt="별점" src="<c:url value='/resources/customer/img/score/5.png'/>">
											</li>		
											<li data-score="4">
												<img alt="별점" src="<c:url value='/resources/customer/img/score/4.png'/>">
											</li>
											<li data-score="3">
												<img alt="별점" src="<c:url value='/resources/customer/img/score/3.png'/>">
											</li>
											<li data-score="2">
												<img alt="별점" src="<c:url value='/resources/customer/img/score/2.png'/>">
											</li>
											<li data-score="1">
												<img alt="별점" src="<c:url value='/resources/customer/img/score/1.png'/>">
											</li>
										</ul>
									</div>
									<input class="not-pass" id="review_score" type="hidden" data-alert="별점을 선택해 주세요.">
								</div>
								<div class="review-textarea">
									<textarea class="not-pass" id="review_content" data-alert="내용을 입력해 주세요." maxlength="200"></textarea>
									<div class="current-count"><p>0</p><p>/200</p></div>
								</div>
								<div class="review-btn">등록하기</div>
							</c:if>
							<c:if test="${mode eq 'sell' }">
								<div class="alert-message">작성된 리뷰가 없습니다.</div>
							</c:if>
						</c:if>
						<c:if test="${dealInfo.DEAL_REVIEW eq 'Y' }">
							<div class="review-info">
								<div class="left" data-no="${reviewInfo.CUSTOMER_NO }">
									<c:if test="${reviewInfo.MEMBER_IMAGE eq '/resources/customer/img/default_profile.png' }">
										<img src="<c:url value='${reviewInfo.MEMBER_IMAGE }'/>">
									</c:if>
									<c:if test="${reviewInfo.MEMBER_IMAGE ne '/resources/customer/img/default_profile.png' }">
										<img src="${reviewInfo.MEMBER_IMAGE }">
									</c:if>
								</div>
								<div class="right">
									<div class="review-nickname">
										<a href="<c:url value='/member/mypage?member_no=${reviewInfo.CUSTOMER_NO }'/>">
											${reviewInfo.MEMBER_NICKNAME }
											<img src="<c:url value='/resources/admin/img/icon/redirect.png'/>">
										</a>
									</div>
									<div class="review-score">
										<c:forEach begin="0" end="4" step="1" varStatus="status">
											<c:if test="${reviewInfo.REVIEW_SCORE ge status.count}">
												<img src="<c:url value='/resources/customer/img/star.png'/>">
											</c:if>
											<c:if test="${reviewInfo.REVIEW_SCORE lt status.count}">
												<img src="<c:url value='/resources/customer/img/star_blank.png'/>">
											</c:if>
										</c:forEach>
									</div>
									<div class="review-content"><c:out value='${reviewInfo.REVIEW_CONTENT }'/></div>
								</div>
							</div>
						</c:if>
					</div>
				</c:if>
				<div class="deal-list-btn" onclick="location.href='<c:url value="/deal/list"/>'">목록</div>
			</div> <!-- deal-info-layout -->
		</div>
	</div>
	<form id="dealInfoForm" action="<c:url value='/deal/info'/>" method="post">
		<input type="hidden" id="deal_no" name="deal_no">
	</form>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function(){
	var socket = null;
	connectWs();
});

// 거래 승인 or 취소
let setAccept = function(el){
	 dealStateModify(confirm('거래를 '+el.textContent+'하시겠습니까?'), el.dataset.no);
};

// 거래상태 변경
let dealStateModify = function(confirm, deal_state){
	let title = (deal_state == 1 ? '거래승인' : (deal_state == 2 ? '거래완료' : '거래취소'));
	let content = (deal_state == 1 ? '거래가 승인되었습니다.' : (deal_state == 2 ? '거래가 완료되었습니다.' : '거래가 취소되었습니다.'));
	
	if(confirm){
		let params = new FormData();
		params.append('deal_state', deal_state);
		params.append('deal_no', `${dealInfo.DEAL_NO}`);
		params.append('product_no', `${dealInfo.PRODUCT_NO}`);
		params.append('seller_no', `${dealInfo.SELLER_NO}`);
		
		fetch('/usMarket/fetch/deal/modify', {
			method: 'POST',
			body: params,
		})
		.then((response) => response.text())
		.then((text) => {
				if(text == 1){
					sendMessge(`${dealInfo.PRODUCT_NAME}` + ' 상품의 ' + content, title);
					alert(content);
				}else{
					alert('요청하신 작업에 실패했습니다. 다시 시도해 주세요.');
					getDealInfo(`${dealInfo.DEAL_NO}`);
				}
		}).catch((error) => {
			console.error('error: '+error);
		});
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
	let cancelMessage = el.dataset.no == 1 ? '거래 취소 요청을 승인하시겠습니까?\n해당 작업은 되돌릴 수 없으므로 반드시 취소된 상품을 수령한 후에 승인해 주세요.' : '거래 취소 요청을 거절하시겠습니까?';
	dealCancel(confirm(cancelMessage), el.dataset.no);
};

// 즉시 거래취소
let dealCancel = function(confirm, deal_cancel){
	if(confirm){
		let title = (`${mode}` == 'buy' ? '취소요청' : (deal_cancel == 1 ? '취소요청 승인' : '취소요청 거절'));
		let content = `${dealInfo.PRODUCT_NAME}` + '상품의 거래 취소' + (`${mode}` == 'buy' ? '가 요청되었습니다.' :  + ' 요청이 ' + (deal_cancel == 1 ? '승인되었습니다.' : '거절되었습니다.'));
		
		let params = new FormData();
		params.append('deal_cancel', deal_cancel);
		params.append('deal_no', `${dealInfo.DEAL_NO}`);
		params.append('product_no', `${dealInfo.PRODUCT_NO}`);
		params.append('seller_no', `${dealInfo.SELLER_NO}`);
		
		fetch('/usMarket/fetch/deal/cancel', {
			method: 'POST',
			body: params,
		})
		.then((response) => response.text())
		.then((text) => {
				if(text == 1){
					sendMessge(content, title);
					alert('요청하신 작업이 완료되었습니다.');
				}else{
					alert('요청하신 작업에 실패했습니다. 다시 시도해 주세요.');
					getDealInfo(`${dealInfo.DEAL_NO}`);
				}
		}).catch((error) => {
			console.error('error: '+error);
		});
	}
};

// 배송상태 변경
let setDeliveryState = function(confirm, deal_delivery_state){
	if(confirm){
		let title = (`${mode}` == 'buy' ? '거래완료' : (deal_delivery_state == 2 ? '배송시작' : '배송완료'));
		let content = `${dealInfo.PRODUCT_NAME}`+ ' 상품의 ' + (`${mode}` == 'buy' ? '거래가 완료되었습니다.' : (deal_delivery_state == 2 ? '배송이 시작되었습니다.' : '배송이 완료되었습니다. 구매확정을 눌러 주세요.'));
		
		let successMessage = (`${mode}` == 'buy' ? '구매확정이 완료되었습니다.' : '배송상태가 변경되었습니다.');
		let failMessage = (`${mode}` == 'buy' ? '구매확정에 실패했습니다.' : '배송상태 변경에 실패했습니다.');
		
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
					sendMessge(content, title);
					alert(successMessage);
				}else{
					alert(failMessage);
					getDealInfo(`${dealInfo.DEAL_NO}`);
				}
		}).catch((error) => {
			console.error('error: '+error);
		});
	}
};

// 구매확정
let setDeliveryReceive = function(el){
	setDeliveryState(confirm('구매확정하신 뒤에는 취소신청이 불가합니다.\n반드시 상품을 수령하신 뒤에 구매확정해 주세요.'), el.dataset.state);
};

// 판매자 배송상태 변경
let setSellerDeliveryState = function(el){
	setDeliveryState(confirm('배송상태를 '+el.dataset.current+'에서 '+el.textContent+'(으)로 변경하시겠습니까?'), el.dataset.state);
};

// 페이지 새로고침
let getDealInfo = function(deal_no){
	document.getElementById('deal_no').value = deal_no;
	document.getElementById('dealInfoForm').submit();
};

// 리뷰 작성, 등록 이벤트
if(document.getElementById('review_content') != null){
	document.querySelectorAll('.score-dropdown li').forEach(el => {
		el.addEventListener('click', function(e){
			if(document.querySelector('.score-selected') != null){
				document.querySelector('.score-selected').classList.remove('score-selected');				
			}
			this.classList.add('score-selected');
			
			document.getElementById('review_score').value = this.dataset.score;
			document.getElementById('review_score').classList.remove('not-pass');
			document.getElementById('review_score').classList.add('pass');
			
			document.querySelector('.score-dropdown > span').innerHTML = this.innerHTML;
		});
	});
	
	document.getElementById('review_content').addEventListener('input', function(){
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
		
		if(confirm('리뷰를 등록하시겠습니까?')){			
			let params = new FormData();
			params.append('deal_no', `${dealInfo.DEAL_NO}`);
			params.append('review_content', document.getElementById('review_content').value);
			params.append('review_score', document.getElementById('review_score').value);
			
			fetch('/usMarket/fetch/review/add', {
				method: 'POST',
				body: params,
			})
			.then((response) => response.text())
			.then((text) => {
					if(text == 2){
						sendMessge(`${dealInfo.PRODUCT_NAME}` + ' 상품 거래의 리뷰가 등록되었습니다.', '리뷰등록');
						alert("리뷰가 등록되었습니다.");
					}else{
						alert("리뷰 작성에 실패했습니다. 다시 시도해 주세요.");
						getDealInfo(`${dealInfo.DEAL_NO}`);
					}
			}).catch((error) => {
				console.error('error: '+error);
			});
		}
	});
}

let connectWs = function(){
	sock = new SockJS('${pageContext.request.contextPath}/echo');
	socket = sock;
	
	sock.onopen = function(){
		console.log('info: connection opened.');
	};
};

// 알림 발송
let sendMessge = function(content, title){
	let params = {
			room_no: `${room_no}`,
			chat_to: (`${mode}` == 'buy' ? `${dealInfo.SELLER_NO}` : `${dealInfo.CUSTOMER_NO}`),
			chat_content: content,
			chat_type: 1,
			chat_title: title,
			chat_info: `${dealInfo.DEAL_NO}`
	};
	
	fetch('/usMarket/fetch/chat/send', {
		method: 'POST',
		headers: {
			'Content-type' : 'application/json'
		},
		body: JSON.stringify(params),
	})
	.then((response) => response.json())
	.then((json) => {
		let msg = {
				type: 'chat',
				body: json
			};
		socket.send(JSON.stringify(msg));
		getDealInfo(`${dealInfo.DEAL_NO}`);
	}).catch((error) => {
		console.error('error: '+error);
	});
};

//신고하기
let openReport = function(){
	console.log(type);
	document.getElementById('report_member_no').value = (`${mode}` == 'buy' ? `${dealInfo.SELLER_NO}` : `${dealInfo.CUSTOMER_NO}`);
	document.getElementById('report_info').value = `${dealInfo.DEAL_NO}`;
	document.querySelector('.report-info').textContent = (`${mode}` == 'buy' ? `${dealInfo.SELLER_NICKNAME}` : `${dealInfo.CUSTOMER_NICKNAME}`);
	
	reportModal.show();	
};
</script>