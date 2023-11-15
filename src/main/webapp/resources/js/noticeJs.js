/**
 * noticeJs
 */
 	function connectNotice(noticeMsg){
 		var noticeSock = new SockJS('noticeSocket');
		noticeSock.onopen = function() {
			console.log('notice 접속');
			if(noticeMsg.length > 0){
				noticeSock.send(noticeMsg);
			}
		};

		noticeSock.onmessage = function(e) {
			console.log('message',e.data);
			//toastr 호출 알람 출력
			noticeAlert(e.data);
		};

		noticeSock.onclose = function() {
			console.log('notice 접속해제');
		};
		return noticeSock;
}		
	function noticeAlert(msgjson){
		let msgObj = JSON.parse(msgjson);
		let mtype = msgObj.msgtype;
		switch(mtype){
		case "reply":
			toastr.options.onclick = function() { location.href='/controller/BoardView?ViewBno='+msgObj.msgcomm; }
			toastr.success(msgObj.msgcomm + "번 글에 댓글이 등록 되었습니다.");
			break;
		case "board":
			toastr.options.onclick = function() { location.href='/controller/BoardList'; }
			toastr.info(msgObj.msgcomm);	
			break;
		}
		
	}	