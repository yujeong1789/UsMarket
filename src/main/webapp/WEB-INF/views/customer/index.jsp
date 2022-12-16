<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<section class="featured spad">

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="hero__item set-bg"
					data-setbg="<c:url value='/resources/customer/img/hero/visual-background.png'/>">
					<div class="hero__text">
						<img src="<c:url value='/resources/customer/img/hero/visual-text.png'/>" />
						<div class="hero__button">
							<a href="#"><img src="<c:url value='/resources/customer/img/hero/visual-icon.png'/>" /></a>
						</div>
					</div>
				</div>
				<!-- hero__item set-bg -->

			</div>
		</div>

		<div class="section-title">
			<h3>오늘의 추천 상품</h3>
		</div>

		<div class="product__area">
			<c:forEach var="productDto" items="${mainProductList }">
			<div class="product__box">
				<div class="product__img">
					<a href="#"> 
						<img src="${pageContext.request.contextPath}/resources/productImgUpload/2022/11/29/IMG_5403.PNG">
						<!-- 임시 이미지 출력 (수정 예정) -->
					</a>
				</div>
				<div class="product__info__1">
					<div class="product__title">
						<a href="#">${productDto.product_name }</a> <!-- 상품명 -->
					</div>
					<div class="product__info__2">
						<div class="product__price">
							<span><fmt:formatNumber value="${productDto.product_price }" pattern="#,###"/></span> <!-- 가격 -->
						</div>
						<div class="product__regdate">
							<fmt:formatDate value="${productDto.product_regdate}" pattern="yyyy.MM.dd"/>
						</div> <!-- regdate -->
					</div>
				</div>
			</div> <!-- product__box -->
			</c:forEach>
		</div> <!-- product__area -->
		
	</div> <!-- container -->
</section>