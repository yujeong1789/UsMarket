<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${not empty removeMessage}">
	<script type="text/javascript">
		var removeMessage = `${removeMessage}`;
		alert(removeMessage);
	</script>
</c:if>

<section class="featured spad">

	<div class="row">
		<div class="container">
			<div class="hero__item set-bg" data-setbg="<c:url value='/resources/customer/img/hero/visual-background.png'/>">
				<div class="hero__text">
					<img src="<c:url value='/resources/customer/img/hero/visual-text.png'/>" />
					<div class="hero__button">
						<img src="<c:url value='/resources/customer/img/hero/visual-icon.png'/>" />
					</div>
				</div>
			</div><!-- hero__item set-bg -->
		</div>
	</div>
	<div class="row">
		<div class="container">
			<div class="section-title">
				<h3>오늘의 추천 상품</h3>
			</div>
			
			<div class="product__area">
				<c:forEach var="productDto" items="${mainProductList }">
				<div class="product__box">
					<div class="product__img">
						<a href="<c:url value='/product/info?product_no=${productDto.product_no}' />">
							<img src="https://usmarket.s3.ap-northeast-2.amazonaws.com/${productDto.product_img_path }">
							<!-- 임시 이미지 출력 (수정 예정) -->
						</a>
					</div>
					<div class="product__info__1">
						<div class="product__title">
							<a href="<c:url value='/product/info?product_no=${productDto.product_no}' />">
								${productDto.product_name }
							</a> <!-- 상품명 -->
						</div>
						<div class="product__info__2">
							<div class="product__price">
								<span><fmt:formatNumber value="${productDto.product_price }" pattern="#,###"/></span> <!-- 가격 -->
							</div>
							<div class="product__regdate">
								${productDto.product_regdate}
							</div> <!-- regdate -->
						</div>
					</div>
				</div> <!-- product__box -->
				</c:forEach>
			</div> <!-- product__area -->
		</div>
	</div>
</section>

<script type="text/javascript">
document.querySelector('.hero__button').addEventListener('click', function(){
	var location = document.querySelector('.section-title').offsetTop;
	window.scrollTo({left: 0, top: location, behavior: 'smooth'});
});
</script>