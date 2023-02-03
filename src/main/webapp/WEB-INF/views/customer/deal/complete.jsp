<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/deal_complete.css'/>" type="text/css">
<section class="deal__complete__section">
	<div class="row">
		<div class="container">
			<div class="deal-complete-container">
				<div>
					<h2>주문이 완료되었습니다.</h2>
				</div>
				<div class="deal-no">
					<span>주문번호</span><span>${param.deal_no }</span>
				</div>
				<div class="deal-btns">
					<div class="btn-home">
						<span>홈으로</span>
					</div>
					<div class="btn-deal-info">
						<span>주문내역</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function(){
		document.querySelector('.btn-home').addEventListener('click', function(){
			location.href = '${pageContext.request.contextPath}/';
		});
		
		document.querySelector('btn-deal-info').addEventListener('click', function(){
			console.log('마이페이지 - 주문내역으로 이동');
		});
	});
</script>