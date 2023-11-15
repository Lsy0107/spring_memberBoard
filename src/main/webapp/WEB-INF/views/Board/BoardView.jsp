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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.css">
<style>
.formWrap {
	width: 600px;
	margin-left: auto;
	margin-right: auto;
}

.hits, .Date {
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

.formIn textarea {
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
<style>
.replyArea {
	border: 3px solid black;
	border-radius: 10px;
	width: 600px;
	margin: 0 auto;
	padding: 15px;
}

.replyWrite textarea {
	border-radius: 7px;
	width: 96%;
	min-height: 70px;
	font-family: auto;
	resize: none;
	padding: 8px;
}

.replyWrite button {
	width: 100%;
	margin-top: 5px;
	cursor: pointer;
	padding: 5px;
}

.reply {
	display: flex;
}

.reply>p {
	padding: 0;
	margin: 3px;
}

.recomm {
	margin-top: 5px;
	border-radius: 7px;
	width: 96%;
	min-height: 70px;
	font-family: auto;
	resize: none;
	padding: 8px;
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
			<h2>게시판 페이지</h2>
			<div class="formWrap">

				<div class="formIn">
					<input type="text" name="btitle" value="${Bview.btitle}" readonly>
					<div class="BoardWriter">
						<h4>작성자 : ${Bview.bwriter}</h4>
					</div>
					<div style="display: flex;">
						<div class="BoardHits">
							<h4 class="hits">조회수 : ${Bview.bhits}</h4>
						</div>
						<div class="BoardDate">
							<h4 class="Date">작성일 : ${Bview.bdate}</h4>
						</div>
					</div>
				</div>
				<div class="formIn">
					<textarea name="bcontents" readonly>${Bview.bcontents}</textarea>
				</div>
				<div style="text-align: center;">
					<img
						src="${pageContext.request.contextPath}/resources/boardUpload/${Bview.bfilename}"
						alt="" style="width: 100px;">
				</div>

			</div>
			<c:if test="${sessionScope.loginMemberId == Bview.bwriter}">
				<div class="foBtn">
					<input type="submit" value="수정"
						onclick="location.href='${pageContext.request.contextPath}/BoardFix'">
					<input type="submit" value="삭제">
				</div>
			</c:if>
			<hr>


			<div class="replyArea">
				<c:if test="${sessionScope.loginMemberId != null }">
					<div class="replyWrite">
						<h3>댓글 작성 양식 - 로그인한 경우 출력</h3>
						<form onsubmit="return replyWrite(this)">
							<input type="hidden" name="rebno" value="${Bview.bno}">
							<input type="hidden" name="bwriter" value="${Bview.bwriter}">
							<textarea name="recomment" placeholder="댓글 내용 작성"></textarea>
							<button type="submit">댓글등록</button>
						</form>
					</div>
				</c:if>

				<h3>댓글 목록 출력</h3>

				<div id="replyList">
					<h3>댓글 출력</h3>
					<div id="replyList"></div>
				</div>


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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.min.js"></script>
	<script type="text/javascript">
		let noticeSock = connectNotice('${noticeMsg}');
	</script>
<script type="text/javascript">
			function replyWrite(formobj) {
				console.log("replywrite 호출" + formobj.rebno.value)
				/* ajax 댓글 등록 요청 전송 */
				$.ajax({
					type: "get",
					url: "replyWrite",
					data: { "rebno": formobj.rebno.value, "recomment": formobj.recomment.value },
					success: function (result) {
						console.log("result : " + result)
						if (result == '1') {
							alert("댓글이 등록되었습니다.");
							//댓글 목록 조회 요청 >> 댓글 목록 데이터 응답
							formobj.recomment.value = "";
							//댓글 목록 갱신
							getReplyList(formobj.rebno.value);
							
							//NoticeSock.send( {"noticeType" : "댓글 알림", "bno" : "글번호", "bwriter" : "글 작성자"} ); json 형식의 string으로 보냄
							//"공지타입,글번호,작성자"
							
							let noticeObj = {"noticeType" : "reply",
											"noticeMsg" : formobj.rebno.value,
											"receiveId" : formobj.bwriter.value		
											};
							noticeSock.send(JSON.stringify(noticeObj) );
							
						} else {
							alert("댓글 등록 실패");
						}
					}
				});

				return false;
			}
			//댓글 목록 조회 및 출력
			function getReplyList(rebno) {
				console.log("getReplyList() 호출");
				console.log("댓글 조회할 글번호 : " + rebno);
				$.ajax({
					type: "get",
					url: "replyList",
					data: { "rebno": rebno },
					dataType: "json",
					success: function (reList) {
						console.log("실행");
						printReplyList(reList) //댓글 출력 기능 호출
					}
				});
			}
		</script>
<script type="text/javascript">
			let bno = '${Bview.bno}'; //현재 글번호
			console.log(bno);
			$(document).ready(function () {
				
				getReplyList(bno);
				/*SELECT문 DAO -> ArrayList<Replys> -> JSON 변환 -> 페이지로 응답*/

			});
		</script>
<script type="text/javascript">
			let loginId = '${sessionScope.loginMemberId}';
			console.log("로그인된 아이디 : " + loginId);
		
			function printReplyList(reList){
				
				
				let reListDiv = document.querySelector('#replyList');
				reListDiv.innerHTML="";
				
				
				for(let reInfo of reList){
					
				let reDiv = document.createElement('div');
				reDiv.classList.add("reply");
				
				let reWriter = document.createElement('p');
				reWriter.classList.add("reWriter");
				reWriter.innerText = reInfo.remid;
				reDiv.appendChild(reWriter);
				
				let reDate = document.createElement('p');
				reDate.classList.add("reDate");
				reDate.innerText = reInfo.redate;
				reDiv.appendChild(reDate);
				
			if( reInfo.remid = loginId){
				let reBtn = document.createElement('button');
				reBtn.innerText = "삭제";
				reBtn.setAttribute("onclick", "delReply( '"+reInfo.renum+"' )");
				reDiv.appendChild(reBtn);
				}
				let recomm = document.createElement('textarea');
				
				recomm.classList.add("recomm");
				recomm.innerText = reInfo.recomment;
				recomm.setAttribute('disabled', 'disabled');
				reListDiv.appendChild(reDiv);
				reListDiv.appendChild(recomm);
					
				}
				
			}
		</script>

<script type="text/javascript">
			function delReply(delrenum){
				console.log('삭제할 댓글 번호 : ' + delrenum);
				let confirmVal = confirm('댓글을 삭제 하시겠습니까?');
				if(confirmVal){
					$.ajax({
						type : "get",
						url : "deleteReply",
						data : { "renum" : delrenum },
						dataType : "json",
						success : function(result){
							if(result == '1'){
								getReplyList(bno);
								
							} else
								alert('댓글 삭제 처리를 실패하였습니다.');
							
						}
					
					});
				}
			}
		</script>


</html>