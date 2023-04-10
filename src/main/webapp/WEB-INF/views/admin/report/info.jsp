<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="<c:url value='/resources/admin/css/report_info.css'/>" type="text/css">

<div class="report-info-container">

	<c:if test="${empty infoMap}">
		<script type="text/javascript">
			alert('접수된 신고를 찾을 수 없습니다.');
			location.href = '${pageContext.request.contextPath}/admin/report/list';
		</script>
	</c:if>
	
	<c:if test="${not empty infoMap}">
	
		<div class="title">
			<span>신고내역</span>
		</div> <!-- title -->
		
		<div class="dashboard">
			<div>
				<div class="info">
					<div class="info-title">신고번호</div>
					<div class="info-info">${infoMap.REPORT_NO }</div>
				</div>
				<div class="info">
					<div class="info-title">신고일시</div>
					<div class="info-info"><fmt:formatDate value="${infoMap.REPORT_REGDATE }" pattern="yyyy/MM/dd (HH:mm:ss)" /></div>
				</div>
				<div class="info">
					<div class="info-title">신고사유</div>
					<div class="info-info">${infoMap.REPORT_CATEGORY1_NAME += ' | ' += infoMap.REPORT_CATEGORY2_NAME }</div>
				</div>
				<div class="info">
					<div class="info-title">신고대상</div>
					<div class="info-info frm">
						<span class="">${infoMap.REPORT_MEMBER_ID }</span>
						<img src="<c:url value='/resources/admin/img/icon/redirect.png'/>">
					</div>
					<form action="<c:url value='/admin/member/info'/>" method="post">
						<input type="hidden" name="member_no" value="${infoMap.REPORT_MEMBER_NO }">
					</form>
				</div>
				<div class="info report-info">
					<c:choose>
						<c:when test="${infoMap.REPORT_CATEGORY1_NO eq 1 }">
							<div class="info-title">상품번호</div>
							<div class="info-info">
								<a href="<c:url value='/product/info?product_no=${infoMap.REPORT_INFO}' />">
									<span>${infoMap.REPORT_INFO }</span>
									<img src="<c:url value='/resources/admin/img/icon/redirect.png'/>">
								</a>
							</div>
						</c:when>
						<c:when test="${infoMap.REPORT_CATEGORY1_NO eq 2 }">
							<div class="info-title">채팅로그</div>
							<div class="info-info info-chat">
								<jsp:include page="/WEB-INF/views/admin/report/chat_modal.jsp"/>
								<span class="chat-modal-open">${infoMap.REPORT_INFO }</span>
								<img src="<c:url value='/resources/admin/img/icon/redirect.png'/>">
							</div>
						</c:when>
						<c:when test="${infoMap.REPORT_CATEGORY1_NO eq 3 || infoMap.REPORT_CATEGORY1_NO eq 4}">
							<div class="info-title">거래내역</div>
							<div class="info-info frm">
								<span>${infoMap.REPORT_INFO }</span>
								<img src="<c:url value='/resources/admin/img/icon/redirect.png'/>">
							</div>
							<form action="<c:url value='/admin/payment/info'/>" method="post">
								<input type="hidden" name="deal_no" value="${infoMap.REPORT_INFO }">
							</form>
						</c:when>
					</c:choose>
				</div>
				<div class="info">
					<div class="info-title">처리여부</div>
					<c:if test="${infoMap.REPORT_COMPLETE  eq 'N'}">
						<div class="info-info" style="color: #FF0028">미처리</div>
					</c:if>
					<c:if test="${infoMap.REPORT_COMPLETE  eq 'Y'}">
						<div class="info-info" style="color: #822AFF">처리완료</div>
					</c:if>
				</div>
				<div class="info">
					<div class="info-title">신고내용</div>
						<div class="info-info">
							<c:if test="${not empty infoMap.REPORT_IMAGE }">
								<img src="${'https://usmarket.s3.ap-northeast-2.amazonaws.com/' += infoMap.REPORT_IMAGE }">
							</c:if>
						<span>${infoMap.REPORT_CONTENT }</span>
					</div>
				</div>
			</div>
			<c:if test="${infoMap.REPORT_COMPLETE eq 'N' }">
				<div>
					<div class="title">
						<span>제재 등록</span>
						<div class="sanction-date">
							<label>
								<span>시작일</span>
								<input type="date" name="sanction_startdate" id="sanction_startdate" readonly="readonly">
							</label>
							<label>
								<span>종료일</span>
								<input type="date" name="sanction_enddate" id="sanction_enddate" readonly="readonly">
							</label>
						</div>
					</div>
					<div class="sanction-category">
						<select class="custom-select" id="sanction_category_no" name="sanction_category_no" required="required">
							<option selected="selected" value="">선택</option>
							<option value="0">제재요건미충족</option>
							<option value="1" data-date="7">7일 정지</option>
							<option value="2" data-date="15">15일 정지</option>
							<option value="3" data-date="30">30일 정지</option>
						</select>
						<div class="report-submit">
							<div class="new">등록하기</div>
							<div onclick="location.href='<c:url value="/admin/report/list"/>'">목록</div>
						</div>
					</div>
					<form id="reportInfoForm" name="reportInfoForm" action="<c:url value='/admin/report/info'/>" method="post">
						<input type="hidden" name="report_no" value="${infoMap.REPORT_NO }">
					</form>
				</div>
			</c:if>
			<c:if test="${infoMap.REPORT_COMPLETE eq 'Y' and not empty historyMap}">
				<div>
					<div class="title">
						<span>제재내역</span>
					</div>
					<div class="report-history">
						<div class="info">
							<div class="info-title">관리자</div>
							<div class="info-info">${historyMap.ADMIN_NAME += ' (' +=  historyMap.ADMIN_ID += ')'}</div>
						</div>
						<div class="info">
							<div class="info-title">제재분류</div>
							<div class="info-info">${historyMap.SANCTION_CATEGORY_NAME }</div>
						</div>
						<c:if test="${not empty historyMap.SANCTION_STARTDATE and not empty historyMap.SANCTION_ENDDATE }">
							<div class="info">
								<div class="info-title">제재시작일</div>
								<div class="info-info"><fmt:formatDate value="${historyMap.SANCTION_STARTDATE }" pattern="yyyy/MM/dd (HH:mm:ss)" /></div>
							</div>
							<div class="info">
								<div class="info-title">제재종료일</div>
								<div class="info-info"><fmt:formatDate value="${historyMap.SANCTION_ENDDATE }" pattern="yyyy/MM/dd (HH:mm:ss)" /></div>
							</div>
						</c:if>
						<div class="info">
							<div class="info-title">처리일</div>
							<div class="info-info"><fmt:formatDate value="${historyMap.SANCTION_REGDATE }" pattern="yyyy/MM/dd (HH:mm:ss)" /></div>
						</div>
						<div class="report-list-btn" onclick="location.href='<c:url value="/admin/report/list"/>'">목록</div>
					</div>
				</div>
			</c:if>
		</div> <!-- dashboard -->
		
	</c:if>
 
</div> <!-- report-info-container -->

<script type="text/javascript">

document.querySelectorAll('.frm > span').forEach(el => {
	el.addEventListener('click', function(e){
		e.target.parentElement.nextElementSibling.submit();
	});
});

if(document.querySelector('.info-chat') != null){
	document.querySelector('.chat-modal-open').addEventListener('click', function(){
		chatModal.show();
	});
}

if(document.querySelector('.sanction-category > select') != null){
	const member_no = `${infoMap.REPORT_MEMBER_NO }`;
	
	fetch('/usMarket/fetch/admin/report/history/'+member_no)
	.then((response) => response.text())
	.then((text) => {
		document.getElementById('sanction_startdate').value = (isEmpty(text) ? getEndDay() : text);
	}).catch((error) => console.log("error: "+error));
	
	document.querySelector('.sanction-category > select').addEventListener('change', function(e){
		if(this.value > 0){
			let endDate = new Date(document.getElementById('sanction_startdate').value);
			endDate.setDate(endDate.getDate() + parseInt(e.target[e.target.selectedIndex].dataset.date));
			document.getElementById('sanction_enddate').value = endDate.getFullYear() + '-' + leftPad(endDate.getMonth() + 1) + '-'+leftPad(endDate.getDate());
			document.querySelector('.sanction-date').style.visibility = 'visible';
		}else{
			document.querySelector('.sanction-date').style.visibility = 'hidden';
		}
	});
	
	document.querySelector('.report-submit > .new').addEventListener('click', function(){
		if(isEmpty(document.getElementById('sanction_category_no').value)){
			alert('제재 기간을 선택하세요.');
			document.getElementById('sanction_category_no').focus();
		}else{
			if(confirm('제재를 등록하시겠습니까?')){
				let params = {
						report_no: `${infoMap.REPORT_NO}`,
						admin_no: document.getElementById('admin_auth').dataset.no,
						member_no: `${infoMap.REPORT_MEMBER_NO}`,
						sanction_category_no: document.getElementById('sanction_category_no').value,
						sanction_startdate: (document.getElementById('sanction_category_no').value == 0 ? '' : document.getElementById('sanction_startdate').value),
						sanction_enddate: (document.getElementById('sanction_category_no').value == 0 ? '' : document.getElementById('sanction_enddate').value)
					};
				
				fetch('/usMarket/fetch/admin/report/reg', {
					method: 'POST',
					headers: {
						'Content-type' : 'application/json'
					},
					body: JSON.stringify(params),
				})
				.then((response) => response.text())
				.then((text) => {
					if(text == '2'){
						alert('제재 등록이 완료되었습니다.');
						document.getElementById('reportInfoForm').submit();
					}
				}).catch((error) => console.log('error: '+error));			
			}
		}
	});
}
</script>