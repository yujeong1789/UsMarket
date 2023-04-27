<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix='form' uri="http://www.springframework.org/tags/form"%>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/product_sell.css'/>" type="text/css">
<section class="product__sell__section">
	<div class="row">
		<div class="container">
			<div class="product__sell__info">
				<h2>기본정보</h2>
				<span>*필수항목</span>
			</div>
			
			<form id="addProductForm" name="addProduct" action="<c:url value='/product/sell'/>" method="post" enctype="multipart/form-data">
				<input type="hidden" id="product_no" name="product_no" readonly required>
				<ul class="product__sell__ul">
					<li>
						<div class="product__sell__title essential">상품이미지</div>
						
						<div class="product__sell__input">
							<div class="product__sell__file" id="product__sell__file"> 
								<input type="file" id="product_img" name="product_img" accept="image/jpg, image/jpeg, image/png"/>
							</div>
							<div class="product__input__warning" id="product__sell__file_warning" data-target="product__sell__file" data-status="not">하나 이상의 사진을 업로드해 주세요.</div>
							<div class="length__check">
								<span id="current__file__length">0</span>/5
							</div>
							<div class="product__img__preview" id="product__img__preview"></div>
							
						</div>
					</li>
					<li>
						<div class="product__sell__title essential">제목</div>
						
						<div class="product__sell__input">
							<input class="input__font text" id="product_name" name="product_name" type="text" maxlength="40" 
								placeholder="상품 제목을 입력해 주세요. (공백 제외 2글자 이상)"/>
							
							<div class="product__input__warning" id="product_name_warning" data-target="product_name" data-status="not">공백 제외 2글자 이상 입력해 주세요.</div>
							
							<div class="length__check">
								<span id="current__name__length">0</span>/40
							</div>
						</div>
					</li>
					<li>
						<div class="product__sell__title essential">카테고리</div>
						<div class="product__sell__input category" id="product__sell__input__category">
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
						<div class="category__input__warning">
							<div class="product__input__warning" id="product_category_warning"  data-target="product__sell__input__category" data-status="not">카테고리를 선택해 주세요.</div>
						</div>
						<div class="selected__category__display" id="selected__category__display">
							<span>선택한 카테고리:</span>
							<span id="selected__category__1"></span>
							<span id="selected__category__2"></span>
							
							<input type="hidden" id="product_category1_no" name="product_category1_no" value="" readonly required>
							<input type="hidden" id="product_category2_no" name="product_category2_no" value="" readonly required>
						</div>
					</li>
					<li>
						<div class="product__sell__title essential">상태</div>
						
						<div class="product__sell__radio">
							<label>
								<input type="radio" name="product_used" id="product_used" value="Y" checked />
								<span>중고상품</span>
							</label>
							<label>
								<input type="radio" name="product_used" id="product_used" value="N" />
								<span>새상품</span>
							</label>
						</div>
					</li>
					<li>
						<div class="product__sell__title essential">교환</div>
						
						<div class="product__sell__radio">
							<label>
								<input type="radio" name="product_change" id="product_change" value="Y" checked />
								<span>교환가능</span>
							</label>
							<label>
								<input type="radio" name="product_change" id="product_change" value="N" />
								<span>교환불가</span>
							</label>
						</div>
					</li>
					<li>
						<div class="product__sell__title essential">가격</div>
						
						<div class="product__sell__input">
							<input class="input__font price" id="product_price" name="product_price" type="text" placeholder="숫자만 입력해 주세요."/> 원
							<div class="product__input__warning" id="product_price_warning" data-target="product_price" data-status="not">100원 이상, 100억원 미만의 상품만 거래할 수 있습니다.</div>
						</div>
					</li>
					<li>
						<div class="product__sell__title essential">설명</div>
						
						<div class="product__sell__input">
							<textarea class="input__font" id="product_explanation" name="product_explanation" rows="6" maxlength="2000"  data-status="" placeholder="구입 연도, 사용감, 하자 여부 등 필요한 정보를 작성해 주세요. (10글자 이상)"></textarea>
							
							<div class="product__input__warning" id="product_explanation_warning" data-target="product_explanation" data-status="not">10글자 이상 입력해 주세요.</div>
							
							<div class="length__check">
								<span id="current__explanation__length">0</span>/2000
							</div>
						</div>
					</li>
					<li>
						<div class="product__sell__title">연관태그</div>
						
						<div class="product__sell__input">
							<input class="input__font text" id="product_tag" name="product_tag" maxlength="10" type="text" placeholder="태그는 띄어쓰기를 기준으로 구분되며, 최대 5개까지 추가할 수 있습니다. (10글자 이하)"/>
						</div>
						<div class="added__tags" id="added__tags"></div>
					</li>
				</ul>
				<div class="product__sell__submit">
					<button class="site-btn" id="sell__submit" type="button">등록하기</button>
				</div>
			</form> <!-- form -->
			
		</div> <!-- container -->
	</div> <!-- row -->
</section> <!-- product__sell__section -->

<script src="<c:url value='/resources/customer/js/product_sell.js'/>"></script>
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
				setDisplayCategory1(this);
				fetch('/usMarket/fetch/category2/'+e.target.value)
					.then((response) => response.json())
					.then((json) => {
						// 카테고리1이 선택되어 카테고리2가 로드되었을 시점에 스타일 적용 및 초기화
						document.getElementById('product_category_warning').innerText = '소분류를 선택해 주세요.';
						document.getElementById('product_category_warning').style.display = 'block';
						setBlank();
						json.forEach((el) => {
							let category2_li = document.createElement('li');
							category2_li.textContent = el.PRODUCT_CATEGORY2_NAME;
							category2_li.setAttribute('value', el.PRODUCT_CATEGORY2_NO);
							category2__ul.appendChild(category2_li);
							
							category2_li.addEventListener('click', function(e){
								setDisplayCategory2(this);
							}); // addEventListner
						}); // forEach
					}).catch((error) => console.error('error: '+error));
					
			}); // addEventListner
		}); // forEach
	}).catch((error) => console.error('error: '+error));
}); // DOMContentLoaded
	
	
// 상품명
document.getElementById('product_name').addEventListener('input', function(e){
	setBorder(this, lengthCheck(this.value.replace(/(\s*)/g,'').length, 2, 40));
	document.getElementById('current__name__length').innerText = this.value.replace(/(\s*)/g,'').length;
});


// 상품 가격
document.getElementById('product_price').addEventListener('input', function(e){
	priceRegexCheck(this);
	setBorder(this, lengthCheck(this.value, 100, 1000000000));
});


// 상품 설명
document.getElementById('product_explanation').addEventListener('input', function(e){
	// 높이 조절
	this.style.height = 'auto';
	this.style.height = this.scrollHeight + 'px';
	
	setBorder(this, lengthCheck(this.value.length, 10, 2000));
	document.getElementById('current__explanation__length').innerText = this.value.length;
});


// 상품 태그
document.getElementById('product_tag').addEventListener('keyup', function(e){
	if(e.keyCode == 32){ // space bar 입력되면 글자 수 검사
		let currentValue = e.target.value.trim();
		e.target.value = '';
		if(lengthCheck(currentValue.length, 1, 10) && document.getElementById('added__tags').childElementCount < 5){
			// 공백 제외 1~10글자면 입력된 태그 div로 추가
			setTag(currentValue);
			console.log('pass');
		}
		console.log(currentValue.length);
	}
});


// 입력된 태그 보여주는 함수
function setTag(value) {
	const parentTag = document.createElement('div');
	
	const tagContent = document.createElement('span');
	tagContent.className = 'tag__content';
	tagContent.innerText = value;
	
	parentTag.appendChild(tagContent);
	
	const tagDelete = document.createElement('img');
	tagDelete.className = 'tag__delete';
	tagDelete.setAttribute('src', '${pageContext.request.contextPath}/resources/customer/img/delete_icon.png');
	
	parentTag.appendChild(tagDelete);

	tagDelete.addEventListener('click', function(e) {
		e.target.parentNode.remove();
	});
	document.getElementById('added__tags').appendChild(parentTag);
};


// 상품 등록
document.getElementById('sell__submit').addEventListener('click', function(e){
	if(!displayWarning()){
		return;			
	}
	
	if(confirm('상품을 등록하시겠습니까?')){
		document.getElementById('product_no').value = getCurrentDate(); 
		
		const addedTags = document.querySelectorAll('.tag__content');
		addedTags.forEach((el, i) => {
			document.getElementById('product_tag').value += el.innerText;
			if(i < addedTags.length - 1){
				document.getElementById('product_tag').value += ' ';	
			}
		})
		init(fileArray);
		
		let formData = new FormData(document.getElementById('addProductForm'));
		
		fetch('/usMarket/fetch/product/sell', {
			method: 'POST',
			body: formData
		})
		.then((response) => response.text())
		.then((text) => {
			if(isEmpty(text)){
				alert('상품 등록에 실패했습니다.');
				location.reload();
			}else{
				alert('상품이 등록되었습니다.');
				location.replace('${pageContext.request.contextPath}/product/info?product_no='+text);
			}
		}).catch((error) => console.error('error: '+error));
	}
});


function displayWarning(){
	var result = true;
	
	const warningElements = document.querySelectorAll('.product__input__warning');
	warningElements.forEach((el) => {
		if(el.getAttribute('data-status') != 'pass'){
			el.style.display = 'block';
			document.getElementById(el.getAttribute('data-target')).style.border = '2px solid red';
			
			result = false;
		}
	});
	console.log(result);
	return result;
};


const fileArray = new Array();
document.getElementById('product_img').addEventListener('change', function(e){
	var maxSize = 5 * 1024 * 1024;
	
	if(fileArray.length > 4){
		alert('첨부파일은 최대 5개까지 등록 가능합니다.');
		this.value = '';
	}else if(this.files[0].size > maxSize){
		alert('첨부파일 사이즈는 5MB 이내로 등록 가능합니다.');
		this.value = '';
	} else{ 
		// 파일 사이즈 유효성 검사 통과하면 미리보기 함수 호출
		console.log('file size pass');
		loadImg(this);
	}	
});


// 업로드된 파일 객체를 배열에 할당
function loadImg(value){
	if(value.files && value.files[0]){
		fileArray.push(value.files[0]);
		let reader = new FileReader();
		console.log('file name = '+value.files[0].name);
		let node = document.createElement('div');
		
		reader.onload = function(e){
			let tmp = '<img class=file__img__preview src='+e.target.result+' /><img class=file__img__delete src=${pageContext.request.contextPath}/resources/customer/img/delete_icon.png data-idx='+value.files[0].lastModified+' />';
			node.innerHTML = tmp;
			
			node.querySelector('.file__img__delete').addEventListener('click', function(e){
 				const idx = Array.from(document.getElementById('product__img__preview').children).indexOf(e.target.parentElement);
 				console.log('target index = '+idx);
 				fileArray.splice(idx, 1);
 				document.getElementById('current__file__length').innerText = fileArray.length;
 				setBorder(document.getElementById('product__sell__file'), lengthCheck(document.getElementById('current__file__length').innerText, 1, 5));
 				node.remove();
			}); // delete click event
 			document.getElementById('product__img__preview').appendChild(node);
			document.getElementById('product_img').value = '';
		}; // onload
		reader.readAsDataURL(value.files[0]);
	} // if
	document.getElementById('current__file__length').innerText = fileArray.length;
	setBorder(document.getElementById('product__sell__file'), lengthCheck(document.getElementById('current__file__length').innerText, 1, 5));
}; // loadImg


// submit 전 파일 저장된 배열을 filelist에 할당
function init(fileArray){
	const dataTransfer = new DataTransfer();
	fileArray.forEach(file => {
		dataTransfer.items.add(file);
		console.log(file);
	});
	document.getElementById('product_img').files = dataTransfer.files;
}; // init
</script>