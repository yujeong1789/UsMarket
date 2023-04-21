<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="<c:url value='/resources/admin/css/payment_list.css'/>" type="text/css">

<div class="payment-list-container">
	<div class="title">
		<span>결제관리</span>
	</div>
	<div class="dashboard">
		<div class="canvas-container">
			<canvas id="payment_canvas"></canvas>		
		</div>
		<div>
			<div class="options-container">
				<div class="date-picker">
					<label for="startDate">시작일</label>
					<input type="date" name="startDate" id="startDate" min="2022-04-01" required>
					<label for="endDate">종료일</label>
					<input type="date" name="endDate" id="endDate" min="2022-04-01" required>
					<div class="date-btn" id="week">1주</div>
					<div class="date-btn" id="month">1개월</div>
					<div class="date-btn" id="half-month">6개월</div>
					<div class="date-btn" id="year">1년</div>
				</div>
				<div class="order-condition">
					<div class="order-dropdown">
						<span>정렬</span>
						<div class="dropdown-content">
							<ul>
								<li class="order-selected" data-order="regdate_desc">결제일 내림차순</li>
								<li data-order="regdate">결제일 오름차순</li>
								<li data-order="price_desc">결제금액 높은순</li>
								<li data-order="price">결제금액 낮은순</li>							
							</ul>
						</div>
					</div>
					<div class="condition-dropdown">
						<span>거래상태</span>
						<div class="dropdown-content">
							<ul>
								<li class="condition-selected" data-condition="">전체</li>
								<li data-condition="0">거래대기중</li>					
								<li data-condition="1">거래진행중</li>					
								<li data-condition="2">거래완료</li>					
								<li data-condition="3">거래취소</li>					
							</ul>
						</div>
					</div>
				</div>			
			</div>

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
								<th>결제액</th>
								<th>거래상태</th>
								<th>결제일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="deal" items="${dealList }">
								<tr class="body" id="${deal.DEAL_NO }" data-num="${deal.NUM }">
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
		</div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<script>
const btns = ['week', 'month', 'half-month', 'year'];

document.addEventListener('DOMContentLoaded', function(){
	dateInit();
	getPaymentChart(document.getElementById('startDate').value, document.getElementById('endDate').value);
	
});

document.getElementById('startDate').addEventListener('change', function(e){
	document.getElementById('endDate').setAttribute('min', this.value);
	getPaymentChart(this.value, document.getElementById('endDate').value);
	getPaymentList(1);
});

document.getElementById('endDate').addEventListener('change', function(e){
	document.getElementById('startDate').setAttribute('max', this.value);
	getPaymentChart(document.getElementById('startDate').value, this.value);
	getPaymentList(1);
});

document.querySelectorAll('.order-dropdown li').forEach(el => {
	el.addEventListener('click', function(){
		document.querySelector('.order-selected').classList.remove('order-selected');
		this.className = 'order-selected';
		console.log(this.dataset.order);
		
		document.getElementById('pageValue').value = 1;
		getPaymentList(1);
	});
});

document.querySelectorAll('.condition-dropdown li').forEach(el => {
	el.addEventListener('click', function(){
		document.querySelector('.condition-selected').classList.remove('condition-selected');
		this.className = 'condition-selected';
		console.log(this.dataset.condition);
		
		document.getElementById('pageValue').value = 1;
		getPaymentList(1);
	});
});

document.querySelectorAll('.date-btn').forEach(el => {
	el.addEventListener('click', function(e){
		const endDate = getEndDay();
		var startDate;
		
		switch (e.target.id) {
		case 'week':
			startDate = getStartDay(7);
			break;
		case 'month':
			startDate = getStartMonth(1);
			break;
		case 'half-month':
			startDate = getStartMonth(6);
			break;
		case 'year':
			startDate = getStartMonth(12);
			console.log('year');
			break;
		};
		document.getElementById('pageValue').value = 1;
		getPaymentChart(startDate, endDate);
		getPaymentList(1);
	});
});

document.querySelectorAll('.payment-list .body').forEach(el => {
	el.addEventListener('click', function(){
		dealInfoSubmit(this);
	});
});

let dealInfoSubmit = function(element){
	document.getElementById('deal_no').value = element.id;
	document.getElementById('dealInfoForm').submit();
};


let dateInit = function(){
	let today = getEndDay();
	document.getElementById('startDate').value = '2022-04-01';
	document.getElementById('startDate').setAttribute('max', today);
	
	document.getElementById('endDate').value = getEndDay();
	document.getElementById('endDate').setAttribute('max', today);
};


let getPaymentChart = function(startDate, endDate){
	document.getElementById('startDate').value = startDate;
	document.getElementById('endDate').value = endDate;
	
	document.getElementById('payment_canvas').remove();
	document.querySelector('.canvas-container').innerHTML = '<canvas id="payment_canvas"></canvas>';
	
	let params = {
			'startDate': startDate,
			'endDate': endDate,
			'mode': (startDate.substr(0, 7) != endDate.substr(0, 7) ? 'month' : 'date')
	};
	
	fetch('/usMarket/fetch/admin/dealstats', {
		method: 'POST',
		headers: {
			'Content-type' : 'application/json'
		},
		body: JSON.stringify(params),
	})
	.then((response) => response.json())
	.then((data) => {
		const labels = new Array();
		const price = new Array();
		const count = new Array();
		
		data.forEach((el, i) => {
			labels.push(el.DAY);
			price.push(el.PRICE);
			count.push(el.COUNT);
		});
		
		var ctx = document.getElementById('payment_canvas');
		const myChart = new Chart(ctx, {
			type: 'line',
			data: {
				labels : labels,
				datasets: [{
		            label: '신규 가입 회원',
		            backgroundColor: 'rgba(235, 242, 255, 0.8)',
		            pointRadius: '3',
		            borderColor: 'rgba(113, 155, 255, 0.8)',
		            pointBorderColor: 'rgba(113, 155, 255, 0.8)',
		            borderWidth: '2',
		            borderRadius: '2',
		            pointBackgroundColor : 'white',
	                pointBorderWidth : '2',
	                pointHoverBorderWidth :'2',
	                pointHoverBackgroundColor : 'white',
	                pointHitRadius: '10',
	                tension: 0,
		            data: count
				}]
			},
		    options: {
		        tooltips: {
		    		backgroundColor: 'rgba(80, 80, 80, 0.8)',
					caretPadding: 10,
					displayColors: false,
					bodyFontStyle: 'bold',
					yPadding: 8,
		    		callbacks: {
		    			label: function(tooltipItem) {
							var label = getPriceFormat(data[tooltipItem.index].PRICE)+'원';
							return label;
		    	        }
					}
		        },
		        hover: {
		        	animationDuration: 0	
		        },
		        animation: {
					duration: 1000,
					onComplete: function () {
						var chartInstance = this.chart,
							ctx = chartInstance.ctx;
						ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, '500', Chart.defaults.global.defaultFontFamily);
						ctx.fillStyle = 'rgba(123, 123, 123, 0.8)';
						ctx.textAlign = 'center';
						ctx.textBaseline = 'bottom';
						
						var dataset = this.data.datasets[0];
						var meta = chartInstance.controller.getDatasetMeta(0);
						meta.data.forEach(function (bar, index) {
							var data = dataset.data[index]+'건';
							ctx.fillText(data, bar._model.x, bar._model.y - 5);
						});
					}
				},
				legend: {
	                display: true,
	                labels: {
	                	boxWidth: 0,
		                fontColor: 'rgba(0,0,0,0)',
		                fontSize: 1
	                }
	            },
	            scales: {
	                xAxes: [{
	                    ticks: {
	                        fontSize: 11,
	                        fontColor: 'rgba(49, 51, 68, 0.8)'
	                    },
	                    gridLines: {
	                        display: false,
	                        lineWidth: 0
	                    }
	                }],
	                yAxes: [{
	                    ticks: {
	                        display: false,
	                        beginAtZero: true
	                    },
	                    gridLines: {
							display: false,
							lineWidth: 0
						} 
					}]
				}
			}
		}); // myChart
		
	}).catch((error) => console.log('error: '+error)); // fetch end
}; // getPaymentChart



let getPaymentList = function(page){
	let params = {
			'page': page,
			'pageSize': 10,
			'startDate': document.getElementById('startDate').value,
			'endDate': document.getElementById('endDate').value,
			'condition': document.querySelector('.condition-selected').dataset.condition,
			'order': document.querySelector('.order-selected').dataset.order
	};
	
	console.log(params);
	
	fetch('/usMarket/admin/payment/list', {
		method: 'POST',
		headers: {
			'Content-type' : 'application/json'
		},
		body: JSON.stringify(params),
	})
	.then((response) => response.text())
	.then((data) => {
		var result = document.createElement('div');
		result.innerHTML = data;
		document.querySelector('.payment-list').innerHTML = result.querySelector('.payment-list').innerHTML;
	}).catch((error) => console.log('error: '+error)); // fetch end
}; // getPaymentList
</script>