<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<section class="featured spad">

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="hero__item set-bg"
					data-setbg="<c:url value='/customer/img/hero/visual-background.png'/>">
					<div class="hero__text">
						<img src="<c:url value='/customer/img/hero/visual-text.png'/>" />
						<div class="hero__button">
							<a href="#"><img src="<c:url value='/customer/img/hero/visual-icon.png'/>" /></a>
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

			<div class="product__box">
				<div class="product__img">
					<a href="#"> <img
						src="<c:url value='/customer/img/featured/feature-1.jpg'/>">
					</a>
				</div>
				<div class="product__info__1">
					<div class="product__title">
						<a href="#">상품명</a> <!-- 상품명 -->
					</div>
					<div class="product__info__2">
						<div class="product__price">
							<span>10,000</span> <!-- 가격 -->
						</div>
						<div class="product__regdate">1일 전</div> <!-- regdate -->
					</div>
				</div>
			</div> <!-- product__box -->

		</div> <!-- product__area -->
	</div> <!-- container -->
</section>