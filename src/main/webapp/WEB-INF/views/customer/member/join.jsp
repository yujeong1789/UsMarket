<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<h1>회원가입</h1>
		<form name="joinForm" enctype="multipart/form-data" onsubmit="return false">
			<input type="file" id="profile" name="member_profile_image" accept="image/jpg, image/jpeg, image/png" style="display:none;"/>
			<input type="image" id="profile_image" name="member_image" style="display:none;"/>
			<div class="profile_box">
				<label for="profile" id="preview">
					<img id="profile_img" alt="프로필 이미지" src="<c:url value='/resources/customer/img/profile.png'/>">
				</label>
				<img class="file__img__delete" src="<c:url value='/resources/customer/img/delete_icon.png'/>">
			</div>
			
			<div style="text-align:center;">
				<span>프로필</span>
			</div>
			<div class="int-area">
			</div>
			<div class="int-area">
				<input type="text" name="member_name" id="name" autocomplete="off" required title="이름을 입력해주세요.">
				<label for="name">이름<text> *</text></label>
			</div>

			<div class="int-area">
				<input type="text" oninput="this.value = this.value.replace(/[^a-z|A-Z|0-9|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '').replace(/(\..*)\./g, '$1');"
				name="member_nickname" id="nick" autocomplete="off" required title="닉네임을 입력해주세요.">
				<label for="nick">닉네임<text> *</text></label>
				<span style="display:block; font-size:13px">특수문자 사용불가(3~10자리 입력)</span>
				<span class="nick_status"></span>
			</div>

			<div class="int-area">
				<input type="text" oninput="this.value = this.value.replace(/[^a-z|A-Z|0-9]/g, '').replace(/(\..*)\./g, '$1');"
				name="member_id" id="id" autocomplete="off" required title="아아디를 입력해주세요.">
				<label for="id">아이디<text> *</text></label>
				<span style="display:block; font-size:13px">영문자+숫자(4~10자리 입력)</span>
				<span class= "id_status"></span>
			</div>

			<div class="int-area">
				<input type="password" oninput="this.value = this.value.replace(/[^a-z|A-Z|0-9|!@#$%^*+=-]/g, '').replace(/(\..*)\./g, '$1');"
				name="member_password" id="pw1" autocomplete="off" required title="비밀번호를 입력해주세요.">
				<label for="pw1">비밀번호<text> *</text></label>
				<span style="display:block; font-size:13px">영문자+숫자+특수조합(8~25자리 입력, ! @ # $ % ^ * + = -)</span>
				<span class="pw_status"></span>
			</div>

			<div class="int-area">
				<input type="password" name="pw2" id="pw2" autocomplete="off" required title="비밀번호를 재입력해주세요.">
				<label for="pw2">비밀번호 재확인<text> *</text></label>
				<span class="pw_no"></span>
			</div>
			<div class="int-area">
				<div class="int-area-addressCheck">
					<input type="text" name="member_zipcode" id="zipcode" required="required" readonly="readonly">
					<label for="zipcode" id="zipcode_label">주소<text> *</text></label>
					<button type="button" class="address_btn" id="address_btn" >우편번호 찾기</button>
				</div>
				<input type="hidden" name="member_address" id="address" readonly="readonly" required="required">
			</div>
			<div class="int-area">
				<input type="hidden" name="member_address_detail" id="address_detail" readonly="readonly" required="required">
				<label for="address_detail" id="address_detail_label" style="display:none;">상세주소<text>*</text></label>
			</div>
			<div class="int-area">
				<input type="text" name="member_email" id="email" autocomplete="off" required title="이메일을 입력해주세요.">
				<label for="email">이메일<text> *</text></label>
				<span class="email_status"></span>
				<div class="int-area-emailCheck">
					<input type="text" name="member_email_check" id="email_check" autocomplete="off" disabled="disabled" required title="인증번호를 입력해주세요.">
					<button type="button" class="email_check_btn" name="email_check_btn" disabled>인증번호 발송</button>
				</div>
				<span class="mail_check_warn"></span>
			</div>
			<div class="int-area" id="hp-area">
				<input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
				name="member_hp" id="hp" autocomplete="off" maxlength="11" required title="전화번호를 입력해주세요.">
				<label for="hp">전화번호<text> *</text></label>
				<span class="hp_status"></span>
			</div>
			<div class="btn-area">
				<button name="btn" id="btn">회원가입</button>
				<p align="center" style="color: red;">${message }</p>
			</div>
		</form>
	</section>
</div>	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		let nameCk = false;
		let nickCk = false;
		let idCk = false;
		let pw1Ck = false;
		let pw2Ck = false;
		let emailCk = false;
		let addressCk = false;
		let hp2Ck = false;
		let hp3Ck = false;
		let code="";
		
		/* 에러 function */
		function name_error(){
			$('#name').next('label').addClass('warning');
			setTimeout(function() {
				$('label').removeClass('warning');
			},1500);
		}
		function nick_error(){
			$('#nick').next('label').addClass('warning');
			setTimeout(function() {
				$('label').removeClass('warning');
			},1500);
		}
		function id_error(){
			$('#id').next('label').addClass('warning');
			setTimeout(function() {
				$('label').removeClass('warning');
			},1500);
		}
		function pw1_error(){
			$('#pw1').next('label').addClass('warning');
			setTimeout(function() {
				$('label').removeClass('warning');
			},1500);
		}
		function pw1_error_message(){
			$('.pw_status').addClass('warning');
			setTimeout(function() {
				$('span').removeClass('warning');
			},1500);
		}
		function pw2_error(){
			$('#pw2').next('label').addClass('warning');
			setTimeout(function() {
				$('label').removeClass('warning');
			},1500);
		}
		function pw2_error_message(){
			$('.pw_no').addClass('warning');
			setTimeout(function() {
				$('span').removeClass('warning');
			},1500);
		}
		function address_error(){
			$('#zipcode').next('label').addClass('warning');
			setTimeout(function() {
				$('label').removeClass('warning');
			},1500);
		}
		function email_error(){
			$('#email').next('label').addClass('warning');
			setTimeout(function() {
				$('label').removeClass('warning');
			},1500);
		}
		function hp_error(){
			$('#hp').next('label').addClass('warning');
			setTimeout(function() {
				$('label').removeClass('warning');
			},1500);
		}
		function hp_error_message(){
			$('.hp_status').addClass('warning');
			$('.hp_status').html('전화번호를 정확히 입력해주세요.');
			setTimeout(function() {
				$('span').removeClass('warning');
			},1500);
		}
		/* 프로필 미리보기 */
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				 
				reader.onload = function (e) {
				$('#profile_img').attr('src', e.target.result); //img태그
				$(".file__img__delete").css('display', "inline");
				}
				reader.readAsDataURL(input.files[0]);
			}//if
		}//function
		 
		// 이벤트를 바인딩해서 input에 파일이 올라올때 (input에 change를 트리거할때) 위의 함수를 this context로 실행합니다.
		$("#profile").on("change", function(){
			var maxSize = 2 * 1024 * 1024;
			if(this.files[0] != null){
				console.log("file-size = "+this.files[0].size);
				if(this.files[0].size > maxSize){
					alert('첨부파일 사이즈는 2MB 이내로 등록 가능합니다.');
				} else{ 
					// 파일 사이즈 유효성 검사 통과하면 미리보기 함수 호출
					console.log('file size pass');
					readURL(this);
				}
			}
		});
		
		$(".file__img__delete").on("click", function(){
			console.log('input{type: file} : '+	$("#profile").val());
			$("#profile").val(null);
			$(".file__img__delete").css('display',"none");
			$('#profile_img').attr('src', '<c:url value='/resources/customer/img/profile.png'/>');
			console.log('input{type: file} : '+	$("#profile").val());
		});
				
		// 주소 api 호출
		document.getElementById('address_btn').addEventListener('click', function(){
			new daum.Postcode({
				oncomplete: function(data){
					$("#zipcode").val(data.zonecode);
					$("#zipcode_label").css({"top":"0","font-size":"13px","color":"#166cea"});
					$("#address").prop('type', "text");
					$("#address_detail").prop('type', "text");
					$("#address_detail_label").css('display', "block");
					$("#address_detail").focus();
					document.getElementById('address').value = data.roadAddress;

					document.getElementById('address_detail').value = '';
					document.getElementById('address_detail').removeAttribute('readonly');
				}
			}).open();
		});
		
		/* 닉네임 중복 검사 */
		$("input[name='member_nickname']").on("change", function(){
			
			$('.nick_status').css('display','block');
			let member_nickname = $('#nick').val();
			if(member_nickname==""){
				$('.nick_status').html('');
			}else if(member_nickname.length<3 || member_nickname.length >10){
				$('.nick_status').html('조건에 맞지 않는 닉네임 입니다.');
				$('.nick_status').css('color','red');
		        nickCk = false;
				nick_error();
			}else {
				$.ajax({
					type : 'POST',
		 			url : "${pageContext.request.contextPath}/member/nickCheck",
					data : member_nickname,
					dataType : 'text',
					async: false,
					headers : {"content-type": "application/json"}, 
					success : function(rec){ //컨트롤러에서 넘어온 rec값을 받는다 
						
					    if(rec == '0'){ //rec가 1이 아니면(=0일 경우) -> 사용 가능한 닉네임
							$('.nick_status').html('사용 가능한 닉네임입니다.');
							$('.nick_status').css('color','green');
							nickCk = true;

					    } else if(rec == '1'){ // rec가 1일 경우 -> 사용 중인 닉네임
							$('.nick_status').html('사용 중인 닉네임입니다.');
							$('.nick_status').css('color','red');
							nickCk = false;
							nick_error();
					    }; 
   	
					}, //success function
					error:function(error){
						console.log("error : "+ error.status);
					}
				}); // ajax
			}; // if				
			console.log("member_nickname = "+ member_nickname);
		});
		
		
		/* 아이디 중복 검사 */
		$("input[name='member_id']").on("change", function(){
			
			$('.id_status').css('display','block');
			let member_id = $('#id').val();
			if(member_id==""){
				$('.id_status').html('');
				idCk = false;
			}else if(member_id.length < 4 || member_id.length > 10){
				$('.id_status').html('조건에 맞지 않는 아이디입니다.');
				$('.id_status').css('color','red');
				idCk = false;
				id_error();
			}else {
				$.ajax({
		            type : 'POST',
		  			url : "${pageContext.request.contextPath}/member/idCheck",
		            data : member_id,
		            dataType : 'text',
		            async: false,
		            headers : {"content-type": "application/json"}, 
		            success : function(rec){ //컨트롤러에서 넘어온 rec값을 받는다 
		            	
		                if(rec == '0'){ //rec가 1이 아니면(=0일 경우) -> 사용 가능한 아이디 
							$('.id_status').html('사용 가능한 닉네임입니다.');
							$('.id_status').css('color','green');
							idCk = true;
		                
		                } else if(rec == '1'){ // rec가 1일 경우 -> 이미 존재하는 아이디
							$('.id_status').html('사용 중인 닉네임입니다.');
							$('.id_status').css('color','red');
							idCk = false;
							id_error();
		                }; 
		            	
		            }, //success function
		            error:function(error){
		                console.log("error : "+ error.status);
		            }
		        }); // ajax
			}; // if				
		        console.log("member_id = "+ member_id);
		}); // idCheck
		
		/* 이메일 중복 검사 */
		$("input[name='member_email']").on("change", function(){
			/* 이메일 정규식 */
			var emailRule = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			
			$('.email_status').css('display','block');
			let member_email = $('#email').val();
			if(member_email==""){
                $('.email_status').html('');
			}else if(!emailRule.test($('#email').val())) {            
				$('.email_status').html('이메일 형식을 확인해주세요.');
				$('.email_status').css('color','red');
				email_error();
			}else {
				$.ajax({
		            type : 'POST',
		  			url : "${pageContext.request.contextPath}/member/emailCheck",
		            data : member_email,
		            dataType : 'text',
		            async: false,
		            headers : {"content-type": "application/json"}, 
		            success : function(rec){ //컨트롤러에서 넘어온 rec값을 받는다 
		            	
		                if(rec == '0'){ //rec가 1이 아니면(=0일 경우) -> 사용 가능한 아이디 
		                    $('.email_status').html('사용 가능한 이메일입니다.');
		    				$('.email_status').css('color','green');
		                    $('.email_check_btn').attr('disabled', false);		    				
		                } else if(rec == '1'){ // rec가 1일 경우 -> 이미 존재하는 아이디
		                    $('.email_status').html('이미 사용중인 이메일입니다.');
		    				$('.email_status').css('color','red');
		                    $('.email_check_btn').attr('disabled', true);
		                    email_error();
		                }; 
		            	
		            }, //success function
		            error:function(error){
		                console.log("error : "+ error.status);
		            }
		        }); // ajax
			}; // if				
		        console.log("member_email = "+ member_email);
		}); // emailcheck
		
		/* 인증번호 이메일 전송 */
		$("button[name='email_check_btn']").click(function(){
			
		    let member_email = $('#email').val();
		    
		    $.ajax({
				type : 'POST',
	 			url : "${pageContext.request.contextPath}/member/sendEmail?member_email=" +member_email,
				async: false,
				success:function(data){
					console.log("data : " +  data);
					$("#email_check").attr('disabled',false);
					$("#email_check").css("background-color", "transparent");
					code=data;
					alert('인증번호가 전송되었습니다.');
				}
			}); // ajax
	
		}); // .click이벤트
	
		/* 인증번호 비교 */
		// blur -> focus가 벗어나는 경우 발생
		$('#email_check').blur(function () {
			const inputCode = $(this).val();
			const $resultMsg = $('.mail_check_warn');
			
			if(inputCode == code){
				$resultMsg.html('인증번호가 일치합니다.');
				$resultMsg.css('color','green');
				$('#mail-Check-Btn').attr('disabled',true);
				$('#email').attr('onFocus', 'this.initialSelect = this.selectedIndex;');
				$('#email').attr('onChange', 'this.selectedIndex = this.initialSelect;');
				emailCk = true;

			}else{
				$resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!.');
				$resultMsg.css('color','red');
				emailCk = false;

			}// if
		});// blur
		
		/* 공백 검사 and 회원가입 */
		$('#btn').on("click", function(){
			/* 이름 */
			if($('#name').val()=="" || $('#name').val()==null){
				name_error();
				nameCk = false;
			}else {
				nameCk = true;
			}
			
			/* 닉네임 */
			if($('#nick').val()=="" || $('#nick').val()==null){
				nick_error();
			}
			
			/* 아이디 */
			if($('#id').val()==""){
				id_error();
			}
			
			//비밀번호 영문자+숫자+특수조합(8~25자리 입력) 정규식
			var pwdCheck = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/;
			
			/* 비밀번호 */
			$('.pw_status').css('display','block');
			$('.pw_no').css('display','block');
			if($('#pw1').val()==""){
				pw1_error();
				pw1Ck = false;
			}else if(!pwdCheck.test($('#pw1').val())){
				pw1_error();				
				pw1Ck = false;
				$('.pw_status').html('비밀번호 형식을 확인해주세요.');
				$('.pw_status').css('color','red');
			}else if(pwdCheck.test($('#pw1').val())){
				pw1Ck = true;
				$('.pw_status').html('사용 가능한 비밀번호입니다.');
				$('.pw_status').css('color','green');
			}
			if($('#pw2').val()==""){
				pw2_error();	
				$('.pw_no').css('display','none');
				pw2Ck = false;
			}else if($('#pw2').val()!==$('#pw1').val()){
				pw2_error();	
				$('.pw_no').html('비밀번호가 일치하지 않습니다.');
				$('.pw_no').css('color','red');
				$('#pw2').val("");
				pw2Ck = false;
			}else{
				pw2Ck = true;
				$('.pw_no').html('');
			}

			/* 주소 */
			if($('#zipcode').val()=="" || $('#address').val()=="" || $('#address_detail').val()=="" ){
				address_error();
				addressCk = false;
			}else {
				addressCk = true;
			}
			
			/* 이메일 */
			if($('#email').val()==""){
				email_error();
			}
			
			/* 전화번호 */
			if($('#hp').val().length == 11){
				hpCk = true;
			}else if($('#hp').val()==""){
				hp_error();
				hpCk = false;
			}else {
				hpCk = false;
				hp_error_message();
			}
			
			console.log("name : "+nameCk+", nick : "+nickCk+", id : "+idCk+
					", pw1 : "+pw1Ck+", pw2 : "+pw2Ck+", address : "+addressCk+", email : "+emailCk+", hp : "+hpCk);
			
			if(nameCk && nickCk && idCk && pw1Ck && pw2Ck && addressCk && emailCk && hpCk){
				joinForm.method="POST";
				joinForm.action="${pageContext.request.contextPath}/member/join";
				joinForm.submit(); 
 			} 
		}); //submitCheck
		
	}); // ready
	</script>
</body>
</html>