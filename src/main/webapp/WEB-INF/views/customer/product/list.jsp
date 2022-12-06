<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<section class="products__section">
	<div class="container">
		<div class="row">
		
			<div class="col-lg-12">
				<a class="home" href="<c:url value='/'/>">홈</a>
				<div class="category__selectBox">
					<select id="selectList">
						<c:forEach var="category" items="${categoryList }">
							<option ${param.category1 eq category.product_category1_no ? 'selected' : ''} value="${category.product_category1_no }" ${selected}>
								${category.product_category1_name }
							</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="product__list">
			
				<div class="product__category" id="product__category">
				<c:forEach var="category2" items="${categoryList2 }">
				<c:if test="${!empty param.category2 }">
					<c:set var="selectedList" value="${param.category2 eq category2.product_category2_no ? 'selectedList' : '' }"/>
				</c:if>
					<div>
						<a id="${selectedList }" href="<c:url value="/product/list?category1=${param.category1}&category2=${category2.product_category2_no }" />">
							<span>${category2.product_category2_name }</span>
						</a>
					</div>
				</c:forEach>
				</div>
				<div class="product__bar">
					<div class="category__name">
						<h3 id="category__name"></h3>
					</div>
					<div class="product__order">
						<a href="#">판매완료 포함</a>
						<a href="#">예약중 포함</a>
					</div>
				</div>
				
				<div class="product__area">
				<c:forEach var="product" items="${productList }">
					<div class="product__box">
						<div class="product__img">
							<a href="#"> 
								<img src="${pageContext.request.contextPath}/resources/productImgUpload/2022/11/29/IMG_5403.PNG">
								<!-- 임시 이미지 출력 (수정 예정) -->
							</a>
						</div>
						<div class="product__info__1">
							<div class="product__title">
								<a href="#">${product.product_no} ${product.product_name }</a> <!-- 상품명 -->
							</div>
							<div class="product__info__2">
								<div class="product__price">
									<span><fmt:formatNumber value="${product.product_price }" pattern="#,###"/></span> <!-- 가격 -->
								</div>
								<div class="product__regdate">
									<fmt:formatDate value="${product.product_regdate}" pattern="yyyy.MM.dd"/>
								</div> <!-- regdate -->
							</div>
						</div>
					</div> <!-- product__box -->
				</c:forEach>
				</div> <!-- product__area -->
				
				<div class="paging__container">
						<c:if test="${ph.totalCnt == null || ph.totalCnt == 0 }">
							<div class="no__item">등록된 상품이 없습니다.</div> <!-- 이미지 만들 것 -->
						</c:if>
						
						<c:if test="${ph.totalCnt != null || ph.totalCnt != 0 }">
							<c:if test="${ph.showPrev }">
								<div class="paging__box">
									<a class="paging__href" href="#">&lt;</a>								
								</div>
							</c:if>
							<c:forEach var="i" begin="${ph.beginPage }" end="${ph.endPage }">
								<div class="paging__box">
									<a class="paging__href ${i==ph.sc.page ? 'paging-active' : ''}" href="<c:url value="/product/list${ph.sc.getQueryString(i)} " />">
										${i}
									</a>															
								</div>
							</c:forEach>
							<c:if test="${ph.showNext }">
								<div class="paging__box">
									<a class="paging__href" href="#">&gt;</a>								
								</div>
							</c:if>
						</c:if>
				</div> <!-- product__container -->
				
			</div> <!-- producgt__list -->
			
		</div> <!-- row -->
	</div>
</section>

<script type="text/javascript">
	selectList.onchange=function(){
		const selectList=document.getElementById("selectList");
		const categoryNo=selectList.options[selectList.selectedIndex].value;
		
		location.href="${pageContext.request.contextPath}/product/list?category1="+categoryNo;
	};
	
	function addCategory(){
		const productCategory=document.getElementById("product__category");
		const addCount=(Math.ceil(productCategory.childElementCount/5)*5)-productCategory.childElementCount;
		
		// 동적으로 자식 요소 추가
		for(let i=0; i<addCount; i++){
			productCategory.appendChild(document.createElement('div'));
		}
	};
	
	function addTextNode(){
		let textNode=selectList.options[selectList.selectedIndex].innerText.trim();
		
		if(document.getElementById("selectedList") != null && document.getElementById("selectedList") != ""){
			textNode=document.getElementById("selectedList").innerText.trim();
		}
		
		let headerTag=document.getElementById("category__name");
		headerTag.innerText=textNode;
	};
	
	addCategory();
	addTextNode();
</script>