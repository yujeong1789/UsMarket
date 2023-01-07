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

<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function(){
		
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
				
		}).catch((error) => console.log("error: "+error)); // fetch-1
		

		
		function getTopReview(reviewCount){
			fetch('/usMarket/fetch/topReview/'+seller_no)
			.then((response) => response.json())
			.then((json) => {
				json.forEach((el, i) => {
					setReview(el);
				});
				
			}).catch((error) => console.log("error: "+error)); // fetch-2
			
			if(reviewCount > 2){
				document.getElementById('product__review__more').style.display = 'flex';
			}
		}
		
		
		
		const tagElement = document.getElementById('product__tag__content');
		const tag = `${productInfo.PRODUCT_TAG}`;
		console.log((tag.length > 0));
		
		if(tag.length > 0){
			const tagArr = tag.split(',');
			
			tagArr.forEach((el) => {
				let appendTag = "<a href='${pageContext.request.contextPath}/product/list?keyword="+el+"'>"+el+"</a>";
				tagElement.innerHTML += appendTag;
			});			
		}
		
	});
	
	
		function setReview(el){
			let parentDiv = document.createElement('div');
			
			// 1. 이미지
			let product__review__1 = document.createElement('div');
			product__review__1.className = 'product__review__1';
			
			let imgUrl = document.createElement('a');
			imgUrl.setAttribute('href', '#'); // 회원 상세보기 링크 추가할 것
			
			let img = document.createElement('img');
			img.setAttribute('alt', '판매자 이미지');
			img.setAttribute('src', '<c:url value="/resources/customer/img/default_profile.png" />');
			
			imgUrl.appendChild(img);
			product__review__1.appendChild(imgUrl);
			parentDiv.appendChild(product__review__1);
			
			
			let product__review__2 = document.createElement('div');
			product__review__2.className = 'product__review__2';
			
			let review__info__1 = document.createElement('div');
			review__info__1.className = 'review__info__1';
			
			
			// 2. 닉네임
			let review__nickname = document.createElement('a');
			review__nickname.id = 'review__nickname';
			review__nickname.setAttribute('href', '#'); // 회원 상세보기 링크 추가할 것
			review__nickname.textContent = el.MEMBER_NICKNAME;
			review__info__1.appendChild(review__nickname);
			
			
			// 3. 등록일
			let review__regdate = document.createElement('span');
			review__regdate.id = review__regdate;
			review__regdate.textContent = convert(el.DEAL_COMPLETE_DATE);
			review__info__1.appendChild(review__regdate);
			
			product__review__2.appendChild(review__info__1);
			
			
			let review__info__2 = document.createElement('div');
			review__info__2.className = 'review__info__2';
			
			
			// 4. 별점
			let review__score = document.createElement('div');
			review__score.id = 'review__score';
			setScore(el.REVIEW_SCORE, review__score);
			
			review__info__2.appendChild(review__score);
							
			
			// 5. 리뷰
			let review__content = document.createElement('div');
			review__content.id = 'review__content';
			review__content.textContent = el.REVIEW_CONTENT;
			review__info__2.appendChild(review__content);
	
			product__review__2.appendChild(review__info__2);
			parentDiv.appendChild(product__review__2);
			
			product__review.appendChild(parentDiv);
		};
		
		
		function setSellerInfo(json){
			document.getElementById('fetch__review__count').innerText = json.REVIEW_COUNT;
			document.getElementById('fetch__member__nickname').innerText = json.MEMBER_NICKNAME; 
			document.getElementById('fetch__product__count').innerText = json.PRODUCT_COUNT; 
		};
		
		
		function setScore(score, element) {
			for (var i = 1; i <= 5; i++) {
				let scoreImg = document.createElement('img');
				
				if(score >= i){
					scoreImg.setAttribute('src', '<c:url value="/resources/customer/img/star.png" />');	
				} else if(score < i){
					scoreImg.setAttribute('src', '<c:url value="/resources/customer/img/star_blank.png" />');
				}
				
				element.appendChild(scoreImg);
			}
			
		};
	
	
</script>
