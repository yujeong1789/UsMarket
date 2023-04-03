<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/qna-info.css'/>" type="text/css">
<c:set var="status" value="${mode eq 'new' ? '' : 'readonly' }" />

<div class="qna-info-container">
	<div class="row">
		<div class="container">
			<div class="title">
				1:1문의하기
			</div>
			<div class="qna-info">
				<form id="qnaInsertForm" action="<c:url value='/qna/new'/>" method="post">
					<div>
						<div class="info-title essential">제목</div>
						<div class="info">
							<div class="input">
								<input class="frmData" type="text" name="qna_title" id="qna_title" ${status }>
							</div>
						</div>
					</div>
					<div>
						<div class="info-title essential">분류</div>
						<div class="info">
							
						</div>
					</div>
					<div>
						<div class="info-title essential">내용</div>
						<div class="info">
							<div class="input">
								<textarea class="frmData" name="qna_content" id="qna_content" cols="" ${status }></textarea>
							</div>
						</div>
					</div>
					<c:if test="${mode eq 'new' }">
						<div>
							<div class="info-title">사진</div>
							<div class="info">
								<input type="file" name="qna_title" id="qna_img" ${status }>
							</div>
						</div>					
					</c:if>
				</form>
			</div>
		</div> <!-- container -->
	</div> <!-- row -->
</div> <!-- qna-info-container -->