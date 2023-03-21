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
			<div class="member-list">
			
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
});

document.getElementById('endDate').addEventListener('change', function(e){
	document.getElementById('startDate').setAttribute('max', this.value);
	getMemberChart(document.getElementById('startDate').value, this.value);
});

document.querySelectorAll('.date-btn').forEach(el => {
	el.addEventListener('click', function(e){
		var endDate = getEndDay();
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
		getMemberChart(startDate, endDate);
	});
});


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
};
</script>