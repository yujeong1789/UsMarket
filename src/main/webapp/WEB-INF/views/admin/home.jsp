<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.spring.usMarket.utils.TimeConvert"%>

<div class="body-container">
	<div class="body-title">
		<span>대시보드</span>
	</div>
	<div class="body-dashboard">
		<div>
			<div class="body-subtitle">
				<a href="<c:url value='/admin/member/list'/>">가입자 추이</a>
				<span class="subtitle-unit">단위: 명</span>			
			</div>
			
			<div class="home-stats">
				<div class="member-stats-loading">로딩중</div>
				<canvas id="member_stats"></canvas>
			</div>
		</div>
		<div>
			<div class="body-subtitle">
				<a href="<c:url value='/admin/payment/list'/>">결제 추이</a>
				<span class="subtitle-unit">단위: KRW</span>			
			</div>
			
			<div class="home-stats">
				<div class="deal-stats-loading">로딩중</div>
				<canvas id="deal_stats"></canvas>
			</div>
		</div>
		<div>
			<span class="body-subtitle">
				<a href="<c:url value='/admin/report/list'/>">최근 신고</a>
			</span>
			<div class="report-preview">
			<c:if test="${empty reportMap }">
				<span class="preview-empty">최근 접수된 신고가 없습니다.</span>
			</c:if>
			<c:if test="${!empty reportMap }">
				<ul class="home-ul report-ul">
					<c:forEach var="report" items="${reportMap }">
						<li data-no="${report.REPORT_NO }">
							<span>
								${report.REPORT_CATEGORY1_NAME += ' | ' += report.REPORT_CATEGORY2_NAME }
								<c:if test="${report.REPORT_COMPLETE eq 'N' }">
									<img src="<c:url value='/resources/admin/img/new_report.png'/>">
								</c:if>
							</span>
							<span>${TimeConvert.calculateTime(report.REPORT_REGDATE)}</span>
						</li>
					</c:forEach>
				</ul>
				<form id="reportInfoForm" action="<c:url value='/admin/report/info'/>" method="post">
					<input type="hidden" id="report_no" name="report_no">
				</form>
			</c:if>
			</div>
		</div>
		<div>
			<span class="body-subtitle">
				<a href="<c:url value='/admin/report/list'/>">최근 문의</a>
			</span>
			<div class="qna-preview">
				<c:if test="${empty qnaMap }">
					<span class="preview-empty">최근 접수된 문의가 없습니다.</span>
				</c:if>
				<c:if test="${!empty qnaMap }">
					<ul class="home-ul qna-ul">
						<c:forEach var="qna" items="${qnaMap }">
							<li data-no="${qna.QNA_NO }">
								<span>
									${qna.QNA_TITLE }
									<c:if test="${qna.QNA_COMPLETE eq 'N' }">
										<img src="<c:url value='/resources/admin/img/new_report.png'/>">
									</c:if>
								</span>
								<span>${TimeConvert.calculateTime(qna.QNA_REGDATE)}</span>
							</li>
						</c:forEach>
					</ul>
					<form id="qnaInfoForm" action="<c:url value='/admin/qna/info'/>" method="post">
						<input type="hidden" id="qna_no" name="qna_no">
					</form>
				</c:if>
			</div>
		</div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<script>
document.addEventListener('DOMContentLoaded', function(){
	if(document.querySelector('.report-ul') != null){
		document.querySelectorAll('.report-ul > li').forEach(el => {
			el.addEventListener('click', function(e){
				 document.getElementById('report_no').value = this.dataset.no;
				 document.getElementById('reportInfoForm').submit();
			});
		});
	}
	
	if(document.querySelector('.qna-ul') != null){
		document.querySelectorAll('.qna-ul > li').forEach(el => {
			el.addEventListener('click', function(e){
				 document.getElementById('qna_no').value = this.dataset.no;
				 document.getElementById('qnaInfoForm').submit();
			});
		});
	}
	
	const memberStatsParam = {
		'startDate': getStartDate(2),
		'endDate': getCurrentEndDate()
	};
	
	fetch('/usMarket/fetch/admin/memberstats', {
		method: 'POST',
		headers: {
			'Content-type' : 'application/json'
		},
		body: JSON.stringify({
			'startDate': getStartDate(2),
			'endDate': getEndDay(),
			'mode': 'month'
		}),
	})
	.then((response) => response.json())
	.then((data) => {
		console.log('member = '+data);
		var ctx = document.getElementById('member_stats');		
		document.querySelector('.member-stats-loading').style.visibility = 'hidden';
		const myChart = new Chart(ctx, {
			type: 'line',
			data: {
				labels : [getDateFormat(data[0].DATE), getDateFormat(data[1].DATE), getDateFormat(data[2].DATE)],
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
		            data: [data[0].CNT, data[1].CNT, data[2].CNT]
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
	                        fontSize: 12,
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
		});
	}).catch((error) => console.log("error: "+error)); // memberStats
	
	
	fetch('/usMarket/fetch/admin/dealstats', {
		method: 'POST',
		headers: {
			'Content-type' : 'application/json'
		},
		body: JSON.stringify({
			'startDate': getStartDay(2),
			'endDate': getEndDay(),
			'mode': 'date'
		}),
	})
	.then((response) => response.json())
	.then((data) => {
		console.log('deal = '+data);
		var ctx = document.getElementById('deal_stats');
		document.querySelector('.deal-stats-loading').style.visibility = 'hidden';
		const myChart = new Chart(ctx, {
			data: {
				labels : [getDateFormat(data[0].DAY), getDateFormat(data[1].DAY), getDateFormat(data[2].DAY)],
				datasets: [{
					type: 'line',
		            label: '발생 건수',
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
		            data: [data[0].PRICE, data[1].PRICE, data[2].PRICE]
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
		                fontSize: 1
	                }
	            },
	            scales: {
	                xAxes: [{
	                    ticks: {
	                    	fontSize: 12,
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
		});
	}).catch((error) => console.log("error: "+error)); // dealStats
});
</script>
