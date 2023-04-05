<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/qna-info.css'/>" type="text/css">
<c:set var="status" value="${mode eq 'new' ? '' : 'readonly' }" />
<c:set var="title" value="${mode eq 'new' ? '1:1문의하기' : '1:1문의 조회' }" />

<div class="qna-info-container">

	<c:if test="${mode eq 'read' and empty qnaInfo}">
		<script type="text/javascript">
			alert('해당 문의를 찾을 수 없습니다.');
			location.href = '${pageContext.request.contextPath}/qna/list';
		</script>
	</c:if>
	
	<div class="row">
		<div class="container">
			<div class="title">${title }</div>
			<div class="qna-info">
				<form id="qnaInsertForm" action="<c:url value='/qna/new'/>" method="post" enctype="multipart/form-data">
					<input type="hidden" name="qna_no" id="qna_no">
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
								<c:if test="${not empty qnaInfo.QNA_IMAGE }">
									<img src="${'https://usmarket.s3.ap-northeast-2.amazonaws.com/' += qnaInfo.QNA_IMAGE }">
								</c:if>
								<textarea class="frmData not-pass" data-alert="내용을 입력해 주세요." name="qna_content" id="qna_content" maxlength="500" ${status }>${qnaInfo.QNA_CONTENT }</textarea>
								<div class="current_count"><p>0</p><p>/500</p></div>
							</div>
						</div>
					</div>
					
					<!-- 문의 작성일 경우 -->
					<c:if test="${mode eq 'new' }">
						<div>
							<div class="info-title">사진</div>
							<div class="info">
								<div class="qna-file">
									<label for="qna_image">파일 선택</label>
										<span class="upload-name"></span>
										<img class="upload-remove" alt="삭제" src="<c:url value='/resources/customer/img/upload_remove.png'/>">
									<input type="file" id="qna_image" accept="image/jpg, image/jpeg, image/png">
								</div>
							</div>
						</div>					
						<div class="qna-btn" id="qna-btn">제출하기</div>
					</c:if>
					
					<!-- 문의 조회일 경우 -->
					<c:if test="${mode eq 'read' }">
						<div>
							<div class="info-title">등록일</div>
							<div class="info">
								<div class="input">
									<div><fmt:formatDate value="${qnaInfo.QNA_REGDATE }" pattern="yyyy/MM/dd (HH:mm:ss)" /></div>
								</div>
							</div>
						</div>
						<div>
							<div class="info-title">처리여부</div>
							<div class="info">
								<div class="input">
									<div>${qnaInfo.QNA_COMPLETE eq 'N' ? '답변대기중' : '답변완료' }</div>
								</div>
							</div>
						</div>
						<div class="qna-btn" id="qna-list-btn" onclick="location.href='<c:url value="/qna/list"/>'">목록</div>
					</c:if>
					
				</form> <!-- form -->
			</div> <!-- qna_info -->
			
			<c:if test="${not empty replyInfo }">
				<div class="title">1:1문의 답변</div>
				<div class="qna-reply">
				</div> <!-- qna_reply -->
			</c:if>
			
		</div> <!-- container -->
	</div> <!-- row -->
</div> <!-- qna-info-container -->

<script type="text/javascript">

// 조회 모드일 경우 글자수 숨김
if(`${mode}` == 'new'){
	document.querySelectorAll('.current_count').forEach(el => {
		el.style.visibility = 'visible';
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

	// submit button event
	document.getElementById('qna-btn').addEventListener('click', function(){
		if(document.querySelector('.not-pass') != null){
			console.log('not-pass');
			alert(document.querySelector('.not-pass').dataset.alert);
			document.querySelector('.not-pass').focus();
			
			return;
		}
		if(confirm('문의를 등록하시겠습니까?')){
			document.getElementById('qna_no').value = 'Q'+getOrderNo(9);
			var formData = new FormData(document.getElementById('qnaInsertForm'));
			
			if(document.getElementById('qna_image').files[0] != null){
				formData.append('image', document.getElementById('qna_image').files[0]);				
			}
			
			fetch('/usMarket/fetch/qna/reg', {
				method: 'POST',
				body: formData
			})
			.then((response) => response.json())
			.then((json) => {
				const jsonData = json;
				console.log(json);
				alert(json.msg);
				location.href = '${pageContext.request.contextPath}/qna/read?qna_no='+json.qna_no;
			}).catch((error) => console.log('error: '+error));
		}
	});
}

// qna_title event
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

// qna_content event
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

// qna_category1_no event
document.getElementById('qna_category1_no').addEventListener('change', function(){
	if(this.value == ""){
		this.classList.remove('pass');
		this.classList.add('not-pass');
	}else{		
		this.classList.remove('not-pass');
		this.classList.add('pass');
	}
});

</script>