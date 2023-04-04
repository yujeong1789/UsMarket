<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/qna-info.css'/>" type="text/css">
<c:set var="status" value="${mode eq 'new' ? '' : 'readonly' }" />

<div class="qna-info-container">
	<div class="row">
		<div class="container">
			<div class="title">1:1문의하기</div>
			<div class="qna-info">
				<form id="qnaInsertForm" action="<c:url value='/qna/new'/>" method="post" enctype="multipart/form-data">
					<div>
						<div class="info-title essential">제목</div>
						<div class="info">
							<div class="input">
								<input class="frmData not-pass" data-alert="제목을 입력해 주세요." type="text" name="qna_title" id="qna_title" maxlength="50" value="${qnaInfo.QNA_TITLE }" ${status }>
								<div class="current_count"><p>0</p><p>/50</p></div>
							</div>
						</div>
					</div>
					<div>
						<div class="info-title essential">분류</div>
						<div class="info">
							<c:if test="${mode eq 'new' }">
								<select class="custom-select not-pass" data-alert="분류를 선택해 주세요." id="qna_category1_no" name="qna_category1_no" class="not-pass">
									<option selected="selected" value="">대분류 선택</option>
									<option value="1">회원/계정</option>					
									<option value="2">안전결제</option>					
									<option value="3">판매광고</option>					
									<option value="4">오류/신고/제안</option>					
									<option value="5">기타</option>					
								</select>
							</c:if>
							<c:if test="${mode eq 'read' }">
								<div class="input">
									<input id="qna_category1_no" class="frmData" type="text" value="${qnaInfo.QNA_CATEGORY1_NAME }" readonly="readonly">
								</div>
							</c:if>
						</div>
					</div>
					<div>
						<div class="info-title essential">내용</div>
						<div class="info">
							<div class="input ta">
								<textarea class="frmData not-pass" data-alert="내용을 입력해 주세요." name="qna_content" id="qna_content" maxlength="500" ${status }>${qnaInfo.QNA_CONTENT }</textarea>
								<div class="current_count"><p>0</p><p>/500</p></div>
							</div>
						</div>
					</div>
					<c:if test="${mode eq 'new' }">
						<div>
							<div class="info-title">사진</div>
							<div class="info">
								<div class="qna-file">
									<label for="qna_image">파일 선택</label>
										<span class="upload-name"></span>
										<img class="upload-remove" alt="삭제" src="<c:url value='/resources/customer/img/upload_remove.png'/>">
									<input type="file" name="qna_image" id="qna_image" accept="image/jpg, image/jpeg, image/png">
								</div>
							</div>
						</div>					
					<div class="qna_btn">제출하기</div>
					</c:if>
				</form>
			</div>
		</div> <!-- container -->
	</div> <!-- row -->
</div> <!-- qna-info-container -->

<script type="text/javascript">
if(`${mode}` == 'read'){
	document.querySelectorAll('.current_count').forEach(el => {
		el.style.visibility = 'hidden';
	});
}

document.getElementById('qna_title').addEventListener('input', function(){
	this.nextElementSibling.firstElementChild.textContent = this.value.length;
	
	if(this.value.length > 0){
		this.classList.remove('not-pass');
		this.classList.add('pass');
	}else{		
		this.classList.remove('pass');
		this.classList.add('not-pass');
	}
});

document.getElementById('qna_content').addEventListener('input', function(){
	this.nextElementSibling.firstElementChild.textContent = this.value.length;
	
	if(this.value.length > 0){
		this.classList.remove('not-pass');
		this.classList.add('pass');
	}else{		
		this.classList.remove('pass');
		this.classList.add('not-pass');
	}
});

document.getElementById('qna_category1_no').addEventListener('change', function(){
	if(this.value == ""){
		this.classList.remove('pass');
		this.classList.add('not-pass');
	}else{		
		this.classList.remove('not-pass');
		this.classList.add('pass');
	}
});

document.querySelector('.qna_btn').addEventListener('click', function(){
	if(document.querySelector('.not-pass') != null){
		console.log('not-pass');
		alert(document.querySelector('.not-pass').dataset.alert);
		document.querySelector('.not-pass').focus();
		
		return;
	}
	if(confirm('문의를 등록하시겠습니까?')){
		console.log('submit');
	}
});

//input file event
document.getElementById('qna_image').addEventListener('change', function(e){
	var maxSize = 5 * 1024 * 1024;
	
	if(this.files[0].size > maxSize){
		alert('첨부파일 사이즈는 5MB 이내로 등록 가능합니다.');
	} else{
		console.log('통과');
		document.querySelector('.upload-name').textContent = this.files[0].name;
		document.querySelector('.upload-remove').style.visibility = 'visible';
	}
	
});


//upload remove event
document.querySelector('.upload-remove').addEventListener('click', function(e){
	document.getElementById('qna_image').value = '';
	document.querySelector('.upload-name').textContent = '';
	this.style.visibility = 'hidden';
});
</script>