<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/chat_list.css'/>" type="text/css">
<section class="chat-list-section">
	<div class="row chat-background">
		<div class="container">
			<div class="chat-list-layout">
				<div class="list-div">
					<div class="list-title">
						<span>채팅목록</span>
					</div>
					<div class="list-div-content">
					
						<div class="list-content">
							<a href="#"> <!-- 해당 회원 페이지로 이동 -->
								<img alt="판매자 이미지" src="<c:url value='/resources/customer/img/default_profile.png' />">
							</a>
							<div class="list-content-1">
								<div class="list-content-left">
									<div class="title">닉네임</div>
									<div class="content">어쩌구 저쩌구</div>
								</div>
								<div class="list-content-right"></div>
							</div>
						</div>
						
					</div> <!-- list-div-content -->
				</div>
				<div class="info-div">
					<div class="info-title">
						<span>닉네임</span>
					</div>
					<div class="info-content-layout">
						<div class="info-content">
							<div class="left">
								<p class="chat-content">Lorem ipsum dolor sit amet, consectetur adipisicing elit</p>
							</div>
						</div>
						<div class="info-content">
							<div class="right">
								<p class="chat-content">Lorem ipsum</p>
							</div>
						</div>
					</div>
					<div class="info-textarea">
						<div class="textarea">
							<textarea id="chat_content" maxlength="2000" placeholder="메세지를 입력해 주세요."></textarea>
							<div class="btn_send">
								<img alt="전송" src="<c:url value='/resources/customer/img/img_send.png' />">
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function(){
	
	document.getElementById('chat_content').addEventListener('keyup', function(){
		if(this.value.length > 0){
			document.querySelector('.btn_send').style.visibility = 'visible';
		}else{
			document.querySelector('.btn_send').style.visibility = 'hidden';
		}
	});
	
});
</script>