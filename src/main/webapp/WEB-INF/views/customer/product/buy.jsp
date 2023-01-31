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
				<input type="hidden" id="deal_no" name="deal_no"  readonly required>
				<input type="hidden" id="product_no" name="product_no" value="${product_no }" readonly required>
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
									<input type="text" class="w-100" id="deal_delivery_message" name="deal_delivery_message" maxlength="30" placeholder="배송 관련 요청사항을 입력해 주세요. (선택)">
								</div>
							</div>
							<div class="mt-5">
								<label class="d-flex align-items-center">
									<input type="checkbox" class="mr-2" id="addressUpdate" name="addressUpdate">
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
							<input type="radio" class="mr-2" name="kakaoPay" id="kakaoPay" checked />
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
			
			// 우편번호, 주소, 상세주소는 필수 데이터가 아니기 때문에 존재하지 않을 수 있음. 따라서 해당 데이터가 존재할 때만 값을 set
			if(len > 2){
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
					document.getElementById('customer_address').value = data.roadAddress;
					
					document.getElementById('customer_address_detail').value = '';
					document.getElementById('customer_address_detail').removeAttribute('readonly');
				}
			}).open();
		});
		
	});
</script>