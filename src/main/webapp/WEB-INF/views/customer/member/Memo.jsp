<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
//----------------------------------------------------------
<form name="joinForm" enctype="multipart/form-data">
	
	<input type="file" id="profile" name="member_profile_image" accept="image/jpg, image/jpeg, image/png" style="display:none;"/>
	
	<input type="image" id="profile_image" name="member_image" style="display:none;"/>
	
	<label for="profile" style="width:100%">
		<img id="profile_img" alt="프로필 이미지" src="<c:url value='/resources/customer/img/profile.png'/>" style="display:block; margin:auto; height:100px;">
	</label>
	
</form>
<script type="text/javascript">
/* 프로필 미리보기 */
function readURL(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		 
		reader.onload = function (e) {
		//img태그
		$('#profile_img').attr('src', e.target.result); 
		//input태그
		$('#profile_image').val($('#profile').val()); 
		console.log($('#profile_image').val());
		}
		 
		reader.readAsDataURL(input.files[0]);
	}//if
}//function
 
// 이벤트를 바인딩해서 input에 파일이 올라올때 (input에 change를 트리거할때) 위의 함수를 this context로 실행합니다.
$("#profile").change(function(){
	var maxSize = 2 * 1024 * 1024;
	console.log("file-size = "+this.files[0].size);
	if(this.files[0].size > maxSize){
		alert('첨부파일 사이즈는 2MB 이내로 등록 가능합니다.');
	} else{ 
		// 파일 사이즈 유효성 검사 통과하면 미리보기 함수 호출
		console.log('file size pass');
		readURL(this);
	}
});
</script>













//----------------------------------------------------------
<div class="int-area">
	<input type="text" oninput="this.value = this.value.replace(/[^a-z|A-Z|0-9|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '').replace(/(\..*)\./g, '$1');"
	name="member_nicknamename" id="nick" autocomplete="off" required title="닉네임을 입력해주세요.">
	<label for="nick">닉네임<text> *</text></label>
	<span>특수문자 사용불가(3~10자리 입력)</span><br>
	<span class="nick_status"></span>
</div>

<input type='hidden' name="member_no">

<input type='file' id="myFile" name="member_image" />

<input type="text" name="member_name" id="name" autocomplete="off" required title="이름을 입력해주세요.">

<input type="text" oninput="this.value = this.value.replace(/[^a-z|A-Z|0-9|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '').replace(/(\..*)\./g, '$1');"
name="member_nick" id="nick" autocomplete="off" required title="닉네임을 입력해주세요.">

<input type="text" oninput="this.value = this.value.replace(/[^a-z|A-Z|0-9]/g, '').replace(/(\..*)\./g, '$1');"
name="member_id" id="id" autocomplete="off" required title="아아디를 입력해주세요.">

<input type="password" oninput="this.value = this.value.replace(/[^a-z|A-Z|0-9|!@#$%^*+=-]/g, '').replace(/(\..*)\./g, '$1');"
name="member_password" id="pw1" autocomplete="off" required title="비밀번호를 입력해주세요.">

<input type="text" id="zipcode" name="member_zipcode" readonly="readonly" required="required">

<input type="text" name="member_email" id="email" autocomplete="off" required title="이메일을 입력해주세요.">

<input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
name="member_hp" id="hp" autocomplete="off" maxlength="11" required title="전화번호를 입력해주세요.">



<div class="int-area">

	<div class="int-area-addressCheck">
		<input type="text" id="zipcode" name="member_zipcode" readonly="readonly" required="required">
		<label for="zipcode">주소<text> *</text></label>
		<button type="button" class="address_btn" id="address_btn" >우편번호 찾기</button>
	</div>
	
	<input type="text" id="address" name="member_address" readonly="readonly" required="required" style="display:none;">
	<input type="text" id="address_detail" name="member_address_detail" readonly="readonly" required="required" placeholder="상세주소">
</div>

<script type="text/javascript">

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

function address_error(){
	$('#address').next('label').addClass('warning');
	setTimeout(function() {
		$('label').removeClass('warning');
	},1500);
}

/ 주소 api 호출
document.getElementById('address_btn').addEventListener('click', function(){
	new daum.Postcode({
		oncomplete: function(data){
			document.getElementById('member_zipcode').value = data.zonecode;
			
			document.getElementById('member_address').value = data.roadAddress;
			
			document.getElementById('member_address_detail').value = '';
			document.getElementById('member_address_detail').removeAttribute('readonly');
			document.getElementById('member_address_detail').style.border = '1px solid red';
		}
	}).open();
});
</script>


<div class="int-area">
<input type="email" name="member_email" id="email" autocomplete="off" required title="이메일을 입력해주세요.">
<label for="email">이메일<text> *</text></label>
<span class="email_status"></span>
<div class="int-area-emailCheck">
	<input type="text" name="member_email_check" id="email_check" autocomplete="off" disabled="disabled" required title="인증번호를 입력해주세요.">
	<button type="button" class="email_check_btn" name="email_check_btn" disabled>인증번호 발송</button>
</div>
<span class="mail_check_warn"></span>
</div>

<script type="text/javascript">
/* 이메일 에러 function */
function email_error(){
	$(email).next('label').addClass('warning');
	setTimeout(function() {
		$('label').removeClass('warning');
	},1500);
}

/* 이메일 중복 검사 */
$("input[name='member_email']").on("change", function(){
	/* 이메일 정규식 */
	var emailRule = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
				
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

$('#btn').on("click", function(){
	/* 이름 */
	if($('#name').val()==""){
		$('#name').next('label').addClass('warning');
		setTimeout(function() {
			$('label').removeClass('warning');
		},1500);
		nameCk = false;
	}else {
		nameCk = true;
	}
	
	/* 닉네임 */
	if($('#nick').val()==""){
		$('#nick').next('label').addClass('warning');
		setTimeout(function() {
			$('label').removeClass('warning');
		},1500);
	}
	
	/* 아이디 */
	if($('#id').val()==""){
		$('#id').next('label').addClass('warning');
		setTimeout(function() {
			$('label').removeClass('warning');
		},1500);
	}
	
	//비밀번호 영문자+숫자+특수조합(8~25자리 입력) 정규식
	var pwdCheck = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/;
	
	/* 비밀번호 */
	if($('#pw1').val()==""){
		$('#pw1').next('label').addClass('warning');
		setTimeout(function() {
			$('label').removeClass('warning');
		},1500);
	}else if (!pwdCheck.test($('#pw1').val())){
		$('#pw1').next('label').addClass('warning');
		setTimeout(function() {
			$('label').removeClass('warning');
		},1500);
		
		$('.pw_check_warn').html('비밀번호 형식을 확인해주세요.');
		$('.pw_check_warn').css('color','red');
	
	}
	if($('#pw2').val()==""){
		$('#pw2').next('label').addClass('warning');
		setTimeout(function() {
			$('label').removeClass('warning');
		},1500);
	}
	if($('#pw2').val()!==$('#pw1').val()){
		$('#pw2').next('label').addClass('warning');
		$('#pw2').val("");
		setTimeout(function() {
			$('label').removeClass('warning');
		},1500);
		$('.pw_no').css("display", "inline-block");
		pw1Ck = false;
		pw2Ck = false;
	} else {
		pw1Ck = true;
		pw2Ck = true;
	}
	
	/* 이메일 */
	if($('#email').val()==""){
		email_error();
	}
	
	/* 전화번호 */
	if($('#hp1').val()==""){
		$('#hp1').next('label').addClass('warning');
		setTimeout(function() {
			$('label').removeClass('warning');
		},1500);
		hp1Ck = false;
	}else {
		hp1Ck = true;
	}
	if($('#hp2').val()==""){
		$('#hp').addClass('warning');
		setTimeout(function() {
			$('label').removeClass('warning');
		},1500);
		hp2Ck = false;
	}else if($('#hp2').val().length == 4){
		hp2Ck = true;
	}
	if($('#hp3').val()==""){
		$('#hp').addClass('warning');
		setTimeout(function() {
			$('label').removeClass('warning');
		},1500);
		hp3Ck = false;
	}else if($('#hp3').val().length == 4){
		hp3Ck = true;
	}
	
	if(nameCk && nickCk && idCk && pw1Ck && pw2Ck && emailCk && hp1Ck && hp2Ck && hp3Ck){
		joinForm.method="POST";
		joinForm.action="${pageContext.request.contextPath}/member/join";
		joinForm.submit(); 
	}else {
		
	}
}); //submitCheck

let nameCk = false;
let nickCk = false;
let idCk = false;
let pwCk = false;
let emailCk = false;
let hp2Ck = false;
let hp3Ck = false;
let code="";

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
function pw2_error(){
	$('#pw2').next('label').addClass('warning');
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
function hp2_error(){
	$('#hp2').next('label').addClass('warning');
	setTimeout(function() {
		$('label').removeClass('warning');
	},1500);
}
function hp3_error(){
	$('#hp3').next('label').addClass('warning');
	setTimeout(function() {
		$('label').removeClass('warning');
	},1500);
}
</script>

</body>
</html>