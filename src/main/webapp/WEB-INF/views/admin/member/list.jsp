<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="<c:url value='/resources/admin/css/member_list.css'/>" type="text/css">

<div class="member-list-container">
	<div class="title">
		<span>회원관리</span>
	</div>
	<div class="dashboard">
		<div class="canvas-container">
			<canvas id="member_canvas"></canvas>		
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
								<li class="order-selected" data-order="regdate_desc">가입일 내림차순</li>
								<li data-order="regdate">가입일 오름차순</li>
								<li data-order="product_desc">판매상품 많은순</li>
								<li data-order="product">판매상품 적은순</li>							
							</ul>
						</div>
					</div>
					<div class="condition-dropdown">
						<span>가입상태</span>
						<div class="dropdown-content">
							<ul>
								<li class="condition-selected" data-condition="0">전체</li>
								<li data-condition="1">정상</li>					
								<li data-condition="2">정지</li>					
								<li data-condition="3">탈퇴</li>					
							</ul>
						</div>
					</div>
				</div>			
			</div>

			<div class="member-list">
				<c:if test="${empty memberList }">
					<span>회원이 존재하지 않습니다.</span>
				</c:if>
				<c:if test="${not empty memberList }">
					<table>
						<thead>
							<tr class="head">
								<th>아이디</th>
								<th>닉네임</th>
								<th>판매상품 수</th>
								<th>가입상태</th>
								<th>가입일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="member" items="${memberList }">
								<tr class="body" id="${member.MEMBER_NO }" data-num="${member.NUM }">
									<td>${member.MEMBER_ID }</td>
									<td>${member.MEMBER_NICKNAME }</td>
									<td>${member.PRODUCT_COUNT }</td>
									<td>${member.MEMBER_STATE_NAME }</td>
									<td><fmt:formatDate value="${member.MEMBER_REGDATE }" pattern="yyyy년 MM월 dd일 HH:mm"/></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<form id="memberInfoForm" name="memberInfoForm" action="<c:url value='/admin/member/info'/>" method="post">
						<input type="hidden" id="member_no" name="member_no" value="">
					</form>
					<div class="paging">
						<c:if test="${ph.totalCnt != null || ph.totalCnt != 0 }">
							<c:if test="${ph.showPrev }">
								<div class="paging-prev">
									&lt;&lt;
								</div>
							</c:if>
							<c:forEach var="i" begin="${ph.beginPage }" end="${ph.endPage }">
								<div class="paging-box ${i eq ph.sc.page ? 'current-page' : 'not-current-page' }" onclick="${i eq ph.sc.page ? '' : 'getMemberList(' += i += ')'}">
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
			</div>
		</div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<script>
const btns = ['week', 'month', 'half-month', 'year'];

document.addEventListener('DOMContentLoaded', function(){
	dateInit();
	getMemberChart(document.getElementById('startDate').value, document.getElementById('endDate').value);
	
});

document.getElementById('startDate').addEventListener('change', function(e){
	document.getElementById('endDate').setAttribute('min', this.value);
	getMemberChart(this.value, document.getElementById('endDate').value);
	getMemberList(1);
});

document.getElementById('endDate').addEventListener('change', function(e){
	document.getElementById('startDate').setAttribute('max', this.value);
	getMemberChart(document.getElementById('startDate').value, this.value);
	getMemberList(1);
});

document.querySelectorAll('.order-dropdown li').forEach(el => {
	el.addEventListener('click', function(){
		document.querySelector('.order-selected').classList.remove('order-selected');
		this.className = 'order-selected';
		console.log(this.dataset.order);
		
		document.getElementById('pageValue').value = 1;
		getMemberList(1);
	});
});

document.querySelectorAll('.condition-dropdown li').forEach(el => {
	el.addEventListener('click', function(){
		document.querySelector('.condition-selected').classList.remove('condition-selected');
		this.className = 'condition-selected';
		console.log(this.dataset.condition);
		
		document.getElementById('pageValue').value = 1;
		getMemberList(1);
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
		getMemberChart(startDate, endDate);
		getMemberList(1);
	});
});

document.querySelectorAll('.member-list .body').forEach(el => {
	el.addEventListener('click', function(){
		memberInfoSubmit(this);
	});
});

let memberInfoSubmit = function(element){
	document.getElementById('member_no').value = element.id;
	document.getElementById('memberInfoForm').submit();
};


let dateInit = function(){
	let today = getEndDay();
	document.getElementById('startDate').value = '2022-04-01';
	document.getElementById('startDate').setAttribute('max', today);
	
	document.getElementById('endDate').value = getEndDay();
	document.getElementById('endDate').setAttribute('max', today);
};


let getMemberChart = function(startDate, endDate){
	document.getElementById('startDate').value = startDate;
	document.getElementById('endDate').value = endDate;
	
	document.getElementById('member_canvas').remove();
	document.querySelector('.canvas-container').innerHTML = '<canvas id="member_canvas"></canvas>';
	
	let params = {
			'startDate': startDate,
			'endDate': endDate,
			'mode': (startDate.substr(0, 7) != endDate.substr(0, 7) ? 'month' : 'date')
	};
	
	fetch('/usMarket/fetch/admin/memberstats', {
		method: 'POST',
		headers: {
			'Content-type' : 'application/json'
		},
		body: JSON.stringify(params),
	})
	.then((response) => response.json())
	.then((data) => {
		const labels = new Array();
		const increase = new Array();
		const cnt = new Array();
		
		data.forEach((el, i) => {
			labels.push(el.DATE);
			increase.push(el.INCREASE);
			cnt.push(el.CNT);
		});
		
		var ctx = document.getElementById('member_canvas');
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
		            data: cnt
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
							var label = (data[tooltipItem.index].INCREASE >= 0 ? '+' : '-')+getPriceFormat(data[tooltipItem.index].INCREASE)+'명';
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
							var data = getPriceFormat(dataset.data[index])+'명';
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
}; // getMemberChart



let getMemberList = function(page){
	let params = {
			'page': page,
			'pageSize': 10,
			'startDate': document.getElementById('startDate').value,
			'endDate': document.getElementById('endDate').value,
			'condition': document.querySelector('.condition-selected').dataset.condition,
			'order': document.querySelector('.order-selected').dataset.order
	};
	
	console.log(params);
	
	fetch('/usMarket/admin/member/list', {
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
		document.querySelector('.member-list').innerHTML = result.querySelector('.member-list').innerHTML;
	}).catch((error) => console.log('error: '+error)); // fetch end
}; // getMemberList
</script>