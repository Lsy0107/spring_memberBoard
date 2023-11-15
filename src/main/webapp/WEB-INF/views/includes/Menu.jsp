<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.min.js"></script>
<div class="nav">
	<ul>
		<li><a href="${pageContext.request.contextPath}/memberChatPage">회원채팅</a></li>

		<li><a href="${pageContext.request.contextPath}/busapi">버스도착정보</a></li>

		<li><a href="${pageContext.request.contextPath}/TagoBus">TagoBus</a></li>

		<li><a href="${pageContext.request.contextPath}/busapi_ajax">버스도착정보_ajax</a></li>

		<li><a href="${pageContext.request.contextPath}/BoardList">게시판</a></li>
		<c:choose>
			<c:when test="${sessionScope.loginMemberId == null}">
				<li><a href="${pageContext.request.contextPath}/MemberJoinForm">회원가입</a></li>
				<li><a
					href="${pageContext.request.contextPath}/MemberLoginForm">로그인</a></li>
			</c:when>


			<c:otherwise>
				<li><a href="${pageContext.request.contextPath}/MyInfo">${sessionScope.loginMemberId}</a></li>
				<li><a href="${pageContext.request.contextPath}/BoardWriteForm">글쓰기</a></li>
				<li><a href="${pageContext.request.contextPath}/MemberLogOut">로그아웃</a></li>
			</c:otherwise>
		</c:choose>
	</ul>
</div>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<!-- <script type="text/javascript">
	var noticeSock = new SockJS('noticeSocket');
	noticeSock.onopen = function() {
		console.log('noticeSocket 접속');
	};

	noticeSock.onmessage = function(e) {
	};

	noticeSock.onclose = function() {
		console.log('noticeSocket 접속해제');
	};
</script>
 -->

