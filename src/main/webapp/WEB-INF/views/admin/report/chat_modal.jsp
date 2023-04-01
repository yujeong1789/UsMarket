<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="<c:url value='/resources/admin/css/chat_modal.css'/>" type="text/css">

	<div class="modal fade" id="chatModal" tabindex="-1" aria-labelledby="chatModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
					<span class="modal-title">채팅내역</span>
					<input type="hidden" id="room_no" value="${infoMap.REPORT_INFO }">
				</div> <!-- modal-header -->
				
				<div class="modal-body">
					<div>
						<table>
							<thead>
								<tr>
									<th>Date</th>
									<th>User</th>
									<th>Message</th>
								</tr>
							</thead>
							<tbody>
								<tr></tr>
							</tbody>
						</table>
					</div>
				</div> <!-- modal-body -->
				
			</div> <!-- modal-content -->
		</div> <!-- modal-dialog -->
	</div> <!-- modal -->
<script type="text/javascript">
const chatModalEl = document.getElementById('chatModal');
const chatModal = new bootstrap.Modal(chatModalEl);

document.addEventListener('DOMContentLoaded', function(){
	const room_no = document.getElementById('room_no').value;
	fetch('/usMarket/fetch/admin/chatlog/'+room_no)
	.then((response) => response.json())
	.then((json) => {
		json.forEach((el, i) => {
			console.log(el);
			let td1 = document.createElement('td');
			td1.textContent = getFullTimeFormat(el.CHAT_TIME);
			document.querySelector('.modal-body tbody > tr').appendChild(td1);
			
			let td2 = document.createElement('td');
			td2.textContent = el.CHAT_FROM_ID;
			document.querySelector('.modal-body tbody > tr').appendChild(td2);
			
			let td3 = document.createElement('td');
			td3.textContent = el.CHAT_CONTENT;
			document.querySelector('.modal-body tbody > tr').appendChild(td3);
		});
	}).catch((error) => console.log("error: "+error)); // fetch-3

	// modal show event
	chatModalEl.addEventListener('show.bs.modal', function(e){
		console.log('show modal');
	});
	
	// modal hide event
	chatModalEl.addEventListener('hide.bs.modal', function(e){
		console.log('hide modal');
	});
});
</script>