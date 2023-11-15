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
					border: 3px solid black;
					border-radius: 10px;
					width: 400px;
					margin-left: auto;
					margin-right: auto;
				}

				.formIn {
					text-align: center;
					margin-top: 10px;
					margin-bottom: 10px;
				}

				input[type="text"] {
					width: 200px;
					padding: 8px;
					border-radius: 13px;
				}

				.pWrap {
					text-align: center;
				}
			</style>
		</head>

		<body>
			<div class="mainWrap">

				<div class="header">
					<h1>Member/MyInfoFix.jsp</h1>
				</div>

				<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>

					<div class="contents">
						<h2>내정보 수정 페이지</h2>
						<div class="formWrap">
							<form action="${pageContext.request.contextPath}/infoFix" method="post">
							<div class="pWrap">
								<p style="font-size:5px;">비밀번호</p>
							</div>
							<div class="formIn">
								<input type="text" name="mpw" value="${mInfo.mpw}">
							</div>
							<div class="pWrap">
								<p style="font-size:5px;">이름</p>
							</div>
							<div class="formIn">
								<input type="text" name="mname" value="${mInfo.mname}">
							</div>
							<div class="pWrap">
								<p style="font-size:5px;">생년월일</p>
							</div>
							<div class="formIn">
								<input type="date" name="mbirth">
							</div>
							<div class="pWrap">
								<p style="font-size:5px;">이메일</p>
							</div>
							<div class="formIn">
								<input type="text" name="memailId"  placeholder="이메일아이디"> @
								<input type="text" id="edomain" name="memailDomain"
									placeholder="이메일도메인"> <select onchange="selectDom(this)">
									<option value="">직접입력</option>
									<option value="naver.com">네이버</option>
									<option value="google.com">구글</option>
									<option value="gmail">Gmail</option>
								</select>
							</div>
							<div class="formIn">
								<input type="submit" value="회원정보 수정">
							</div>
						</form>
						</div>
					</div>
			</div>
			
		</body>
		<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
		<script type="text/javascript">
			function selectDom(selobj) {
				document.querySelector('#edomain').value = selobj.value;
			}
		</script>
		
		</html>