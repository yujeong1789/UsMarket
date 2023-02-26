<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="<c:url value='/resources/customer/css/report_modal.css'/>" type="text/css">

	<div class="modal fade" id="reportModal" tabindex="-1" aria-labelledby="reportModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">신고하기</h5>
				</div>
				<div class="modal-body">
					<div class="report-into">
						<span class="report-title">신고대상</span>
						<div class="report-body report-info">				
						</div>
					</div>
					<div class="report-content">
						<form id="addReportForm" action="<c:url value='/fetch/report'/>" method="post" enctype="multipart/form-data">
							<span class="report-title">신고사유</span>
							
							<input type="text" id="report_category1_no" name="report_category1_no" readonly="readonly">
							<input type="hidden" id="report_member_no" name="report_member_no" readonly="readonly">
							<input type="hidden" id="report_info" name="report_info" readonly="readonly">
							
							<div class="report-body">
								
								<label>
									<input type="radio" name="report_category2_no" id="report_category2_no" value="4" checked />
									<span>허위매물</span>
								</label>
								<label>
									<input type="radio" name="report_category2_no" id="report_category2_no" value="5"/>
									<span>기타</span>
								</label>
								 
								<div class="report-textarea">
									<textarea readonly="readonly" name="report_content" rows="5" maxlength="300"></textarea>
									<div><p>0</p><p>/300</p></div>
								</div>
							</div>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<div class="btn-close">
						<p>취소</p>
					</div>
					<div class="modal-submit">
						<p>신고하기</p>
					</div>
				</div>
			</div>
		</div>
	</div> <!-- modal -->
<script type="text/javascript">
const reportModalEl = document.getElementById('reportModal');
const reportModal = new bootstrap.Modal(reportModalEl);

// modal show event
reportModalEl.addEventListener('show.bs.modal', function(e){
	console.log('show modal');
	document.getElementById('report_category1_no').value = document.getElementById('report_type').value;
});

// modal hide event
reportModalEl.addEventListener('hide.bs.modal', function(e){
	console.log('hide modal');
	switchWriteable(false);
	radioNodes[0].checked = 'true';
});

//close button event
document.querySelector('.btn-close').addEventListener('click', function(e){
	reportModal.hide();
}); 

// radio click event
const radioNodes = document.querySelectorAll('.report-body input[type=radio]');
radioNodes.forEach((el, i) => {
	el.addEventListener('click', function(){
		switchWriteable(i == radioNodes.length-1);
	});
}); 

// textarea input event
document.querySelector('.report-textarea > textarea').addEventListener('input', function(e){
	this.nextElementSibling.firstChild.textContent = this.value.length;
}); 

// submit button event
document.querySelector('.modal-submit').addEventListener('click', function(e){
	if(document.querySelector('input[type=radio]:checked').value == radioNodes[radioNodes.length-1].value && document.querySelector('.report-textarea > textarea').value.length == 0){
		alert('신고 내용을 입력해 주세요.');
		document.querySelector('.report-textarea > textarea').focus();
	} else {
		if(confirm('해당 상품을 신고하시겠습니까?')){
			var formData = getFormData(document.getElementById('addReportForm'));
			console.log(JSON.stringify(formData));
			/*
			// fetch
			fetch('/usMarket/fetch/report', {
				method: 'POST',
				headers: {
					'Content-type' : 'application/json'
				},
				body: JSON.stringify(formData),
			})
			.then((response) => response.text())
			.then((text) => {
				console.log(text);
			}).catch((error) => console.log('error: '+error));
			*/
			alert('신고가 정상적으로 접수되었습니다.');
			reportModal.hide();
		}
	}
});

function switchWriteable(result){
	var reportTextarea = document.querySelector('.report-textarea');
	var textarea = document.querySelector('.report-textarea > textarea');
	
	if(result){
		reportTextarea.style.backgroundColor = '#F4F8FB';
		textarea.style.backgroundColor = '#F4F8FB';
		textarea.removeAttribute('readonly');
		textarea.setAttribute('placeholder', '위 신고항목에 없거나 추가로 신고하실 내용을 적어 주세요.');
	}else{
		reportTextarea.style.backgroundColor = '#F5F5F5';
		textarea.style.backgroundColor = '#F5F5F5';
		textarea.setAttribute('readonly', 'true');
		textarea.value = '';
		textarea.nextElementSibling.firstChild.textContent = 0;
		textarea.removeAttribute('placeholder');
	}
};
</script>