<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/notice_list.css'/>" type="text/css">

<c:set var="pageTitle" value="${status eq '0' ? '공지사항' : '자주 묻는 질문' }" />

<div class="notice-list-container">
	<div class="row">
		<div class="container">
			<div class="list-title">
				<a href="<c:url value='/help'/>">고객센터</a>
				<span>></span>
				<div>${pageTitle }</div>
			</div>
			<div class="title">
				<span>${pageTitle }</span>
			</div>
			
			<div class="notice-list">
				<c:if test="${empty noticeList }">
					<span>${pageTitle += '이 존재하지 않습니다.' }</span>
					<input id="pageValue" type="hidden">
				</c:if>
				<c:if test="${not empty noticeList }">
					<table>
						<thead>
							<tr class="head">
								<th>번호</th>
								<th>제목</th>
								<th>조회수</th>
								<th>등록일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="notice" items="${noticeList }">
								<tr class="body" id="${notice.NOTICE_NO }" data-num="${notice.NUM }">
									<td>${notice.NUM }</td>
									<td>${notice.NOTICE_TITLE }</td>
									<td>${notice.NOTICE_VIEW += '회'}</td>
									<td><fmt:formatDate value="${notice.NOTICE_REGDATE }" pattern="yyyy년 MM월 dd일 HH:mm"/></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<form id="noticeInfoForm" name="noticeInfoForm" action="<c:url value='/notice/info'/>" method="post">
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
			
		</div> <!-- container -->
	</div> <!-- row -->
</div> <!-- notice-list-container -->

<script type="text/javascript">
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
			'status': `${status}`
	};
	
	console.log(params);
	
	fetch('/usMarket/notice/list', {
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