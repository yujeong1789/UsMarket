<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="<c:url value='/resources/admin/css/qna_list.css'/>" type="text/css">

<div class="qna-list-container">
	<div class="title">
		<span>문의관리</span>
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

			<div class="qna-list">
				<c:if test="${empty qnaList }">
					<span>신고내역이 존재하지 않습니다.</span>
					<input id="pageValue" type="hidden">
				</c:if>
				<c:if test="${not empty qnaList }">
					<table>
						<thead>
							<tr class="head">
								<th>문의번호</th>
								<th>제목</th>
								<th>답변여부</th>
								<th>등록일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="qna" items="${qnaList }">
								<tr class="body" id="${qna.QNA_NO }" data-num="${qna.NUM }">
									<td>${qna.QNA_NO }</td>
									<td>${qna.QNA_TITLE }</td>
									<c:if test="${qna.QNA_COMPLETE  eq 'N'}">
										<td data-status="${qna.QNA_COMPLETE }" style="color: #FF0028">미처리</td>
									</c:if>
									<c:if test="${qna.QNA_COMPLETE  eq 'Y'}">
										<td data-status="${qna.QNA_COMPLETE }" style="color: #822AFF">처리완료</td>
									</c:if>
									<td><fmt:formatDate value="${qna.QNA_REGDATE }" pattern="yyyy년 MM월 dd일 HH:mm"/></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<form id="qnaInfoForm" name="qnaInfoForm" action="<c:url value='/admin/qna/info'/>" method="post">
						<input type="hidden" id="qna_no" name="qna_no">
					</form>
					<div class="paging">
						<c:if test="${ph.totalCnt != null}">
							<c:if test="${ph.showPrev }">
								<div class="paging-prev">
									&lt;&lt;
								</div>
							</c:if>
							<c:forEach var="i" begin="${ph.beginPage }" end="${ph.endPage }">
								<div class="paging-box ${i eq ph.sc.page ? 'current-page' : 'not-current-page' }" onclick="${i eq ph.sc.page ? '' : 'getQnaList(' += i += ')'}">
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
			</div> <!-- qna-list -->
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
		getQnaList(1);
	});
});

document.querySelectorAll('.complete-dropdown li').forEach(el => {
	el.addEventListener('click', function(){
		document.querySelector('.complete-selected').classList.remove('complete-selected');
		this.className = 'complete-selected';
		console.log(this.dataset.complete);
		
		document.getElementById('pageValue').value = 1;
		getQnaList(1);
	});
});

if(document.querySelector('.qna-list > table') != null){
	document.querySelectorAll('.qna-list tbody > tr').forEach(el => {
		el.addEventListener('click', function(e){
			 qnaInfoSubmit(this);
		});
	});
};

let qnaInfoSubmit = function(element){
	document.getElementById('qna_no').value = element.id;
	document.getElementById('qnaInfoForm').submit();
};

let getQnaList = function(page){
	let params = {
			'page': page,
			'pageSize': 10,
			'complete': document.querySelector('.complete-selected').dataset.complete,
			'order': document.querySelector('.order-selected').dataset.order
	};
	
	console.log(params);
	
	fetch('/usMarket/admin/qna/list', {
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
		document.querySelector('.qna-list').innerHTML = result.querySelector('.qna-list').innerHTML;
	}).catch((error) => console.log('error: '+error)); // fetch end
}; // getReportList
</script>