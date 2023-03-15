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
			<li class="stats">
				<a href="<c:url value='/admin/stats/list'/>">
					<img src="<c:url value='/resources/admin/img/icon/stats.png'/>">
					<span>통계</span>
				</a>
			</li>
			<li class="member">
				<a href="<c:url value='/admin/member/list'/>">
					<img src="<c:url value='/resources/admin/img/icon/member.png'/>">
					<span>회원관리</span>
				</a>
			</li>
			<li class="payment">
				<a href="<c:url value='/admin/payment/list'/>">
					<img src="<c:url value='/resources/admin/img/icon/payment.png'/>">
					<span>결제관리</span>
				</a>
			</li>
			<li class="report">
				<a href="<c:url value='/admin/report/list'/>">
					<img src="<c:url value='/resources/admin/img/icon/report.png'/>">
					<span>신고관리</span>
				</a>
			</li>
			<li class="qna">
				<a href="<c:url value='/admin/qna/list'/>">
					<img src="<c:url value='/resources/admin/img/icon/qna.png'/>">
					<span>문의관리</span>
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
const categories = ['home', 'stats', 'member', 'payment', 'report', 'qna', 'faq'];

document.addEventListener('DOMContentLoaded', function(){
	if(!isEmpty(document.querySelector('.selected'))){
		document.querySelector('.selected').classList.remove('selected');		
	}
	
	let path = window.location.pathname.split('/')[3];
	if(categories.includes(path)){
		setSelectedSidebar(categories[categories.indexOf(path)]);
	}
});
function setSelectedSidebar(path){
	document.querySelector('.'+path).classList.add('selected');
	document.querySelector('.'+path+' img').setAttribute('src', '${pageContext.request.contextPath}/resources/admin/img/icon/'+path+'-selected.png');
};
</script>