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
	border-radius: 10px;
	width: 650px;
	margin-left: auto;
	margin-right: auto;
}

.formBoard {
	margin-top: 10px;
	margin-bottom: 10px;
	border: 3px solid black;
	border-radius: 10px;
	width: 600px;
	margin-left: auto;
	margin-right: auto;
}

input[type="text"] {
	width: 100%;
	height: 25px;
	box-sizing: border-box;
	border-radius: 10px;
	border: none;
	outline: none;
}

textarea {
	width: 100%;
	height: 200px;
	box-sizing: border-box;
	border-radius: 10px;
	resize: none;
	border: none;
	outline: none;
	box-sizing: border-box;
}

input[type="submit"] {
	width: 600px;
	height: 35px;
	margin-left: auto;
	margin-right: auto;
	display: inherit;
	border-radius: 10px;
	margin-bottom: 10px;
}
input[type="button"]{
    width: 150px;
    border-radius: 5px;
}
</style>
</head>

<body>
	<div class="mainWrap">

		<div class="header">
			<h1>Board/BoardWriteForm.jsp</h1>
		</div>

		<%@ include file="/WEB-INF/views/includes/Menu.jsp"%>

		<div class="contents">
			<h2>글작성 페이지</h2>
			<div class="formWrap">
				<form action="${pageContext.request.contextPath}/BoardWrite"
					method="post" enctype="multipart/form-data"> 
					<div class="formBoard">
						<input type="text" name="btitle" placeholder="글 제목">
					</div>
					<div class="formBoard">
						<textarea name="bcontents" placeholder="글 내용"></textarea>
					</div>
					<div class="formBoard">
						<div style="padding:5px;">
							<input type="file" name="bfile" value="파일 선택">

						</div>
					</div>

					<input type="submit" class="submitBtn" value="글 등록">

				</form>
			</div>
		</div>
	</div>
</body>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>

</html>