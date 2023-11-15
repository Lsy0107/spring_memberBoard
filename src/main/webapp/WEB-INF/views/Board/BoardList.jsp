<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.css">

<link href="${pageContext.request.contextPath}/resources/css/main.css"
	rel="stylesheet">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
table {
	border-collapse: collapse;
}

th, td {
	border-top: 1px solid black;
}
</style>
</head>

<body>
	<div class="mainWrap">

		<div class="header">
			<h1>Board/BoardList.jsp</h1>
		</div>

		<%@ include file="/WEB-INF/views/includes/Menu.jsp"%>

		<div class="contents">
			<h2>게시판 페이지 - ${noticeMsg}</h2>
			<div class="formWrap">
				<table>
					<thead>
						<tr>
							<th style="width: 50px;">번호</th>
							<th style="width: 300px;">제목</th>
							<th style="width: 200px;">작성자</th>
							<th style="width: 100px;">날짜</th>
							<th style="width: 100px;">조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="Boards" items="${bList}">
							<tr>
								<td>${Boards.bno}</td>
								<td><a
									href="${pageContext.request.contextPath}/BoardView?ViewBno=${Boards.bno}">${Boards.btitle}</a>
									<c:if test="${Boards.bfilename != null}">
										<span><i class="fa-solid fa-image"></i></span>
									</c:if> <i class="fa-solid fa-comment"></i> <span>${Boards.recount}</span>

								</td>
								<td>${Boards.bwriter}</td>
								<td>${Boards.bdate}</td>
								<td>${Boards.bhits}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

		<hr>

		<div class="contents">
			<h2>게시판 페이지 - ${noticeMsg}</h2>
			<div class="formWrap">
				<table>
					<thead>
						<tr>
							<th style="width: 50px;">번호</th>
							<th style="width: 300px;">제목</th>
							<th style="width: 200px;">작성자</th>
							<th style="width: 100px;">날짜</th>
							<th style="width: 100px;">조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="bListMap" items="${bListMap}">
							<tr>
								<td>${bListMap.BNO}</td>
								<td><a
									href="${pageContext.request.contextPath}/BoardView?ViewBno=${bListMap.BNO}">${bListMap.BTITLE}</a>
									<c:if test="${bListMap.BFILENAME != null}">
										<span><i class="fa-solid fa-image"></i></span>
									</c:if> <i class="fa-solid fa-comment"></i> <span>${bListMap.RECOUNT}</span>

								</td>
								<td>${bListMap.BWRITER}</td>
								<td>${bListMap.BDATE}</td>
								<td>${bListMap.BHITS}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
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


</html>