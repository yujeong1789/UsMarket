<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="<c:url value='/resources/admin/css/notice_new.css'/>" type="text/css">

<div class="notice-new-container">
	<div class="title">
		<span>공지사항 작성</span>
	</div>
	<div class="dashboard">
		<div>
			<div class="input">
				<div class="input-title">제목</div>
				<div class="input-content">
					<input class="not-pass" type="text" id="notice_title" data-alert="제목을 입력해 주세요." placeholder="제목을 입력해 주세요." maxlength="50"/>
					<div class="current_count"><p>0</p><p>/50</p></div>
				</div>
			</div>
			<div class="input">
				<div class="input-title">분류</div>
				<div class="input-content">
					<select class="custom-select not-pass" id="notice_status" data-alert="분류를 선택해 주세요." id="notice_status">
						<option selected="selected" value="">선택</option>
						<option value="0">공지사항</option>
						<option value="1" data-date="7">자주묻는질문</option>
					</select>
				</div>
			</div>
			<div class="input">
				<div class="input-title">내용</div>
				<div class="input-content ta">
					<textarea class="not-pass" id="notice_content" data-alert="내용을 입력해 주세요." placeholder="내용을 입력해 주세요." maxlength="500"></textarea>
					<div class="current_count"><p>0</p><p>/500</p></div>
				</div>
			</div>
			<div class="notice-btn">등록하기</div>
			<form id="noticeInfoForm" name="noticeInfoForm" action="<c:url value='/admin/notice/info'/>" method="post">
				<input type="hidden" id="notice_no" name="notice_no">
			</form>
		</div>
	</div>
</div>

<script type="text/javascript">
//qna_title event
document.getElementById('notice_title').addEventListener('input', function(){
	this.nextElementSibling.firstElementChild.textContent = this.value.length;
	
	if(this.value.length > 0){
		this.classList.remove('not-pass');
		this.classList.add('pass');
	}else{		
		this.classList.remove('pass');
		this.classList.add('not-pass');
	}
});

document.getElementById('notice_content').addEventListener('input', function(){
	// 높이 조절
	this.style.height = 'auto';
	this.style.height = (12 + this.scrollHeight) + 'px';
	
	this.nextElementSibling.firstElementChild.textContent = this.value.length;
	
	if(this.value.length > 0){
		this.classList.remove('not-pass');
		this.classList.add('pass');
	}else{		
		this.classList.remove('pass');
		this.classList.add('not-pass');
	}
});

document.getElementById('notice_status').addEventListener('change', function(){
	if(isEmpty(this.value)){
		this.classList.remove('pass');
		this.classList.add('not-pass');
	}else{
		this.classList.remove('not-pass');
		this.classList.add('pass');
	}
});

document.querySelector('.notice-btn').addEventListener('click', function(){
	if(document.querySelector('.not-pass') != null){
		console.log('not-pass');
		alert(document.querySelector('.not-pass').dataset.alert);
		document.querySelector('.not-pass').focus();
		
		return;
	}
	
	if(confirm('공지사항을 등록하시겠습니까?')){
		const notice_no = 'N'+getOrderNo(9)
		let params = {
				admin_no: document.getElementById('admin_auth').dataset.no,
				notice_no: notice_no,
				notice_status: document.getElementById('notice_status').value,
				notice_title: document.getElementById('notice_title').value,
				notice_content: document.getElementById('notice_content').value
			};
		
		fetch('/usMarket/fetch/admin/notice/new', {
			method: 'POST',
			headers: {
				'Content-type' : 'application/json'
			},
			body: JSON.stringify(params),
		})
		.then((response) => response.text())
		.then((text) => {
			if(text == '1'){
				alert('공지사항이 등록되었습니다.');
				document.getElementById('notice_no').value = notice_no;
				document.getElementById('noticeInfoForm').submit();
			}else{
				alert('등록에 실패했습니다.');
			}
		}).catch((error) => console.log('error: '+error));
	}
});
</script>