<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="req" value="${pageContext.request }" />
<c:set var="loginOn" value="${req.getSession(false) == null ? '' : pageContext.request.session.getAttribute('userNo')}"/>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/member_mypage.css'/>" type="text/css">

<c:if test="${empty memberInfo }">
	<script type="text/javascript">
		alert('회원정보를 찾을 수 없습니다.');
		location.href = '${pageContext.request.contextPath}/';
	</script>
</c:if>

<c:if test="${!empty memberInfo }">

<section class="member_info_section">
	<div class="row">
		<div class="container">
			<div class="member_info">
				
				<!-- 회원 정보 영역 -->
				<div class="member_info_img">
					<input type="file" id="profile" name="member_profile_image" accept="image/jpg, image/jpeg, image/png" style="display:none;"/>
					<input type="image" id="profile_image" name="member_image" style="display:none;"/>
					<div class="profile_img_div">
						<img id="profile_img" alt="프로필 이미지" src="<c:url value='${memberInfo.member_image}' />" >
					</div>
				</div>
				
				<c:choose>
					<c:when test="${memberInfo.member_state_no != 1 }"> 
						<!-- 판매 중이 아닌 상품일 경우 -->
						<div class="member_not">
							<span>현재 회원이 아닙니다.</span>
						</div><!-- 추후 수정 예정 -->
					</c:when>
					<c:otherwise>
					<div class="member_info_div">
						<div class="member_nickname">
							<c:out value="${memberInfo.member_nickname }"/>
						</div>
							<div class="member_detail">
								<div class="member_regdate">
									<div class="member_label">상점 오픈일</div>
									<span><c:out value="${regdate }"/></span>
								</div>
								<c:if test="${loginOn ne memberInfo.member_no}">
									<c:forEach var="state" begin="1" end="3">
										<c:choose>
											<c:when test="${state == 1}">
												<div class="product_state">
													<div class="member_label">판매중인 상품</div>
													<c:forEach var="item" items="${stateCnt}">
														<c:if test="${item.STATE == '판매중' }">
															<span><c:out value="${item.CNT }"/>개</span>
														</c:if>
													</c:forEach>
												</div>
											</c:when>
											<c:when test="${state == 2}">
												<div class="product_state">
													<div class="member_label">판매한 상품</div>
													<c:forEach var="item" items="${stateCnt}">
														<c:if test="${item.STATE == '판매완료' }">
															<span><c:out value="${item.CNT }"/>개</span>
														</c:if>
													</c:forEach>
												</div>
											</c:when>
											<c:when test="${state == 3}">
												<div class="product_state">
													<div class="member_label">예약중인 상품</div>
													<c:forEach var="item" items="${stateCnt}">
														<c:if test="${item.STATE == '예약중' }">
															<span><c:out value="${item.CNT }"/>개</span>
														</c:if>
													</c:forEach>
												</div>
											</c:when>
										</c:choose>
									</c:forEach>
								</c:if>
								<c:if test="${loginOn == memberInfo.member_no}">
									<div class="member_name">
										<div class="member_label">이름</div>
										<span><c:out value="${memberInfo.member_name }"/></span>
									</div>
									<div class="member_id">
										<div class="member_label">아이디</div>
										<span><c:out value="${memberInfo.member_id }"/></span>
									</div>
									<div class="member_email">
										<div class="member_label">이메일</div>
										<span><c:out value="${memberInfo.member_email }"/></span>
									</div>
									<div class="member_hp">
										<div class="member_label">전화번호</div>
										<span><c:out value="${memberInfo.member_hp }"/></span>
									</div>					
								</c:if>
								
								<c:if test="${loginOn eq memberInfo.member_no}">
									<div class="member_option">
										<div class="left">
											<a href="<c:url value='/member/join?mode=modify'/>">회원 정보 수정</a>
										</div>
										<div>
											<a href="<c:url value='/deal/list'/>">거래내역</a>
										</div>
									</div>
								</c:if>	
								
							</div>  <!-- member_detail -->
						</div> <!-- member_info_div -->
					</c:otherwise>
				</c:choose>
			</div><!-- member_info -->

			<div class="member_mypage">
				<div class="mypage_category">
					<div class="category_head">
						<button class="head_category" id="head_product" data-status="selected">
							<span id="span_category" class="product_name">상품 <c:out value="${product }"/></span>
						</button>
						<button class="head_category" id="head_review">
							<span id="span_category" class="review_name">상점후기 <c:out value="${review }"/></span>
						</button>
						<button class="head_category" id="head_bookmark">
							<span id="span_category" class="bookmark_name">찜 <c:out value="${bookmark }" /></span>
						</button>
					</div>
				</div>
				<div class="mypage_content">
					<div class="sub-title">
						<div></div>
						<div class="dropdown-container">
							<div class="dropdown order-dropdown">
								<span>정렬</span>
								<div class="dropdown-content">
									<ul>
										<li class="order-selected" data-order="regdate_desc">등록 최신순</li>
										<li data-order="regdate">등록 오래된순</li>
										<li data-order="view_desc">조회 많은순</li>
										<li data-order="view">조회 적은순</li>							
									</ul>
								</div>
							</div>
							<div class="dropdown condition-dropdown">
								<span>판매상태</span>
								<div class="dropdown-content">
									<ul>
										<li class="condition-selected" data-condition="0">전체</li>					
										<li data-condition="1">판매중</li>					
										<li data-condition="2">예약중</li>					
										<li data-condition="3">판매완료</li>					
									</ul>
								</div>
							</div>
						</div>
					</div>
					<input class="mode" type="hidden" value="${category}">
					<div class="content_list">
						<c:if test="${! empty mypageList }">
							<div class="product__area" id="product__area">
							
								<c:forEach var="product" items="${mypageList }">
									<div class="product__box">
										<div class="product__img">
											<a href="<c:url value='/product/info?product_no=${product.PRODUCT_NO}' />"> 
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
													<span><fmt:formatNumber value="${product.PRODUCT_PRICE }" pattern="#,###"/></span>
												</div>
												<div class="product__regdate">
													<fmt:formatDate value="${product.PRODUCT_REGDATE }" pattern="yyyy년 MM월 dd일 (a K:mm)"/>
												</div>
												<div class="info-view">
													<img src="<c:url value='/resources/customer/img/view.png'/>">
													<span>${product.PRODUCT_VIEW }</span>
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
						</c:if>
						
						<c:if test="${empty mypageList }">
							<div class="no__item">등록된 상품이 없습니다.</div> 		
						</c:if>
						
						<div class="paging__container">
							<c:if test="${ph.totalCnt != null}">
								<c:if test="${ph.showPrev }">
									<div class="paging-prev">&lt;&lt;</div>
								</c:if>
								<c:forEach var="i" begin="${ph.beginPage }" end="${ph.endPage }">
									<div class="paging-box ${i eq ph.sc.page ? 'current-page' : 'not-current-page' }">
										<input id="pageValue" type="hidden" value="${i }">
										${i}
									</div>
								</c:forEach>
								<c:if test="${ph.showNext }">
									<div class="paging-next">&gt;&gt;</div>
								</c:if>
							</c:if>
						</div> <!-- paging__container -->
						<form id="productInfoForm" action="<c:url value='/product/info'/>" method="get">
						    <input type="hidden" id="product_no" name="product_no">
						</form>
					</div>
				</div> <!-- mypage_content -->
			</div> <!-- member_mypage -->
			<!-- member_content_layout -->
		</div>
	</div>
</section>
</c:if>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		let member_no = ${memberInfo.member_no};
	    let method = null;
	    let list = null;
	    	    
	    let btn_p = $("#head_product");
	    let btn_r = $("#head_review");
	    let btn_b = $("#head_bookmark");
		
	    function selectButton(btn, font) {
    	  // 선택한 버튼에만 스타일 적용
    	  btn.css('background', '#16A7F1');
    	  font.css('color', 'white');
    	  
    	  // 선택하지 않은 버튼 스타일 초기화
    	  $('.head_category').not(btn).css('background', 'rgb(250, 250, 250)');
    	  $('.head_category').not(btn).find('span').css('color', 'black');
    	}

    	function optOut() {
    	  // 모든 버튼 스타일 초기화
    	  $('.head_category').css('background', 'rgb(250, 250, 250)');
    	  $('.head_category span').css('color', 'black');
    	}

    	// 클릭 이벤트
    	btn_p.click(function(){
    	  myCategory("myProductList");
    	  optOut();
    	  selectButton(btn_p, $(".product_name"));
    	});

    	btn_r.click(function(){
    	  myCategory("myReview");
    	  optOut();
    	  selectButton(btn_r, $(".review_name"));
    	});

    	btn_b.click(function(){
    	  myCategory("myBookmark");
    	  optOut();
    	  selectButton(btn_b, $(".bookmark_name"));
    	});
		
		pageInfo = {
				'member_no': member_no,
				'condition': $('.condition-selected').data('condition'),
				'order': $('.order-selected').data('order')
		};
		
		function myCategory(myProductList){
		    $.ajax({
				type : 'POST',
	 			url : "${pageContext.request.contextPath}/member/"+myProductList,
	 			headers : {"content-type": "application/json"},
	 			data: JSON.stringify(pageInfo),
	 			dataType: "text",
				async: false,
				success:function(data){
					var result = $('<div></div>').html(data);
					var productBox = $(result).find('.mypage_content').html();
					$('.mypage_content').html(productBox);
				},
				error: function(jqXHR, textStatus, errorThrown){
					alert("오류가 발생했습니다.");
				}
			}); // ajax
		} // function
	
		$(document).on('click', '.order-dropdown li', function() {
			$('.order-selected').removeClass('order-selected');
			$(this).addClass('order-selected');
			console.log($(this).data('order'));

			$('#pageValue').val(1);
			if($('.pageList') != null){
				myProductList(1);				
			}
		});
		
		$(document).on('click', '.condition-dropdown li', function() {
			$('.condition-selected').removeClass('condition-selected');
			$(this).addClass('condition-selected');
			console.log($(this).data('condition'));

			$('#pageValue').val(1);
			if($('.pageList') != null){
				myProductList(1);				
			}
		});
    
		function myProductList(page){			
			params = {
					'page': page,
					'member_no': member_no,
					'condition': $('.condition-selected').data('condition'),
					'order': $('.order-selected').data('order'),
					'mode': $('.mode').val()
			};
			
			console.log(params);

			$.ajax({
				type: 'POST',
				url: '/usMarket/member/mypage',
				contentType: 'application/json',
				data: JSON.stringify(params),
				async: false,
				success: function(result) {
					var productBox = $(result).find('.content_list').html();
					$('.content_list').html(productBox);
				},
				error: function(error) {
					console.log('error: ' + error);
				}
			}); // ajax
		}; // myProductList 
		
		$(document).on('click', '.paging-box', function(){
		    var page = $(this).find('input').val();
		    myProductList(page);
		});

		$(document).on('click', '.review-list li', function() {
	        $('#product_no').val($(this).data('no'));
	        $('#productInfoForm').submit();
	    });
	}); // ready
	
	
</script>
