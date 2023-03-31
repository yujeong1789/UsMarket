<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<div class="mypage_category_content">
	<c:if test="${! empty mypageProductList }">
		<div class="product__area">
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
		</div>
	</c:if>
	
	<c:if test="${empty mypageProductList }">
		<div class="no__item">등록된 상품이 없습니다.</div> <!-- 이미지 만들 것 -->				
	</c:if>
	
	<div class="paging__container">
		<c:if test="${ph.totalCnt != null || ph.totalCnt != 0 }">
			<c:if test="${ph.showPrev }">
				<div class="paging__box">
					<a class="paging__href" href="<c:url value='/product/list${ph.sc.getQueryString(ph.beginPage-1)}'/>">&lt;</a>								
				</div>
			</c:if>
			<c:forEach var="i" begin="${ph.beginPage }" end="${ph.endPage }">
			<input id="pageValue" type="hidden" value="${i }">
				<div class="paging__box">
					<a class="paging__href ${i==ph.sc.page ? 'paging-active' : ''}" href="<c:url value="/product/list${ph.sc.getQueryString(i)} " />">
						${i}
					</a>															
				</div>
			</c:forEach>
			<c:if test="${ph.showNext }">
				<div class="paging__box">
					<a class="paging__href" href="<c:url value='/product/list${ph.sc.getQueryString(ph.endPage+1)}'/>">&gt;</a>								
				</div>
			</c:if>
		</c:if>
	</div> <!-- product__container -->	
</div>
</html>