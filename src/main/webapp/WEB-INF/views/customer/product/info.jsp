<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.spring.usMarket.utils.TimeConvert"%>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/product_info.css'/>" type="text/css">
<section class="product__info__section">
	
	<c:if test="${empty productInfo}">
		<script type="text/javascript">
			alert('존재하지 않는 상품입니다.');
			location.replace('${pageContext.request.contextPath}/');
		</script>
	</c:if>

	<!-- 신고하기 모달 -->
	<input type="hidden" id="report_type" value="1">
	<jsp:include page="/WEB-INF/views/customer/inc/report_modal.jsp"/>
	
	<div class="row">
		<div class="container">
			<!-- 카테고리 영역 -->
			<a class="home" href="<c:url value='/'/>">홈</a>
			<span class="home__span"></span>
			<a id="info__category1" href="<c:url value='/product/list?category1=${productInfo.PRODUCT_CATEGORY1_NO }'/>">${productInfo.PRODUCT_CATEGORY1_NAME }</a>
			<span class="before__span"></span>
			<a id="info__category2" href="<c:url value='/product/list?category1=${productInfo.PRODUCT_CATEGORY1_NO }&category2=${productInfo.PRODUCT_CATEGORY2_NO }'/>">${productInfo.PRODUCT_CATEGORY2_NAME}</a>
			
			<div class="product__info">
				<!-- 상품 정보 영역 -->
				<div class="product__info__img">
					<div class="product__img__button" id="product__img__button">
						<img id="img_preview" src="<c:url value='/resources/customer/img/img_preview.png'/>">
						<img id="img_next" src="<c:url value='/resources/customer/img/img_next.png'/>">
					</div>
					<img id="product__current__img">
				</div>
				<div class="product__info__div">
					<div class="product_name">
						<c:out value="${productInfo.PRODUCT_NAME }"/>
					</div>
					<div class="product_price">
						<fmt:formatNumber value="${productInfo.PRODUCT_PRICE }" pattern="#,###"/>
					</div>
					
					<div class="product__detail__1">
						<div class="left">
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
								<span>${TimeConvert.calculateTime(productInfo.PRODUCT_REGDATE)}</span>						
							</div>
						</div>
						<div class="right" id="productReport" onclick="openReport()">
							<div class="product__detail__icon">
								<img alt="신고하기" src="<c:url value='/resources/customer/img/report.png'/>">
							</div>
							<span id="product__report">신고하기</span>
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
					</div>
					
					<!-- 내 상품일 경우 -->
					<c:if test="${isMyProduct }">
						<c:choose>
							<c:when test="${productInfo.PRODUCT_STATE_NO eq 1 or productInfo.PRODUCT_STATE_NO eq 2}">
								<div class="product__my__buttons" id="product__my__buttons">
									<div class="btn__my__store" id="btn__my__store">
										<span onclick="location.href='<c:url value='/member/mypage'/>'">내 상점 관리하기</span>
									</div>
									<div class="btn__product__modify" id="btn__product__modify">
										<span>상태변경</span>
										<div class="dropdown-content">
											<ul>
												<li class="${productInfo.PRODUCT_STATE_NO eq 1 ? 'status-selected' : ''}" data-status="1" onclick="${productInfo.PRODUCT_STATE_NO eq 1 ? '' : 'productStateChange(this)'}">판매중</li>
												<li class="${productInfo.PRODUCT_STATE_NO eq 2 ? 'status-selected' : ''}" data-status="2" onclick="${productInfo.PRODUCT_STATE_NO eq 2 ? '' : 'productStateChange(this)'}">예약완료</li>			
											</ul>
										</div>
									</div>
									<div class="btn__product__delete" id="btn__product__delete" onclick="productRemove()">
										<span>삭제하기</span>
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<div class="product__not__sale">
									<span>현재 판매 중인 상품이 아닙니다.</span>
								</div>
							</c:otherwise>
						</c:choose>
					</c:if>
					
					<!-- 내 상품이 아닐 경우 -->
					<c:if test="${!isMyProduct }">
						<c:choose>
							<c:when test="${productInfo.PRODUCT_STATE_NO eq 1 }">
								<div class="product__buttons" id="product__buttons">
									<div id="btn__wish" data-status="${bookmarkStatus }" onclick="productWish(this)">
										<img id="bookmark__status" alt="찜" src="<c:url value='/resources/customer/img/wish_icon_${bookmarkStatus }.png' />">
										<span>찜</span>
										<span><c:out value="${productInfo.BOOKMARK_COUNT }"/></span>
									</div>
									<div id="btn__chat" onclick="sendChat()">
										<span>채팅하기</span>
										<form id="addChatRoomForm" method="post" action="<c:url value='/chat/add'/>">
											<input type="hidden" name="seller_no">
											<input type="hidden" name="product_name">
											<input type="hidden" name="seller_nickname">
										</form>
									</div>
									<div id="btn__buy" onclick="productBuy()">
										<span>바로구매</span>
										<form id="productBuyForm" method="post" action="<c:url value='/product/buy'/>">
											<input type="hidden" name="product_no">
										</form>
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<div class="product__not__sale">
									<span>현재 판매 중인 상품이 아닙니다.</span>
								</div>
							</c:otherwise>
						</c:choose>
					</c:if>
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
							<a href="<c:url value='/member/mypage?member_no=${productInfo.SELLER_NO }'/>">
								<img alt="판매자 이미지" src="<c:url value='/resources/customer/img/default_profile.png' />">
							</a>
						</div>
						<div class="product__seller__info">
							<div class="product__seller__info__1">
								<a id="fetch__member__nickname" href="<c:url value='/member/mypage?member_no=${productInfo.SELLER_NO }'/>"></a>
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
						<a href="<c:url value='/member/mypage?member_no=${productInfo.SELLER_NO }'/>">더 많은 후기 보러가기</a>
					</div>
					
					
				</div>
			</div> <!-- product__content -->
			
		</div>
	</div>
</section>

<script src="<c:url value='/resources/customer/js/product_info.js'/>"></script>
<script type="text/javascript">
const seller_id = `${productInfo.MEMBER_ID}`;
const seller_no = `${productInfo.SELLER_NO}`;
const current_id = document.getElementById('loginId').getAttribute('data-id');
const current_no = document.getElementById('loginNo').getAttribute('data-no');
const product_no = `${productInfo.PRODUCT_NO}`;
const product_state = `${productInfo.PRODUCT_STATE_NO}`;

document.addEventListener('DOMContentLoaded', function(){
	// 이미지 불러오기
	const imgList = JSON.parse(`${jsonText}`);
	const imgPath = 'https://usmarket.s3.ap-northeast-2.amazonaws.com/';
	document.getElementById('product__current__img').src = imgPath + imgList[0]; 
	document.getElementById('img_preview').style.visibility = 'hidden';
	let imgOrder = 0;
	
	if(imgList.length <= 1){
		// 이미지가 한 장만 존재할 경우 preview, next 버튼 숨기기
		document.getElementById('product__img__button').style.display = 'none';
	}
		
	// 이전 요소가 존재하는지
	function getPreviewImg(imgOrder){
		// 현재 index가 0이 아니면
		if(imgOrder > 0){
			imgOrder--;
		}
		return imgOrder;
	};
	
	// 다음 요소가 존재하는지
	function getNextImg(imgOrder){
		// 현재 index가 마지막 index보다 작으면
		if(imgOrder < (imgList.length-1)){
			imgOrder++;
		}
		return imgOrder;
	};
	
	document.getElementById('img_next').addEventListener('click', function(){
		imgOrder = getNextImg(imgOrder);
		console.log('imgOrder = '+imgOrder);
		
		if(imgOrder == (imgList.length - 1)){
			// 마지막 요소면 next 버튼 숨김
			console.log('마지막 요소');
			document.getElementById('img_next').style.visibility = 'hidden';	
		}
		// preview 버튼 표시
		document.getElementById('img_preview').style.visibility = 'visible';
		document.getElementById('product__current__img').src = imgPath + imgList[imgOrder];							
	});
	
	document.getElementById('img_preview').addEventListener('click', function(){
		imgOrder = getPreviewImg(imgOrder);
		console.log('imgOrder = '+imgOrder);
		
		if(imgOrder == 0){
			// 첫번째 요소면 preview 버튼 숨김
			console.log('첫번째 요소');
			document.getElementById('img_preview').style.visibility = 'hidden';
		}
		// next 버튼 표시
		document.getElementById('img_next').style.visibility = 'visible';
		document.getElementById('product__current__img').src = imgPath + imgList[imgOrder];
	});
	
	// 리뷰 출력하기
	const product__review = document.getElementById('product__review');
	
	fetch('/usMarket/fetch/seller/'+seller_no)
	.then((response) => response.json())
	.then((json) => {
		setSellerInfo(json);
		
		if (json.REVIEW_COUNT == 0) {
			document.getElementById('product__review__empty').style.display = 'flex';
		} else if(json.REVIEW_COUNT > 0){
			getTopReview(json.REVIEW_COUNT);
		}
			
	}).catch((error) => console.error('error: ' + error));

	
	// 상위 2건 리뷰 얻기
	function getTopReview(reviewCount){
		fetch('/usMarket/fetch/topReview/'+seller_no)
		.then((response) => response.json())
		.then((json) => {
			json.forEach((el, i) => {
				product__review.appendChild(setReview(el));
			});
		}).catch((error) => console.log('error: ' + error));
		
		if(reviewCount > 2){
			document.getElementById('product__review__more').style.display = 'flex';
		}
		
	}; // getTopReview
		
		
	// 상품 태그 출력하기
	const tagElement = document.getElementById('product__tag__content');
	const tag = `${productInfo.PRODUCT_TAG}`;
	
	if(tag.length > 0){
		const tagArr = tag.split(' ');
		
		tagArr.forEach((el) => {
			let appendTag = document.createElement('a');
			appendTag.setAttribute('href', '${pageContext.request.contextPath}/product/list?keyword=' + encodeURIComponent(el));
			appendTag.textContent = el;
			tagElement.appendChild(appendTag);
		});		
	}
	
	// 내 상품일 경우 신고하기 버튼 숨김
	if(`${isMyProduct}` == 'true'){
		document.getElementById('productReport').style.visibility = 'hidden';
	};
}); // DOMContentLoaded


// 상품 삭제
function productRemove(){
	if(confirm('상품을 삭제하시겠습니까?')){
		
		let formData = new FormData();
		formData.append('product_no', `${productInfo.PRODUCT_NO}`);
		formData.append('product_state_no', 4);
		
		fetch('/usMarket/fetch/product/remove', {
			method: 'POST',
			body: formData
		})
		.then((response) => response.text())
		.then((text) => {
			if(text == '1'){
				alert('정상적으로 삭제되었습니다.');
				location.replace('${pageContext.request.contextPath}/');
			}else{
				alert('상품 삭제에 실패했습니다.');
			}
		}).catch((error) => console.error('error: ' + error));
	}	
};


// 상품 구매
function productBuy(){
	const productBuyForm = document.getElementById('productBuyForm');
	productBuyForm.children[0].value = `${productInfo.PRODUCT_NO}`;
	
	productBuyForm.submit();
};


// 상품 찜하기
function productWish(el){
	let status = el.dataset.status;
	
	if(isEmpty(current_no)){
		location.href = '${pageContext.request.contextPath}/member/login';
		return;
	}
	
	if(el.dataset.status == '0'){
		el.dataset.status = '1';
		el.children[0].setAttribute('src', '${pageContext.request.contextPath}/resources/customer/img/wish_icon_1.png');
		el.children[2].textContent = parseInt(el.children[2].textContent) + 1;
		document.querySelector('.product__wish span').textContent = el.children[2].textContent; 
	}else{
		el.dataset.status = '0';
		el.children[0].setAttribute('src', '${pageContext.request.contextPath}/resources/customer/img/wish_icon_0.png');
		el.children[2].textContent = parseInt(el.children[2].textContent) - 1;
		document.querySelector('.product__wish span').textContent = el.children[2].textContent; 
	}
		
	fetch('/usMarket/fetch/bookmark/'+product_no+'/'+status)
	.then((response) => response.text())
	.then((text) => {
		console.log('after status = '+text);
	}).catch((error) => console.error('error: ' + error));
};


// 채팅하기
function sendChat(){
	const addChatRoomForm = document.getElementById('addChatRoomForm');
	addChatRoomForm.children[0].value = seller_no;
	addChatRoomForm.children[1].value = document.querySelector('.product_name').textContent.trim();
	addChatRoomForm.children[2].value = document.getElementById('fetch__member__nickname').textContent;
	
	console.log(addChatRoomForm);
	addChatRoomForm.submit();
};


// 신고하기
function openReport(){
	if(isEmpty(current_no)){
		location.href = '${pageContext.request.contextPath}/member/login';
		return;
	}
	
	document.getElementById('report_member_no').value = seller_no;
	document.getElementById('report_info').value = `${param.product_no}`;
	document.querySelector('.report-info').textContent = document.getElementById('fetch__member__nickname').textContent;
	reportModal.show();	
};


// 상품 상태 변경
function productStateChange(el){
	let currentStatus = el.dataset.status == '1' ? '판매중으로' : '예약완료로';
	
	if(confirm('해당 상품을 ' + currentStatus + ' 변경하시겠습니까?')){
		
		let formData = new FormData();
		formData.append('product_no', `${productInfo.PRODUCT_NO}`);
		formData.append('product_state_no', el.dataset.status);
		
		fetch('/usMarket/fetch/product/modify', {
			method: 'POST',
			body: formData
		})
		.then((response) => response.text())
		.then((text) => {
			if(text == '1'){
				alert('정상적으로 변경되었습니다.');
			}else{
				alert('상태 변경에 실패했습니다.');
			}
			location.reload();
		}).catch((error) => console.error('error: '+error));
	}
};
</script>
