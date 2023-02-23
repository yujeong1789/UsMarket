<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.spring.usMarket.utils.TimeConvert"%>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/chat_list.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/resources/customer/css/report_modal.css'/>" type="text/css">
<script src="<c:url value='/resources/customer/js/chat_list.js'/>"></script>
<section class="chat-list-section">
	
	<!-- 신고하기 모달 -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">신고하기</h5>
				</div>
				<div class="modal-body">
					
				</div>
				<div class="modal-footer">
					<div class="btn-close">
						<p>취소</p>
					</div>
					<div>
						<p>신고하기</p>
					</div>
				</div>
			</div>
		</div>
	</div> <!-- modal -->
	
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
								<input type="hidden" id="chat_time" value="${chatList.CHAT_TIME }">
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
						<div class="info-title-report">
							<img alt="신고하기" src="<c:url value='/resources/customer/img/report.png'/>">
							<span id="chat-report">신고하기</span>
						</div>
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
	listClickEvent(el);
});

function listClickEvent(el){
	el.addEventListener('click', function(){
		if(document.querySelector('[data-open="Y"]')){
			document.querySelector('[data-open="Y"]').removeAttribute('data-open');
		}
		if(this.getAttribute('data-read') == 'N'){ // 조회 여부 update
			this.querySelector('.list-content-right').style.visibility = 'hidden';
			modifyChatRead(this.getAttribute('data-room'));
		}
		initChatInfo(this);
		getChatInfo(this.getAttribute('data-room'), this.getAttribute('data-read'));
	});
};


document.addEventListener('DOMContentLoaded', function(){
	var socket = null;
	connectWs();
});


function initChatInfo(element){
	element.setAttribute('data-open', 'Y');
	document.getElementById('chat_to').value = element.getAttribute('data-to');
	document.getElementById('chat_to_nickname').innerHTML = '';
	document.querySelector('.info-title-report').style.visibility = 'visible';
	document.querySelector('.info-textarea').style.visibility = 'visible';
	document.getElementById('chat_content').value = '';
	document.querySelector('.btn_send').style.visibility = 'hidden';
	document.querySelector('.info-content-layout').replaceChildren();
};


if(`${room_no}` != ''){
	var tmp_room = `${room_no}`;
	document.querySelector('[data-room="'+tmp_room+'"]').click();
	setTimeout(() => {
		let msg = {
			type: 'init',
			body: `${chatDto}`
		};
		socket.send(JSON.stringify(msg));
	}, 5000);
};


//채팅내역 얻기
function getChatInfo(room_no, is_read){
	console.log('getChatInfo room_no, is_read = '+room_no+', '+is_read);
	fetch('/usMarket/fetch/chatinfo', {
		method: 'POST',
		headers: {
			'Content-type' : 'application/json'
		},
		body: room_no,
	})
	.then((response) => response.json())
	.then((json) => {
		document.querySelector('.info-content-layout').replaceChildren();
		let chatTime;
		json.forEach((el, i) => {
			var currentDate = msToDate(el.chat_time);
			if(i != 0 && chatTime != currentDate){
				document.querySelector('.info-content-layout').appendChild(setChatTime(chatTime));
			}
			document.querySelector('.info-content-layout').appendChild(setChatInfo(el));
			if(i == json.length-1){
				document.querySelector('.info-content-layout').appendChild(setChatTime(currentDate));
			}
			chatTime = currentDate;
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


function connectWs(){
	sock = new SockJS('${pageContext.request.contextPath}/echo');
	socket = sock;
	
	sock.onopen = function(){
		console.log('info: connection opened.');
	};
	
	sock.onmessage = function(evt){
		let data = JSON.parse(evt.data);
		let newList = document.querySelector('[data-room="'+data.room_no+'"]');
		
		if(newList == null){
			let newList_ = setChatList(data);
			newList_.style.order = listOrder;
			getChatMember(data.chat_from, newList_);
			listClickEvent(newList_);
			document.querySelector('.list-div-content').appendChild(newList_);
		} else {
			newList.style.order = listOrder;
			newList.children[0].value = new Date(data.chat_time);
			newList.querySelector('p:last-child').textContent = convert(data.chat_time);
			newList.querySelector('.content p').textContent = setPreview(data.chat_content);
			
			if(data.chat_to == current_no){
				newList.querySelector('.list-content-right').style.visibility = 'visible';			
			}
			
			let openList = document.querySelector('[data-open="Y"]');
			if(openList != null){
				if(openList.getAttribute('data-room') == data.room_no){
					console.log(document.querySelector('[data-open="Y"]').getAttribute('data-room'));
					newList.querySelector('.list-content-right').style.visibility = 'hidden';
					document.querySelector('.info-content-layout').prepend(setChatInfo(data));				
				}
				
				if(data.chat_to == current_no){
					modifyChatRead(data.room_no);
				}
			}
			listOrder--;		
		}
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
		chat_to: openList.getAttribute('data-to'),
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
		let msg = {
				type: 'chat',
				body: json
			};
		socket.send(JSON.stringify(msg));
	}).catch((error) => console.log('error: '+error));
};


function setPreview(content){
	if(content.length > 25){
		content = content.substr(0, 25)+'...';
	}
	return content;
};


function setChatTime(currentDate){
	let time = document.createElement('div');
	time.className = 'chat_date';
	time.textContent = currentDate;
	
	return time;
};


function modifyChatRead(room_no){
	fetch('/usMarket/fetch/chat/read', {
		method: 'POST',
		headers: {
			'Content-type' : 'application/json'
		},
		body: room_no,
	})
	.then((response) => response.text())
	.then((text) => {
		console.log(text);
	}).catch((error) => console.log('error: '+error));
};


setInterval(() => {
	chatList.forEach((el, i) => {
		console.log('change');
		el.querySelector('p:last-child').textContent = convert(el.children[0].value);
	});
}, 60000);


function getChatMember(member_no, element){
	fetch('/usMarket/fetch/chatmember/'+member_no)
	.then((response) => response.json())
	.then((json) => {
		element.children[1].setAttribute('src', '${pageContext.request.contextPath}'+json.MEMBER_IMAGE);
		element.children[2].children[0].children[0].children[0].textContent = json.MEMBER_NICKNAME;
	}).catch((error) => console.log("error: "+error)); // fetch-3	
};

// 신고하기
document.getElementById('chat-report').addEventListener('click', function(){
	var reportModal = new bootstrap.Modal(document.getElementById('exampleModal'));
	reportModal.show();
	document.querySelector('.btn-close').addEventListener('click', function(e){
		console.log('hide');
		reportModal.hide();	
	});
});
</script>