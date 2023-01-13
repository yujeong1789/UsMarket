<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix='form' uri="http://www.springframework.org/tags/form"%>

<link rel="stylesheet"
	href="<c:url value='/resources/customer/css/product_sell.css'/>"
	type="text/css">
<section class="product__sell__section">
	<div class="row">
		<div class="container">
			<div class="product__sell__info">
				<h2>기본정보</h2>
				<span>*필수항목</span>
			</div>
			
			<form name="addProduct">
				<ul class="product__sell__ul">
					<li>
						<div class="product__sell__title essential">상품이미지</div>
						
						<div class="product__sell__input">
							이미지 업로드 api 적용 예정
						</div>
					</li>
					<li>
						<div class="product__sell__title essential">제목</div>
						
						<div class="product__sell__input">
							<input class="input__font text" type="text" />
							<div class="length__check first">
								<span id="current__title__length">0</span>/<span id="max__title__length">40</span>
							</div>
						</div>
					</li>
					<li>
						<div class="product__sell__title essential">카테고리</div>
						<div class="product__sell__input category">
							<div class="sell__category__ul" id="sell__category1">
								<ul id="category1__ul"></ul>
							</div>
							<div class="sell__category__ul" id="sell__category2">
								<div class="category2__alert" id="category2__alert">
									<span>소분류 선택</span>
								</div>
								<ul id="category2__ul"></ul>
							</div>
						</div>
						<div class="selected__category__display" id="selected__category__display">
							<span>선택한 카테고리:</span>
							<span id="selected__category__1"></span>
							<span id="selected__category__2"></span>
							
							<!-- 확인용, 추후 hidden으로 변경 -->
							<input style="width: 50px;" type="text" id="product_category1_no" name="product_category1_no" value="">
							<input style="width: 50px;" type="text" id="product_category2_no" name="product_category2_no" value="">
							
						</div>
					</li>
					<li>
						<div class="product__sell__title essential">상태</div>
						
						<div class="product__sell__radio">
							<label>
								<input type="radio" value="Y" checked />
								<span>중고상품</span>
							</label>
							<label>
								<input type="radio" value="N" />
								<span>새상품</span>
							</label>
						</div>
					</li>
					<li>
						<div class="product__sell__title essential">교환</div>
						
						<div class="product__sell__radio">
							<label>
								<input type="radio" value="N" checked />
								<span>교환가능</span>
							</label>
							<label>
								<input type="radio" value="Y" />
								<span>교환불가</span>
							</label>
						</div>
					</li>
					<li>
						<div class="product__sell__title essential">가격</div>
						
						<div class="product__sell__input">
							<input class="input__font price" type="text" placeholder="숫자만 입력해 주세요."/>
							원
						</div>
					</li>
					<li>
						<div class="product__sell__title essential">설명</div>
						
						<div class="product__sell__input">
							<textarea class="input__font" rows="6" placeholder="구입 연도, 사용감, 하자 여부 등 필요한 정보를 작성해 주세요. (10글자 이상)"></textarea>
							<div class="length__check">
								<span id="current__content__length">0</span>/<span id="max__content__length">2000</span>
							</div>
						</div>
					</li>
					<li>
						<div class="product__sell__title">연관태그</div>
						
						<div class="product__sell__input">
							<input class="input__font text" type="text" />
						</div>
					</li>
				</ul>
				<div class="product__sell__submit">
					<button type="button" class="site-btn">등록하기</button>
				</div>
			</form> <!-- form -->
			
		</div> <!-- container -->
	</div> <!-- row -->
</section> <!-- product__sell__section -->
<script type="text/javascript">

	document.addEventListener('DOMContentLoaded', function(){
		
		const category1__ul = document.getElementById('category1__ul');
		const category2__ul = document.getElementById('category2__ul');
		
		const product_category1_no = document.getElementById('product_category1_no');
		const product_category2_no = document.getElementById('product_category2_no');
		
		fetch("/usMarket/fetch/category")
		.then((response) => response.json())
		.then((json) => {
			json.forEach((el) => {
				let category1_li = document.createElement('li');
				category1_li.textContent = el.PRODUCT_CATEGORY1_NAME;
				category1_li.setAttribute('value', el.PRODUCT_CATEGORY1_NO);
				category1__ul.appendChild(category1_li);
				
				category1_li.addEventListener('click', function(e) {
					setDisplayCategory1(e.target);
					
					
					fetch('/usMarket/fetch/category2/'+e.target.value)
						.then((response) => response.json())
						.then((json) => {
							json.forEach((el) => {
								let category2_li = document.createElement('li');
								category2_li.textContent = el.PRODUCT_CATEGORY2_NAME;
								category2_li.setAttribute('value', el.PRODUCT_CATEGORY2_NO);
								category2__ul.appendChild(category2_li);
								
								category2_li.addEventListener('click', function(e){
									setDisplayCategory2(e.target);
								}); // addEventListner
							}); // forEach
						}).catch((error) => console.log("error: "+error)); // fetch-2
						
				}); // addEventListner
				
			}); // forEach
		}).catch((error) => console.log("error: "+error)); // fetch-1
		
		
	});
	
	
	function setDisplayCategory1(element){
		setBlank();
		document.getElementById('category2__alert').style.display = 'none';
		product_category1_no.value = element.getAttribute('value');
		console.log('category1 input value = '+product_category1_no.value);
		document.getElementById('selected__category__display').style.display = 'flex';
		document.getElementById('selected__category__1').className = 'selected__category';
		document.getElementById('selected__category__1').innerText = element.innerText;
	}
	
	function setBlank(){
		category2__ul.innerHTML = '';
		product_category2_no.value = '';
		document.getElementById('selected__category__2').style.display = 'none';
	}
	
	function setDisplayCategory2(element){
		product_category2_no.value = element.getAttribute('value');
		console.log('category2 input value = '+product_category2_no.value);
		document.getElementById('selected__category__2').style.display = 'flex';
		document.getElementById('selected__category__2').className = 'selected__category';
		document.getElementById('selected__category__2').innerText = element.innerText;
	}
</script>