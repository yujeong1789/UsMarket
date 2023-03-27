<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
			<div class="product-list">
				<div class="product-area">
					<c:if test="${empty productList }">
						<span class="product-empty">판매 중인 상품이 존재하지 않습니다.</span>
					</c:if>
					<c:if test="${not empty productList }">
						<c:forEach var="product" items="${productList }">
							<div class="box">
								<div class="img">
									<a href="<c:url value='/product/info?product_no=${product.PRODUCT_NO}' />"> 
										<c:if test="${product.PRODUCT_STATE_NO eq 2}">
											<img class="img-top" src="${pageContext.request.contextPath}/resources/customer/img/product/reserve.png">
										</c:if>
										<c:if test="${product.PRODUCT_STATE_NO eq 3}">
											<img class="img-top" src="${pageContext.request.contextPath}/resources/customer/img/product/complete.png">
										</c:if>
										<img src="https://usmarket.s3.ap-northeast-2.amazonaws.com/${product.PRODUCT_IMG_PATH}">
									</a>
								</div>
								<div class="info-1">
									<div class="info-title">
										<a href="<c:url value='/product/info?product_no=${product.PRODUCT_NO}' />">
											<c:out value="${product.PRODUCT_NAME }" />
										</a> <!-- 상품명 -->
									</div>
									<div class="info-price">
										<span><fmt:formatNumber value="${product.PRODUCT_PRICE }" pattern="#,###"/></span> <!-- 가격 -->
									</div>
									<div class="info-regdate">
										<fmt:formatDate value="${product.PRODUCT_REGDATE }" pattern="yyyy년 MM월 dd일 HH:mm"/>
									</div> <!-- regdate -->
								</div>
							</div> <!-- product__box -->
						</c:forEach>
					</c:if>
				</div> <!-- prduct-area -->
				<div class="paging">
					<c:if test="${ph.totalCnt != null || ph.totalCnt != 0 }">
						<c:if test="${ph.showPrev }">
							<div class="paging-prev">&lt;&lt;</div>
						</c:if>
						<c:forEach var="i" begin="${ph.beginPage }" end="${ph.endPage }">
							<div class="paging-box ${i eq ph.sc.page ? 'current-page' : 'not-current-page' }" onclick="${i eq ph.sc.page ? '' : 'getProductList(' += i += ')'}">
								<input id="pageValue" type="hidden" value="${i }">
								${i}
							</div>
						</c:forEach>
						<c:if test="${ph.showNext }">
							<div class="paging-next">&gt;&gt;</div>
						</c:if>
					</c:if>
				</div> <!-- paging -->
			</div> <!-- product-list -->
</html>