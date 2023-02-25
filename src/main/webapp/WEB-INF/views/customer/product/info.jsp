<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/product_info.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/resources/customer/css/report_modal.css'/>" type="text/css">
<section class="product__info__section">

	<!-- 신고하기 모달 -->
	<div class="modal fade" id="reportModal" tabindex="-1" aria-labelledby="reportModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">신고하기</h5>
				</div>
				<div class="modal-body">
					<div class="report-into">
						<span class="report-title">신고대상</span>
						<div class="report-body report-info">
							<p></p>
							<p></p>							
						</div>
					</div>
					<div class="report-content">
						<form id="addReportForm" action="<c:url value='/report'/>" method="post">
							<span class="report-title">신고사유</span>
							<input type="hidden" id="qna_category1_no" name="qna_category1_no" value="1" readonly="readonly">
							<input type="hidden" id="qna_title" name="qna_title" value="상품 신고" readonly="readonly">
							<input type="hidden" id="member_no" name="member_no" readonly="readonly">
							<div class="report-body">
								<label>
									<input type="radio" name="qna_category2_no" id="qna_category2_no" value="4" checked />
									<span>허위매물</span>
								</label>
								<label>
									<input type="radio" name="qna_category2_no" id="qna_category2_no" value="5"/>
									<span>기타</span>
								</label>
								<div class="report-textarea">
									<textarea readonly="readonly" rows="5" maxlength="300"></textarea>
									<div><p>0</p><p>/300</p></div>
								</div>
							</div>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<div class="btn-close">
						<p>취소</p>
					</div>
					<div class="modal-submit">
						<p>신고하기</p>
					</div>
				</div>
			</div>
		</div>
	</div> <!-- modal -->
	
	<div class="container">
		<div class="row">
			<!-- 신고하기 모달 -->
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
								<span><c:out value="${productInfo.PRODUCT_REGDATE }"/></span>						
							</div>
						</div>
						<div class="right">
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
					
					<c:choose>
						<c:when test="${productInfo.PRODUCT_STATE_NO != 1 }"> 
							<!-- 판매 중이 아닌 상품일 경우 -->
							<div class="product__not__sale">
								<span>현재 판매 중인 상품이 아닙니다.</span>
							</div>
						</c:when>
						<c:otherwise>
							<!-- 판매 중이며 내 상품이 아닐 경우 보여질 버튼 -->
							<div class="product__buttons" id="product__buttons">
								<div id="btn__wish" data-url="/product/like?product_no=${productInfo.PRODUCT_NO}">
									<img id="bookmark__status" alt="찜" src="<c:url value='/resources/customer/img/wish_icon_0.png' />">
									<span>찜</span>
									<span><c:out value="${productInfo.BOOKMARK_COUNT }"/></span>
								</div>
								<div id="btn__chat">
									<span>채팅하기</span>
									<form id="addChatRoomForm" method="post" action="<c:url value='/chat/add'/>">
										<input type="hidden" name="seller_no">
										<input type="hidden" name="product_name">
										<input type="hidden" name="seller_nickname">
									</form>
								</div>
								<div id="btn__buy">
									<span>바로구매</span>
									<form id="productBuyForm" method="post" action="<c:url value='/product/buy'/>">
										<input type="hidden" name="product_no">
									</form>
								</div>
							</div>
							
							<!-- 판매 중이며 내 상품일 경우 보여질 버튼 -->
							<div class="product__my__buttons" id="product__my__buttons">
							<form id="productModifyForm" method="post" action="<c:url value='/product/remove'/>">
								<input type="hidden" name="product_no">
								<input type="hidden" name="product_state_no">
							</form>
								<div class="btn__my__store" id="btn__my__store">
									<span>내 상점 관리하기</span>
								</div>
								<div class="btn__product__delete" id="btn__product__delete">
									<span>삭제하기</span>
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
		const seller_no = `${productInfo.SELLER_NO}`;
		const current_id = document.getElementById('loginId').getAttribute('data-id');
		const current_no = document.getElementById('loginNo').getAttribute('data-no');
		const product_no = `${productInfo.PRODUCT_NO}`;
		const product_state = `${productInfo.PRODUCT_STATE_NO}`;
		
		const reportModalEl = document.getElementById('reportModal');
		const reportModal = new bootstrap.Modal(reportModalEl);
		
		// modal show event
		reportModalEl.addEventListener('show.bs.modal', function(e){
			console.log('show modal');
			document.querySelector('.report-info > p:first-child').textContent = seller_id.substr(0, 3)+'****';
			document.querySelector('.report-info > p:last-child').textContent = `${productInfo.PRODUCT_NAME}`;
			document.getElementById('member_no').value = document.getElementById('loginNo').dataset.no;						
		});
		
		// modal hide event
		reportModalEl.addEventListener('hide.bs.modal', function(e){
			console.log('hide modal');
			document.querySelector('input[type="radio"]').checked = 'true';
			switchWriteable(false);
		});
		
		console.log("product_no = "+product_no);
		console.log("current_id = "+current_id);
		console.log("seller_no = "+seller_no);
		
		console.log("isEmpty() = "+isEmpty(current_id));
		
		if(!isEmpty(current_id)){
			if(seller_id == current_id && product_state == 1){ // 내 상품이며 판매 중인 상품일 경우
				document.getElementById('product__buttons').style.display = 'none'; // 찜, 구매, 채팅 숨기기
				document.querySelector('.product__detail__1 > .right').style.visibility = 'hidden'; // 신고 버튼 숨기기
				document.getElementById('product__my__buttons').style.display = 'flex'; // 내 상점 관리, 삭제 활성화
			}else if(seller_id != current_id && product_state == 1){ // 내 상품이 아니며 판매 중인 상품일 경우
				fetch('/usMarket/fetch/bookmark/'+current_no+'/'+product_no)
				.then((response) => response.json())
				.then((json) => {
					let icon__element = document.getElementById('bookmark__status');
					let data_url = document.getElementById('btn__wish').getAttribute('data-url')+'&status='+json;
					document.getElementById('btn__wish').setAttribute('data-url', data_url);
					
					console.log(json == 0 ? 'NOT_ADDED' : 'ADDED');
					
					if(json == 1){
						icon__element.setAttribute('src', '${pageContext.request.contextPath}/resources/customer/img/wish_icon_1.png');
					}
				}).catch((error) => console.log("error: "+error)); // fetch-1
			}
		}
		
		
		// 이미지 불러오기
		const imgList = JSON.parse(`${jsonText}`);
		const imgPath = 'https://usmarket.s3.ap-northeast-2.amazonaws.com/';
		document.getElementById('product__current__img').src = imgPath + imgList[0]; 
		document.getElementById('img_preview').style.visibility = 'hidden';
		let imgOrder = 0;
		
		console.log('imgList = '+imgList);
		console.log('imgListSize = '+imgList.length);
		
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
		}
		
		// 다음 요소가 존재하는지
		function getNextImg(imgOrder){
			// 현재 index가 마지막 index보다 작으면
			if(imgOrder < (imgList.length-1)){
				imgOrder++;
			}
			return imgOrder;
		}
		
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
		
		
		// 판매 중인 상품일 경우에만 구매, 채팅, 찜, 삭제 이벤트 등록 (판매 중이 아닐 경우 버튼이 존재하지 않기 때문)
		if(product_state == 1){
			// 삭제하기
			document.getElementById('btn__product__delete').addEventListener('click', function(){
				if(confirm('상품을 삭제하시겠습니까?')){
					const productModifyForm = document.getElementById('productModifyForm');
					productModifyForm.children[0].value = product_no;
					productModifyForm.children[1].value = 4;
					
					productModifyForm.submit();
				}
			});		
			
			// 구매하기
			document.getElementById('btn__buy').addEventListener('click', function(){
				const productBuyForm = document.getElementById('productBuyForm');
				productBuyForm.children[0].value = product_no;
				
				productBuyForm.submit();
			});
			
			// 찜
			document.getElementById('btn__wish').addEventListener('click', function(){
				location.href = '${pageContext.request.contextPath}'+this.getAttribute('data-url');
			});
			
			// 채팅하기
			document.getElementById('btn__chat').addEventListener('click', function(){
				const addChatRoomForm = document.getElementById('addChatRoomForm');
				addChatRoomForm.children[0].value = seller_no;
				addChatRoomForm.children[1].value = document.querySelector('.product_name').textContent.trim();
				addChatRoomForm.children[2].value = document.getElementById('fetch__member__nickname').textContent;
				
				console.log(addChatRoomForm);
				addChatRoomForm.submit();				
			});
			
			// 신고하기
			document.getElementById('product__report').addEventListener('click', function(e){
				if(isEmpty(document.getElementById('loginNo').dataset.no)){
					location.href = '${pageContext.request.contextPath}/member/login';
				} else{
					reportModal.show();
					
					// close button event
					document.querySelector('.btn-close').addEventListener('click', function(e){
						reportModal.hide();
					}); 
				}
			});
			
			// radio click event
			const radioNodes = document.getElementsByName('qna_category2_no');
			radioNodes.forEach(el => {
				el.addEventListener('click', function(){
					switchWriteable(this.value == '5');
				});
			}); 
			
			// textarea input event
			document.querySelector('.report-textarea > textarea').addEventListener('input', function(e){
				this.nextElementSibling.firstChild.textContent = this.value.length;
			}); 
			
			// submit button event
			document.querySelector('.modal-submit').addEventListener('click', function(e){
				if(document.querySelector('input[type=radio]:checked').value == '5' && document.querySelector('.report-textarea > textarea').value.length == 0){
					alert('신고 내용을 입력해 주세요.');
				} else {
					if(confirm('해당 상품을 신고하시겠습니까?')){
						// submit 처리
						alert('신고가 정상적으로 접수되었습니다.');
						reportModal.hide();
					}
				}
			}); 
			
		} // if
		
		
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
			} // if-else
				
		}).catch((error) => console.log("error: "+error)); // fetch-2
		
		
		// 상위 2건 리뷰 얻기
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
		
		
		// 상품 태그 출력하기
		const tagElement = document.getElementById('product__tag__content');
		const tag = `${productInfo.PRODUCT_TAG}`;
		
		if(tag.length > 0){
			const tagArr = tag.split(' ');
			
			tagArr.forEach((el) => {
				let appendTag = "<a href='${pageContext.request.contextPath}/product/list?keyword="+el+"'>"+el+"</a>";
				tagElement.innerHTML += appendTag;
			});			
		}
		
		function switchWriteable(result){
			if(result){
				document.querySelector('.report-textarea').style.backgroundColor = '#F4F8FB';
				document.querySelector('.report-textarea > textarea').style.backgroundColor = '#F4F8FB';
				document.querySelector('.report-textarea > textarea').removeAttribute('readonly');
				document.querySelector('.report-textarea > textarea').setAttribute('placeholder', '위 신고항목에 없거나 추가로 신고하실 내용을 적어 주세요.');
			}else{
				document.querySelector('.report-textarea').style.backgroundColor = '#F5F5F5';
				document.querySelector('.report-textarea > textarea').style.backgroundColor = '#F5F5F5';
				document.querySelector('.report-textarea > textarea').setAttribute('readonly', 'true');
				document.querySelector('.report-textarea > textarea').value = '';
				document.querySelector('.report-textarea > textarea').nextElementSibling.firstChild.textContent = 0;
				document.querySelector('.report-textarea > textarea').removeAttribute('placeholder');
			}
		}
		
	});
	
	
</script>
