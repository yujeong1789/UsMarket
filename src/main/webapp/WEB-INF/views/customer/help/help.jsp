<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/help.css'/>" type="text/css">
<div class="help-container">
	<div class="row">
		<div class="container">
			<div class="help-title">
				<span>고객센터</span>
			</div>
			<div class="help-btn">
				<div class="help-notice">
					<a href="<c:url value='/notice/list'/>">
						<span>공지사항</span>
						<img src="<c:url value='/resources/customer/img/customer_redirect.png'/>">
					</a>
				</div>
				<div class="help-faq">
					<a href="<c:url value='/faq/list'/>">
						<span>자주 묻는 질문</span>
						<img src="<c:url value='/resources/customer/img/customer_redirect.png'/>">
					</a>
				</div>
				<div class="help-qna">
					<a href="<c:url value='/qna/list'/>">
						<span>1:1 문의하기</span>
						<img src="<c:url value='/resources/customer/img/customer_redirect.png'/>">
					</a>
				</div>
			</div> <!-- help-btn -->
		</div> <!-- container -->
	</div> <!-- row -->
</div> <!-- help-contaimer --> 