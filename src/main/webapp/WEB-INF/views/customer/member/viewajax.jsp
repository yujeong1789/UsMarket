<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<c:forEach var="product" items="${mypageList }" varStatus="status">
<div class="product__box">
	<div class="product__img">
		<a href="<c:url value='/product/info?product_no=${PRODUCT.PRODUCT_NO}' />"> 
			<c:if test="${product.PRODUCT_STATE_NO == 2}">
				<img class="product__img__top" src="${pageContext.request.contextPath}/resources/customer/img/product/reserve.png">
			</c:if>
			<c:if test="${product.PRODUCT_STATE_NO == 3}">
				<img class="product__img__top" src="${pageContext.request.contextPath}/resources/customer/img/product/complete.png">
			</c:if>
			<img src="https://usmarket.s3.ap-northeast-2.amazonaws.com/${product.PRODUCT_IMG_PATH}">
		</a>
	</div>
	<div class="product__info__1">
		<div class="product__title">
			<a href="<c:url value='/product/info?product_no=${product.PRODUCT_NO}' />">
				<c:out value="${product.PRODUCT_NAME }" />
			</a>
		</div>
		<div class="product__info__2">
			<div class="product__price">
				<span><fmt:formatNumber value="${product.PRODUCT_PRICE}" pattern="#,###"/></span>
			</div>
			<div class="product__regdate">
				<c:out value="${product.PRODUCT_REGDATE}" />
			</div>
		</div>
	</div>
</div>
</c:forEach>
</html>