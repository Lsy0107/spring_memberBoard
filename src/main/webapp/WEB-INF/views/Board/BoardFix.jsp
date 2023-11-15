<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>Insert title here</title>
			<link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet">
			<style>
				.formWrap {

					width: 600px;
					margin-left: auto;
					margin-right: auto;
				}

				.hits,
				.Date {
					margin: 0;
					display: contents;
				}

				.formIn {
					text-align: center;
					margin-left: auto;
					margin-right: auto;
					margin-top: 10px;
					margin-bottom: 10px;
				}

				textarea {
					resize: none;
					width: 600px;
					height: 400px;
				}

				.BoardWriter {
					display: inline-block;
				}

				.BoardHits {
					display: table;
					box-sizing: border-box;
					width: 33%;
				}

				.BoardDate {
					text-align: right;
					width: 100%;
				}

				input[type="submit"] {
					width: 120px;
					height: 30px;
				}

				.foBtn {
					text-align: center;
					margin-top: 10px;
					margin-bottom: 10px;
				}
			</style>
		</head>

		<body>
			<div class="mainWrap">

				<div class="header">
					<h1>Board/BoardFix.jsp</h1>
				</div>

				<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>

					<div class="contents">
						<h2>게시물 수정 페이지</h2>
						<div class="formWrap">
							<form action="${pageContext.request.contextPath}/fixComplete" method="post">
								<div class="formIn">
									<input type="text" name="btitle" value="${Bview.btitle}">
									<div class="BoardWriter">
										<h4>작성자 : ${Bview.bwriter}</h4>
									</div>
									<div style="display:flex;">
										<div class="BoardHits">
											<h4 class="hits">조회수 : ${Bview.bhits}</h4>
										</div>
										<div class="BoardDate">
											<h4 class="Date">작성일 : ${Bview.bdate}</h4>
										</div>
									</div>
								</div>
								<div class="formIn">
									<textarea name="bcontents">${Bview.bcontents}</textarea>
								</div>
								<div style="text-align: center;">
									<img src="${pageContext.request.contextPath}/resources/boardUpload/${Bview.bfilename}"
										alt="" style="width: 100px;">
								</div>
								<div class="foBtn">
									<input type="submit" value="수정">
								</div>
							</form>
						</div>

					</div>
			</div>

		</body>
		<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
		<script>
			let msg = "${msg}";
			if (msg.length > 0) {
				alert(msg);
			}
		</script>

		</html>