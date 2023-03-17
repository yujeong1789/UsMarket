<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="body-container">
	<div class="body-title">
		<span>대시보드</span>
	</div>
	<div class="body-dashboard">
		<div>
			<span class="body-subtitle">가입자 추이</span>
			<div class="home-stats">
				<canvas id="member_stats"></canvas>
			</div>
		</div>
		<div>
			<span class="body-subtitle">결제 추이</span>
		</div>
		<div>
			<span class="body-subtitle">최근 신고</span>
		</div>
		<div>
			<span class="body-subtitle">최근 문의</span>
		</div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<script>
	const getChartData = function(){
		return fetch('/usMarket/fetch/memberstats/'+getStartDate()+'/'+getEndDate())
    			.then(response => response.json());
	};
	
	getChartData().then(data => data.forEach((el, i) => {
		console.log(el);
	}));
	
	const currentMonth = new Date().getMonth() + 1;
	var ctx = document.getElementById('member_stats');
	const myChart = new Chart(ctx, {
		type: 'line',
		data: {
			labels : [(currentMonth-2)+'월', (currentMonth-1)+'월', currentMonth+'월'],
			datasets: [{
	            // dataset의 이름(String)
	            label: '',
	            data: [100, 200, 300],
	            fill: false,
	            pointRadius: '4',
	            borderColor: 'rgba(113, 155, 255, 0.8)',
	            // dataset의 선 색(rgba값을 String으로 표현)
	            pointBorderColor: [
	            	'rgba(207, 221, 255, 0.8)',
	            	'rgba(166, 192, 255, 0.8)',
	            	'rgba(113, 155, 255, 0.8)'
	            ],
	            // dataset의 선 두께(Number)
	            borderWidth: 2,
	            borderRadius: 10,
	            pointBackgroundColor : 'white',
                pointBorderWidth : '2', //pointBorder사이즈
                pointHoverBorderWidth :'2', //hover시 pointBorder사이즈
                pointHoverBackgroundColor : 'white', //hover시 pointBacground
			}]
		},
	    options: {
	        // 축에 관한 설정(Object)
	        scales: {
	            // y축에 대한 설정(Object)
	            y: {
	                // 시작을 0부터 하게끔 설정(최소값이 0보다 크더라도)(boolean)
	                beginAtZero: true
	            }
	        },
	        tooltips: {
	        	enabled: false
	        },
	        hover: {
	        	animationDuration: 0	
	        },
	        animation: {
				duration: 1,
				onComplete: function () {
					var chartInstance = this.chart,
						ctx = chartInstance.ctx;
					ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, Chart.defaults.global.defaultFontStyle, Chart.defaults.global.defaultFontFamily);
					ctx.fillStyle = 'black';
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
                fontColor: 'rgba(0,0,0,0)', //제목 레이블 안보이게
                fontSize: 20
                }
            },
            scales: {
                xAxes: [{
                    ticks: {
                        fontSize: 13, //x축 텍스트 폰트 사이즈
                        fontColor: 'rgba(0,0,0,80)', //x축 레이블 안보이게
                    },
                    gridLines: {
                        display:false,
                        lineWidth:0
                    }
                }],
                yAxes: [{
                    ticks: {
                        display: false, //y축 텍스트 삭제
                        beginAtZero: false, //y축값이 0부터 시작
                    },
                    gridLines: {
						display:false,
						lineWidth:0
					}   
				}]
			},
			elements: {
				line: {
					borderCapStyle: 'round', // 선 끝을 둥글게
					borderJoinStyle: 'bevel', // 꺾이는 모서리를 둥글게
				}
			}
		}
	});
</script>
