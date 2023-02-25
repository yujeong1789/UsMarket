/**
 * 
 */
 function setChatList(data){
	let list_content = document.createElement('div');
	list_content.className = 'list-content';
	list_content.setAttribute('data-room', data.room_no);
	list_content.setAttribute('data-read', (data.chat_read == 'N' ? data.chat_read : 'Y'));
	list_content.setAttribute('data-to', data.chat_from);
	
	let chat_time = document.createElement('input');
	chat_time.type = 'hidden';
	chat_time.value = new Date(data.chat_time);
	list_content.appendChild(chat_time);
	
	let img = document.createElement('img');
	list_content.appendChild(img);
	
	let list_content_1 = document.createElement('div');
	list_content_1.className = 'list-content-1';
	
	let list_content_left = document.createElement('div');
	list_content_left.className = 'list-content-left';
	
	let title = document.createElement('div');
	title.className = 'title';
	let p1 = document.createElement('p');
	title.appendChild(p1);
	
	let p2 = document.createElement('p');
	p2.textContent = convert(data.chat_time);
	title.appendChild(p2);
	list_content_left.appendChild(title);
	
	let content = document.createElement('div');
	content.className = 'content';
	let p3 = document.createElement('p');
	p3.textContent = setPreview(data.chat_content);
	content.appendChild(p3);
	list_content_left.appendChild(content);
	list_content_1.appendChild(list_content_left);
	
	let list_content_right = document.createElement('div');
	list_content_right.className = 'list-content-right';
	list_content_1.appendChild(list_content_right);
	
	list_content.appendChild(list_content_1);
	
	return list_content;
};