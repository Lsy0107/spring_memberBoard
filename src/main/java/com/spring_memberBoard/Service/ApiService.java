package com.spring_memberBoard.Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.spring_memberBoard.dao.Bus;

@Service
public class ApiService {

	public ArrayList<Bus> getBusArrive() throws Exception {
		System.out.println("SERVICE getBusArrive() 호출");
		
		 StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/ArvlInfoInqireService/getSttnAcctoArvlPrearngeInfoList"); /*URL*/
	        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=S7zgFEQqSlrWVhHdRtINMDDNv%2BTnaJrW2iEOUsm2Y5UdcfYh6inhqrsA1Qls%2BtLEub4iFJ4UT89YTfsFhZ0sZQ%3D%3D"); /*Service Key*/
	        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
	        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
	        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*데이터 타입(xml, json)*/
	        urlBuilder.append("&" + URLEncoder.encode("cityCode","UTF-8") + "=" + URLEncoder.encode("23", "UTF-8")); /*도시코드 [상세기능3 도시코드 목록 조회]에서 조회 가능*/
	        urlBuilder.append("&" + URLEncoder.encode("nodeId","UTF-8") + "=" + URLEncoder.encode("ICB163000063", "UTF-8")); /*정류소ID [국토교통부(TAGO)_버스정류소정보]에서 조회가능*/
	        URL url = new URL(urlBuilder.toString());
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        System.out.println("Response code: " + conn.getResponseCode());
	        BufferedReader rd;
	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }
	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = rd.readLine()) != null) {
	            sb.append(line);
	        }
	        rd.close();
	        conn.disconnect();
	        System.out.println(sb.toString());
		
	        //변환
	        JsonObject busInfo_Json = (JsonObject) JsonParser.parseString(sb.toString()); 
	        System.out.println("[busInfo_Json] "+busInfo_Json);
	        JsonArray infoList = busInfo_Json.get("response").getAsJsonObject()
	        		.get("body").getAsJsonObject()
	        		.get("items").getAsJsonObject()
	        		.get("item").getAsJsonArray();
	        
	        System.out.println("[infoList] "+infoList);
	        
	        JsonObject busInfo_body = busInfo_Json.get("response").getAsJsonObject().get("body").getAsJsonObject();
	        
	        JsonObject busInfo_Items = busInfo_body.get("items").getAsJsonObject();
	        
	        System.out.println("[busInfo_body] "+busInfo_body);
	        System.out.println("[busInfo_Items] "+busInfo_Items);
	        
	        JsonArray itemList = busInfo_Items.get("item").getAsJsonArray();
	        System.out.println("[itemList] "+itemList);
	        
	        System.out.println("[itemList.size()] "+itemList.size()); 
	        
	        ArrayList<Bus> busList = new ArrayList<Bus>();
	        for(int i=0; i<infoList.size(); i++) {
	        	Bus bus = new Bus();
	        	String nodenm = infoList.get(i).getAsJsonObject().get("nodenm").getAsString();
	        	bus.setNodenm(nodenm);
	        	
	        	String routeno = infoList.get(i).getAsJsonObject().get("routeno").getAsString();
	        	bus.setRouteno(routeno);
	        	
	        	String arrprevstationcnt = infoList.get(i).getAsJsonObject().get("arrprevstationcnt").getAsString();
	        	bus.setArrprevstationcnt(arrprevstationcnt);
	        	
	        	String arrtime = infoList.get(i).getAsJsonObject().get("arrtime").getAsString();
	        	bus.setArrtime(arrtime);
	        	busList.add(bus);
	        }
	        System.out.println(busList);
	        
	        return busList;
	}

	public String getBusArrInfoList(String nodeId, String cityCode) throws IOException{
		System.out.println("getBusArrInfoList() 호출");
		/*공공 데이터 포털 예제 코드*/
		  StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/ArvlInfoInqireService/getSttnAcctoArvlPrearngeInfoList"); /*URL*/
	        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=S7zgFEQqSlrWVhHdRtINMDDNv%2BTnaJrW2iEOUsm2Y5UdcfYh6inhqrsA1Qls%2BtLEub4iFJ4UT89YTfsFhZ0sZQ%3D%3D"); /*Service Key*/
	        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
	        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
	        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*데이터 타입(xml, json)*/
	        urlBuilder.append("&" + URLEncoder.encode("cityCode","UTF-8") + "=" + URLEncoder.encode(cityCode, "UTF-8")); /*도시코드 [상세기능3 도시코드 목록 조회]에서 조회 가능*/
	        urlBuilder.append("&" + URLEncoder.encode("nodeId","UTF-8") + "=" + URLEncoder.encode(nodeId, "UTF-8")); /*정류소ID [국토교통부(TAGO)_버스정류소정보]에서 조회가능*/
	        URL url = new URL(urlBuilder.toString());
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        System.out.println("Response code: " + conn.getResponseCode());
	        BufferedReader rd;
	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }
	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = rd.readLine()) != null) {
	            sb.append(line);
	        }
	        rd.close();
	        conn.disconnect();
	        System.out.println(sb.toString());
	        
	        JsonObject arrInfoJson = JsonParser.parseString(sb.toString()).getAsJsonObject();
	        JsonArray busInfoList = arrInfoJson.get("response").getAsJsonObject().get("body").getAsJsonObject()
	        		.get("items").getAsJsonObject().get("item").getAsJsonArray();
	        System.out.println("arrInfoJson : "+arrInfoJson);
	        System.out.println("busInfoList : "+busInfoList);
	        System.out.println("busInfoList.size() : "+busInfoList.size());
	        Gson gson = new Gson();
	        String result = gson.toJson(busInfoList);
	        
		return result;
	}

	public String getBusSttnList(String lati, String longti) throws IOException {
		System.out.println("getBusSttnList() 호출");
		
		/*위치기반 서비스*/
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/BusSttnInfoInqireService/getCrdntPrxmtSttnList"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=S7zgFEQqSlrWVhHdRtINMDDNv%2BTnaJrW2iEOUsm2Y5UdcfYh6inhqrsA1Qls%2BtLEub4iFJ4UT89YTfsFhZ0sZQ%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*데이터 타입(xml, json)*/
        urlBuilder.append("&" + URLEncoder.encode("gpsLati","UTF-8") + "=" + URLEncoder.encode(lati, "UTF-8")); /*WGS84 위도 좌표*/
        urlBuilder.append("&" + URLEncoder.encode("gpsLong","UTF-8") + "=" + URLEncoder.encode(longti, "UTF-8")); /*WGS84 경도 좌표*/
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        System.out.println(sb.toString());
		
        JsonObject BusSttnInfoJson = JsonParser.parseString(sb.toString()).getAsJsonObject();
        JsonArray SttnList = BusSttnInfoJson.get("response")
        		.getAsJsonObject().get("body")
        		.getAsJsonObject().get("items")
        		.getAsJsonObject().get("item").getAsJsonArray();
        
        System.out.println("[BusSttnInfoJson] "+BusSttnInfoJson);
        System.out.println("[SttnList] "+SttnList);
        System.out.println("[SttnList.size()] "+SttnList.size());
        
        Gson gson = new Gson();
        
        String Bsstnresult = gson.toJson(SttnList);
        
       
        
		return Bsstnresult;
	}

	public String getGpsBusInfo(String cityCode, String routeId) throws IOException {
		System.out.println("getGpsBusInfo 호출");
		
		 StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/BusLcInfoInqireService/getRouteAcctoBusLcList"); /*URL*/
	        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=S7zgFEQqSlrWVhHdRtINMDDNv%2BTnaJrW2iEOUsm2Y5UdcfYh6inhqrsA1Qls%2BtLEub4iFJ4UT89YTfsFhZ0sZQ%3D%3D"); /*Service Key*/
	        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
	        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("800", "UTF-8")); /*한 페이지 결과 수*/
	        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*데이터 타입(xml, json)*/
	        urlBuilder.append("&" + URLEncoder.encode("cityCode","UTF-8") + "=" + URLEncoder.encode(cityCode, "UTF-8")); /*도시코드 [상세기능3 도시코드 목록 조회]에서 조회 가능*/
	        urlBuilder.append("&" + URLEncoder.encode("routeId","UTF-8") + "=" + URLEncoder.encode(routeId, "UTF-8")); /*노선ID [국토교통부(TAGO)_버스노선정보]에서 조회가능*/
	        URL url = new URL(urlBuilder.toString());
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        System.out.println("Response code: " + conn.getResponseCode());
	        BufferedReader rd;
	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }
	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = rd.readLine()) != null) {
	            sb.append(line);
	        }
	        rd.close();
	        conn.disconnect();
	        System.out.println(sb.toString());
		
        JsonObject GpsBusIn = JsonParser.parseString(sb.toString()).getAsJsonObject();
        JsonArray GpsGetBus = GpsBusIn.get("response")
        		.getAsJsonObject().get("body")
        		.getAsJsonObject().get("items")
        		.getAsJsonObject().get("item").getAsJsonArray();
        
        
        System.out.println("[GpsBusIn] "+GpsBusIn);
        System.out.println("[GpsGetBus] "+GpsGetBus);
        System.out.println("[GpsGetBus.size()] "+GpsGetBus.size());
        Gson gson = new Gson();
        
        String GpsGetBusResult = gson.toJson(GpsGetBus);
        
        /*노선번호*/
        
        
		return GpsGetBusResult;
	}

	//버스 노선 조회
	public String getBusNodeInfo(String cityCode, String routeId) throws IOException {
		System.out.println("getBusNodeInfo 호출");
		
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/BusRouteInfoInqireService/getRouteAcctoThrghSttnList"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=서비스키"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("800", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("xml", "UTF-8")); /*데이터 타입(xml, json)*/
        urlBuilder.append("&" + URLEncoder.encode("cityCode","UTF-8") + "=" + URLEncoder.encode("25", "UTF-8")); /*도시코드 [상세기능4. 도시코드 목록 조회]에서 조회 가능*/
        urlBuilder.append("&" + URLEncoder.encode("routeId","UTF-8") + "=" + URLEncoder.encode("DJB30300004", "UTF-8")); /*노선ID [상세기능1. 노선번호목록 조회]에서 조회 가능*/
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        System.out.println(sb.toString());
        
        JsonObject NodeView = JsonParser.parseString(sb.toString()).getAsJsonObject();
        
        JsonArray NodeViewArray = NodeView.get("response").getAsJsonObject()
        		.get("body").getAsJsonObject()
        		.get("items").getAsJsonObject()
        		.get("item").getAsJsonArray();
        
        Gson gson = new Gson();
        
        String NodeResult = gson.toJson(NodeViewArray);
        
		return NodeResult;
	}
	
}
