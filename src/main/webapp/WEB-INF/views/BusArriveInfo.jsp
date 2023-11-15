<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>BusArriveInfo</title>
            <link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet">
            <script type="text/javascript"
                src="//dapi.kakao.com/v2/maps/sdk.js?appkey=23bdfe79ede96bc585d6800ad13f132f"></script>
       <style type="text/css">

       
       
       </style>
        </head>

        <body>
            <div class="mainWrap">
                <div class="header">
                    <h1>BusArriveInfo.jsp</h1>
                </div>

                <%@ include file="/WEB-INF/views/includes/Menu.jsp" %>

                    <div class="contents">
                        <h2>버스 도착 정보 ajax</h2>

                        <div id="map" style="width:500px;height:400px;"></div>

                        <hr>

                        <div id="busSttnArea">

                        </div>

                        <div id="busInfoArea">

                        </div>
                        <div id="busGpsArea">

                        </div>
                    </div>
            </div>
        </body>
        <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
        <script type="text/javascript">
            let msg = "${msg}";
            if (msg.length > 0) {
                alert(msg);
            }
        </script>
        <script type="text/javascript">
            function getBusArriveInfo(nodeId,citycode) {
                console.log("nodeId : " + nodeId);
                console.log("citycode : "+citycode);
                //1. 도착정보 조회 ajax
                $.ajax({
                    type: "get",
                    url: "getBusArr",
                    data: { "nodeId": nodeId, 
                            "cityCode":citycode
                },
                    dataType: "json",
                    success: function (arrInfoList) {
                        printEl(arrInfoList,citycode);
                       

                    }
                });
                
            
            }
        </script>
        <script type="text/javascript">
            function printEl(arrInfoList,citycode) {
                let busInfoArea_div = document.querySelector("#busInfoArea");
                busInfoArea_div.innerHTML = "";

                let tableTag = document.createElement('table');

                let trTag = document.createElement('tr');

                let thTag1 = document.createElement('th');
                thTag1.innerText = "번호";
                trTag.appendChild(thTag1);

                let thTag2 = document.createElement('th');
                thTag2.innerText = "남은정류장";
                trTag.appendChild(thTag2);

                let thTag3 = document.createElement('th');
                thTag3.innerText = "도착예정시간";
                trTag.appendChild(thTag3);

                tableTag.appendChild(trTag);

                for (let info of arrInfoList) {
                    let infoTrTag = document.createElement('tr');

                    let tdTag_routeno = document.createElement('td');
                    let tdTag_routenoBtnTag = document.createElement('button');
                    
                    tdTag_routenoBtnTag.setAttribute("onclick","BusInfoView('"+citycode+"','"+info.routeid+"')");
                    tdTag_routenoBtnTag.innerText = info.routeno;

                    

                    tdTag_routeno.appendChild(tdTag_routenoBtnTag);
                    
                    infoTrTag.appendChild(tdTag_routeno);

                    let tdTag_cnt = document.createElement('td');
                    tdTag_cnt.innerText = info.arrprevstationcnt + "번째 전";
                    infoTrTag.appendChild(tdTag_cnt);

                    let tdTag_arrtime = document.createElement('td');
                    tdTag_arrtime.innerText = info.arrtime + "초 후 도착예정";
                    infoTrTag.appendChild(tdTag_arrtime);

                    

                    tableTag.appendChild(infoTrTag);
                }


                busInfoArea_div.appendChild(tableTag);

            }

        </script>
        <script type="text/javascript">
            $(document).ready(function () {
                getBusSttnList(37.4398411, 126.6640894);
            });

            function getBusSttnList(lati, longti) {
                $.ajax({
                    type: "get",
                    url: "getBusSttn",
                    data: {
                        "lati": lati,
                        "longti": longti
                    },
                    dataType: "json",
                    success: function (sttnList) {
                        printE2(sttnList)


                    }
                });
            }

        </script>
        <script type="text/javascript">
            function printE2(sttnList) {
                let sttnDiv = document.querySelector("#busSttnArea");

                sttnDiv.innerHTML = "";
                let idx = 0;

                for (let SttnInfo of sttnList) {
                    let sttnBtn = document.createElement('button');
                    sttnBtn.classList.add('sttnBtn');
                    sttnBtn.setAttribute("onclick", "getBusArriveInfo('"+SttnInfo.nodeid+"','"+SttnInfo.citycode+"')");


                    sttnBtn.innerHTML = SttnInfo.nodeno + "<br>" + SttnInfo.nodenm;
                    sttnDiv.appendChild(sttnBtn);
                    idx++;
                    if (idx % 5 == 0) {
                        let br = document.createElement('br');
                        sttnDiv.appendChild(br);
                    }
                }

            }

        </script>

        <script type="text/javascript">
            function BusInfoView(citycode,routeid){
                console.log(citycode);
                console.log(routeid);
                $.ajax({
                    type: "get",
                    url: "GpsBusInfo",
                    data: {
                        "cityCode":citycode,
                        "routeId":routeid
                    },
                    dataType: "json",
                    success: function(GpsSttn){
                        console.log(GpsSttn);
                        GpsBus(GpsSttn)
                        
                    }
                });
                $.ajax({
                    type: "get",
                    url: "NodeInfo",
                    data: {
                        "cityCode":citycode,
                        "routeId":routeid
                    },
                    dataType : "json",
                    success: function(NodeInfo){
                        NodeInfo(NodeInfo)
                    }
                })
            }

        </script>
        <script type="text/javascript">
            function NodeInfo(NodeInfo){
                let busGpsArea_div = document.querySelector("#busGpsArea");
                busGpsArea_div.innerHTML = "";

                let busGpsTable = document.createElement('table');
                busGpsArea_div.appendChild(busGpsTable);

                let busTableTr = document.createElement('tr');
                busGpsTable.appendChild(busTableTr);


                let busTableTh = document.createElement('th');
                busTableTr.appendChild(busTableTh);
                busTableTh.innerText = "현재정류장";

                

                for(let nodeInfo of NodeInfo){

                    let busGpsTr = document.createElement('tr');

                    let busGpsTh = document.createElement('th');
                    busGpsTr.appendChild(busGpsTh);
                    busGpsTh.innerText=nodeInfo.nodeord;

                    


                    busGpsTable.appendChild(busGpsTr);

                }

            }

        </script>
        <script type="text/javascript">
            var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                mapOption = {
                    center: new kakao.maps.LatLng(37.4398411, 126.6640894), // 지도의 중심좌표
                    level: 3 // 지도의 확대 레벨
                };

            var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

            // 지도에 클릭 이벤트를 등록합니다
            // 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
            kakao.maps.event.addListener(map, 'click', function (mouseEvent) {

                // 클릭한 위도, 경도 정보를 가져옵니다 
                var latlng = mouseEvent.latLng;

                var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
                message += '경도는 ' + latlng.getLng() + ' 입니다';

                console.log(message);
                getBusSttnList(latlng.getLat(),latlng.getLng());
            });
        </script>

        </html>