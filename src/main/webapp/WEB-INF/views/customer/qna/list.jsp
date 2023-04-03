<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/qna-list.css'/>" type="text/css">

<div class="qna-list-container">
	<div class="row">
		<div class="container">
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
					<div class="paging">페이징</div>
				</c:if>
			</div> <!-- qna-list -->
		</div> <!-- container -->
	</div> <!-- row -->
</div> <!-- qna-list-container -->