<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/resources/dist/css/ChangeUserInfo.css">
<%@ include file="/WEB-INF/include/header.jspf"%>
<!-- 2019-09=05 추가 전용태 -->
<script>
	var nickname;
	var password;
	var newpassword;
	var sel_file;
	var nickCheck = 0;
	var pwdCheck = 0;
	var newnickname;
	var unickname;
	var uPwd;
	var p = /^[A-Za-z0-9]{4,12}$/;
	$(document).ready(
			function() {

				$("#btnSignup").prop("disabled", true);
				$("#btnSignup").css("background-color", "#aaaaaa");

				$("#profileImg").click(function() {
					$("#input_img").click();
				});
				$("#btnSignup").click(
						function() {
							nickname = $("#nickname").val();
							password = $("#password").val();
							newpassword = $("#newpassword").val();
							newnickname = $("#newnickname").val();
							unickname = "${userVO.nickname}";
							uPwd = "<c:out value='${userVO.password}'/>";

							/* if ((unickname != nickname) || (uPwd != password)) {
								$("#error1").text("회원정보 불일치");
							} else */ if (password == "" /* || newpassword == ""
									|| nickname == "" || newnickname == "" */) {
								alert("회원 정보를 입력하세요.");
								history.go(-1);
							} /* else if (password == newpassword
									|| nickname == newnickname) {
								alert("회원 정보를 확인하세요.");
								history.go(-1);
								$('#newpassword').val('');
								$('#newnickname').val('');
							}  else if (!p.test(newpassword)
									|| !p.test(newnickname)) {
								alert("회원 정보를 확인하세요.");
								history.go(-1);
							}*/ else {
								$("#form").submit();
							}
						});

				$("#btnCancle").click(function() {
					$('#password').val('');
					$('#newpassword').val('');
					$('#nickname').val('');
					$('#newnickname').val('');
					$("#error0").text("");
					$("#error1").text("");
					$("#error2").text("");
					$("#error3").text("");
					$("#nickname").css("background-color", "#ffffff");
					$("#newnickname").css("background-color", "#ffffff");
					$("#newpassword").css("background-color", "#ffffff");
					$("#password").css("background-color", "#ffffff");
				});
			});

	$(document).ready(function() {
		$("#input_img").on("change", fileChange);
	});

	function fileChange(e) {
		e.preventDefault();

		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);

		filesArr.forEach(function(f) {
			if (!f.type.match("image.*")) {
				alert("확장자는 이미지 확장자만 가능합니다.");
				return;
			}

			sel_file = f;

			var reader = new FileReader();
			reader.onload = function(e) {
				$("#profileImg").attr("src", e.target.result);
				$("#profileImg").css("height", "100px")
			}
			reader.readAsDataURL(f);
		});

		var file = files[0]
		console.log(file)
		var formData = new FormData();

		formData.append("file", file);

		$.ajax({
			url : '/user/uploadAjax',
			data : formData,
			dataType : 'text',
			processData : false,
			contentType : false,
			type : 'POST',
			success : function(data) {
				var str = "";

				if (checkImageType(data)) {
					str = "<a href=displayFile?fileName=" + getImageLink(data)
							+ ">" + "<img src='displayFile?fileName=" + data
							+ "'/>" + "</a><small data-src="+data+">X</small>";
				} else {
					str = "<a href='displayFile?fileName=" + data + "'>"
							+ getOriginalName(data) + "</a>"
							+ "<small data-src="+data+">X</small>";
				}
				$("#Img").append(str);

				alert("프로필 이미지가 변경 되었습니다.")

			}
		});

		function checkImageType(fileName) {
			var pattern = /jpg$|gif$|png$|jpeg$/i;
			return fileName.match(pattern);
		}

		function getOriginalName(fileName) {
			if (checkImageType(fileName)) {
				return;
			}

			var idx = fileName.indexOf("_") + 1;
			return fileName.substr(idx);

		}

		function getImageLink(fileName) {

			if (!checkImageType(fileName)) {
				return;
			}
			var front = fileName.substr(0, 12);
			var end = fileName.substr(14);

			return front + end;

		}

	}

	function checkPwd() {
		password = $("#password").val();
		/* if (password == newpassword) {
			$("#btnSignup").prop("disabled", true);
			$("#btnSignup").css("background-color", "#aaaaaa");
			$("#newpassword").css("background-color", "#FFCECE");
			$("#error1").text("현재 비밀번호와 일치합니다.");
		} else {
			$("#newpassword").css("background-color", "#ffffff");
			$("#error1").text("");
		} */
		
		$.ajax({
			data : {
				password : password
			},
			url : "/user/checkPwd",
			dataType : 'text',
			type : 'POST',
			success : function(data) {
				console.log(p.test(newpassword));
				if (password == "" && data == '0') {
					$("#btnSignup").prop("disabled", true);
					$("#btnSignup").css("background-color", "#aaaaaa");
					$("#password").css("background-color", "#FFCECE");
					$("#error0").text("비밀번호를 입력하세요");
					pwdCheck = 1;
				} else if (data == '0') {
					$("#password").css("background-color", "#FFCECE");
					$("#error0").text("현재 비밀번호가 일치하지 않습니다..");
					pwdCheck = 1;
				} else if (data == '1') {
					$("#btnSignup").prop("disabled", true);
					$("#btnSignup").css("background-color", "#aaaaaa");
					$("#password").css("background-color", "#B0F6AC");
					$("#error0").text("비밀번호가 일치합니다.");
					pwdCheck = 1;
					nickCheck = 1;
					if (nickCheck == 1 && pwdCheck == 1) {
						$("#btnSignup").prop("disabled", false);
						$("#btnSignup").css("background-color", "#4CAF50");
						$("#error1").text("");
					}
				}
			}
		});
	}
	
	function checkNewPwd() {
		password = $("#password").val();
		newpassword = $("#newpassword").val();
		$.ajax({
			data : {
				password : password
			},
			url : "/user/checkPwd",
			dataType : 'text',
			type : 'POST',
			success : function(data) {
				console.log(p.test(newpassword));
				/* if(!p.test(newpassword)) {
					$("#btnSignup").prop("disabled", true);
					$("#btnSignup").css("background-color", "#aaaaaa");
					$("#newpassword").css("background-color", "#FFCECE");
					$("#error1").text("형식에 맞지 않습니다.");
				}
				else  */if(newpassword == "") {
					/* $("#btnSignup").prop("disabled", true);
					$("#btnSignup").css("background-color", "#aaaaaa");
					$("#newpassword").css("background-color", "#FFCECE");
					$("#error1").text("비밀번호를 입력하세요"); */
					$("#newpassword").attr('value', "${userVO.password}");
					pwdCheck = 1;
				/* } else {
					$("#btnSignup").prop("disabled", false);
					$("#btnSignup").css("background-color", "#4CAF50");
					$("#newpassword").css("background-color", "#B0F6AC");
					$("#error1").text("");
					pwdCheck = 1; */
					if (nickCheck == 1 && pwdCheck == 1) {
						$("#btnSignup").prop("disabled", false);
						$("#btnSignup").css("background-color", "#4CAF50");
						$("#error1").text("");
					}
				}
			}
		});
	}

	/* function checkNick() {
		nickname = $("#nickname").val();
		newnickname = $("#newnickname").val();
		$.ajax({
			data : {
				nickname : nickname
			},
			url : "/user/checkNickname",
			dataType : 'text',
			type : 'POST',
			success : function(data) {
				if (nickname == "" && data == '0') {
					$("#btnSignup").prop("disabled", true);
					$("#btnSignup").css("background-color", "#aaaaaa");
					$("#nickname").css("background-color", "#FFCECE");
					$("#error2").text("닉네임을 입력하세요.");
					nickCheck = 1;
				} else if (data == '0') {
					$("#nickname").css("background-color", "#FFCECE");
					$("#error2").text("현재 닉네임과 일치하지 않습니다.");
					nickCheck = 1;
				} else if (data == '1') {
					$("#btnSignup").prop("disabled", true);
					$("#btnSignup").css("background-color", "#aaaaaa");
					$("#nickname").css("background-color", "#B0F6AC");
					$("#error2").text("현재 닉네임과 일치합니다.");
					nickCheck = 1;
					if (nickCheck == 1 && pwdCheck == 1 && newnickname != "") {
						$("#btnSignup").prop("disabled", false);
						$("#btnSignup").css("background-color", "#4CAF50");
					}
				} else if (nickname == newnickname) {
					$("#btnSignup").prop("disabled", true);
					$("#btnSignup").css("background-color", "#aaaaaa");
					$("#newnickname").css("background-color", "#FFCECE");
					$("#error3").text("현재 닉네임과 일치합니다.!!!!!");
				}
			}
		});
	} */
	
	function checkNewNick() {
		nickname = $("#nickname").val();
		newnickname = $("#newnickname").val();
		$.ajax({
			data : {
				nickname : nickname
			},
			url : "/user/checkNickname",
			dataType : 'text',
			type : 'POST',
			success : function(data) {
				$("#newnickname").attr('value', "${userVO.nickname}");
				console.log(newnickname);
				if (newnickname == "") {
					//$("#btnSignup").prop("disabled", true);
					//$("#btnSignup").css("background-color", "#aaaaaa");
					//$("#newnickname").css("background-color", "#FFCECE");
					//$("#error3").text("닉네임을 입력하세요.");
					//nickCheck = 0;
					
					$("#newnickname").attr('value', "${userVO.nickname}");
				}/*  else if (nickname == newnickname) {
					$("#btnSignup").prop("disabled", true);
					$("#btnSignup").css("background-color", "#aaaaaa");
					$("#newnickname").css("background-color", "#FFCECE");
					$("#error3").text("현재 닉네임과 일치합니다.!!!!!");
				} else if(!p.test(newnickname)){
					$("#btnSignup").prop("disabled", true);
					$("#btnSignup").css("background-color", "#aaaaaa");
					$("#newnickname").css("background-color", "#FFCECE");
					$("#error3").text("형식에 맞지 않습니다.");
				}else{
					$("#btnSignup").prop("disabled", false);
					$("#btnSignup").css("background-color", "#4CAF50");
					$("#newnickname").css("background-color", "#B0F6AC");
					$("#error3").text("");
				} */
			}
		});
	}
</script>
<!-- 2019-08-09 추가 전용태 end -->
<h2>회원정보 수정</h2>
<br />
<div class="align-center" id="Img"></div>
<div class="align-center">
	<button type="button" id="profileImg">등록</button>
	<input type="file" name="file" id="input_img" style="display: none">
</div>
<form class=".form" action="/user/changePwdSuccess" method="post"
	id="form">
	<br />
	<div class="align-center">
		<input class="hihihi" type="memberid" name="memberid" id="memberid"
			value="${userVO.memberid}" readonly>
	</div>
	<br />
	<div class="align-center">
		<input class="hihihi" type="password" name="password" id="password"
			placeholder="현재 비밀번호를 입력하세요." required autofocus oninput="checkPwd()">
		<div id="error0"></div>
	</div>
	<br />
	<div class="align-center">
		<input class="hihihi" type="password" name="newpassword"
			id="newpassword" placeholder="새 비밀번호를 입력하세요." required
			oninput="checkNewPwd()">
		<div id="error1"></div>
	</div>
	<br />
	<div class="align-center">
		<input class="hihihi" type="text" name="nickname" id="nickname"
			placeholder="${userVO.nickname}" value="${userVO.nickname}" required oninput="checkNick()">
		<div id="error2"></div>
	</div>
	<br />
	<div class="align-center">
		<input class="hihihi" type="text" name="newnickname" id="newnickname"
			placeholder="새 닉네임을 입력하세요." required oninput="checkNewNick()">
		<div id="error3"></div>
	</div>
	<br />
	<div class="align-center">
		<button type="button" id="btnSignup">수정완료</button>
		<button type="button" id="btnCancle">취소</button>
	</div>
</form>
<%@ include file="/WEB-INF/include/footer.jspf"%>

<!-- <SCRIPT LANGUAGE=JavaScript>
	function checkCapsLock(e) {

		var myKeyCode = 0;
		var myShiftKey = false;
		var myMsg = 'Caps Lock is On.\n\nTo prevent entering your password incorrectly,\nyou should press Caps Lock to turn it off.';

		// Internet Explorer 4+

		if (document.all) {
			myKeyCode = e.keyCode;
			myShiftKey = e.shiftKey;

			// Netscape 4
		} else if (document.layers) {
			myKeyCode = e.which;
			myShiftKey = (myKeyCode == 16) ? true : false;

			// Netscape 6
		} else if (document.getElementById) {
			myKeyCode = e.which;
			myShiftKey = (myKeyCode == 16) ? true : false;

		}

		if ((myKeyCode >= 65 && myKeyCode <= 90) && !myShiftKey) {
			alert(myMsg);
			return false;

		} else if ((myKeyCode >= 97 && myKeyCode <= 122) && myShiftKey) {
			alert(myMsg);
			return false;
		}

	}
</SCRIPT> -->

