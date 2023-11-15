<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>채팅페이지</title>
<style type="text/css">
#chatAreaDiv::-webkit-scrollbar {
	width: 10px;
}

#chatAreaDiv::-webkit-scrollbar-thumb {
	background-color: wheat;
	border-radius: 10px;
	background-clip: padding-box;
	border: 2px solid transparent;
}

#chatAreaDiv::-webkit-scrollbar-track {
	background-color: white;
	border-radius: 10px;
	box-shadow: inset 0px 0px 5px white;
}

#inputMsg {
	display: flex;
	box-sizing: border-box;
	border: 3px solid black;
	border-radius: 10px;
	width: 650px;
	padding: 10px;
}

#inputMsg>input {
	width: 100%;
	padding: 5px;
}

#inputMsg>button {
	width: 100px;
	padding: 5px;
}

#chatAreaDiv {
	box-sizing: border-box;
	border: 3px solid black;
	border-radius: 10px;
	padding: 10px;
	width: 650px;
	background-color: #9bbbd4;
	height: 500px;
	overflow: scroll;
	overflow-x: hidden;
}

.msgDiv {
	disyplay: inline-block;
}

.connDiv {
	min-width: 200px;
	max-width: 300px;
	margin-left: auto;
	margin-right: auto;
	text-align: center;
	background-color: #556677;
	color: white;
	border-radius: 10px;
	margin-bottom: 10px;
	padding: 5px;
}

.msgComment {
	display: inline-block;
	padding: 7px;
	border-radius: 7px;
	max-width: 220px;
}

.receiveMsg>.msgComment {
	background-color: #ffffff;
}

.sendMsg>.msgComment {
	background-color: #fef01b;
	margin-bottom: 10px;
}

.sendMsg {
	text-align: right;
}

.msgId {
	font-weight: bold;
	font-size: 13px;
	margin-bottom: 2px;
}

#chatAreaDiv {
	width: 900px;
}

#leftContent {
	margin: 5px;
}

#rightContent {
	margin: 5px;
	width: 230px;
}

#connMembersArea {
	box-sizing: border-box;
	border: 3px solid black;
	border-radius: 10px;
	padding: 7px;
}

.connMember {
	border: 2px solid black;
	border-radius: 7px;
	padding: 5px;
	margin: 5px;
}
</style>
<link href="${pageContext.request.contextPath}/resources/css/main.css"
	rel="stylesheet">
</head>

<body>
	<div class="mainWrap">
		<div class="header">
			<h1>채팅페이지 - views/ChatPage.jsp - ${sessionScope.loginMemberId }</h1>
		</div>

		<%@ include file="/WEB-INF/views/includes/Menu.jsp"%>

		<div class="contents">
			<div id="chatAreaDiv"></div>
			<div id="inputMsg">
				<input type="text" id="sendMsg">
				<button onclick="sendMsg()" id="sendBtn">전송</button>
			</div>

			<div id="rightContent">
				<div id="connMembersArea"></div>
			</div>

		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	<script type="text/javascript">
		var sock = new SockJS('ChatPage');
		sock.onopen = function() {
			console.log('open');
		};

		sock.onmessage = function(e) {
			let msgObj = JSON.parse(e.data);
			let mtype = msgObj.msgtype;

			switch (mtype) {
			case "m":
				printMessage(msgObj); // 메세지 출력 기능
				break;
			case "c":
				printConnect(msgObj);
				break;
			case "d":
				printDisConnect(msgObj); // 접속 정보 출력 기능
				break;
			}

		};

		sock.onclose = function() {
			console.log('close');
		};
	</script>
	<script type="text/javascript">
		function sendMsg() {
			let msgInput = document.querySelector("#sendMsg");
			sock.send(msgInput.value);
			let chatAreaDiv = document.querySelector('#chatAreaDiv');
			let sendMsg = document.createElement('div');
			sendMsg.classList.add('sendMsg');
			let msgComm = document.createElement('div');
			msgComm.classList.add('msgComment');
			msgComm.innerText = msgInput.value;
			sendMsg.appendChild(msgComm);
			chatAreaDiv.appendChild(sendMsg);
			msgInput.value = "";

			chatAreaDiv.scrollTop = chatAreaDiv.scrollHeight;
		}
	</script>
	<script type="text/javascript">
		function printMessage(msgObj) {
			let chatAreaDiv = document.querySelector('#chatAreaDiv');
			let receiveDiv = document.createElement('div');
			receiveDiv.classList.add('receiveMsg');
			let idDiv = document.createElement('div');
			idDiv.classList.add('idDiv');
			idDiv.innerText = msgObj.msgid;
			let msgDiv = document.createElement('div');
			msgDiv.classList.add('msgComment');
			msgDiv.innerText = msgObj.msgcomm;
			receiveDiv.appendChild(idDiv);
			receiveDiv.appendChild(msgDiv);
			chatAreaDiv.appendChild(receiveDiv);

			chatAreaDiv.scrollTop = chatAreaDiv.scrollHeight;

		}
	</script>

	<script type="text/javascript">
		function printConnect(msgObj) {
			let chatAreaDiv = document.querySelector('#chatAreaDiv');
			let connDiv = document.createElement('div');
			connDiv.classList.add('connDiv');

			connDiv.innerText = msgObj.msgid + "가 입장했습니다.";

			chatAreaDiv.appendChild(connDiv);

			chatAreaDiv.scrollTop = chatAreaDiv.scrollHeight;
			//접속정보 >> 접속자 목록에서 출력/삭제 (id="connMembersArea")
			let connMembersAreaDiv = document.querySelector("#connMembersArea");

			//msgtype = 'c' >> 접속자 목록에 추가
			let connMemberDiv = document.createElement('div');
			connMemberDiv.classList.add('connMember');
			connMemberDiv.setAttribute('id', msgObj.msgid);
			connMemberDiv.innerText = msgObj.msgid;
			connMembersAreaDiv.appendChild(connMemberDiv);

		}
	</script>

	<script type="text/javascript">
		function printDisConnect(msgObj) {
			let chatAreaDiv = document.querySelector('#chatAreaDiv');
			let connDiv = document.createElement('div');
			connDiv.classList.add('connDiv');

			connDiv.innerText = msgObj.msgid + "가 퇴장했습니다.";
			chatAreaDiv.appendChild(connDiv);

			document.querySelector('#' + msgObj.msgid).remove();
		}
	</script>

	<script src="${pageContext.request.contextPath}/resources/js/main.js">
		
	</script>
	<script type="text/javascript">
		let msg = "${msg}";
		if (msg.length > 0) {
			alert(msg);
		}
	</script>
	<script type="text/javascript">
		let msgInputTag = document.querySelector("#sendMsg");

		msgInputTag.addEventListener("keyup", function(e) {
			if (e.keyCode === 13) {
				sendMsg();
			}
		});
	</script>
</body>

</html>