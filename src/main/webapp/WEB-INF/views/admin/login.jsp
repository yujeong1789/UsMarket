<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="<c:url value='/resources/admin/css/login.css'/>" type="text/css">
    
<div class="login-container">
	<div class="login-logo">
		<img src="<c:url value='/resources/admin/img/logo.png'/>">
	</div>
	<div id="login-message" class="login-message">
		<img src="<c:url value='/resources/admin/img/icon/login-alert-icon.png'/>">
		<span>로그인 정보가 올바르지 않습니다.</span>
	</div>
	<div class="login-box">
		<div class="login-box-1">
			관리자 로그인
		</div>
		<div class="login-box-2">
			<form id="adminLoginForm" method="post" action="<c:url value='/admin/login'/>">
				<input class="login-input" id="admin_id" name="admin_id" type="text" value="${admin_id }" placeholder="아이디" maxlength="30" data-status="not" required="required">
				<input class="login-input" id="admin_password" name="admin_password" type="password" placeholder="비밀번호" data-status="not" maxlength="30" required="required">
			</form>
		</div>
		<div class="login-box-3">
			<div class="login-button">로그인</div>
		</div>
	</div>
</div>

<script type="text/javascript">

document.addEventListener('DOMContentLoaded', function(){
	if(!isEmpty(`${message}`)){
		document.getElementById('login-message').style.display = 'flex';
	}
	document.querySelector('aside').style.zIndex = '-1';
	document.querySelector('aside').style.backgroundColor = '#F4F7FB';
	document.querySelector('header').style.zIndex = '-1';
	
	document.querySelector('main').style.padding = '100px';
	document.querySelector('main').style.maxHeight = '1800px';
	document.querySelector('main').style.overflow = 'scroll';
});

document.querySelectorAll('.login-input').forEach((el) => {
	el.addEventListener('input', function(){
		if(this.value.length == 0){
			this.setAttribute('data-status', 'not');
		} else {
			this.setAttribute('data-status', 'pass');
		}		
	});
});

document.querySelector('.login-button').addEventListener('click', function(){
	if(document.querySelector('input[data-status="not"]') == null){
		document.getElementById('adminLoginForm').submit();	
	} else {
		document.querySelector('input[data-status="not"]').focus();
	}
});
</script>