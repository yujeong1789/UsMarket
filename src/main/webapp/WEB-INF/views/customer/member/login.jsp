<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
	
    <link rel="stylesheet" href="<c:url value='/resources/customer/css/login_style.css'/>?after" type="text/css">	
	
</head>
<body>
<div class="login-body">
	<section class="login-form">
		<h1>Login</h1>
		<form name="loginForm">
			<div class="int-area">
				<input type="text" name="memberId" id="id" autocomplete="off" required>
				<label for="id">USER ID</label>
			</div>
			<div class="int-area">
				<input type="password" name="memberPassword" id="pw" autocomplete="off" required>
				<label for="pw">PASSWORD</label>
			</div>
			<div class="btn-area">
				<button type="button" name="btn" id="btn">LOGIN</button>
			</div>
		</form>
		<div class="caption">
			<a href=#>비밀번호를 잃어버리셨나요?</a>
			<a href="<c:url value='/member/join'/>">회원가입</a>
		</div>
	</section>
</div>	
	<script>
		let id = $("#id");
		let pw = $('#pw');
		let btn = $("#btn");
		
		$(btn).on('click', function() {
			if($(id).val()=="" && $(pw).val()==""){
				$(id).next('label').addClass('warning');
				setTimeout(function() {
					$('label').removeClass('warning');
				},1500)
				$(pw).next('label').addClass('warning');
				setTimeout(function() {
					$('label').removeClass('warning');
				},1500)
				return;
			}
			loginForm.method='POST';
			loginForm.action="${pageContext.request.contextPath}/member/login";
			loginForm.submit();
		})
	</script>
</body>
</html>