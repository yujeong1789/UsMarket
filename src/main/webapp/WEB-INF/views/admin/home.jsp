<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="body-container">
	<div class="body-title">
		<span>대시보드</span>
	</div>
	<div class="body-dashboard">
		<div>
			<span class="body-subtitle">신규 가입자 추이</span>
			<span class="subtitle-unit">단위: 명</span>
			
			<div class="home-stats">
				<div class="member-stats-loading">로딩중</div>
				<canvas id="member_stats"></canvas>
			</div>
		</div>
		<div>
			<span class="body-subtitle">결제 추이</span>
			<span class="subtitle-unit">단위: KRW</span>
			
			<div class="home-stats">
				<div class="deal-stats-loading">로딩중</div>
				<canvas id="deal_stats"></canvas>
			</div>
		</div>
		<div>
			<span class="body-subtitle">최근 신고</span>
			<span class="subtitle-unit">단위: 건</span>
			
			<div class="home-stats">
				<div class="report-stats-loading">로딩중</div>
				<canvas id="report_stats"></canvas>
			</div>
		</div>
		<div>
			<span class="body-subtitle">최근 문의</span>
			<span class="subtitle-unit">단위: 건</span>
			
			<div class="home-stats">
				<div class="qna-stats-loading">로딩중</div>
				<canvas id="qna_stats"></canvas>
			</div>
		</div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<script>
	const getMemberStats = function(){
		return fetch('/usMarket/fetch/memberstats/'+getStartDate()+'/'+getEndDate())
    			.then(response => response.json());
	};
	
	const getDealStats = function(){
		return fetch('/usMarket/fetch/dealstats/'+getStartDay()+'/'+getEndDay())
    			.then(response => response.json());
	};

	getMemberStats().then(data  => {
		var ctx = document.getElementById('member_stats');		
		document.querySelector('.member-stats-loading').style.visibility = 'hidden';
		const myChart = new Chart(ctx, {
			type: 'line',
			data: {
				labels : [setDateFormat(data[0].MONTH), setDateFormat(data[1].MONTH), setDateFormat(data[2].MONTH)],
				datasets: [{
		            label: '',
		            data: [data[0].CNT, data[1].CNT, data[2].CNT],
		            backgroundColor: 'rgba(235, 242, 255, 0.8)',
		            pointRadius: '4',
		            borderColor: 'rgba(113, 155, 255, 0.8)',
		            pointBorderColor: 'rgba(113, 155, 255, 0.8)',
		            borderWidth: 2,
		            borderRadius: 10,
		            pointBackgroundColor : 'white',
	                pointBorderWidth : '2',
	                pointHoverBorderWidth :'2',
	                pointHoverBackgroundColor : 'white'
				}]
			},
		    options: {
		        tooltips: {
		        	enabled: false
		        },
		        hover: {
		        	animationDuration: 0	
		        },
		        animation: {
					duration: 1000,
					onComplete: function () {
						var chartInstance = this.chart,
							ctx = chartInstance.ctx;
						ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, 'bold', Chart.defaults.global.defaultFontFamily);
						ctx.fillStyle = 'rgba(123, 123, 123, 0.8)';
						ctx.textAlign = 'center';
						ctx.textBaseline = 'bottom';

						this.data.datasets.forEach(function (dataset, i) {
							var meta = chartInstance.controller.getDatasetMeta(i);
							meta.data.forEach(function (bar, index) {
								var data = dataset.data[index];							
								ctx.fillText(data, bar._model.x, bar._model.y - 5);
							});
						});
					}
				},
				legend: {
	                display: true,
	                labels: {
	                boxWidth: 0,
	                fontColor: 'rgba(0,0,0,0)',
	                fontSize: 20
	                }
	            },
	            scales: {
	                xAxes: [{
	                    ticks: {
	                        fontSize: 12,
	                        fontColor: 'rgba(49, 51, 68, 0.8)'
	                    },
	                    gridLines: {
	                        display:false,
	                        lineWidth:0
	                    }
	                }],
	                yAxes: [{
	                    ticks: {
	                        display: false,
	                        beginAtZero: false
	                    },
	                    gridLines: {
							display:false,
							lineWidth:0
						}   
					}]
				}
			}
		});
	}); // member-stats
	
	
	getDealStats().then(data  => {
		var ctx = document.getElementById('deal_stats');
		document.querySelector('.deal-stats-loading').style.visibility = 'hidden';
		const myChart = new Chart(ctx, {
			type: 'line',
			data: {
				labels : [setDateFormat(data[0].DAY), setDateFormat(data[1].DAY), setDateFormat(data[2].DAY)],
				datasets: [{
		            label: '',
		            data: [data[0].PRICE, data[1].PRICE, data[2].PRICE],
		            backgroundColor: 'rgba(235, 242, 255, 0.8)',
		            pointRadius: '4',
		            borderColor: 'rgba(113, 155, 255, 0.8)',
		            pointBorderColor: 'rgba(113, 155, 255, 0.8)',
		            borderWidth: 2,
		            borderRadius: 10,
		            pointBackgroundColor : 'white',
	                pointBorderWidth : '2',
	                pointHoverBorderWidth :'2',
	                pointHoverBackgroundColor : 'white'
				}]
			},
		    options: {
		    	tooltips: {
		        	enabled: false
		        },
		        hover: {
		        	animationDuration: 0	
		        },
		        animation: {
					duration: 1000,
					onComplete: function () {
						var chartInstance = this.chart,
							ctx = chartInstance.ctx;
						ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, 'bold', Chart.defaults.global.defaultFontFamily);
						ctx.fillStyle = 'rgba(123, 123, 123, 0.8)';
						ctx.textAlign = 'center';
						ctx.textBaseline = 'bottom';

						this.data.datasets.forEach(function (dataset, i) {
							var meta = chartInstance.controller.getDatasetMeta(i);
							meta.data.forEach(function (bar, index) {
								var data = getPriceFormat(dataset.data[index]);							
								ctx.fillText(data, bar._model.x, bar._model.y - 5);
							});
						});
					}
				},
				legend: {
	                display: true,
	                labels: {
	                boxWidth: 0,
	                fontColor: 'rgba(0,0,0,0)',
	                fontSize: 20
	                }
	            },
	            scales: {
	                xAxes: [{
	                    ticks: {
	                    	fontSize: 12,
	                        fontColor: 'rgba(49, 51, 68, 0.8)'
	                    },
	                    gridLines: {
	                        display:false,
	                        lineWidth:0
	                    }
	                }],
	                yAxes: [{
	                    ticks: {
	                        display: false,
	                        beginAtZero: false
	                    },
	                    gridLines: {
							display:false,
							lineWidth:0
						}   
					}]
				}
			}
		});
	}); // deal-stats
	
	
	
</script>
