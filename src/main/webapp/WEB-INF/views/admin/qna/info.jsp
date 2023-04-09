<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="<c:url value='/resources/admin/css/qna_info.css'/>" type="text/css">

<div class="qna-info-container">

	<c:if test="${empty infoMap}">
		<script type="text/javascript">
			alert('접수된 문의를 찾을 수 없습니다.');
			location.href = '${pageContext.request.contextPath}/admin/qna/list';
		</script>
	</c:if>
	
	<c:if test="${not empty infoMap}">
	
		<div class="title">
			<span>문의내역</span>
		</div> <!-- title -->
		
		<div class="dashboard">
			<div>
				<div class="info">
					<div class="info-title">문의번호</div>
					<div class="info-info">${infoMap.QNA_NO }</div>
				</div>
				<div class="info">
					<div class="info-title">등록일시</div>
					<div class="info-info"><fmt:formatDate value="${infoMap.QNA_REGDATE }" pattern="yyyy/MM/dd (HH:mm:ss)" /></div>
				</div>
				<div class="info">
					<div class="info-title">문의분류</div>
					<div class="info-info">${infoMap.QNA_CATEGORY1_NAME }</div>
				</div>
				<div class="info">
					<div class="info-title">문의회원</div>
					<div class="info-info frm">
						<span class="">${infoMap.MEMBER_ID }</span>
						<img src="<c:url value='/resources/admin/img/icon/redirect.png'/>">
					</div>
					<form action="<c:url value='/admin/member/info'/>" method="post">
						<input type="hidden" name="member_no" value="${infoMap.MEMBER_NO }">
					</form>
				</div>
				<div class="info">
					<div class="info-title">처리여부</div>
					<c:if test="${infoMap.QNA_COMPLETE  eq 'N'}">
						<div class="info-info" style="color: #FF0028">미처리</div>
					</c:if>
					<c:if test="${infoMap.QNA_COMPLETE  eq 'Y'}">
						<div class="info-info" style="color: #822AFF">처리완료</div>
					</c:if>
				</div>
				<div class="info">
					<div class="info-title">문의내용</div>
						<div class="info-info">
							<c:if test="${not empty infoMap.QNA_IMAGE }">
								<img class="qna_img" src="${'https://usmarket.s3.ap-northeast-2.amazonaws.com/' += infoMap.QNA_IMAGE }">
							</c:if>
						<span>${infoMap.QNA_CONTENT }</span>
					</div>
				</div>
			</div>
			<c:if test="${infoMap.QNA_COMPLETE eq 'N' }">
				<div>
					<div class="title">
						<span>답변 등록</span>
					</div>
					<div class="qna-reply-input">
						<textarea name="qna_reply_content" id="qna_reply_content" placeholder="내용을 입력해 주세요." maxlength="500"></textarea>
						<div class="current_count"><p>0</p><p>/500</p></div>
					</div>
					<div class="qna-submit">
						<div class="new">등록하기</div>
						<div onclick="location.href='<c:url value="/admin/qna/list"/>'">목록</div>
					</div>
					<form id="qnaInfoForm" name="qnaInfoForm" action="<c:url value='/admin/qna/info'/>" method="post">
						<input type="hidden" name="qna_no" value="${infoMap.QNA_NO }">
					</form>
				</div>
			</c:if>
			<c:if test="${infoMap.QNA_COMPLETE eq 'Y' and not empty replyMap}">
				<div>
					<div class="title">
						<span>답변</span>
					</div>
					<div class="qna-reply">
						<div class="info">
							<div class="info-title">관리자</div>
							<div class="info-info">${replyMap.ADMIN_NAME += ' (' +=  replyMap.ADMIN_ID += ')'}</div>
						</div>
						<div class="info">
							<div class="info-title">처리일</div>
							<div class="info-info"><fmt:formatDate value="${replyMap.QNA_REPLY_REGDATE }" pattern="yyyy/MM/dd (HH:mm:ss)" /></div>
						</div>
						<div class="info last">
							<div class="info-title">내용</div>
							<div class="info-info">${replyMap.QNA_REPLY_CONTENT }</div>
						</div>
					</div>
				</div>
			</c:if>
		</div> <!-- dashboard -->
		
	</c:if>
 
</div> <!-- qna-info-container -->

<script type="text/javascript">
if(`${infoMap.QNA_COMPLETE}` == 'N'){
	document.querySelector('.current_count').style.visibility = 'visible';
	
	//qna_content event
	document.getElementById('qna_reply_content').addEventListener('input', function(){
		// 높이 조절
		this.style.height = 'auto';
		this.style.height = this.scrollHeight + 'px';
		
		this.nextElementSibling.firstElementChild.textContent = this.value.length;
	});
	
	document.querySelector('.qna-submit > .new').addEventListener('click', function(){
		if(isEmpty(document.getElementById('qna_reply_content').value)){
			alert('내용을 입력해 주세요.');
			document.getElementById('qna_reply_content').focus();
			return;
		}
		
		if (confirm('답변을 등록하시겠습니까?')) {
			
			let params = {
					qna_no: `${infoMap.QNA_NO}`,
					admin_no: document.getElementById('admin_auth').dataset.no,
					qna_reply_content: document.getElementById('qna_reply_content').value
				};
			
			fetch('/usMarket/fetch/admin/qna/reg', {
				method: 'POST',
				headers: {
					'Content-type' : 'application/json'
				},
				body: JSON.stringify(params),
			})
			.then((response) => response.text())
			.then((text) => {
				if(text == '2'){
					alert('답변 등록이 완료되었습니다.');
					document.getElementById('qnaInfoForm').submit();
				}else{
					alert('답변 등록에 실패했습니다.');
				}
			}).catch((error) => console.log('error: '+error));
		}
		
	});
}
</script>