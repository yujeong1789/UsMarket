<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="<c:url value='/resources/admin/css/notice_info.css'/>" type="text/css">

<div class="notice-info-container">

	<c:if test="${empty infoMap}">
		<script type="text/javascript">
			alert('작성된 공지사항를 찾을 수 없습니다.');
			location.href = '${pageContext.request.contextPath}/admin/notice/list';
		</script>
	</c:if>
	
	<c:if test="${not empty infoMap}">
	
		<div class="title">
			<span>공지사항</span>
		</div> <!-- title -->
		
		<div class="dashboard">
			<div>
				<div class="info">
					<div class="info-title">글번호</div>
					<div class="info-info">${infoMap.NOTICE_NO }</div>
				</div>
				<div class="info">
					<div class="info-title">작성일시</div>
					<div class="info-info"><fmt:formatDate value="${infoMap.NOTICE_REGDATE }" pattern="yyyy/MM/dd (HH:mm:ss)" /></div>
				</div>
				<div class="info">
					<div class="info-title">관리자</div>
					<div class="info-info">${infoMap.ADMIN_NAME += ' (' +=  infoMap.ADMIN_ID += ')'}</div>
				</div>
				<div class="info">
					<div class="info-title">조회수</div>
					<div class="info-info">${infoMap.NOTICE_VIEW }회</div>
				</div>
				<div class="info">
					<div class="info-title">분류</div>
					<div class="info-info">${infoMap.NOTICE_STATUS eq '0' ? '공지사항' : '자주묻는질문'}</div>
				</div>
				<div class="notice-contents">
					<div class="notice-title mb-20">
						<div>제목</div>
						<div class="modify-false">
							<input class="none pass" type="text" id="notice_title" name="notice_title" data-alert="제목을 입력해 주세요." value="${infoMap.NOTICE_TITLE }" readonly>
						</div>
					</div>
					<div class="notice-title">
						<div>내용</div>
						<div class="modify-false">
							<textarea class="none pass" id="notice_content" name="notice_content" data-alert="내용을 입력해 주세요." readonly>${infoMap.NOTICE_CONTENT }</textarea>
						</div>
					</div>
				</div>
				<div class="notice-btns">
					<div class="modify">수정</div>
					<div class="remove">삭제</div>
					<div onclick="location.href='<c:url value='/admin/notice/list'/>'">목록</div>
				</div>
				<div class="notice-modify">
					<div class="new">등록</div>
					<div class="cancel">취소</div>
				</div>
				<form id="noticeInfoForm" name="noticeInfoForm" action="<c:url value='/admin/notice/info'/>" method="post">
					<input type="hidden" id="notice_no" name="notice_no" value="${infoMap.NOTICE_NO }">
				</form>
			</div>
		</div> <!-- dashboard -->
		
	</c:if>
 
</div> <!-- notice-info-container -->

<script src="https://cdn.ckeditor.com/ckeditor5/36.0.1/classic/ckeditor.js"></script>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function(){
	document.getElementById('notice_content').style.height = document.getElementById('notice_content').scrollHeight + 'px';
});

document.querySelector('.modify').addEventListener('click', function(e){
	// 테두리 강조
	document.querySelectorAll('.modify-false').forEach(el => {
		el.classList.remove('modify-false');
		el.classList.add('modify-true')
	});
	
	// 제목 수정
	document.querySelector('.title > span').textContent = '공지사항 수정';
	
	// readonly 속성 삭제
	document.getElementById('notice_title').removeAttribute('readonly');
	document.getElementById('notice_content').removeAttribute('readonly');
	document.getElementById('notice_title').focus();

	
	// 수정 삭제 목록 버튼 삭제, 등록 버튼 활성화
	e.target.parentElement.style.display = 'none';
	document.querySelector('.notice-modify').style.display = 'flex';
	
	
	// 입력 이벤트
	// notice_title event
	document.getElementById('notice_title').addEventListener('input', function(){
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
		this.style.height = this.scrollHeight + 'px';
		
		if(this.value.length > 0){
			this.classList.remove('not-pass');
			this.classList.add('pass');
		}else{		
			this.classList.remove('pass');
			this.classList.add('not-pass');
		}
	});
	
	
	// 등록 클릭 이벤트
	document.querySelector('.notice-modify > .new').addEventListener('click', function(){
		if(document.querySelector('.not-pass') != null){
			console.log('not-pass');
			alert(document.querySelector('.not-pass').dataset.alert);
			document.querySelector('.not-pass').focus();
			
			return;
		}
		
		if(confirm('공지사항을 수정하시겠습니까?')){
			let params = {
					notice_no: `${infoMap.NOTICE_NO}`,
					notice_title: document.getElementById('notice_title').value,
					notice_content: document.getElementById('notice_content').value
				};
			
			fetch('/usMarket/fetch/admin/notice/modify', {
				method: 'POST',
				headers: {
					'Content-type' : 'application/json'
				},
				body: JSON.stringify(params),
			})
			.then((response) => response.text())
			.then((text) => {
				if(text == '1'){
					alert('수정되었습니다.');	
				}else{
					alert('수정에 실패했습니다.');
				}
				document.getElementById('noticeInfoForm').submit();
			}).catch((error) => console.log('error: '+error));
		}
	});
	
	// 취소 클릭 이벤트
	document.querySelector('.notice-modify > .cancel').addEventListener('click', function(){
		document.querySelector('.notice-modify').style.display = 'none';
		document.querySelector('.notice-btns').style.display = 'flex';
		
		// 테두리 강조
		document.querySelectorAll('.modify-true').forEach(el => {
			el.classList.remove('modify-true');
			el.classList.add('modify-false')
		});
		
		// 제목 수정
		document.querySelector('.title > span').textContent = '공지사항';
		
		// readonly 속성 삭제 및 value 복구
		document.getElementById('notice_title').setAttribute('readonly', true);
		document.getElementById('notice_title').value = `${infoMap.NOTICE_TITLE }`;
		
		document.getElementById('notice_content').setAttribute('readonly', true);
		document.getElementById('notice_content').value = `${infoMap.NOTICE_CONTENT }`;
		document.getElementById('notice_content').style.height = 'auto';
	});
});

document.querySelector('.remove').addEventListener('click', function(){
	if(confirm('공지사항을 삭제하시겠습니까?')){
		fetch('/usMarket/fetch/admin/notice/remove', {
			method: 'POST',
			headers: {
				'Content-type' : 'application/json'
			},
			body: `${infoMap.NOTICE_NO}`,
		})
		.then((response) => response.text())
		.then((text) => {
			if(text == '1'){
				alert('삭제되었습니다.');
				location.href = '${pageContext.request.contextPath}/admin/notice/list';
			}else{
				alert('삭제에 실패했습니다.');
			}
		}).catch((error) => console.log('error: '+error));
	}
});
</script>