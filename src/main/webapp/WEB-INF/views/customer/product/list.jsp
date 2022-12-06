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
							${category2.product_category2_name }
						</a>
					</div>
				</c:forEach>
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
								<a href="#">${product.product_name }</a> <!-- 상품명 -->
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
				
				<div class="product__container">
					<div class="paging">
						<!-- 페이징 영역 (완성 예정) -->
						<a href="#">&lt;</a>
						<a href="#">1</a>
						<a href="#">2</a>
						<a href="#">3</a>
						<a href="#">4</a>
						<a href="#">5</a>
						<a href="#">&gt;</a>
					</div>
				</div> <!-- product__container -->
				
			</div> <!-- producgt__list -->
			
		</div> <!-- row -->
	</div>
</section>

<script type="text/javascript">
	selectList.onchange=function(){
		const selectList=document.getElementById("selectList");
		const categoryNo=selectList.options[selectList.selectedIndex].value
		location.href="${pageContext.request.contextPath}/product/list?category1="+categoryNo;
	};
	
	const productCategory=document.getElementById("product__category");
	const addCount=(Math.ceil(productCategory.childElementCount/5)*5)-productCategory.childElementCount;
	
	// 동적으로 자식 요소 추가
	for(let i=0; i<addCount; i++){
		productCategory.appendChild(document.createElement('div'));
	}
</script>