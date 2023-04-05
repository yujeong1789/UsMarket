<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
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
		</table>

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
</html>