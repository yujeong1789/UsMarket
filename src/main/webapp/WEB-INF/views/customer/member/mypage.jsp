<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/member_mypage.css'/>" type="text/css">

<section class="member_info_section">
	<div class="container">
		<div class="row">
			<div class="member_info">
				<!-- 회원 정보 영역 -->
				<div class="member_info_img">
					<input type="file" id="profile" name="member_profile_image" accept="image/jpg, image/jpeg, image/png" style="display:none;"/>
					<input type="image" id="profile_image" name="member_image" style="display:none;"/>
					<label for="profile" style="width:100%">
						<img id="profile_img" alt="프로필 이미지" src="<c:url value=${member_image }/>" 
						style="display:block; margin:auto; height:100px; border: 1px solid #999999; border-radius: 50%;">
					</label>
					<div class="member_nickname">
						<c:out value="${member_nickname }"/>
					</div>
				</div>
				
				<c:choose>
					<c:when test="${productInfo.PRODUCT_STATE_NO != 1 }"> 
						<!-- 판매 중이 아닌 상품일 경우 -->
						<div class="member_not">
							<span>현재 회원이 아닙니다.</span>
						</div>
					</c:when>
					<c:otherwise>
					<div class="member_info_div">
						<div class="member_nickname">
							<c:out value="${member_nickname }"/>
						</div>
							<div class="member_detail">
								<div class="member_status">
									<div class="member_ragdate">상점 오픈일 : </div>
									<span><c:out value="${member_regdate }"/></span>
								</div>
								<div class="member_status">
									<div class="member_name">이름 : </div>
									<span><c:out value="${member_name }"/></span>
								</div>
								<div class="member_status">
									<div class="member_id">아이디 : </div>
									<span><c:out value="${member_id }"/></span>
								</div>
								<div class="member_status">
									<div class="member_email">이메일 : </div>
									<span><c:out value="${member_email }"/></span>
								</div>
								<div class="member_status">
									<div class="member_hp">전화번호 : </div>
									<span><c:out value="${member_hp }"/></span>
								</div>					
								<div class="left">
									<div class="member__detail__icon">
										<img alt="신고하기" src="<c:url value='/resources/customer/img/report.png'/>">
									</div>
									<span id="member_report">신고하기</span>
								</div>
							</div>  <!-- member_detail -->
						</div> <!-- member_info_div -->
					</c:otherwise>
				</c:choose>
			</div><!-- member_info -->
			
			<div class="member_content_layout">
				<div class="product__buttons" id="product__buttons">
					<div id="btn__wish" data-url="/product/like?product_no=${productInfo.PRODUCT_NO}">
						<img id="bookmark__status" alt="찜" src="<c:url value='/resources/customer/img/wish_icon_0.png' />">
						<span>찜</span>
						<span><c:out value="${productInfo.BOOKMARK_COUNT }"/></span>
					</div>
					<div id="btn__chat">
						<span>채팅하기</span>
						<form id="addChatRoomForm" method="post" action="<c:url value='/chat/add'/>">
							<input type="hidden" name="seller_no">
							<input type="hidden" name="product_name">
							<input type="hidden" name="seller_nickname">
						</form>
					</div>
					<div id="btn__buy">
						<span>바로구매</span>
						<form id="productBuyForm" method="post" action="<c:url value='/product/buy'/>">
							<input type="hidden" name="product_no">
						</form>
					</div>
				</div>
				<div></div>
			</div> <!-- member_content_layout -->
		</div>
	</div>
</section>

<script src="<c:url value='/resources/customer/js/product_info.js'/>"></script>
<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function(){
		
		
	});
	
	
</script>
