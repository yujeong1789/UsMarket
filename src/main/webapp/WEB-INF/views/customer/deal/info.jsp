<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/deal_info.css'/>" type="text/css">
<c:if test="${empty dealInfo }">
	<script type="text/javascript">
		alert("잘못된 접근입니다.");
		location.href = '${pageContext.request.contextPath}/deal/list';
	</script>
</c:if>

<div class="deal-info-container">
	<div class="row">
		<div class="container">
			<div class="title">
				<span>거래내역</span>
			</div>
			<div class="deal-info">
			</div>
		</div>
	</div>
</div>