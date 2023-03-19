<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="body-container">
	<div class="body-title">
		<span>대시보드</span>
	</div>
	<div class="body-dashboard">
		<div>
			<div class="body-subtitle">
				<span>신규 가입자 추이</span>
				<span class="subtitle-unit">단위: 명</span>			
			</div>
			
			<div class="home-stats">
				<div class="member-stats-loading">로딩중</div>
				<canvas id="member_stats"></canvas>
			</div>
		</div>
		<div>
			<div class="body-subtitle">
				<span>결제 추이</span>
				<span class="subtitle-unit">단위: KRW</span>			
			</div>
			
			<div class="home-stats">
				<div class="deal-stats-loading">로딩중</div>
				<canvas id="deal_stats"></canvas>
			</div>
		</div>
		<div>
			<span class="body-subtitle">최근 신고</span>
			<div class="report-preview">
				<span class="loading">로딩중</span>
				<span class="preview-empty">최근 접수된 신고가 없습니다.</span>
				<ul class="home-ul report-ul"></ul>
			</div>
		</div>
		<div>
			<span class="body-subtitle">최근 문의</span>
			<div class="qna-preview">
				<span class="loading">로딩중</span>
				<span class="preview-empty">최근 접수된 문의가 없습니다.</span>
				<ul class="home-ul qna-ul"></ul>
			</div>
		</div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<script>
document.addEventListener('DOMContentLoaded', function(){
	fetch('/usMarket/fetch/admin/memberstats/'+getStartDate()+'/'+getEndDate())
	.then((response) => response.json())
	.then((data) => {
		console.log('member = '+data);
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
						ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, '500', Chart.defaults.global.defaultFontFamily);
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
	}).catch((error) => console.log("error: "+error)); // memberStats
	
	
	
	fetch('/usMarket/fetch/admin/dealstats/'+getStartDay()+'/'+getEndDay())
	.then((response) => response.json())
	.then((data) => {
		console.log('deal '+data);
		var ctx = document.getElementById('deal_stats');
		document.querySelector('.deal-stats-loading').style.visibility = 'hidden';
		const myChart = new Chart(ctx, {
			data: {
				labels : [setDateFormat(data[0].DAY), setDateFormat(data[1].DAY), setDateFormat(data[2].DAY)],
				datasets: [{
					type: 'line',
		            label: '발생 건수',
		            data: [data[0].PRICE, data[1].PRICE, data[2].PRICE],
		            backgroundColor: 'rgba(235, 242, 255, 0.8)',
		            pointRadius: '4',
		            borderColor: 'rgba(113, 155, 255, 0.8)',
		            pointBorderColor: 'rgba(113, 155, 255, 0.8)',
		            borderWidth: 2,
		            borderRadius: 2,
		            pointBackgroundColor : 'white',
	                pointBorderWidth : '2',
	                pointHoverBorderWidth :'2',
	                pointHoverBackgroundColor : 'white',
	                pointHitRadius: '10'
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
							var label = data[tooltipItem.index].COUNT+'건';
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

						this.data.datasets.forEach(function (dataset, i) {
							var meta = chartInstance.controller.getDatasetMeta(i);
							meta.data.forEach(function (bar, index) {
								var data = getPriceFormat(dataset.data[index])+'원';							
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
	}).catch((error) => console.log("error: "+error)); // dealStats
	
	
	
	fetch('/usMarket/fetch/admin/reportlist')
	.then((response) => response.json())
	.then((data) => {
		document.querySelector('.report-preview > .loading').style.visibility = 'hidden';
		
		if(data.length == 0){
			document.querySelector('.report-preview > .preview-empty').style.display = 'flex';
			return;
		}
		
		data.forEach((el, i) => {
			var li = document.createElement('li');
			var a = document.createElement('a');
			
			a.setAttribute('href', '${pageContext.request.contextPath}/admin/report/info?report_no='+el.REPORT_NO);
			a.textContent = el.REPORT_TITLE;
			
			if(el.REPORT_COMPLETE == 'N'){
				var img = document.createElement('img');
				img.setAttribute('src', '${pageContext.request.contextPath}/resources/admin/img/new_report.png');
				a.appendChild(img);				
			}			
			li.appendChild(a);
			
			var span = document.createElement('span');
			span.textContent = convert(el.REPORT_REGDATE);
			li.appendChild(span);
			
			document.querySelector('.report-ul').appendChild(li);
		});
	}).catch((error) => console.log("error: "+error)); // reportList
	
	
	
	fetch('/usMarket/fetch/admin/qnalist')
	.then((response) => response.json())
	.then((data) => {
		document.querySelector('.qna-preview > .loading').style.visibility = 'hidden';
		
		if(data.length == 0){
			document.querySelector('.qna-preview > .preview-empty').style.display = 'flex';
			return;
		}
		
		data.forEach((el, i) => {
			var li = document.createElement('li');
			var a = document.createElement('a');
			
			a.setAttribute('href', '${pageContext.request.contextPath}/admin/qna/info?qna_no='+el.QNA_NO);
			a.textContent = el.QNA_TITLE;
			
			if(el.QNA_COMPLETE == 'N'){
				var img = document.createElement('img');
				img.setAttribute('src', '${pageContext.request.contextPath}/resources/admin/img/new_report.png');
				a.appendChild(img);				
			}			
			li.appendChild(a);
			
			var span = document.createElement('span');
			span.textContent = convert(el.QNA_REGDATE);
			li.appendChild(span);
			
			document.querySelector('.qna-ul').appendChild(li);
		});
	}).catch((error) => console.log("error: "+error)); // reportList

});
</script>
