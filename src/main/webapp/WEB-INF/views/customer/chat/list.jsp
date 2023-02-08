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
						<span id="chat_to_nickname"></span>
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
<script type="text/javascript" charset="utf-8">
document.addEventListener('DOMContentLoaded', function(){
	const condition = `${condition}`; // 새로 생성되었을 경우 add, 이미 존재하면 기존 채팅방 띄우기
	console.log(condition);
	
	document.getElementById('chat_content').addEventListener('keyup', function(){
		if(this.value.length > 0){
			document.querySelector('.btn_send').style.visibility = 'visible';
		}else{
			document.querySelector('.btn_send').style.visibility = 'hidden';
		}
	});
		
	// 1. 새로 생성되었을 경우 새 채팅방 띄우기
	if(condition == 'add'){
		console.log(`${chat_from}`);
		console.log(`${chat_to}`);
		// getNickName(`${chat_to}`);
		
	}
	
	// 회원 닉네임 얻기
	function getNickName(user_no){
		fetch('/usMarket/fetch/nickname/'+user_no)
		.then((response) => response.text())
		.then((text) => {
			console.log(text);
			setTextContent(document.getElementById('chat_to_nickname'), text);
		}).catch((error) => console.log('error: '+error));
	}
	
	// 특정 element의 textContent를 변경
	function setTextContent(element, text){
		element.textContent = text;
	}
});
</script>