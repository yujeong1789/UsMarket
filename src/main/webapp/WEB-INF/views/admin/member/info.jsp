<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="<c:url value='/resources/admin/css/member_info.css'/>" type="text/css">

<div class="member-info-container">

	<c:if test="${empty infoMap}">
		<script type="text/javascript">
			alert('회원정보를 찾을 수 없습니다.');
			location.href = '${pageContext.request.contextPath}/admin/home';
		</script>
	</c:if>
	
	<c:if test="${not empty infoMap}">
		<div class="title">
			<span>회원 상세보기</span>
		</div>
		<div class="dashboard">
			<div class="dashboard-1">				
				<c:set var="memberInfo" value="${infoMap.memberInfo }"/>
				<div class="member-info-1">
					<img src="<c:url value='${memberInfo.MEMBER_IMAGE }' />" >				
				</div> <!-- member-info-1 -->
				
				<div class="member-info-2">
					<input type="hidden" id="member_no" name="member_no" value="${memberInfo.MEMBER_NO }">
					<div>
						<div class="title">이름</div>
						<div class="info">${memberInfo.MEMBER_NAME }</div>
					</div>
					<div>
						<div class="title">아이디</div>
						<div class="info member-id">${memberInfo.MEMBER_ID }</div>
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
			</div>
		</div> <!-- dashboard -->
	</c:if>
	

	<div class="dashboard">
		<div>
			<c:set var="productList" value="${infoMap.productList }"/>
			<div class="sub-title">
				<span>판매상품 ${' (' += totalCnt += ')'}</span>
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
			<div class="product-list">
				<div class="product-area">
					<c:if test="${empty productList }">
						<span class="product-empty">판매 중인 상품이 존재하지 않습니다.</span>
						<input id="pageValue" type="hidden">
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
									<div class="info-view">
										<img src="<c:url value='/resources/customer/img/view.png'/>">
										<span>${product.PRODUCT_VIEW }</span>
									</div> <!-- product_view -->
								</div>
							</div> <!-- product__box -->
						</c:forEach>
					</c:if>
				</div> <!-- prduct-area -->
				<div class="paging">
					<c:if test="${ph.totalCnt != null || ph.totalCnt != 0 }">
						<c:if test="${ph.showPrev }">
							<div class="paging-prev">&lt;&lt;</div>
						</c:if>
						<c:forEach var="i" begin="${ph.beginPage }" end="${ph.endPage }">
							<div class="paging-box ${i eq ph.sc.page ? 'current-page' : 'not-current-page' }" onclick="${i eq ph.sc.page ? '' : 'getProductList(' += i += ')'}">
								<input id="pageValue" type="hidden" value="${i }">
								${i}
							</div>
						</c:forEach>
						<c:if test="${ph.showNext }">
							<div class="paging-next">&gt;&gt;</div>
						</c:if>
					</c:if>
				</div> <!-- paging -->
			</div> <!-- product-list -->
		</div>
	</div>
</div>

<script type="text/javascript">
document.querySelectorAll('.order-dropdown li').forEach(el => {
	el.addEventListener('click', function(){
		document.querySelector('.order-selected').classList.remove('order-selected');
		this.className = 'order-selected';
		console.log(this.dataset.order);
		
		document.getElementById('pageValue').value = 1;
		getProductList(1);
	});
});

document.querySelectorAll('.condition-dropdown li').forEach(el => {
	el.addEventListener('click', function(){
		document.querySelector('.condition-selected').classList.remove('condition-selected');
		this.className = 'condition-selected';
		console.log(this.dataset.condition);
		
		document.getElementById('pageValue').value = 1;
		getProductList(1);
	});
});

let getProductList = function(page){
	let params = {
			'page': page,
			'pageSize': 10,
			'member_no': document.getElementById('member_no').value,
			'condition': document.querySelector('.condition-selected').dataset.condition,
			'order': document.querySelector('.order-selected').dataset.order
	};
	
	console.log(params);
	
	fetch('/usMarket/admin/member/reinfo', {
		method: 'POST',
		headers: {
			'Content-type' : 'application/json'
		},
		body: JSON.stringify(params),
	})
	.then((response) => response.text())
	.then((data) => {
		var result = document.createElement('div');
		result.innerHTML = data;
		document.querySelector('.product-list').innerHTML = result.querySelector('.product-list').innerHTML;
	}).catch((error) => console.log('error: '+error)); // fetch end
}; // getMemberList
</script>