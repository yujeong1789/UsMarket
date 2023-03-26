<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<div class="member-list">
	<c:if test="${empty memberList }">
		<span>회원이 존재하지 않습니다.</span>
	</c:if>
	<c:if test="${not empty memberList }">
		<table>
			<thead>
				<tr class="head">
					<th>아이디</th>
					<th>닉네임</th>
					<th>판매상품 수</th>
					<th>가입상태</th>
					<th>가입일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="member" items="${memberList }">
					<tr class="body" id="${member.MEMBER_NO }" data-num="${member.NUM }" onclick="memberInfoSubmit(this)">
						<td>${member.MEMBER_ID }</td>
						<td>${member.MEMBER_NICKNAME }</td>
						<td>${member.PRODUCT_COUNT }</td>
						<td>${member.MEMBER_STATE_NAME }</td>
						<td><fmt:formatDate value="${member.MEMBER_REGDATE }" pattern="yyyy년 MM월 dd일 HH:mm"/></td>
					</tr>
					
				</c:forEach>
			</tbody>
		</table>
		<form id="memberInfoForm" name="memberInfoForm" action="<c:url value='/admin/member/info'/>" method="post">
			<input type="hidden" id="member_no" name="member_no" value="">
		</form>
		<div class="paging">
			<c:if test="${ph.totalCnt != null || ph.totalCnt != 0 }">
				<c:if test="${ph.showPrev }">
					<div class="paging-prev">
						&lt;&lt;
					</div>
				</c:if>
				<c:forEach var="i" begin="${ph.beginPage }" end="${ph.endPage }">
					<div class="paging-box ${i eq ph.sc.page ? 'current-page' : 'not-current-page' }" onclick="${i eq ph.sc.page ? '' : 'getMemberList(' += i += ')'}">
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
</div>
</html>