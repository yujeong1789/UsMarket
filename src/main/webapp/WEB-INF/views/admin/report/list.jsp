<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="<c:url value='/resources/admin/css/report_list.css'/>" type="text/css">

<div class="report-list-container">
	<div class="title">
		<span>신고관리</span>
	</div>
	<div class="dashboard">
		<div>
			<div class="options-container">
				<div class="order-condition">
					<div class="order-dropdown">
						<span>정렬</span>
						<div class="dropdown-content">
							<ul>
								<li class="order-selected" data-order="regdate_desc">접수일 내림차순</li>
								<li data-order="regdate">접수일 오름차순</li>						
							</ul>
						</div>
					</div>
					<div class="condition-dropdown">
						<span>대분류</span>
						<div class="dropdown-content">
							<ul>
								<li class="condition-selected" data-condition="">전체</li>
								<li data-condition="1">상품신고</li>					
								<li data-condition="2">채팅신고</li>					
								<li data-condition="3">거래신고</li>
								<li data-condition="5">기타</li>					
							</ul>
						</div>
					</div>
					<div class="complete-dropdown">
						<span>처리여부</span>
						<div class="dropdown-content">
							<ul>
								<li class="complete-selected" data-complete="">전체</li>
								<li data-complete="Y">처리</li>					
								<li data-complete="N">미처리</li>					
							</ul>
						</div>
					</div>
				</div>			
			</div>

			<div class="report-list">
				<c:if test="${empty reportList }">
					<span>신고내역이 존재하지 않습니다.</span>
					<input id="pageValue" type="hidden">
				</c:if>
				<c:if test="${not empty reportList }">
					<table>
						<thead>
							<tr class="head">
								<th>신고번호</th>
								<th>대분류</th>
								<th>소분류</th>
								<th>처리여부</th>
								<th>등록일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="report" items="${reportList }">
								<tr class="body" id="${report.REPORT_NO }" data-num="${report.NUM }">
									<td>${report.REPORT_NO }</td>
									<td>${report.REPORT_CATEGORY1_NAME }</td>
									<td>${report.REPORT_CATEGORY2_NAME }</td>
									<c:if test="${report.REPORT_COMPLETE  eq 'N'}">
										<td data-status="${report.REPORT_COMPLETE }" style="color: #FF0028">미처리</td>
									</c:if>
									<c:if test="${report.REPORT_COMPLETE  eq 'Y'}">
										<td data-status="${report.REPORT_COMPLETE }" style="color: #822AFF">처리완료</td>
									</c:if>
									<td><fmt:formatDate value="${report.REPORT_REGDATE }" pattern="yyyy년 MM월 dd일 HH:mm"/></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<form id="reportInfoForm" name="reportInfoForm" action="<c:url value='/admin/report/info'/>" method="post">
						<input type="hidden" id="report_no" name="report_no">
					</form>
					<div class="paging">
						<c:if test="${ph.totalCnt != null}">
							<c:if test="${ph.showPrev }">
								<div class="paging-prev">
									&lt;&lt;
								</div>
							</c:if>
							<c:forEach var="i" begin="${ph.beginPage }" end="${ph.endPage }">
								<div class="paging-box ${i eq ph.sc.page ? 'current-page' : 'not-current-page' }" onclick="${i eq ph.sc.page ? '' : 'getReportList(' += i += ')'}">
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
			</div> <!-- report-list -->
		</div>
	</div>
</div>

<script type="text/javascript">
document.querySelectorAll('.order-dropdown li').forEach(el => {
	el.addEventListener('click', function(){
		document.querySelector('.order-selected').classList.remove('order-selected');
		this.className = 'order-selected';
		console.log(this.dataset.order);
		
		document.getElementById('pageValue').value = 1;
		getReportList(1);
	});
});

document.querySelectorAll('.condition-dropdown li').forEach(el => {
	el.addEventListener('click', function(){
		document.querySelector('.condition-selected').classList.remove('condition-selected');
		this.className = 'condition-selected';
		console.log(this.dataset.condition);
		
		document.getElementById('pageValue').value = 1;
		getReportList(1);
	});
});

document.querySelectorAll('.complete-dropdown li').forEach(el => {
	el.addEventListener('click', function(){
		document.querySelector('.complete-selected').classList.remove('complete-selected');
		this.className = 'complete-selected';
		console.log(this.dataset.complete);
		
		document.getElementById('pageValue').value = 1;
		getReportList(1);
	});
});

if(document.querySelector('.report-list > table') != null){
	document.querySelectorAll('.report-list tbody > tr').forEach(el => {
		el.addEventListener('click', function(e){
			 reportInfoSubmit(this);
		});
	});
};

let reportInfoSubmit = function(element){
	document.getElementById('report_no').value = element.id;
	document.getElementById('reportInfoForm').submit();
};

let getReportList = function(page){
	let params = {
			'page': page,
			'pageSize': 10,
			'condition': document.querySelector('.condition-selected').dataset.condition,
			'complete': document.querySelector('.complete-selected').dataset.complete,
			'order': document.querySelector('.order-selected').dataset.order
	};
	
	console.log(params);
	
	fetch('/usMarket/admin/report/list', {
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
		document.querySelector('.report-list').innerHTML = result.querySelector('.report-list').innerHTML;
	}).catch((error) => console.log('error: '+error)); // fetch end
}; // getReportList

</script>