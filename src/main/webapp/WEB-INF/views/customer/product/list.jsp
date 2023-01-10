<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="option" value="${param.option }"/>
<c:set var="keyword" value="${param.keyword }"/>
<c:set var="list" value="${productList }"/>

<section class="products__section">
	<div class="container">
		<div class="row">
		<c:if test="${empty param.keyword }">
			<div class="col-lg-12">
				<a class="home" href="<c:url value='/'/>">홈</a>
				<span class="home__span"></span>
				<div class="category__selected" id="category__selected">
					<a id="category1" href="<c:url value='/product/list?category1=${param.category1 }'/>">
						<c:out value="${category1_name }"/>
					</a>
				</div>
			</div>
			
			<div class="product__category" id="product__category">
			<c:forEach var="category2" items="${categoryList2 }">
			<c:if test="${!empty param.category2 }">
				<c:set var="selectedList" value="${param.category2 eq category2.product_category2_no ? 'selectedList' : '' }"/>
			</c:if>
				<div>
					<a id="${selectedList }" href="<c:url value="/product/list${ph.sc.getQueryString(param.category1, category2.product_category2_no)}" />">
						<span><c:out value="${category2.product_category2_name }" /></span>
					</a>
				</div>
			</c:forEach>
			</div>
		</c:if>
		
			<div class="product__list">
			
				<div class="product__bar">
					<div class="category__name">
						<h3 id="category__name"></h3>
					</div>
					
					<div class="product__order">
						<ul class="order__ul" id="order__ul">
							<li id="2" value="2">예약중 포함</li>
							<li id="3" value="3">판매완료 포함</li>
						</ul>
					</div>
					
				</div>
				
				<c:if test="${! empty productList }">
				<div class="product__area">
				<c:forEach var="product" items="${productList }">
					<div class="product__box">
						<div class="product__img">
							<a href="<c:url value='/product/info?product_no=${product.product_no}' />"> 
								<c:if test="${product.product_state_no == 2}">
									<img class="product__img__top" src="${pageContext.request.contextPath}/resources/customer/img/product/reserve.png">
								</c:if>
								<c:if test="${product.product_state_no == 3}">
									<img class="product__img__top" src="${pageContext.request.contextPath}/resources/customer/img/product/complete.png">
								</c:if>
								<img src="${pageContext.request.contextPath}/resources/productImgUpload/2022/11/29/IMG_5403.PNG">
								<!-- 임시 이미지 출력 (수정 예정) -->
							</a>
						</div>
						<div class="product__info__1">
							<div class="product__title">
								<a href="<c:url value='/product/info?product_no=${product.product_no}' />">
									<c:out value="${product.product_no} ${product.product_name }" />
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
				<c:if test="${empty productList }">
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
				
			</div> <!-- producgt__list -->
			
		</div> <!-- row -->
	</div>
</section>

<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function(){
		const url = new URLSearchParams(window.location.search);
		
		const keyword = `${ph.sc.getKeyword()}`;
		const headerTag = document.getElementById("category__name");

		
		if(isEmpty(keyword)){
			
			// 동적으로 자식 요소 추가
			const productCategory = document.getElementById("product__category");
			const addCount = (Math.ceil(productCategory.childElementCount/5)*5)-productCategory.childElementCount;
			
			for(let i=0; i<addCount; i++){
				productCategory.appendChild(document.createElement('div'));
			}
			
			// 선택 카테고리 강조
			let textNode =  document.getElementById('category1').innerText.trim();
			
 			if(document.getElementById("selectedList") != null && document.getElementById("selectedList") != ""){
 				const category2TextNode = document.getElementById("selectedList").innerText.trim();
				textNode = category2TextNode;
				const category2InnerHtml = '<span class="before__span"></span><a id = category2 href=${pageContext.request.contextPath}/product/list?category1='+url.get('category1')+'&category2='+url.get('category2')+'>'+category2TextNode+'</a>';
				document.getElementById('category__selected').innerHTML+=category2InnerHtml;
			}
			
			headerTag.innerText = textNode;
			
		}else if(! isEmpty(keyword)){
			headerTag.innerText = keyword;
			document.getElementById("searchKeyword").value = keyword;
			
		} // if
		
		
			
		const list = `${list}`
		if(! isEmpty(list)){
			// 선택 옵션 강조
			const optionParam = url.get('option');
			
			setStyle(optionParam);
			
			
			// 포함 option 추가
			document.getElementById("order__ul").addEventListener('click', (e) => { // 매개변수는 이벤트가 발생한 태그를 의미
				
				url.set('page', 1);
				console.log("e.target.value= " + e.target.value);
	
				if(optionParam == e.target.value){ // option과 value가 일치하면 파라미터 삭제 (같은 옵션 재클릭했다는 뜻)
					url.delete('option');
					console.log("같은 곳에서 클릭 발생, option delete");
				}else{
					let setOption = getOption(optionParam, e.target.value);
					url.set('option', setOption);
					console.log("option set");
				} // if-else end
				
				console.log("queryString= " + url);
				
				location.href = "${pageContext.request.contextPath}/product/list?" + url;
			});
		} // if
	
	});
	
	
	function getOption(value, targetValue){ // parameter option, e.target.value
		switch (value) {
			case "5":
				return parseInt(value)-targetValue;
				break;
			case "2":
			case "3":
				return parseInt(value)+targetValue;
				break;
			default:
				return targetValue;
		}
	};
	
	
	function setStyle(optionParam){
		switch (optionParam) {
			case "5":
				const ul = document.querySelectorAll('.order__ul li');
				ul.forEach(el => el.className = 'selectedOption');
				break;
			case "2":
			case "3":
				document.getElementById(optionParam).className='selectedOption';
				break;
			default:
				break;
		}
	};
	
/* 	
	function isEmpty(value){
		if( value == "" || value == null || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length ) ){
			return true
		}else{
			return false
		}
	}; */
</script>