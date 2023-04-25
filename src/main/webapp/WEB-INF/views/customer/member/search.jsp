<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
	
    <link rel="stylesheet" href="<c:url value='/resources/customer/css/search_style.css'/>?after" type="text/css">	
	
</head>
<body>
<c:if test="${memberInfo != null}">
	<script type="text/javascript">
		alert('잘못된 접근입니다.');
		location.href = '${pageContext.request.contextPath}/';
	</script>
</c:if>
	<div class="search_body">
		<section class="search_form">
			<h1>${mode eq 'id' ? '아이디' : '비밀번호' } 찾기</h1>
			<form name="searchForm">
				<c:if test="${mode eq 'id' }">
					<div class="int-area">
							<input type="text" name="member_name" id="name" autocomplete="off" required>
							<label for="name">이름</label>
					</div>
					<div class="int-area">
						<input type="text" name="member_hp" id="hp" autocomplete="off" required>
						<label for="hp">전화번호</label>
					</div>
				</c:if>

				<c:if test="${mode eq 'pw' }">
					<div class="int-area">
						<input type="text" name="member_id" id="id" autocomplete="off" required>
						<label for="id">아이디</label>
					</div>
					<div class="int-area">
						<input type="text" name="member_email" id="email" autocomplete="off" required>
						<label for="email">이메일</label>
					</div>
				</c:if>

				<div id="eMessage" style="display:none; color:red;">숫자만 입력 가능합니다.</div>
				<span style="color:red;">${msg }</span>
				<div class="btn-area">
					<c:if test="${mode eq 'id' }">
						<button type="button" name="id_btn" id="id_btn">찾기</button>
					</c:if>
					<c:if test="${mode eq 'pw' }">
						<button type="button" name="pw_btn" id="pw_btn">찾기</button>
					</c:if>
				</div>
			</form>
			<div class="caption">
				<div class="search">
					<c:if test="${mode eq 'pw'}">
						<a href="<c:url value='/member/search?mode=id'/>">아이디를 잊어버리셨나요?</a>
					</c:if>
					<c:if test="${mode eq 'id'}">
						<a href="<c:url value='/member/search?mode=pw'/>">비밀번호를 잊어버리셨나요?</a>
					</c:if>
				</div>
				<a href="<c:url value='/member/join'/>">회원가입</a>
			</div>
		</section>
	</div>	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
		const id = $("#id");
		const hp = $("#hp");
		const name = $("#name");
		const email = $("#email");
		const id_btn = $("#id_btn");
		const pw_btn = $("#pw_btn");
		const permition = false;

		function isNumeric(input) {
			return /^-?\d+$/.test(input);
		};
			
		function showError(input) {
			$(input).next('label').addClass('warning');
			setTimeout(() => {
				$('label').removeClass('warning');
			}, 1500);
		}

		$(id_btn).on('click', function() {
			const inputs = [name, hp];
			let hasError = false;
			
			inputs.forEach(input => {
				if ($(input).val() === "") {
					showError(input);
					hasError = true;
				}
			});
			if (!hasError) {
				const param = {
						'member_name' : $(name).val(),
						'member_hp' : $(hp).val()
				};
				$.ajax({
					url: "${pageContext.request.contextPath}/member/search",
					type: "POST",
					data: JSON.stringify(param),
					contentType: "application/json",
					dataType: "text",
					success : function(result){
						var result = $('<div></div>').html(result);
						var resultBox = $(result).find('.mypage_content').html();
						$('.search_form').html(resultBox);
					},
					error : function(error){
						console.log(error);					
					}
				})
			};	
		});
		
		$(pw_btn).on('click', function() {
			const inputs = [id, email];
			let hasError = false;
			
			inputs.forEach(input => {
				if ($(input).val() === "") {
					showError(input);
					hasError = true;
				}
			});
			
			if (!hasError) {
				const param = {
					'member_id' : $(id).val(),
					'member_email' : $(email).val()
				};
				
				$.ajax({
					url: "${pageContext.request.contextPath}/member/newpw",
					type: "POST",
					data: JSON.stringify(param),
					contentType: "application/json",
					dataType: "text",
					success : function(result){
						var result = $('<div></div>').html(result);
						var resultBox = $(result).find('.mypage_content').html();
						$('.search_form').html(resultBox);
					},
					error : function(error){
						console.log(error);					
					}
				})
			}
		});
		
		$(function() {
			const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}$/;
			$(email).on('input', function() {
				const email = $(this).val();
				const isValidEmail = emailRegex.test(email);
			
				if (!isValidEmail) {
					$('#eMessage').text('유효한 이메일 형식이 아닙니다.').show();
				} else if (email == "" || isValidEmail){
					$('#eMessage').hide();
				}
			});
		});
		
		$(hp).on('input',function() {
			var input=$(this).val();
			if(!isNumeric(input)) {
				$('#eMessage').show();
				if (input !== "") {
					$(this).val("");
				}
			} else {
				$('#eMessage').hide();				
			}
		});
		
	</script>
</body>
</html>