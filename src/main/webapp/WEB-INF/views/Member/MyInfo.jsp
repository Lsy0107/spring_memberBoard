<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
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
	border-radius:10px;
	width: 400px;
	margin-left:auto;
	margin-right:auto;
}
.formIn{
	text-align:center;
	margin-top: 10px;
	margin-bottom: 10px;
}
input[type="text"]{
	width: 200px;
	padding: 8px;
    border-radius: 13px;
}
.pWrap{
	text-align: center;
}
</style>
</head>

<body>
	<div class="mainWrap">

		<div class="header">
			<h1>Member/MyInfo.jsp</h1>
		</div>

		<%@ include file="/WEB-INF/views/includes/Menu.jsp"%>

		<div class="contents">
			<h2>내정보 조회 페이지</h2>
			<div class="formWrap">
				<div class="pWrap">
					<p style="font-size:5px;">아이디</p>
				</div>
				<div class="formIn">
					<input type="text" value="${mInfo.mid}" readonly>
				</div>
				<div class="pWrap">
					<p style="font-size:5px;">비밀번호</p>
				</div>
				<div class="formIn">
					<input type="text" value="${mInfo.mpw}" readonly>
				</div>
				<div class="pWrap">
					<p style="font-size:5px;">이름</p>
				</div>
				<div class="formIn">
					<input type="text" value="${mInfo.mname}" readonly>
				</div>
				<div class="pWrap">
					<p style="font-size:5px;">생년월일</p>
				</div>
				<div class="formIn">
					<input type="text" value="${mInfo.mbirth}" readonly> 
				</div>
				<div class="pWrap">
					<p style="font-size:5px;">이메일</p>
				</div>
				<div class="formIn">
					<input type="text" value="${mInfo.memail}" readonly>
				</div>
				<div class="formIn">
					<input type="submit" value="비밀번호 변경" onclick="pwCheck('${mInfo.mpw}')">
				</div>
			</div>
			<hr>
				작성한 글 : ${BoardInfo}개
			<hr>
				작성한 댓글 : ${RepInfo}개
		</div>
	</div>
</body>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script type="text/javascript">
	function pwCheck(mpw){
		let inputpw = prompt("비밀번호 입력");
		if(mpw == inputpw){
			location.href="MyInfoFix";
		}else{
			alert("비밀번호를 다시 확인해주세요")
		}
	}
</script>
</html>