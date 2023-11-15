<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>메인페이지</title>
<link href="${pageContext.request.contextPath}/resources/css/main.css"
	rel="stylesheet">
<style>
#MsgId {
	font-size: 8px;
	padding: 0px;
}

.formWrap {
	border: 3px solid black;
	border-radius: 10px;
}

.formRow>input[type=text], .formRow>input[type=date], input[type=submit]
	{
	padding: 5px;
	margin-bottom: 5px;
	margin-top: 5px;
	margin-left: 8px;
	border-radius: 5px;
}

input[type=submit] {
	width: 100px;
	display: block;
	margin-left: auto;
	margin-right: auto;
}
</style>
</head>

<body>
	<div class="mainWrap">

		<div class="header">
			<h1>Member/MemberJoinForm.jsp</h1>
		</div>

		<%@ include file="/WEB-INF/views/includes/Menu.jsp"%>

		<div class="contents">
			<h2>회원가입 페이지</h2>
			<div class="formWrap">
				<form action="${pageContext.request.contextPath}/memberJoin"
					method="post" onsubmit="return joinCheckForm(this)">
					<div class="formRow">
						<input type="text" id="inputId" name="mid" placeholder="아이디입력">
						<button type="button" onclick="idCheck()">중복확인</button>
						<p id="MsgId"></p>
					</div>
					<div class="formRow">
						<input type="text" name="mpw" placeholder="비밀번호입력">
					</div>
					<div class="formRow">
						<input type="text" name="mname" placeholder="이름입력">
					</div>
					<div class="formRow">
						<input type="date" name="mbirth">
					</div>
					<div class="formRow">
						<input type="text" name="memailId" placeholder="이메일아이디"> @
						<input type="text" id="edomain" name="memailDomain"
							placeholder="이메일도메인"> <select onchange="selectDom(this)">
							<option value="">직접입력</option>
							<option value="naver.com">네이버</option>
							<option value="google.com">구글</option>
							<option value="gmail">Gmail</option>
						</select>
					</div>

					<input type="submit" value="회원가입">

				</form>
			</div>
		</div>
	</div>
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<script type="text/javascript">
		function selectDom(selobj) {
			document.querySelector('#edomain').value = selobj.value;
		}
	</script>
	<script type="text/javascript">
		function idCheck() {
			//중복확인 할 아이디 value 확인
			let idEl = document.querySelector('#inputId');
			console.log(idEl.value);
			//아이디 중복 확인 요청 -ajax
			$
					.ajax({
						type : "get", /*요청 방식*/
						url : "idCheck", /*요청 url*/
						data : {
							"inputId" : idEl.value
						}, /*전송 파라메터*/
						success : function(re) { /*전송에 성공 했을 경우*/
							/*re : 응답받은 데이터*/
							console.log("확인결과 : " + re);
							if (re == "Y") {
								$('#MsgId').css("color", "green").text(
										"사용가능한 아이디입니다.");
							} else {
								$('#MsgId').css("color", "red").text(
										"중복된 아이디입니다.");
							}
						}

					});
		}
		function joinCheckForm(formObj) {
			let idEl = formObj.mid;
			let pwEl = formObj.mpw;
			let nameEl = formObj.mname;
			let birthEl = formObj.mbirth;
			let eamilEl = formObj.memailId;
			let domainEl = formObj.memailDomain;

			if (idEl.value == "") {
				alert("아이디 비어있음.");
				return false;
			}
			if (pwEl.value == "") {
				alert("비밀번호 비어있음.");
				return false;
			}
			if (nameEl.value == "") {
				alert("이름 비어있음.");
				return false;
			}
			if (birthEl.value == "") {
				alert("생년월일 비어있음.");
				return false;
			}
			if (emailEl.value == "") {
				alert("이메일아이디 비어있음.");
				return false;
			}
			if (domainEl.value == "") {
				alert("이메일도메인 비어있음.");
				return false;  
			}
			return true;
		}
	</script>
	<script type="text/javascript">
		let msg = "${msg}";
		if (msg.length > 0) {
			alert(msg);
		}
	</script>

</body>

</html>