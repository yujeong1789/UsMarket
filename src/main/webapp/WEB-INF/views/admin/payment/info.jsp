<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="<c:url value='/resources/admin/css/payment_info.css'/>" type="text/css">
<div class="payment-info-container">

	<c:if test="${empty infoMap}">
		<script type="text/javascript">
			alert('회원정보를 찾을 수 없습니다.');
			location.href = '${pageContext.request.contextPath}/admin/home';
		</script>
	</c:if>
	<c:if test="${not empty infoMap}">
		<div class="title">
			<span>결제내역</span>
		</div>
		<div class="dashboard">
			<div></div>
		</div>	
	</c:if>
 
</div>

<script type="text/javascript">
</script>