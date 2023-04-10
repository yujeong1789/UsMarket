<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/notice_info.css'/>" type="text/css">

<c:set var="title" value="${noticeInfo.NOTICE_STATUS eq '0' ? '공지사항' : '자주 묻는 질문' }" />
<c:set var="url" value="${noticeInfo.NOTICE_STATUS eq '0' ? '/notice/list' : '/notice/faq/list' }" />

<div class="notice-info-container">

	<c:if test="${empty noticeInfo }">
		<script type="text/javascript">
			alert("해당 게시물을 찾을 수 없습니다.");
			location.href = '${pageContext.request.contextPath}/notice/list';
		</script>
	</c:if>
	<div class="row">
		<div class="container">
			<div class="list-title">
				<a href="<c:url value='/help'/>">고객센터</a>
				>
				<a href="<c:url value='${url }'/>">${title }</a>
			</div>
			<div class="title">${title }</div>
			
			<div class="notice-info">
				<div class="notice-header">
					<div class="notice-title">${noticeInfo.NOTICE_TITLE }</div>
					<div class="notice-regdate"><fmt:formatDate value="${noticeInfo.NOTICE_REGDATE }" pattern="yyyy/MM/dd (HH:mm:ss)" /></div>
					<div class="notice-view">
						<img src="<c:url value='/resources/customer/img/view.png'/>">
						${noticeInfo.NOTICE_VIEW }
					</div>
				</div>
				<span class="notice-line"></span>
				<div class="notice-body">
					<textarea class="notice-content" readonly>${noticeInfo.NOTICE_CONTENT }</textarea>
				</div>
				<div class="notice-btn" onclick="location.href='<c:url value="${url }"/>'">목록</div>
			</div>
		</div> <!-- container -->
	</div> <!-- row -->
</div> <!-- notice-info-container --> 
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function(){
	document.querySelector('.notice-content').style.height = document.querySelector('.notice-content').scrollHeight + 'px';
});
</script>