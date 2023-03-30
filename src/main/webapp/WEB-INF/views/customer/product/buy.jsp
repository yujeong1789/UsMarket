<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/product_buy.css'/>" type="text/css">
<section class="product__buy__section">
	<div class="row">
		<div class="container">
			<form id="buyProductForm" name="buyProduct">
				<input type="hidden" id="deal_no" name="deal_no" readonly required>
				<input type="hidden" id="seller_no" name="seller_no" value="${productOrderInfo.SELLER_NO}" readonly required>
				<input type="hidden" id="product_no" name="product_no" value="${product_no }" readonly required>
				<input type="hidden" id="customer_email" readonly required>
				<ul class="product__buy__ul" >
					<li>
						<div class="title">결제하기</div>
						<div class="product__order__info order__border">
							<div>
								<div class="col-6">상품정보</div>
								<div class="col-3">가격</div>
								<div class="col-3">판매자</div>
							</div>
							<div>
								<div class="col-6">
									<img class="infoLink product_img_path" alt="상품 이미지" src="https://usmarket.s3.ap-northeast-2.amazonaws.com/${productOrderInfo.PRODUCT_IMG_PATH}">
									<div class="infoLink">${productOrderInfo.PRODUCT_NAME}</div>
								</div>
								<div class="col-3"><fmt:formatNumber value="${productOrderInfo.PRODUCT_PRICE }" pattern="#,###"/>원</div>
								<div class="col-3">${productOrderInfo.SELLER_NICKNAME}</div>
							</div>
						</div>
					</li>
					<li>
						<div class="title">배송지</div>
						<div class="product__order__address order__border">
							<div>
								<div class="address-title essential">이름</div>
								<div>
									<input type="hidden" name="customer_no" value="${customer_no}" id="customer_no" readonly="readonly" required="required">
									<input class="w-50" type="text" name="customer_name" id="customer_name" maxlength="20">
								</div>
							</div>
							<div>
								<div class="address-title essential">연락처</div>
								<div class="address-hp">
									<input class="w-50" type="text" id="customer_hp" name="customer_hp" required="required">
								</div>
							</div>
							<div>
								<div class="address-title essential">주소</div>
								<div>
									<div class="d-flex align-items-center mb-2">
										<input class="w-50" type="text" id="customer_zipcode" name="customer_zipcode" readonly="readonly" required="required">
										<button type="button" id="btn_address" >우편번호 찾기</button>
									</div>
									<div class="d-flex flex-column">
										<input class="mb-2" type="text" id="customer_address" name="customer_address" readonly="readonly" required="required">
										<input type="text" id="customer_address_detail" name="customer_address_detail" readonly="readonly" required="required" placeholder="상세주소를 입력해 주세요.">
									</div>
								</div>
							</div>
							<div>
								<div class="address-title">배송 요청사항</div>
								<div>
									<textarea id="deal_delivery_message" name="deal_delivery_message" maxlength="30" placeholder="배송 관련 요청사항을 입력해 주세요. (선택)"></textarea>
								</div>
							</div>
							<div class="mt-5">
								<label class="d-flex align-items-center">
									<input type="checkbox" class="mr-2" id="addressUpdate" name="addressUpdate" value="N">
									<span>입력한 주소로 내 정보를 업데이트합니다.</span>
								</label>
							</div>
						</div>
					</li>
					<li>
						<div class="title">결제금액</div>
						<div class="product__order__report order__border d-flex">
							<div class="w-25">상품금액</div>
							<div class="w-25"><fmt:formatNumber value="${productOrderInfo.PRODUCT_PRICE }" pattern="#,###"/>원</div>
						</div>
					</li>
					<li>
						<div class="title">결제수단</div>
						<div class="product__order__report order__border d-flex">
							<input type="radio" class="mr-2" checked />
							<span class="mr-1">카카오페이</span>
							<img src="<c:url value='/resources/customer/img/payment_icon.png'/>">
						</div>
					</li>
					<li>
						<button class="w-100 buy-submit" id="buy__submit" type="button">결제하기</button>
					</li>
				</ul>
			</form> <!-- form -->
		</div> <!-- container -->
	</div> <!-- row -->
</section> <!-- product__buy__section -->

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	document.addEventListener('DOMContentLoaded', function(){
	
		document.querySelectorAll('.infoLink').forEach(el => {
			el.addEventListener('click', function(e){
				e.target.style.cursor = 'pointer';
				location.href='${pageContext.request.contextPath}/product/info?product_no='+`${productOrderInfo.PRODUCT_NO}`;
			});
		});
		

		// 회원 이름, 연락처 불러오기
		const customer_no = `${customer_no}`;
		fetch('/usMarket/fetch/customerInfo/'+customer_no)
		.then((response) => response.json())
		.then((json) => {
			console.log(json);
			
			var len = Object.keys(json).length;
			document.getElementById('customer_name').value = json.MEMBER_NAME;
			document.getElementById('customer_hp').value = json.MEMBER_HP;
			document.getElementById('customer_email').value = json.MEMBER_EMAIL;
			
			// 우편번호, 주소, 상세주소는 필수 데이터가 아니기 때문에 존재하지 않을 수 있음. 따라서 해당 데이터가 존재할 때만 값을 set
			if(len > 3){
				document.getElementById('customer_zipcode').value = json.MEMBER_ZIPCODE;
				document.getElementById('customer_address').value = json.MEMBER_ADDRESS;
				document.getElementById('customer_address_detail').value = json.MEMBER_ADDRESS_DETAIL;
			}
			
		}).catch((error) => console.log("error: "+error)); // fetch
		
		// 주소 api 호출
		document.getElementById('btn_address').addEventListener('click', function(){
			new daum.Postcode({
				oncomplete: function(data){
					document.getElementById('customer_zipcode').value = data.zonecode;
					document.getElementById('customer_zipcode').style.border = '1px solid #e7e7e7';
					
					document.getElementById('customer_address').value = data.roadAddress;
					
					if(!isEmpty(data.buildingName)){
						document.getElementById('customer_address').value += ' ('+data.buildingName+')'; 
					}
					
					document.getElementById('customer_address').style.border = '1px solid #e7e7e7';
					
					document.getElementById('customer_address_detail').value = '';
					document.getElementById('customer_address_detail').removeAttribute('readonly');
					document.getElementById('customer_address_detail').style.border = '1px solid red';
				}
			}).open();
		});
		
		// 유효성 검증
		// 1. 이름
		document.querySelectorAll('#buyProductForm input[type=text]').forEach(el => {
			el.addEventListener('keyup', function(e){
				valueCheck(el);
			})
		});
		
		
		// 2. 연락처
		// 숫자 이외의 값을 입력할 경우 alert 띄우고 값 제거
		document.getElementById('customer_hp').addEventListener('keyup', function(e){
			const hpRegex = /[^-0-9]/g;
			if (hpRegex.test(e.target.value)) {
				alert('숫자만 입력해 주세요.');
				e.target.value = e.target.value.replace(hpRegex, '');
			}
		});
		
		// 3. 주소
		document.getElementById('buy__submit').addEventListener('click', function(e){
			if(!orderValidate()){
				return;
			}else{
				let deal_no = getOrderNo(10);
				document.getElementById('deal_no').value = deal_no;
				
				let addressUpdate = document.getElementById('addressUpdate');
				if(addressUpdate.checked) addressUpdate.value = 'Y'; 
				
				payment();
			}
		});
		
		
		function orderValidate(){
			var result = true;
			document.querySelectorAll('#buyProductForm input[type=text]').forEach(el => {
				if(el.value.length < 1){
					el.style.border = '1px solid red';
					el.focus();
					result = false;
				}else{
					el.style.border = '1px solid #e7e7e7';
				}
			});
			return result;
		};
		
		function valueCheck(element){
			if(element.value.length < 1){
				element.style.border = '1px solid red';
				element.focus();
				return false;
			}else{
				element.style.border = '1px solid #e7e7e7';
			}
		};
		
		
		// 결제 api 호출
		function payment(data){
			IMP.init('imp88123621');
			IMP.request_pay({
				pg: 'kakaopay.TC0ONETIME',
			    pay_method : 'card',  //생략가
			    merchant_uid: document.getElementById('deal_no').value, //상점에서 생성한 고유 주문번호
			    name : `${productOrderInfo.PRODUCT_NAME}`, // 상품명
			    amount : `${productOrderInfo.PRODUCT_PRICE}`, // 가격
			    buyer_email : document.getElementById('customer_email').value, 
			    buyer_name : document.getElementById('customer_name').value,
			    buyer_tel : document.getElementById('customer_hp').value,
			    buyer_addr : document.getElementById('customer_address').value+' '+document.getElementById('customer_address_detail').value,
			    buyer_postcode : document.getElementById('customer_zipcode').value,
			    m_redirect_url : '${pageContext.request.contextPath}/product/info?product_no='+`${productOrderInfo.PRODUCT_NO}`,
			}, function(rsp){
				if(rsp.success){
					alert('success!');
					
					let params = {
						deal_no: document.getElementById('deal_no').value,
						product_no: document.getElementById('product_no').value,
						seller_no: document.getElementById('seller_no').value,
						customer_no: document.getElementById('customer_no').value,
						customer_name: document.getElementById('customer_name').value,
						customer_hp: document.getElementById('customer_hp').value,
						customer_zipcode: document.getElementById('customer_zipcode').value,
						customer_address: document.getElementById('customer_address').value,
						customer_address_detail: document.getElementById('customer_address_detail').value,
						deal_delivery_message: document.getElementById('deal_delivery_message').value,
					}
					
					// 결제 성공시 fetch api로 db작업
					fetch('/usMarket/fetch/deal/add/'+document.getElementById('addressUpdate').value, {
						method: 'POST',
						headers: {
							'Content-type' : 'application/json'
						},
						body: JSON.stringify(params),
					})
					.then((response) => response.text()) // 서버가 텍스트를 반환하는 경우 response.text()가 적합하다.
					.then((text) => {
						location.href = '${pageContext.request.contextPath}/deal/complete?deal_no='+text;
					}).catch((error) => console.log('error: '+error)); // fetch
					
					
				} else {
					alert(rsp.error_msg);
					location.href='${pageContext.request.contextPath}/product/info?product_no='+`${productOrderInfo.PRODUCT_NO}`;
				}
			});
		}
	});
</script>