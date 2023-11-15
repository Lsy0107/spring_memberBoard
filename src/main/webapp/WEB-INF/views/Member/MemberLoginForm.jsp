<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/main.css"
	rel="stylesheet">
<style>
.formWrap {
	border: 3px solid black;
	border-radius: 25px;
	height: 400px ;
}

input[type=text] {
	margin-left: auto;
	margin-right: auto;
	margin-top: 15px ;
	margin-bottom: 15px;
	border-radius: 8px;
	display: inherit;
	width: 80%;
	height: 30px;
}
input[type=submit]{
	margin-left: auto;
	margin-right: auto;
	margin-top: 15px ;
	margin-bottom: 15px;
	border-radius: 8px;
	display: inherit;
	width: 200px;
	height: 40px
}
</style>
</head>
 <link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet">
<body>
	<div class="mainWrap">

		<div class="header">
			<h1>Member/MemberLoginForm.jsp</h1>
		</div>

		<%@ include file="/WEB-INF/views/includes/Menu.jsp"%>

		<div class="contents">
			<h2>로그인 페이지</h2>
			<div class="formWrap">
				<form action="${pageContext.request.contextPath}/memberLogin"
					method="post" onsubmit="return joinCheckForm(this)">
					<div>
						<input type="text" name="mid" placeholder="아이디 입력">
					</div>
					<div>
						<input type="text" name="mpw" placeholder="비밀번호 입력">
					</div>

					<input type="submit" value="로그인">
				</form>
					<button onclick="toastrOn()">toastr!!</button>
			</div>
		</div>
	</div>
</body>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script type="text/javascript">
	let msg = "${msg}";
	if (msg.length > 0) {
		alert(msg);
	}
</script>
</html>