<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<aside class="aside-container">
	<div class="aside-logo">
		<a href="<c:url value='/admin/home'/>">
			<img src="<c:url value='/resources/admin/img/logo.png'/>">
		</a>
	</div>
	<div class="aside-ul">
		<ul>
			<li class="home">
				<a href="<c:url value='/admin/home'/>">
					<img src="<c:url value='/resources/admin/img/icon/home.png'/>">
					<span>홈</span>
				</a>
			</li>
			<li class="report">
				<a href="<c:url value='/admin/report/list'/>">
					<img src="<c:url value='/resources/admin/img/icon/report.png'/>">
					<span>신고 관리</span>
				</a>
			</li>
			<li class="qna">
				<a href="<c:url value='/admin/qna/list'/>">
					<img src="<c:url value='/resources/admin/img/icon/qna.png'/>">
					<span>문의 관리</span>
				</a>
			</li>
			<li class="payment">
				<a href="<c:url value='/admin/payment/list'/>">
					<img src="<c:url value='/resources/admin/img/icon/payment.png'/>">
					<span>결제 관리</span>
				</a>
			</li>
			<li class="faq">
				<a href="<c:url value='/admin/faq/list'/>">
					<img src="<c:url value='/resources/admin/img/icon/faq.png'/>">
					<span>공지사항</span>
				</a>
			</li>
		</ul>
	</div>
</aside>

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function(){
	if(!isEmpty(document.querySelector('.selected'))){
		document.querySelector('.selected').classList.remove('selected');		
	}
	
	let path = window.location.pathname.split('/')[3];
	switch (path) {
	case 'home':
		setSelectedSidebar(path);
		break;
	case 'report':
		setSelectedSidebar(path);
		break;
	case 'qna':
		setSelectedSidebar(path);
		break;
	case 'payment':
		setSelectedSidebar(path);
		break;
	case 'faq':
		setSelectedSidebar(path);
		break;
	};
});
function setSelectedSidebar(path){
	document.querySelector('.'+path).classList.add('selected');
	document.querySelector('.'+path+' img').setAttribute('src', '${pageContext.request.contextPath}/resources/admin/img/icon/'+path+'-selected.png');
};
</script>