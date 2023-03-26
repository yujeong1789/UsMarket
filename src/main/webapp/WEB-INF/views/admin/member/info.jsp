<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="<c:url value='/resources/admin/css/member_info.css'/>" type="text/css">

<div class="member-info-container">
	<div class="title">
		<span>회원 상세보기</span>
	</div>
	<div class="dashboard">
		<div class="dashboard-1">
			<c:if test="${empty infoMap}">
				<span>회원정보를 찾을 수 없습니다.</span>
			</c:if>
			
			<c:if test="${not empty infoMap}">
				<c:set var="memberInfo" value="${infoMap.memberInfo }"/>
				<div class="member-info-1">
					<img src="<c:url value='${memberInfo.MEMBER_IMAGE }' />" >				
				</div> <!-- member-info-1 -->
				
				<div class="member-info-2">
					<div>
						<div class="title">이름</div>
						<div class="info">${memberInfo.MEMBER_NAME }</div>
					</div>
					<div>
						<div class="title">아이디</div>
						<div class="info">${memberInfo.MEMBER_ID }</div>
					</div>
					<div>
						<div class="title">닉네임</div>
						<div class="info">${memberInfo.MEMBER_NICKNAME }</div>
					</div>
					<div>
						<div class="title">이메일</div>
						<div class="info">${memberInfo.MEMBER_EMAIL }</div>
					</div>
					<div>
						<div class="title">가입일</div>
						<div class="info"><fmt:formatDate value="${memberInfo.MEMBER_REGDATE }" pattern="yyyy년 MM월 dd일 HH시 mm분"/></div>
					</div>
					<div>
						<div class="title">주소</div>
						<div class="info">
							<c:if test="${empty memberInfo.MEMBER_ZIPCODE }">
								없음
							</c:if>
							<c:if test="${not empty memberInfo.MEMBER_ZIPCODE }">
								${'(' += memberInfo.MEMBER_ZIPCODE += ') ' += memberInfo.MEMBER_ADDRESS += ' ' += memberInfo.MEMBER_ADDRESS_DETAIL}
							</c:if>
						</div>
					</div>
					<div>
						<div class="title">가입상태</div>
						<div class="info">${memberInfo.MEMBER_STATE_NAME }</div>
					</div>
				</div> <!-- member-info-2 -->
			</c:if>
			
		</div>
	</div> <!-- dashboard -->
	

	<div class="dashboard">
		<div>
			<c:set var="productList" value="${infoMap.productList }"/>
			<div class="sub-title">
				<span>판매상품 ${' (' += productList.size() += ')'}</span>
			</div>
			<div class="product-area">
				<c:if test="${empty productList }">
					<span class="product-empty">판매 중인 상품이 존재하지 않습니다.</span>
				</c:if>
				<c:if test="${not empty productList }">
					<c:forEach var="product" items="${productList }">
						<div class="box">
							<div class="img">
								<a href="<c:url value='/product/info?product_no=${product.PRODUCT_NO}' />"> 
									<c:if test="${product.PRODUCT_STATE_NO eq 2}">
										<img class="img-top" src="${pageContext.request.contextPath}/resources/customer/img/product/reserve.png">
									</c:if>
									<c:if test="${product.PRODUCT_STATE_NO eq 3}">
										<img class="img-top" src="${pageContext.request.contextPath}/resources/customer/img/product/complete.png">
									</c:if>
									<img src="https://usmarket.s3.ap-northeast-2.amazonaws.com/${product.PRODUCT_IMG_PATH}">
								</a>
							</div>
							<div class="info-1">
								<div class="info-title">
									<a href="<c:url value='/product/info?product_no=${product.PRODUCT_NO}' />">
										<c:out value="${product.PRODUCT_NAME }" />
									</a> <!-- 상품명 -->
								</div>
								<div class="info-price">
									<span><fmt:formatNumber value="${product.PRODUCT_PRICE }" pattern="#,###"/></span> <!-- 가격 -->
								</div>
								<div class="info-regdate">
									<fmt:formatDate value="${product.PRODUCT_REGDATE }" pattern="yyyy년 MM월 dd일 HH:mm"/>
								</div> <!-- regdate -->
							</div>
						</div> <!-- product__box -->
					</c:forEach>
				</c:if>
			</div>
		</div>
		
	</div>
</div>