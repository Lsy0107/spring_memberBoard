<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>    
    <html>

    <head>
        <meta charset="UTF-8">
        <title>BusList</title>
        <link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet">
    </head>

    <body>
        <div class="mainWrap">
            <div class="header">
                <h1>BusList.jsp</h1>
            </div>

            <%@ include file="/WEB-INF/views/includes/Menu.jsp" %>

            <div class="contents">
                <h2>버스 도착 정보</h2>
                <table>
                	<tr>
                		<th>정류소명</th>
                		<th>버스번호</th>
                		<th>남은정류장</th>
                		<th>도착예정시간</th>
                	</tr>
                	<c:forEach items="${busList}"  var="bus">
                		<tr>
                			<td>${bus.nodenm}</td>
                			<td>${bus.routeno} 번</td>
                			<td>${bus.arrprevstationcnt} 전</td>
                			<td>${bus.arrtime} 초 후 도착예정</td>
                		</tr>
                	</c:forEach>
                </table>
            </div>
        </div>
    <script src="${pageContext.request.contextPath}/resources/js/main.js">        
    </script>   
    <script type="text/javascript">
    	let msg = "${msg}";
    	if(msg.length>0){
    		alert(msg);
    	}
    </script> 
    </body>

    </html>