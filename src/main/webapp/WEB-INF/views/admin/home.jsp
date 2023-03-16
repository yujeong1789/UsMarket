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

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.2.1/chart.umd.min.js" integrity="sha512-GCiwmzA0bNGVsp1otzTJ4LWQT2jjGJENLGyLlerlzckNI30moi2EQT0AfRI7fLYYYDKR+7hnuh35r3y1uJzugw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
	const currentMonth = new Date().getMonth() + 1;
	const memberStats = new Chart(document.getElementById('member_stats'), {
		type: 'bar',
		data: {
			labels : [(currentMonth-2)+'월', (currentMonth-1)+'월', currentMonth+'월'],
			datasets: [{
	            // dataset의 이름(String)
	            label: '',
	            data: [1, 2, 3],
	            // dataset의 배경색(rgba값을 String으로 표현)
	            backgroundColor: [
		            	'rgba(207, 221, 255, 0.8)',
		            	'rgba(166, 192, 255, 0.8)',
		            	'rgba(113, 155, 255, 0.8)'        		
	            ],
	            // dataset의 선 색(rgba값을 String으로 표현)
	            borderColor: [
	            	'rgba(207, 221, 255, 0.8)',
	            	'rgba(166, 192, 255, 0.8)',
	            	'rgba(113, 155, 255, 0.8)'
	            ],
	            // dataset의 선 두께(Number)
	            borderWidth: 1,
	            borderRadius: 10,
	            barThickness: 20
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
	        plugins: {	        	
		        legend: {
		        	// label hide
		        	display: false
		        }
	        }
	    }
	});
</script>
