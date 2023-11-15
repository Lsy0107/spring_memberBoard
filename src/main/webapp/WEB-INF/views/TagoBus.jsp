<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>BusList</title>
            <link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet">
            <style type="text/css">
                #mapInfo {
                    display: flex;
                }

                #busSttnArea {
                    box-sizing: border-box;
                    border: 1px solid black;
                    margin-left: 3px;
                    padding: 5px;
                    width: 180px;
                    height: 300px;
                    overflow: scroll;
                    font-size: 12px;
                }

                .busSttn {
                    border: 1px solid black;
                    border-radius: 10px;
                    padding: 5px;
                    text-align: center;
                    margin-bottom: 3px;
                    cursor: pointer;
                }

                .busSttn:hover {
                    background-color: gray;
                }
                #busArrInfo{
                	box-sizing:border-box;
                    border: 2px solid black;
                    width: 500px;            
                    padding:5px;
                    margin-top:5px;
                }
                .arrInfo{
                    display: flex;
                    padding:5px;
                    border: 1px solid black;
                    border-radius: 10px;
                    margin-top: 3px;
                }
                #busLocInfo{
                    border: 2px solid black;
                    overflow: scroll;
                    width: 500px;
                    height: 300px;
                    margin-top :10px ;
                }
                .busNode{
                	border:1px solid black;
                	border-radius: 7px;
                	margin-top: 5px;
                	margin-left: 5px;
                }
                .busNode:hover{
                	background-color:gray;
                }
                .nowBus{
                    border: 2px solid red !important;

                }
                .nowBusSttn{
                    background-color: black;
                    color: white;
                    font-weight: bold;
                }
            </style>
        </head>

        <body>
            <div class="mainWrap">
                <div class="header">
                    <h1>TagoBus.jsp</h1>
                </div>

                <%@ include file="/WEB-INF/views/includes/Menu.jsp" %>

                    <div class="contents">
                        <h2>컨텐츠 영역</h2>

                        <div id="TagoBus">
                            <div id="leftInfo">

                                <div id="mapInfo">
                                    <!-- 지도 -->
                                    <div id="map" style="width:500px;height:400px;"></div>

                                    <!-- 정류소 목록/버스 정류소 조회 api -->
                                    <div id="busSttnArea">
                                        <div class="busSttn" onclick="getBusArrInfo('도시코드','정류소id')">
                                            30063
                                            정류소A
                                        </div>

                                    </div>
                                </div>
                                <div id="busArrInfo">
                                    <!-- 도착예정 버스 정보 -->
                                    <div class="arrInfo">
                                        <div>
                                            버스번호
                                        </div>
                                        <div>
                                            남은 정류장
                                        </div>
                                        <div>
                                            도착 예정시간
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div id="busLocInfo">
                                <!-- 버스 노선 정보 -->
                                
                            </div>
                        </div>
                    </div>
            </div>
            <script src="https://kit.fontawesome.com/148f0d76e9.js" crossorigin="anonymous"></script>
            <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
            <script type="text/javascript"
                src="//dapi.kakao.com/v2/maps/sdk.js?appkey=23bdfe79ede96bc585d6800ad13f132f"></script>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
            <script type="text/javascript">
                let msg = "${msg}";
                if (msg.length > 0) {
                    alert(msg);
                }
            </script>
            <script type="text/javascript">

                var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                    mapOption = {
                        center: new kakao.maps.LatLng(37.438829899829784, 126.6755252880684), // 지도의 중심좌표
                        level: 3 // 지도의 확대 레벨
                    };

                var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

                // 지도에 클릭 이벤트를 등록합니다
                // 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
                kakao.maps.event.addListener(map, 'click', function (mouseEvent) {

                    // 클릭한 위도, 경도 정보를 가져옵니다 
                    var latlng = mouseEvent.latLng;


                    console.log("위도:" + latlng.getLat());
                    console.log("경도:" + latlng.getLng());
                    document.querySelector("#busSttnArea").innerHTML="";
                    document.querySelector("#busArrInfo").innerHTML="";
                    document.querySelector("#busLocInfo").innerHTML="";
                    //정류소 목록 조회
                    getBusSttnList(latlng.getLat(), latlng.getLng());
                });
            </script>
            <script type="text/javascript">
                //정류소 목록 조회 기능
                function getBusSttnList(lati, longti) {
                    console.log("getBusSttnList() 호출");
                    console.log(lati + ":" + longti);
                    //1. 정류소 목록 조회
                    $.ajax({
                        type: "get",
                        url: "getTagoSttnList",
                        data: {
                            "lati": lati
                            , "longti": longti
                        },
                        dataType: "json",
                        success: function (result) {
                            //console.log(result);
                            //console.log(result.length)
                            printBusSttn(result);
                        }
                    });

                }
                let currentCityCode = null;

                let oldMarker = null;
                let SttnNodenm = null; //방금 추가한거
                //정류소 목록 출력 기능
                function printBusSttn(sttnList) {
                    console.log(sttnList);
                    console.log(sttnList.length);

                    //div선택
                    let busSttnArea_div = document.querySelector("#busSttnArea");
                    busSttnArea_div.innerHTML = ""; //목록 초기화

                    for (let sttn of sttnList) {

                        let sttnList_div = document.createElement("div");
                        sttnList_div.classList.add("busSttn");
                        //sttnList_div.setAttribute("onclick","getBusArrInfo('"+sttn.citycode+"','"+sttn.nodeid+"')");
                        sttnList_div.innerText = sttn.nodeno + " " + sttn.nodenm;
                        sttnList_div.addEventListener('click', function () {

//집에서 찾아올 부분!!===================================================
                            sttnList_div.classList.toggle("nowBusSttn");


                            // 이동할 위도 경도 위치를 생성합니다 
                            var moveLatLon = new kakao.maps.LatLng(sttn.gpslati, sttn.gpslong);

                            // 지도 중심을 부드럽게 이동시킵니다
                            // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
                            map.panTo(moveLatLon);

                            // 마커가 표시될 위치입니다 
                            var markerPosition = new kakao.maps.LatLng(sttn.gpslati, sttn.gpslong);

                            // 마커를 생성합니다
                            var marker = new kakao.maps.Marker({
                                position: markerPosition
                            });

                            if(oldMarker !=null){
                                oldMarker.setMap(null);
                            }
                            // 마커가 지도 위에 표시되도록 설정합니다
                            marker.setMap(map);
                            // 아래 코드는 지도 위의 마커를 제거하는 코드입니다
                            //marker.setMap(null);   
                            oldMarker = marker;
                            currentCityCode = sttn.citycode;
                            getBusArrInfo(sttn.citycode, sttn.nodeid);
                            SttnNodenm = sttn.nodenm; //방금 추가한거
                        });

                        busSttnArea_div.appendChild(sttnList_div);
                    }

                }
            </script>
            <script type="text/javascript">
                function getBusArrInfo(citycode, nodeid) {
                    console.log("citycode:" + citycode);
                    console.log("nodeid:" + nodeid);
                    $.ajax({
                        type: "get",
                        url: "busArrInfo",
                        data: { "citycode": citycode, "nodeid": nodeid },
                        dataType: "json",
                        success: function (result) {
                            //버스 도착 정보 목록 출력기능
                            console.log(result);

                            printBusArriveInfo(result);
                        }
                    });
                }
				
                let currentClick = null;
                
                function printBusArriveInfo(arrList){
                        console.log("버스도착정보 출력 기능 호출");
                        console.log(arrList);
                        console.log(arrList.length);
                        console.log(arrList.length == undefined);

                        //도착 정보를 출력할 div 선택
                        let busArrInfo_div = document.querySelector("#busArrInfo");
                        busArrInfo_div.innerHTML="";
                        
                        for(let arrInfo of arrList){
                            
                            let arrInfoDiv = document.createElement('div');    
                            arrInfoDiv.classList.add('arrInfo');
                            arrInfoDiv.innerText=arrInfo.routeno+"번 "+
                            arrInfo.arrprevstationcnt+"정거장 전 "+arrInfo.arrtime+"초 후 도착예정";

                            arrInfoDiv.addEventListener('click',function(){
                                console.log("버스 선택! ");
                                //버스 위치 정보 조회 기능
                                if(currentClick!=null){
                                    currentClick.classList.remove("nowBusSttn");
                                    currentClick=null;
                                }
                                    arrInfoDiv.classList.add("nowBusSttn");
                                    currentClick=arrInfoDiv;
                                    
                                

                                getBusLocList(currentCityCode,arrInfo.routeid);
                            })

                            busArrInfo_div.appendChild(arrInfoDiv);
                        }
                }
                function getBusLocList(citycode,routeid){
                    console.log("버스 위치정보 조회 기능 호출");
                    console.log("버스 위치정보 :"+citycode);
                    console.log("버스 위치정보 :"+routeid);
                    let nodeList = null; //정류소 목록
                    let locList = null; //버스 위치 정보 목록

                    //1. 버스노선정보 - 노선별 경유 정류소 목록
                        $.ajax({
                            type : "get",
                            url : "BusNodeInfo",
                            data : {"citycode" :citycode,
                                    "routeid" : routeid},
                            dataType : "json",
                            async : false, //동기식? 으로하는 코드 (평소 ajax코드 따로 기본 코드흐름 따로임)
                            success : function(NodeResult){
                               
                                nodeList = NodeResult;
                            }        
                        });

                    //2. 버스 위치정보 - 노선별 버스 위치 목록 조회
                        $.ajax({
                            type : "get",
                            url : "LocInfo",
                            data : {"citycode":citycode,
                                    "routeid":routeid},
                            dataType : "json",
                            async : false, //위에서부터 아래로 진행되는 코드로 
                            success : function(LocResult){
                                
                                locList = LocResult;
                            }
                        });
                        console.log("노선 목록 ")
                        console.log(nodeList);

                        console.log("버스위치 목록")
                        console.log(locList);

                        let locNodeIdArr = []; //버스 위치 목록의 nodeid 
                        for(let locnode of locList){
                            locNodeIdArr.push(locnode.nodeid);
                        }
                        console.log(locNodeIdArr);

                        let busLocInfoDiv = document.querySelector("#busLocInfo");
                        busLocInfoDiv.innerHTML= "";

                        for(let busNode of nodeList){
                            let busNodeDiv = document.createElement('div');
                            busNodeDiv.classList.add('busNode');
                            
                            
                            //선택한 정류소인지 확인
                            if(SttnNodenm == busNode.nodenm){
                                busNodeDiv.classList.add('nowBusSttn');
                                busNodeDiv.setAttribute("tabindex","0");
                                busNodeDiv.setAttribute("id","focusNode");
                            }



                            /* class="busNode nowBus */
                            /* busNode.nodeid가 버스 위치 목록에 있으면 
                            locList[0].nodeid, locList[1].nodeid,.....locList[n].nodeid
                            */
                           // 해당 정류소에 버스가 위치하고 있는지 확인 하는 코드
                            if(locNodeIdArr.includes(busNode.nodeid)){
                                busNodeDiv.classList.add('nowBus');
                                busNodeDiv.innerHTML='<i class="fa-solid fa-bus"></i>'+busNode.nodenm;
                            }else{
                                busNodeDiv.innerHTML=busNode.nodenm;
                            }


                            busLocInfoDiv.appendChild(busNodeDiv);
                        }
                        document.querySelector("#focusNode").focus();

                }

            </script>
        </body>

        </html>