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
					<a href="<c:url value='/notice/faq/list'/>">
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
			<div class="help-list">
				<div>
					<div class="sub-title">공지사항</div>
					<div class="notice-list">
						<c:if test="${empty noticeList }">
							<span class="empty">작성된 게시글이 없습니다.</span>
						</c:if>
						<c:if test="${not empty noticeList }">
							<ul>
								<c:forEach var="notice" items="${noticeList }">
									<li data-no=${notice.NOTICE_NO } data-status="${notice.NOTICE_STATUS }">${notice.NOTICE_TITLE }</li>
								</c:forEach>
							</ul>
							<div>
								<span onclick="location.href='<c:url value="/notice/list"/>'">+ 더보기</span>	
							</div>
						</c:if>
					</div>
				</div>
				<div>
					<div class="sub-title">자주묻는질문</div>
					<div class="faq-list">
						<c:if test="${empty faqList }">
							<span class="empty">작성된 게시글이 없습니다.</span>
						</c:if>
						<c:if test="${not empty faqList }">
							<ul>
								<c:forEach var="faq" items="${faqList }">
									<li data-no=${faq.NOTICE_NO } data-status="${faq.NOTICE_STATUS }">${faq.NOTICE_TITLE }</li>
								</c:forEach>
							</ul>
							<div>
								<span onclick="location.href='<c:url value="/notice/faq/list"/>'">+ 더보기</span>
							</div>
						</c:if>
					</div>
				</div>
				<form id="noticeInfoForm" name="noticeInfoForm" action="<c:url value='/notice/info'/>" method="post">
					<input type="hidden" id="notice_no" name="notice_no">
					<input type="hidden" id="notice_status" name="notice_status">
				</form>
			</div>
		</div> <!-- container -->
	</div> <!-- row -->
</div> <!-- help-contaimer --> 

<script type="text/javascript">
document.querySelectorAll('.notice-list li, .faq-list li').forEach(el => {
	el.addEventListener('click', function(e){
		document.getElementById('notice_no').value = e.target.dataset.no;
		document.getElementById('notice_status').value = e.target.dataset.status;
		
		document.getElementById('noticeInfoForm').submit();
	});
})
</script>