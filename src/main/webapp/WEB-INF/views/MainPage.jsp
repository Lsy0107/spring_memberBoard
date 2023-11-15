<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>메인페이지</title>
<link href="${pageContext.request.contextPath}/resources/css/main.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.css">

<!-- TOASTR CSS -->

</head>

<body>
	<div class="mainWrap">
		<div class="header">
			<h1>MainPage.jsp</h1>
		</div>

		<%@ include file="/WEB-INF/views/includes/Menu.jsp"%>

		<div class="contents">
			<h2>컨텐츠 영역</h2>
			<button onclick="sendText()">클릭!!</button>

		</div>
	</div>
	<script type="text/javascript">
		function sendText() {
			noticeSock.send("test");
		}
	</script>

	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/noticeJs.js"></script>

	<!-- JQUERY 다음에 TOASTR가 와야함 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.min.js"></script>

	<script type="text/javascript">
		let noticeSock = connectNotice('${noticeMsg}');
	</script>
	<script type="text/javascript">
		function sendText() {
			let noticeObj = {"noticeType" : "board"}
			noticeSock.send(JSON.stringify(noticeObj));
		}
	</script>


</body>

</html>