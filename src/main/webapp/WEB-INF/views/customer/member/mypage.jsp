<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="req" value="${pageContext.request }" />
<c:set var="loginOn" value="${req.getSession(false) == null ? '' : pageContext.request.session.getAttribute('userId')}"/>
<c:set var="con" value="1"/>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/member_mypage.css'/>" type="text/css">

<section class="member_info_section">
	<div class="container">
		<div class="row">
			<div class="member_info">
				<!-- 회원 정보 영역 -->
				<div class="member_info_img">
					<input type="file" id="profile" name="member_profile_image" accept="image/jpg, image/jpeg, image/png" style="display:none;"/>
					<input type="image" id="profile_image" name="member_image" style="display:none;"/>
					<label for="profile" style="width:100%">
						<img id="profile_img" alt="프로필 이미지" src="<c:url value='${memberInfo.member_image}' />" >
					</label>
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
								<div class="member_regdate">
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
								
								<div class="member_option">
									<div class="left">
										<c:if test="${loginOn eq memberInfo.member_id}">
											<a href="<c:url value='#'/>">회원 정보 수정</a>
										</c:if>	
									</div>
									<div class="right">
										<div class="member_detail_icon">
											<img alt="신고하기" src="<c:url value='/resources/customer/img/report.png'/>">
										</div>
										<span id="member_report">신고하기</span>
									</div>
								</div>
								
							</div>  <!-- member_detail -->
						</div> <!-- member_info_div -->
					</c:otherwise>
				</c:choose>
			</div><!-- member_info -->

			<div class="member_mypage_content">
				<div class="content_category">
					<div class="category_head">
						<a class="head_category" id="head_product" href="<c:url value="/member/mypage" />">
							상품<span>${mypageProductList.size() }</span>
						</a>
						<a class="head_category" id="head_review" href="<c:url value="/member/mypage" />">
							상점후기<span></span>
						</a>
						<a class="head_category" id="head_bookmark" href="<c:url value="/member/mypage" />">
							찜<span></span>
						</a>
					</div>
				</div>
				<div class="mypage_category_content">
					<c:if test="${! empty mypageProductList }">
						<div class="product__area">
						<c:forEach var="product" items="${mypageProductList }">
							<div class="product__box">
								<div class="product__img">
									<a href="<c:url value='/product/info?product_no=${product.product_no}' />"> 
										<c:if test="${product.product_state_no == 2}">
											<img class="product__img__top" src="${pageContext.request.contextPath}/resources/customer/img/product/reserve.png">
										</c:if>
										<c:if test="${product.product_state_no == 3}">
											<img class="product__img__top" src="${pageContext.request.contextPath}/resources/customer/img/product/complete.png">
										</c:if>
										<img src="https://usmarket.s3.ap-northeast-2.amazonaws.com/${product.product_img_path}">
									</a>
								</div>
								<div class="product__info__1">
									<div class="product__title">
										<a href="<c:url value='/product/info?product_no=${product.product_no}' />">
											<c:out value="${product.product_name }" />
										</a> <!-- 상품명 -->
									</div>
									<div class="product__info__2">
										<div class="product__price">
											<span><fmt:formatNumber value="${product.product_price }" pattern="#,###"/></span> <!-- 가격 -->
										</div>
										<div class="product__regdate">
											<c:out value="${product.product_regdate}" />
										</div> <!-- regdate -->
									</div>
								</div>
							</div> <!-- product__box -->
						</c:forEach>
						</div> <!-- product__area -->
					</c:if>
					
					<c:if test="${empty mypageProductList }">
						<div class="no__item">등록된 상품이 없습니다.</div> <!-- 이미지 만들 것 -->				
					</c:if>
					
					<div class="paging__container">
							<c:if test="${ph.totalCnt != null || ph.totalCnt != 0 }">
								<c:if test="${ph.showPrev }">
									<div class="paging__box">
										<a class="paging__href" href="<c:url value='/product/list${ph.sc.getQueryString(ph.beginPage-1)}'/>">&lt;</a>								
									</div>
								</c:if>
								<c:forEach var="i" begin="${ph.beginPage }" end="${ph.endPage }">
								<input id="pageValue" type="hidden" value="${i }">
									<div class="paging__box">
										<a class="paging__href ${i==ph.sc.page ? 'paging-active' : ''}" href="<c:url value="/product/list${ph.sc.getQueryString(i)} " />">
											${i}
										</a>															
									</div>
								</c:forEach>
								<c:if test="${ph.showNext }">
									<div class="paging__box">
										<a class="paging__href" href="<c:url value='/product/list${ph.sc.getQueryString(ph.endPage+1)}'/>">&gt;</a>								
									</div>
								</c:if>
							</c:if>
					</div> <!-- product__container -->						
				</div>
			</div>
			<!-- member_content_layout -->
		</div>
	</div>
</section>

<script type="text/javascript">
	$(document).ready(function(){
		
	});
	
	
</script>
