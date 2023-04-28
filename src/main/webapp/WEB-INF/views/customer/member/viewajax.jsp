<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>

<div class="mypage_content">

<c:if test="${category == 'productList' || category == 'bookmarkList'}"> <!-- Product, Bookmark -->

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
		<c:if test="${! empty pageList }">
			<div class="product__area">
				<c:forEach var="product" items="${pageList }" varStatus="status">
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
								<span><fmt:formatNumber value="${product.PRODUCT_PRICE}" pattern="#,###"/></span>
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
		</c:if>
		
		<c:if test="${empty pageList }">
			<c:if test="${category == 'productList' }">
				<div class="no__item">등록된 상품이 없습니다.</div>
			</c:if>
			<c:if test="${category == 'bookmarkList' }">
				<div class="no__item">찜한 상품이 없습니다.</div>
			</c:if>			
		</c:if>
	</div>
</c:if>

<c:if test="${category == 'reviewList'}"> <!-- Review -->
	<div class="sub-title">
		<div></div>
		<div class="dropdown-container">
			<div class="dropdown order-dropdown">
				<span>정렬</span>
				<div class="dropdown-content">
					<ul>
						<li class="order-selected" data-order="regdate_desc">등록 최신순</li>
						<li data-order="regdate">등록 오래된순</li>
					</ul>
				</div>
			</div>
			<div class="dropdown condition-dropdown">
				<span>별점</span>
				<div class="dropdown-content">
					<ul>
						<li class="condition-selected" data-condition="0">전체</li>
						<li data-condition="1">1점</li>
						<li data-condition="2">2점</li>
						<li data-condition="3">3점</li>
						<li data-condition="4">4점</li>
						<li data-condition="5">5점</li>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<input class="mode" type="hidden" value="${category}">
	
	<div class="content_list">
		<c:if test="${empty pageList }">
			<div class="no__item">리뷰내역이 존재하지 않습니다.</div>
		</c:if>
		<c:if test="${! empty pageList }">
			<input type="hidden" class="pageList" value="${pageList}">
			<div class="review__area">
				<ul class="review-list">
					<c:forEach var="review" items="${pageList }">
						<li data-no="${review.PRODUCT_NO }">
							<div class="review-left">
								<img class="seller-img" src="<c:url value='${review.MEMBER_IMAGE }' />">
							</div>
							<div class="review-right">
								<div class="review-info">
									<div class="info-label">
										<div class="info-label-nickname">구매자</div>
										<span class="info-redirect" onclick="location.href='<c:url value="/member/mypage?member_no=${review.MEMBER_NO }"/>'">
											<c:out value="${review.MEMBER_NICKNAME }"/>
											<img src="<c:url value='/resources/admin/img/icon/redirect.png'/>">
										</span>
									</div>
									<div class="info-label">
										<div class="info-label-product">판매상품</div>
										<span class="info-redirect" onclick="location.href='<c:url value="/product/info?product_no=${review.PRODUCT_NO }"/>'">
											<c:out value="${review.PRODUCT_NAME }"/>
											<img src="<c:url value='/resources/admin/img/icon/redirect.png'/>">
										</span>
									</div>
								</div>
								<div class="review-info">
									<div class="review-info-right">
										<div class="info-label-regdate">등록 시간</div>
										<span class="name-right"><fmt:formatDate value="${review.REVIEW_REGDATE }" pattern="yyyy년 MM월 dd일 (a hh:mm)"/></span>
									</div>
								</div>
								<div class="review-info-score">
									<c:forEach begin="1" end="5" var="loopIndex">
										<c:choose>
											<c:when test="${review.REVIEW_SCORE >= loopIndex}">
												<img class="score" src="${pageContext.request.contextPath}/resources/customer/img/star.png">
											</c:when>
											<c:otherwise>
												<img class="score" src="${pageContext.request.contextPath}/resources/customer/img/star_blank.png">
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</div>
								<textarea class="review-content" readonly>${review.REVIEW_CONTENT }</textarea>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
			
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
		</c:if>
	</div>
</c:if>

<c:if test="${category == 'search'}"><!-- 아이디 찾기 페이지 -->
<div>
<div class="search_body">
	<section class="search_form">
		<h1>아이디 찾기</h1>
		<div class="value_area">
		<c:choose>
			<c:when test="${message eq '없는 회원 정보입니다.' }">
				<c:out value="${message}"></c:out>
			</c:when>
			<c:otherwise>
				내 아이디 : <c:out value="${result.MEMBER_ID }" />
			</c:otherwise>
		</c:choose>
		</div>
		<div class="a_area">
			<a class="a_btn" href="<c:url value='/member/login'/>">돌아가기</a>
		</div>
	</section>
</div>
</div>
</c:if>

<c:if test="${category == 'newPw'}"><!-- 새로운 비밀번호 전송 -->
<div>
<div class="search_body">
	<section class="search_form">
		<h1>비밀번호 찾기</h1>
		<div class="value_area">
			<c:if test="${result eq null}">
				없는 회원 정보입니다.
			</c:if>
			<c:if test="${result ne null}">
				임시 비밀번호를 이메일로 발송하였습니다. 확인하고 로그인해 주세요.
				<input type="hidden" value="${result}">
			</c:if>
		</div>
		<div class="a_area">
			<a class="a_btn" href="<c:url value='/member/login'/>">돌아가기</a>
		</div>
	</section>
</div>
</div>
</c:if>
</div>



</html>