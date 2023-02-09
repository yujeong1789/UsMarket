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
					<div class="list-div-content"></div>
				</div>
				<div class="info-div">
					<div class="info-title">
						<span id="chat_to_nickname"></span>
					</div>
					<div class="info-content-layout"></div>
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
	const current_no = document.getElementById('loginNo').getAttribute('data-no');
	
	getChatList(current_no);
	
	// info에서 이동했을 경우 해당 채팅방 띄우기 (새로 추가된 경우, 이미 존재하는 경우 모두 동일함)
	if(`${condition}` == 'open'){
		console.log('open');
		getChatInfo(`${room_no}`);
		getNickName(`${chat_from}`);
	} 
	
	// 입력창 이벤트
	document.getElementById('chat_content').addEventListener('keyup', function(){
		if(this.value.length > 0){
			document.querySelector('.btn_send').style.visibility = 'visible';
		}else{
			document.querySelector('.btn_send').style.visibility = 'hidden';
		}
	});
	

	// 회원 닉네임 얻기 (사진 얻어오는 로직도 추가할 것)
	function getNickName(user_no){
		fetch('/usMarket/fetch/nickname/'+user_no)
		.then((response) => response.text())
		.then((text) => {
			setTextContent(document.getElementById('chat_to_nickname'), text);
		}).catch((error) => console.log('error: '+error));
	}
	
	// 채팅방 list 얻기
	function getChatList(user_no){
		fetch('/usMarket/fetch/chatlist/'+current_no)
		.then((response) => response.json())
		.then((json) => {
			document.querySelector('.list-div-content').replaceChildren(); // list 초기화
			json.forEach((el, i) => {
				let chatList_ = setChatList(el);
				chatList_.addEventListener('click', function(e){
					document.querySelector('.info-content-layout').replaceChildren();
					getChatInfo(el.ROOM_NO);
					document.getElementById('chat_to_nickname').textContent = el.MEMBER_NICKNAME;
				});
				document.querySelector('.list-div-content').appendChild(chatList_);
			});
		}).catch((error) => console.log('error: '+error));
	}
	
	function setChatList(el){
		let parentDiv = document.createElement('div');
		parentDiv.className = 'list-content';
		
		let img = document.createElement('img');
		img.setAttribute('src', '${pageContext.request.contextPath}/resources/customer/img/default_profile.png');
		parentDiv.appendChild(img);
		
		let list_content_1 = document.createElement('div');
		list_content_1.className = 'list-content-1';
		
		let list_content_left = document.createElement('div');
		list_content_left.className = 'list-content-left';
		
		let title = document.createElement('div');
		title.className = 'title';
		title.textContent = el.MEMBER_NICKNAME;
		list_content_left.appendChild(title);
		
		let content = document.createElement('div');
		content.className = 'content';
		content.textContent = el.CHAT_CONTENT;
		list_content_left.appendChild(content);
		
		list_content_1.appendChild(list_content_left);
		
		if(el.CHAT_READ == 'N'){
			let list_content_right = document.createElement('div');
			list_content_right.className = 'list-content-right';
			list_content_1.appendChild(list_content_right);
		}
		
		parentDiv.appendChild(list_content_1);
		
		return parentDiv;
	}
	
	// 채팅내역 얻기
	function getChatInfo(room_no){
		fetch('/usMarket/fetch/chatinfo/'+room_no)
		.then((response) => response.json())
		.then((json) => {
			document.querySelector('.info-content-layout').replaceChildren(); // 채팅내역 로드된 시점에 info 다시 초기화
			json.forEach((el, i) => {
				document.querySelector('.info-content-layout').appendChild(setChatInfo(el));
			});
		}).catch((error) => console.log('error: '+error));
	}
	
	function setChatInfo(el){
		let parentDiv = document.createElement('div');
		parentDiv.className = 'info-content';
		
		let childDiv = document.createElement('div');
		
		if(current_no == el.chat_from){
			childDiv.className = 'right';
		} else {
			childDiv.className = 'left';
		}
		
		let p = document.createElement('p');
		p.className = 'chat-content';
		p.textContent = el.chat_content;
		childDiv.appendChild(p);
		
		parentDiv.appendChild(childDiv);
		
		return parentDiv;
	}
	
	// 특정 element의 textContent를 변경
	function setTextContent(element, text){
		element.textContent = text;
	}
	
});
</script>