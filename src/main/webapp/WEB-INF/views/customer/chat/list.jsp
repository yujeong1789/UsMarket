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
					</div>
				</div>
				<div class="info-div">
					<div class="info-title">
						<span id="chat_to_nickname"></span>
						<input type="text" name="room_no" id="room_no">
						<input type="text" name="room_no" id="chat_to">
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
		setTimeout(() => {
			var tmp_room = `${room_no}`;
			document.querySelector('[data-room="'+tmp_room+'"]').click();
		}, 500);
	}
	
	
	// 입력창 이벤트
	document.getElementById('chat_content').addEventListener('keyup', function(event){
		if(this.value.trim().length > 0){
			document.querySelector('.btn_send').style.visibility = 'visible';
			if(event.keyCode == 13){
				event.preventDefault();
				document.querySelector('.btn_send').click();
			}
		}else{
			document.querySelector('.btn_send').style.visibility = 'hidden';
		}
	});
	
	document.querySelector('.btn_send').addEventListener('click', function(){
		console.log('btn click');
		sendMessage();
	});
	
	
	// 채팅방 list 얻기
	function getChatList(user_no){
		fetch('/usMarket/fetch/chatlist')
		.then((response) => response.json())
		.then((json) => {
			document.querySelector('.list-div-content').replaceChildren(); // list 초기화
			console.log(json);
			json.forEach((el, i) => {
				let chatList_ = setChatList(el);
				
				chatList_.addEventListener('click', function(e){
					document.getElementById('room_no').value = el.ROOM_NO;
					document.getElementById('chat_to').value = el.CHAT_TO;
					initChatInfo(this);
					getChatInfo(el.ROOM_NO, this.getAttribute('data-read'));
				});
				document.querySelector('.list-div-content').appendChild(chatList_);
			});
		}).catch((error) => console.log('error: '+error));
	}
	
	function initChatInfo(element){
		element.childNodes[1].childNodes[1].style.visibility = 'hidden';
		document.getElementById('chat_to_nickname').innerHTML = '';
		document.querySelector('.info-textarea').style.visibility = 'visible';
		document.getElementById('chat_content').value = '';
		document.querySelector('.btn_send').style.visibility = 'hidden';
		document.querySelector('.info-content-layout').replaceChildren();
	} 
	
	function setChatList(el){
		let parentDiv = document.createElement('div');
		parentDiv.className = 'list-content';
		parentDiv.setAttribute('data-room', el.ROOM_NO);
		
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
		
		let list_content_right = document.createElement('div');
		list_content_right.className = 'list-content-right';
		list_content_1.appendChild(list_content_right);
		
		parentDiv.appendChild(list_content_1);
		
		if(el.CHAT_READ == 'N'){
			list_content_right.style.visibility = 'visible';
			parentDiv.setAttribute('data-read', 'N');
		} else {
			list_content_right.style.visibility = 'hidden';
			parentDiv.setAttribute('data-read', 'Y');
		}
		
		return parentDiv;
	}
	
	// 채팅내역 얻기
	function getChatInfo(room_no, is_read){
		fetch('/usMarket/fetch/chatinfo', {
			method: 'POST',
			headers: {
				'Content-type' : 'application/json'
			},
			body: JSON.stringify({
				room_no: room_no,
				is_read: is_read,
			}),
		})
		.then((response) => response.json())
		.then((json) => {
			console.log(json);
			
			document.querySelector('.info-content-layout').replaceChildren(); // 채팅내역 로드된 시점에 info 다시 초기화
			document.querySelector('[data-room="'+room_no+'"]').setAttribute('data-read', 'Y');
			document.getElementById('chat_to_nickname').textContent = document.querySelector('[data-room="'+room_no+'"] .title').textContent;
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
	
	function sendMessage(){
		let params = {
			room_no: document.getElementById('room_no').value,
			chat_to: document.getElementById('chat_to').value,
			chat_content: document.getElementById('chat_content').value.replace(/<[^>]*>?/g, '').slice(0, -1),
		}
		
		document.getElementById('chat_content').value = '';
		document.querySelector('.btn_send').style.visibility = 'hidden';
		
		fetch('/usMarket/fetch/chat/send', {
			method: 'POST',
			headers: {
				'Content-type' : 'application/json'
			},
			body: JSON.stringify(params),
		})
		.then((response) => response.json())
		.then((json) => {
			getChatList(current_no);
			document.querySelector('[data-room="'+json.room_no+'"]').click();
			// click()으로 전체 채팅 불러오지 말고 안 읽은 채팅만 추가적으로 불러오도록 수정할 것
		}).catch((error) => console.log('error: '+error));
	}
});
</script>