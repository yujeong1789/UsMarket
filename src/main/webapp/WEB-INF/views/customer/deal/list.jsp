<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/deal_list.css'/>" type="text/css">
<div class="deal-list-container">
	<div class="row">
		<div class="container">
			<div class="title">
				<span>거래내역</span>
			</div>	
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
			<form id="dealInfoForm" action="<c:url value='/deal/info'/>" method="post">
				<input type="hidden" id="deal_no" name="deal_no">
			</form>
		</div> <!-- container -->
	</div> <!-- row -->
</div> <!-- deal-list-container --> 

<script type="text/javascript">
document.querySelectorAll('.deal-list li').forEach(el => function(){
	el.addEventListener('click', function(){
		getDealInfo(el);
	});
});

let setCondition = function(el){
	document.querySelector('.condition-selected').classList.remove('condition-selected');
	el.className = 'condition-selected';
	
	document.querySelector('.state-selected').classList.remove('state-selected');
	document.querySelector('.deal-states > div:first-child').className = 'state-selected';
	
	getDealList();
};

let setState = function(el){
	document.querySelector('.state-selected').classList.remove('state-selected');
	el.className = 'state-selected';
	
	getDealList();
};

let getDealInfo = function(el){
	document.getElementById('deal_no').value = el.dataset.no;
	document.getElementById('dealInfoForm').submit();
};

let getDealList = function(page){
	console.log(document.querySelector('.condition-selected').dataset.condition);
	console.log(document.querySelector('.state-selected').dataset.state);
	
	let params = new FormData();
	params.append('condition', document.querySelector('.condition-selected').dataset.condition);
	params.append('state', document.querySelector('.state-selected').dataset.state);
	
	fetch('/usMarket/deal/list', {
		method: 'POST',
		body: params,
	})
	.then((response) => response.text())
	.then((data) => {
		var result = document.createElement('div');
		result.innerHTML = data;
		document.querySelector('.deal-list').innerHTML = result.querySelector('.deal-list').innerHTML;
	}).catch((error) => console.log('error: '+error)); // fetch end
}; // getDealList
</script>