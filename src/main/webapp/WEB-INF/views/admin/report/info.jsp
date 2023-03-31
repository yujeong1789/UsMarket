<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="<c:url value='/resources/admin/css/report_info.css'/>" type="text/css">

<div class="report-info-container">
	<c:if test="${empty infoMap}">
		<script type="text/javascript">
			alert('접수된 신고를 찾을 수 없습니다.');
			location.href = '${pageContext.request.contextPath}/admin/report/list';
		</script>
	</c:if>
	<c:if test="${not empty infoMap}">
	
		<div class="title">
			<span>신고내역</span>
		</div> <!-- title -->
		
		<div class="dashboard">
			<div>
				신고정보
			</div>
		</div> <!-- dashboard -->
		
	</c:if>
 
</div> <!-- report-info-container -->
