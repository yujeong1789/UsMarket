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
		<h1>${mode eq 'id' ? '아이디' : '비밀번호' } 찾기</h1>
		<form name="searchForm">
			<div class="int-area">
				<input type="text" name="member_name" id="name" autocomplete="off" required>
				<label for="name">이름</label>
			</div>
			<div class="int-area">
				<input type="password" name="member_password" id="pw" autocomplete="off" value="${mem_pw }" required>
				<label for="pw">비밀번호</label>
			</div>
			<span style="color:red;">${msg }</span>
			<div class="btn-area">
				<button type="button" name="btn" id="btn">로그인</button>
			</div>
		</form>
		<div class="caption">
			<div class="search">
				<c:if test="${mode ne 'id'}">
					<a href="<c:url value='/member/search?mode=id'/>">아이디를 잃어버리셨나요?</a>
				</c:if>
				<c:if test="${mode ne 'pw'}">
					<a href="<c:url value='/member/search?mode=pw'/>">비밀번호를 잃어버리셨나요?</a>
				</c:if>
			</div>
			<a href="<c:url value='/member/join'/>">회원가입</a>
		</div>
	</section>
</div>	
	<script>
		let id = $("#id");
		let pw = $("#pw");
		let btn = $("#btn");
		
		$(btn).on('click', function() {
			if($(id).val()==""){
				$(id).next('label').addClass('warning');
				setTimeout(function() {
					$('label').removeClass('warning');
				},1500)
			}
			if($(pw).val()==""){
				$(pw).next('label').addClass('warning');
				setTimeout(function() {
					$('label').removeClass('warning');
				},1500)
			}else {
				loginForm.method='POST';
				loginForm.action="${pageContext.request.contextPath}/member/login";
				loginForm.submit();
			}
		});
	</script>
</body>
</html>