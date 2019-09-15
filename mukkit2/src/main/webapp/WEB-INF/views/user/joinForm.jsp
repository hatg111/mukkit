<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/resources/dist/css/joinForm.css">
<%@ include file="/WEB-INF/include/header.jspf"%>
<!-- 2019-08-09 추가 전용태 -->
<script>
var memberid;
var nickname;
var password;
var confirmPassword;
var gender;
var birthdate;
var authkey;
var code;
var p = /^[a-zA-z]{1}[a-zA-Z0-9]{4,12}@\w{4,8}\.(com|co.kr|net)/;
var p2 = /^[A-Za-z0-9]{6,12}$/;
var idCheck = 0;
var nickCheck = 0;
var pwdCheck = 0;
var inputed;
var reinputed;
var codeCheck = 0;
	$(document)
			.ready(
					function() {
						$("#btnSignup").prop("disabled", true);
						$("#btnSignup").css("background-color", "#aaaaaa");
						$("#btnSignup")
								.click(
										function() {
											nickname = $("#nickname").val();
											password = $("#password").val();
											confirmPassword = $("#confirmPassword").val();
											memberid = $("#memberid").val();
											gender = $("#gender").val();
											birthdate = $("#birthdate").val();

											if ((memberid || nickname
													|| password || confirmPassword
													|| gender || birthdate) == "") {
												alert("회원 정보를 입력하세요.");
											} else {
												$("#form").submit();
											}

										});
						
						$("#btnCancle").click(function() {
							$('#memberid').val('');
							$('#password').val('');
							$('#confirmPassword').val('');
							$('#nickname').val('');
							$('#gender').val('');
							$('#birthdate').val('');
							$("#error1").text("");
							$("#error2").text("");
							$("#error3").text("");
							$("#error4").text("");
							$("#memberid").css("background-color", "#ffffff");
							$("#nickname").css("background-color", "#ffffff");
							$("#confirmPassword").css("background-color", "#ffffff");
						});
						
						$("#btnMail").click(function() {
							memberid = $("#memberid").val();
							console.log("ggg");
							$.ajax({
								data : {
									memberid : memberid
								},
								url : "/user/sendmail",
								dataType : 'text',
								type : 'POST',
								success : function(data) {
										console.log(data);
										authkey = data;
										alert("인증메일을 전송했습니다.");
										//$("#error1").append("<br/><input class='hihihi' type='text' name='code' id='code' placeholder='코드를 입력하세요.' required value='"+data+"'>");
										$("#error1").append("<br/><input class='hihihi' type='text' name='code' id='code' placeholder='코드를 입력하세요.' required oninput='chkCode()'>");
								}
							});	
						});
					});
	//아이디 체크하여 가입버튼 비활성화, 중복확인.
	function checkId() {
		inputed = $("#memberid").val();
		console.log(inputed);
		$.ajax({
			data : {
				memberid : inputed
			},
			url : "/user/checkId",
			dataType : 'text',
			type : 'POST',
			success : function(data) {
				if (inputed == "" && data == '0') {
					$("#btnSignup").prop("disabled", true);
					$("#btnSignup").css("background-color", "#aaaaaa");
					$("#memberid").css("background-color", "#FFCECE");
					$("#error1").text("아이디를 입력하세요.");
					idCheck = 0;
				} else if (data == '0' && p.test(inputed)) {
					$("#memberid").css("background-color", "#B0F6AC");
					$("#error1").text("사용 가능한 아이디 입니다.");
					idCheck = 1;
					if (idCheck == 1 && pwdCheck == 1 && codeCheck == 1) {
						$("#btnSignup").prop("disabled", false);
						$("#btnSignup").css("background-color", "#4CAF50");
						$("#error1").text("");
					}
				} else if (data == '1') {
					$("#btnSignup").prop("disabled", true);
					$("#btnSignup").css("background-color", "#aaaaaa");
					$("#memberid").css("background-color", "#FFCECE");
					$("#error1").text("이미 존재하는 아이디 입니다.");
					idCheck = 0;
				} else if (!p.test(inputed)) {
					$("#memberid").css("background-color", "#FFCECE");
					$("#error1").text("이메일 형식으로 입력하세요.");
				}
			}
		});
	}
	//재입력 비밀번호 체크하여 가입버튼 비활성화 또는 맞지않음을 알림.
	function checkPwd() {
		inputed = $('#password').val();
		reinputed = $('#confirmPassword').val();
		console.log(inputed);
		console.log(reinputed);
		if (reinputed == "" && (inputed != reinputed || inputed == reinputed)) {
			$("#btnSignup").prop("disabled", true);
			$("#btnSignup").css("background-color", "#aaaaaa");
			$("#confirmPassword").css("background-color", "#FFCECE");
			$("#password").css("background-color", "#FFCECE");
			$("#error4").text("비밀번호를 입력하세요.");
		} else if (inputed == reinputed) {
			$("#confirmPassword").css("background-color", "#B0F6AC");
			$("#password").css("background-color", "#B0F6AC");
			$("#error4").text("비밀번호가 일치합니다.");
			pwdCheck = 1;
			if (idCheck == 1 && pwdCheck == 1 && codeCheck == 1) {
				$("#btnSignup").prop("disabled", false);
				$("#btnSignup").css("background-color", "#4CAF50");
			}
		} else if (inputed != reinputed) {
			pwdCheck = 0;
			$("#btnSignup").prop("disabled", true);
			$("#btnSignup").css("background-color", "#aaaaaa");
			$("#confirmPassword").css("background-color", "#FFCECE");
			$("#error4").text("비밀번호가 다릅니다.");

		}
	}
	//닉네임
	function checkNick() {
		inputed = $("#nickname").val();
		console.log(nickname);
		$.ajax({
			data : {
				nickname : inputed
			},
			url : "/user/checkNickname",
			dataType : 'text',
			type : 'POST',
			success : function(data) {
				if (inputed == "" && data == '0') {
					$("#btnSignup").prop("disabled", true);
					$("#btnSignup").css("background-color", "#aaaaaa");
					$("#nickname").css("background-color", "#FFCECE");
					$("#error2").text("닉네임을 입력하세요.");
					nickCheck = 0;
				} else if (data == '0') {
					$("#nickname").css("background-color", "#B0F6AC");
					$("#error2").text("사용 가능한 닉네임 입니다.");
					nickCheck = 1;
					if (nickCheck == 1 && pwdCheck == 1 && codeCheck == 1) {
						$("#btnSignup").prop("disabled", false);
						$("#btnSignup").css("background-color", "#4CAF50");
					}
				} else if (data == '1') {
					$("#btnSignup").prop("disabled", true);
					$("#btnSignup").css("background-color", "#aaaaaa");
					$("#nickname").css("background-color", "#FFCECE");
					$("#error2").text("이미 존재하는 닉네임 입니다.");
					nickCheck = 0;
				}
			}
		});
	}
	//인증코드
	function chkCode(){
		code = $("#code").val();
		if(authkey == code){
			codeCheck = 1;
			$("#error1").text("인증완료");
		}else{
			$("#error5").text("인증실패");
		}
	}
	

	
</script>
<!-- 2019-08-09 추가 전용태 end -->
<form action="/user/insertUser" method="post" id="form">
	<br />
	<h2>회원가입 양식</h2>
	<br />
	<div class="align-center">
		<input class="hihihi" type="text" name="memberid" id="memberid"
			placeholder="이메일을 입력하세요." required autofocus oninput="checkId()">
			<button type="button" id="btnMail">이메일 인증</button>
		<br />
		<div id="error1"></div>
		<div id="error5"></div>
		<br/>
		<input class="hihihi" type="text" name="nickname" id="nickname"
			required id="nickname" placeholder="이름을 입력하세요." oninput="checkNick()">
		<div id="error2"></div>
	
	<br />
	
		<input class="hihihi" type="password" name="password" required
			placeholder="비밀번호를 입력하세요." id="password">
		<%-- <c:if test="${errors.password}">암호를 입력하세요.</c:if> --%>
		<div id="error3"></div>
	<br />
		<input class="hihihi" type="password" required name="confirmPassword"
			placeholder="비밀번호를 다시 입력하세요." id="confirmPassword"
			oninput="checkPwd()">
		<div id="error4"></div>
	<br />
		<b>성별</b> <br /> <label><input type="radio" name="gender"
			id="gender" value="M" required id="gender">남자</label> <label>
			<input type="radio" name="gender" value="F" id="gender">여자
		</label>
	<br />
		<b>생일</b><br /> <input type="date" name="birthdate" required
			id="birthdate">
	<br />
		<button type="button"  id="btnSignup">회원가입</button>
		<button type="button"  id="btnCancle">취소</button>
		<!-- <button type="button" id="btnMail">이메일 인증</button> -->
	</div>
</form>

<%@ include file="/WEB-INF/include/footer.jspf"%>
