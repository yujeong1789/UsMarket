<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
					<input type="hidden" id="notice_no" name="notice_no" value="${infoMap.NOTICE_NO }">
					<div class="notice-title mb-20">
						<div>제목</div>
						<div class="modify-false">
							<input class="none" type="text" id="notice_title" name="notice_title" data-pass="" value="${infoMap.NOTICE_TITLE }" readonly>
						</div>
					</div>
					<div class="notice-title">
						<div>내용</div>
						<div class="modify-false">
							<textarea class="none" id="notice_content" name="notice_content" readonly>${infoMap.NOTICE_CONTENT }</textarea>
						</div>
					</div>
				</div>
				<div class="notice-btns">
					<div class="modify">수정</div>
					<div class="remove">삭제</div>
					<div onclick="location.href='<c:url value='/admin/notice/list'/>'">목록</div>
				</div>
				<div class="notice-modify">
					<div>등록</div>
				</div>
			</div>
		</div> <!-- dashboard -->
		
	</c:if>
 
</div> <!-- notice-info-container -->
<!-- <script src="https://cdn.ckeditor.com/ckeditor5/36.0.1/classic/ckeditor.js"></script> -->
<script src="<c:url value='/resources/customer/js/ckeditor.js'/>"></script>
<script type="text/javascript">
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
	document.getElementById('notice_title').focus();
	
	// 에디터 초기화
/* 	ClassicEditor
		.create(document.getElementById('notice_content'), {
			licenseKey: '',
		})
		.catch(error => {
			console.log(error);
		}); */
	
	// 수정 삭제 목록 버튼 삭제, 등록 버튼 활성화
	e.target.parentElement.style.display = 'none';
	document.querySelector('.notice-modify').style.display = 'flex';
	
	// 등록 클릭 이벤트
	document.querySelector('.notice-modify').addEventListener('click', function(){
		if(confirm('공지사항을 수정하시겠습니까?')){
			alert('modify');
		}	
	})
});
</script>