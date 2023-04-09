<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="<c:url value='/resources/admin/css/notice_list.css'/>" type="text/css">

<div class="notice-list-container">
	<div class="title">
		<span>공지사항 관리</span>
	</div>
	<div class="dashboard">
		<div>
			<div class="notice-header">
				<div>
					<div class="options-container">
						<div class="order-condition">
							<div class="order-dropdown">
								<span>정렬</span>
								<div class="dropdown-content">
									<ul>
										<li class="order-selected" data-order="regdate_desc">작성일 내림차순</li>
										<li data-order="regdate">작성일 오름차순</li>
										<li data-order="view_desc">조회 많은순</li>
										<li data-order="view">조회 적은순</li>							
									</ul>
								</div>
							</div>
							<div class="condition-dropdown">
								<span>분류</span>
								<div class="dropdown-content">
									<ul>
										<li class="condition-selected" data-condition="">전체</li>
										<li data-condition="0">공지사항</li>					
										<li data-condition="1">자주묻는질문</li>					
									</ul>
								</div>
							</div>
						</div>			
					</div>
				</div>
				<div>
					<a href="<c:url value='/admin/notice/new'/>">
						<span>작성하기</span>
						<img src="<c:url value='/resources/customer/img/customer_redirect.png'/>">
					</a>
				</div>
			</div>
			

			<div class="notice-list">
				<c:if test="${empty noticeList }">
					<span>공지사항이 존재하지 않습니다.</span>
					<input id="pageValue" type="hidden">
				</c:if>
				<c:if test="${not empty noticeList }">
					<table>
						<thead>
							<tr class="head">
								<th>번호</th>
								<th>제목</th>
								<th>분류</th>
								<th>조회수</th>
								<th>등록일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="notice" items="${noticeList }">
								<tr class="body" id="${notice.NOTICE_NO }" data-num="${notice.NUM }">
									<td>${notice.NOTICE_NO }</td>
									<td>${notice.NOTICE_TITLE }</td>
									<c:if test="${notice.NOTICE_STATUS  eq '0'}">
										<td>공지사항</td>
									</c:if>
									<c:if test="${notice.NOTICE_STATUS  eq '1'}">
										<td>자주묻는질문</td>
									</c:if>
									<td>${notice.NOTICE_VIEW }</td>
									<td><fmt:formatDate value="${notice.NOTICE_REGDATE }" pattern="yyyy년 MM월 dd일 HH:mm"/></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<form id="noticeInfoForm" name="noticeInfoForm" action="<c:url value='/admin/notice/info'/>" method="post">
						<input type="hidden" id="notice_no" name="notice_no">
					</form>
					<div class="paging">
						<c:if test="${ph.totalCnt != null}">
							<c:if test="${ph.showPrev }">
								<div class="paging-prev">
									&lt;&lt;
								</div>
							</c:if>
							<c:forEach var="i" begin="${ph.beginPage }" end="${ph.endPage }">
								<div class="paging-box ${i eq ph.sc.page ? 'current-page' : 'not-current-page' }" onclick="${i eq ph.sc.page ? '' : 'getNoticeList(' += i += ')'}">
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
			</div> <!-- notice-list -->
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
		getNoticeList(1);
	});
});

document.querySelectorAll('.condition-dropdown li').forEach(el => {
	el.addEventListener('click', function(){
		document.querySelector('.condition-selected').classList.remove('condition-selected');
		this.className = 'condition-selected';
		console.log(this.dataset.condition);
		
		document.getElementById('pageValue').value = 1;
		getNoticeList(1);
	});
});

if(document.querySelector('.notice-list > table') != null){
	document.querySelectorAll('.notice-list tbody > tr').forEach(el => {
		el.addEventListener('click', function(e){
			 noticeInfoSubmit(this);
		});
	});
};

let noticeInfoSubmit = function(element){
	document.getElementById('notice_no').value = element.id;
	document.getElementById('noticeInfoForm').submit();
};

let getNoticeList = function(page){
	let params = {
			'page': page,
			'pageSize': 10,
			'condition': document.querySelector('.condition-selected').dataset.condition,
			'order': document.querySelector('.order-selected').dataset.order
	};
	
	console.log(params);
	
	fetch('/usMarket/admin/notice/list', {
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
		document.querySelector('.notice-list').innerHTML = result.querySelector('.notice-list').innerHTML;
	}).catch((error) => console.log('error: '+error)); // fetch end
}; // getReportList
</script>