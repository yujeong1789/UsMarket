<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/product_info.css'/>" type="text/css">
<script src="<c:url value='/resources/customer/js/timeConvert.js'/>"></script>

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
					
					<c:choose>
						<c:when test="${productInfo.PRODUCT_STATE_NO != 1 }"> <!-- 판매 중이 아닌 상품일 경우 -->
							<div class="product__not__sale">
								<span>현재 판매 중인 상품이 아닙니다.</span>
							</div>
						</c:when>
						<c:otherwise>
							<div class="product__buttons" id="product__buttons">
								<div id="btn__wish" class="product__loginCheck" data-url="/product/like?product_no=${productInfo.PRODUCT_NO}">
									<img id="bookmark__status" alt="찜" src="<c:url value='/resources/customer/img/wish_icon_0.png' />">
									<span>찜</span>
									<span><c:out value="${productInfo.BOOKMARK_COUNT }"/></span>
								</div>
								<div id="btn__chat" class="product__loginCheck" data-url="/chat/list">
									<span>채팅하기</span>
								</div>
								<div id="btn__buy" class="product__loginCheck" data-url="/product/buy">
									<span>바로구매</span>
								</div>
							</div>
							
							<div class="product__my__buttons" id="product__my__buttons">
								<div class="btn__my__store">
									<span>내 상점 관리하기</span>
								</div>
							</div>	
						</c:otherwise>
					</c:choose>
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
							<div class="product__tag__content" id="product__tag__content"></div>
						</c:if>
					</div>
				</div>
				<div class="product__content__2">
					<div class="product__content__title">상점정보</div>
					<div class="product__seller">
						<div class="product__seller__profile">
							<a href="#"> <!-- 회원 상세보기 링크 추가할 것 -->
								<img alt="판매자 이미지" src="<c:url value='/resources/customer/img/default_profile.png' />">
							</a>
						</div>
						<div class="product__seller__info">
							<div class="product__seller__info__1">
								<a id="fetch__member__nickname" href="#"></a> <!-- 회원 상세보기 링크 추가할 것 -->
							</div>
							<div class="product__seller__info__2">
								<span id="fetch__product__count"></span>
							</div>
						</div>
					</div>
					<div class="product__content__title">
						<span>상점후기</span>
						<span id="fetch__review__count"></span>
					</div>
					
					
					<div class="product__review" id="product__review"></div>  <!-- prouct__review -->
					
					<div class="product__review__empty" id="product__review__empty">
						<span>아직 작성된 후기가 없습니다.</span>
					</div>
					
					<div class="product__review__more" id="product__review__more">
						<a href="#">더 많은 후기 보러가기</a>
					</div>
					
					
				</div>
			</div> <!-- product__content -->
			
		</div>
	</div>
</section>

<script src="<c:url value='/resources/customer/js/product_info.js'/>"></script>
<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function(){
		
		const seller_id = `${productInfo.MEMBER_ID}`;
		const current_id = document.getElementById('loginId').getAttribute('data-id');
		const product_no = `${productInfo.PRODUCT_NO}`;
		
		console.log("product_no = "+product_no);
		console.log("current_id = "+current_id);
		
		console.log("isEmpty() = "+isEmpty(current_id));
		if(!isEmpty(current_id)){
			if(seller_id == current_id){ // 내 상품일 경우
				document.getElementById('product__buttons').style.display = 'none';
				document.getElementById('product__my__buttons').style.display = 'flex';			
			}else{ // 내 상품이 아닐 경우
				fetch('/usMarket/fetch/bookmark/'+current_id+'/'+product_no)
				.then((response) => response.json())
				.then((json) => {
					console.log(json == 0 ? 'NOT_ADDED' : 'ADDED');
					if(json == 1){
						document.getElementById('bookmark__status').setAttribute('src', '${pageContext.request.contextPath}/resources/customer/img/wish_icon_1.png');
					}
				}).catch((error) => console.log("error: "+error)); // fetch-2
			}
		}
		
		
		
		const seller_no = `${productInfo.SELLER_NO}`;
		const product__review = document.getElementById('product__review');
		
		
		fetch('/usMarket/fetch/seller/'+seller_no)
		.then((response) => response.json())
		.then((json) => {
			setSellerInfo(json);
			
			if (json.REVIEW_COUNT == 0) {
				document.getElementById('product__review__empty').style.display = 'flex';
			} else if(json.REVIEW_COUNT > 0){
				getTopReview(json.REVIEW_COUNT);
			} // if-else
				
		}).catch((error) => console.log("error: "+error)); // fetch-2
		

		
		function getTopReview(reviewCount){
			fetch('/usMarket/fetch/topReview/'+seller_no)
			.then((response) => response.json())
			.then((json) => {
				json.forEach((el, i) => {
					product__review.appendChild(setReview(el));
				});
				
			}).catch((error) => console.log("error: "+error)); // fetch-3
			
			if(reviewCount > 2){
				document.getElementById('product__review__more').style.display = 'flex';
			}
			
		}; // getTopReview
		
		
		
		const tagElement = document.getElementById('product__tag__content');
		const tag = `${productInfo.PRODUCT_TAG}`;
		
		if(tag.length > 0){
			const tagArr = tag.split(',');
			
			tagArr.forEach((el) => {
				let appendTag = "<a href='${pageContext.request.contextPath}/product/list?keyword="+el+"'>"+el+"</a>";
				tagElement.innerHTML += appendTag;
			});			
		}
		
		
		const loginElements = document.querySelectorAll('.product__loginCheck');
		loginElements.forEach((el) => {
			el.addEventListener('click', function() {
				console.log('clicked');
				location.href = "${pageContext.request.contextPath}"+el.getAttribute('data-url');
			});
		});
		
	});
	
	
</script>
