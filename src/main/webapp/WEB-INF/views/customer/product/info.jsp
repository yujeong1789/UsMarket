<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/product_info.css'/>" type="text/css">

<section class="product__info__section">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<!-- 카테고리 영역 -->
				<a class="home" href="<c:url value='/'/>">홈</a>
				<span class="home__span"></span>
				<a id="info__category1" href="<c:url value='/product/list?category1=${productInfo.PRODUCT_CATEGORY1_NO }'/>">${productInfo.PRODUCT_CATEGORY1_NAME }</a>
				<span class="before__span"></span>
				<a id="info__category2" href="<c:url value='/product/list?category1=${productInfo.PRODUCT_CATEGORY1_NO }&category2=${productInfo.PRODUCT_CATEGORY2_NO }'/>">${productInfo.PRODUCT_CATEGORY2_NAME}</a>
			</div>
			
			<div class="product__info">
				<!-- 상품 정보 영역 -->
				<div class="product__info__img">
					<img src="${pageContext.request.contextPath}/resources/productImgUpload/2022/11/29/IMG_5403.PNG">
				</div>
				<div class="product__info__div">
					<div class="product_name">
						<c:out value="${productInfo.PRODUCT_NAME }"/>
					</div>
					<div class="product_price">
						<fmt:formatNumber value="${productInfo.PRODUCT_PRICE }" pattern="#,###"/>
					</div>
					
					<div class="product__detail__1">
						<div class="product__wish">
							<div class="product__detail__icon">
								<img alt="좋아요" src="<c:url value='/resources/customer/img/wish.png' />">
							</div>
							<span><c:out value="${productInfo.BOOKMARK_COUNT }"/></span>
						</div>
						<div class="product__view">
							<div class="product__detail__icon">
								<img alt="조회수" src="<c:url value='/resources/customer/img/view.png' />">
							</div>
						 	<span><c:out value="${productInfo.PRODUCT_VIEW }"/></span>
						</div>
						<div class="product__uploaded">
							<div class="product__detail__icon">
								<img alt="업로드 시간" src="<c:url value='/resources/customer/img/clock.png' />">
							</div>
							<span><c:out value="${productInfo.PRODUCT_REGDATE }"/></span>						
						</div>
					</div>
					
					<div class="product__detail__2">
						<div class="product__status">
							<div class="product__label">상품상태</div>
							<span><c:out value="${productInfo.PRODUCT_USED eq 'Y' ? '중고상품':'새상품'}"/></span>
						</div>
						<div class="product__exchange">
							<div class="product__label">교환여부</div>
							<span><c:out value="${productInfo.PRODUCT_CHANGE eq 'Y' ? '교환가능':'교환불가능'}"/></span>
						</div>
						<div class="product__location">
							<div class="product__label">거래지역</div>
							<span></span>
						</div>							
					</div>
					
					<div class="product__buttons">
						<div class="btn__wish">
							<img alt="찜" src="<c:url value='/resources/customer/img/wish_icon.png' />">
							<span>찜</span>
							<span><c:out value="${productInfo.BOOKMARK_COUNT }"/></span>
						</div>
						<div class="btn__chat">
							<span>채팅하기</span>
						</div>
						<div class="btn__buy">
							<span>바로구매</span>
						</div>
					</div>
					
				</div>
			</div> <!-- product__info -->
			
			<div class="product__content__layout">
				<div class="product__content__1">
					<div class="product__content__title">상품정보</div>
					<div class="product__content">
						<c:out value="${productInfo.PRODUCT_EXPLANATION }"/>
					</div>
					<div class="product__tag">
						<c:if test="${!empty productInfo.PRODUCT_TAG}">
							<div class="product__tag__icon">
								<img alt="태그" src="<c:url value='/resources/customer/img/tag_icon.png' />">
							</div>
							<div class="product__tag__content" id="product__tag__content">
								<!-- 해당 태그 클릭시 태그 search 요청 로직 추가할 것 -->
							</div>
						</c:if>
					</div>
				</div>
				<div class="product__content__2">
					<div class="product__content__title">상점정보</div>
					<div class="product__seller">
						<div class="product__seller__profile">
							<a href="#">
								<img alt="판매자 이미지" src="<c:url value='/resources/customer/img/default_profile.png' />">
							</a>
						</div>
						<div class="product__seller__info">
							<div class="product__seller__info__1">
								<a href="#"><c:out value="${productInfo.MEMBER_NAME }"/></a>
							</div>
							<div class="product__seller__info__2">
								<span><c:out value="${productInfo.PRODUCT_COUNT }"/></span>
							</div>
						</div>
					</div>
					<div class="product__content__title">상점후기</div>
					<div>
						판매자 정보 출력 영역
					</div>
				</div>
			</div> <!-- product__content -->
			
		</div>
	</div>
</section>

<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function(){
		const tagElement = document.getElementById('product__tag__content');
		const tag = `${productInfo.PRODUCT_TAG}`;
		const tagArr = tag.split(',');
		
		tagArr.forEach((el) => {
			let appendTag = "<a href='${pageContext.request.contextPath}/product/list?keyword="+el+"'>"+el+"</a>";
			tagElement.innerHTML += appendTag;
		});
	});
</script>
