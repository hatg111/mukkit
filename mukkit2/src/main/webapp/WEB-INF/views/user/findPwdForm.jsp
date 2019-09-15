<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/resources/dist/css/findPwdForm.css">
<%@ include file="/WEB-INF/include/header.jspf"%>
<!-- 2019-08-09 추가 전용태 -->
<script>
	$(document).ready(
			function() {

				$("#memberid").blur(function() {
					var memberid = $("#memberid").val();
					if (memberid == "") {
						$("#error1").text("아이디를 입력하세요");
					}
				});

				$("#nickname").blur(function() {
					var nickname = $("#nickname").val();
					if (nickname == "")
						$("#error2").text("닉네임을 입력하세요");
				});
				$("#btnSignup").click(
						function() {
							nickname = $("#nickname").val();
							memberid = $("#memberid").val();
							gender = $("#gender").val();
							birthdate = $("#birthdate").val();
							if ((memberid || nickname || password || npassword
									|| gender || birthdate) == "") {
								alert("회원 정보를 입력하세요.");
							} else {
								//alert("이메일로 임시 비밀번호를 발급했습니다.")
								$("#bookingForm").submit();
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
			});
</script>
<!-- 2019-08-09 추가 전용태 end -->
<form action="/user/findPwdSuccess" method="post" id="bookingForm">
	<br />
	<h2>비밀번호 찾기</h2>
	<br />
	<div class="align-center">
		<input class="hihihi" type="text" name="memberid" id="memberid"
			placeholder="아이디를 입력하세요." required autofocus><br />
		<div id="error1"></div>
	</div>
	<br />
	<div class="align-center">
		<input class="hihihi" type="text" name="nickname" required
			id="nickname" value="${param.name}" placeholder="닉네임을 입력하세요.">
		<br />
		<div id="error2"></div>
	</div>
	<br />
	<div class="align-center">
		<b>성별</b> <br /> <label><input class="hihihi" type="radio"
			name="gender" id="gender" value="M" required>남자</label> <label><input
			class="hihihi" type="radio" name="gender" id="gender" value="F">여자</label>
	</div>
	<br />

	<div class="align-center">
		<b>생일</b> <br /> <input class="hihihi" type="date" name="birthdate"
			id="birthdate" required>
	</div>
	<br />
	<div class="align-center">
		<input class="ok" type="submit" value=" 확인  " id="btnSignup">
		<input class="ok" type="reset" value=" 취소  " id="btnCancle">
	</div>

</form>

<%@ include file="/WEB-INF/include/footer.jspf"%>