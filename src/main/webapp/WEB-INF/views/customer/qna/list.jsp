<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/qna_list.css'/>" type="text/css">

<div class="qna-list-container">
	<div class="row">
		<div class="container">
			<div class="list-title">
				<a href="<c:url value='/help'/>">고객센터</a>
				<span>></span>
				<div>1:1문의</div>
			</div>
			<div class="title">
				<span>1:1 문의내역</span>
				<a href="<c:url value='/qna/new'/>">
					<span>문의하기</span>
					<img src="<c:url value='/resources/customer/img/customer_redirect.png'/>">
				</a>
			</div>
			
			<div class="qna-list">
			
				<c:if test="${empty qnaList }">
					<span class="empty">문의 내역이 존재하지 않습니다.</span>
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
								<tr class="body" id="${qna.QNA_NO }" data-num="${qna.NUM }" onclick="location.href='<c:url value="/qna/read?qna_no=${qna.QNA_NO }"/>'">
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
					</table> <!-- table -->
					
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
					</div> <!-- paging -->
				</c:if>
				
			</div> <!-- qna-list -->
			
		</div> <!-- container -->
	</div> <!-- row -->
</div> <!-- qna-list-container -->

<script type="text/javascript">
let getQnaList = function(page){
	let params = {
			'page': page,
			'pageSize': 10
	};
	
	console.log(params);
	
	fetch('/usMarket/qna/list', {
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