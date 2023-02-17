<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.spring.usMarket.utils.TimeConvert"%>

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
					
					<c:if test="${!empty chatList }">
						<c:forEach var="chatList" items="${chatList }">
							<div class="list-content" data-room="${chatList.ROOM_NO}" data-read="${chatList.CHAT_READ eq 'N' ? chatList.CHAT_READ : 'Y'}" data-to="${chatList.CHAT_TO}">
								<c:set var="member_image" value="${empty chatList.MEMBER_IMAGE || chatList.MEMBER_IMAGE eq '' ? '/resources/customer/img/default_profile.png' : chatList.MEMBER_IMAGE}"/>
								<img src="<c:url value='${member_image }'/>">
								<div class="list-content-1">
									<div class="list-content-left">
										<div class="title">
											<p>${chatList.MEMBER_NICKNAME}</p>
											<p>${TimeConvert.calculateTime(chatList.CHAT_TIME)}</p>
										</div>
										
										<div class="content">
											<p>${chatList.CHAT_CONTENT}</p>
										</div>
									</div>
									<div class="list-content-right"></div>
								</div>
							</div>
						</c:forEach>
					</c:if>
					
					</div>
				</div>
				<div class="info-div">
					<div class="info-title">
						<form id="formMyPage" method="post" action="<c:url value='/member/mypage'/>">
							<input type="hidden" id="chat_to" name="member_no">
						</form>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script type="text/javascript">

const current_no = document.getElementById('loginNo').getAttribute('data-no');
const chatList = document.querySelectorAll('.list-content');
let listOrder = -1; 

chatList.forEach(el => {
	el.addEventListener('click', function(){
		if(document.querySelector('[data-open="Y"]')){
			document.querySelector('[data-open="Y"]').removeAttribute('data-open');
		}
		initChatInfo(this);
		getChatInfo(this.getAttribute('data-room'), this.getAttribute('data-read'));
	});
});


function initChatInfo(element){
	element.setAttribute('data-open', 'Y');
	document.getElementById('chat_to').value = element.getAttribute('data-to');
	document.getElementById('chat_to_nickname').innerHTML = '';
	document.querySelector('.info-textarea').style.visibility = 'visible';
	document.getElementById('chat_content').value = '';
	document.querySelector('.btn_send').style.visibility = 'hidden';
	document.querySelector('.info-content-layout').replaceChildren();
}


if(`${room_no}` != ''){
	var tmp_room = `${room_no}`;
	document.querySelector('[data-room="'+tmp_room+'"]').click();
}


//채팅내역 얻기
function getChatInfo(room_no, is_read){
	console.log('getChatInfo room_no, is_read = '+room_no+', '+is_read);
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
		document.querySelector('.info-content-layout').replaceChildren();
		json.forEach((el, i) => {
			document.querySelector('.info-content-layout').appendChild(setChatInfo(el));
		});
		document.getElementById('chat_to_nickname').textContent = document.querySelector('[data-room="'+room_no+'"] .title > p:first-child').textContent;
		document.getElementById('chat_to_nickname').addEventListener('click', function(){
			document.getElementById('formMyPage').submit();
		});
	}).catch((error) => console.log('error: '+error));
};


function setChatInfo(el){
	let parentDiv = document.createElement('div');
	parentDiv.className = 'info-content';
	
	let childDiv = document.createElement('div');
	
	if(current_no == el.chat_from){
		childDiv.className = 'right';
	} else {
		childDiv.className = 'left';
	}
	
	let span = document.createElement('span');
	span.textContent = msToTime(el.chat_time);
	span.className = 'chat-time';
	childDiv.appendChild(span);
	
	let p = document.createElement('p');
	p.className = 'chat-content';
	p.textContent = el.chat_content;
	childDiv.appendChild(p);
	
	parentDiv.appendChild(childDiv);
	
	return parentDiv;
};


document.addEventListener('DOMContentLoaded', function(){
	var socket = null;
	
	connectWs();
});


function connectWs(){
	sock = new SockJS('${pageContext.request.contextPath}/echo');
	socket = sock;
	
	sock.onopen = function(){
		console.log('info: connection opened.');
	};
	
	sock.onmessage = function(evt){
		let data = JSON.parse(evt.data);
		let newList = document.querySelector('[data-room="'+data.room_no+'"]');
		newList.style.order = listOrder;
		newList.querySelector('p:last-child').textContent = convert(data.chat_time);
		newList.querySelector('.content p').textContent = setPreview(data.chat_content);
		
		if(data.chat_from != current_no){
			newList.querySelector('.list-content-right').style.visibility = 'visible';			
		}
		
		if(document.querySelector('[data-open="Y"]').getAttribute('data-room') == data.room_no){
			console.log(document.querySelector('[data-open="Y"]').getAttribute('data-room'));
			newList.querySelector('.list-content-right').style.visibility = 'hidden';
			let appendInfo = setChatInfo(data);
			document.querySelector('.info-content-layout').prepend(appendInfo);
		}
		listOrder--;		
	};
	
};

document.getElementById('chat_content').addEventListener('keyup', function(event){
	if(this.value.trim().length > 0){
		document.querySelector('.btn_send').style.visibility = 'visible';
		if(event.keyCode == 13){
			event.preventDefault();
			document.querySelector('.btn_send').click();
		}
	} else {			
		document.querySelector('.btn_send').style.visibility = 'hidden';
	}
});

document.querySelector('.btn_send').addEventListener('click', function(){
	console.log('btn click');
	sendMessage();
});

function sendMessage(){
	const openList = document.querySelector('[data-open="Y"]');
	let params = {
		room_no: openList.getAttribute('data-room'),
		chat_to: openList.getAttribute('chat-to'),
		chat_content: document.getElementById('chat_content').value.replace(/\n|<[^>]*>?/g, ''),
	};
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
		socket.send(JSON.stringify(json));
	}).catch((error) => console.log('error: '+error));
}

function setPreview(content){
	if(content.length > 15){
		content = content.substr(0, 15)+'...';
	}
	return content;
};
</script>