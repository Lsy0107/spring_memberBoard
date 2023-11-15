package com.spring_memberBoard.controller;

import java.io.IOException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring_memberBoard.Service.ApiService;
import com.spring_memberBoard.dao.Bus;

@Controller
public class ApiController {
	
	@Autowired
	private ApiService apisvc;

	@RequestMapping(value="/busapi")
	public ModelAndView busapi() throws Exception {
		System.out.println("버스도착정보 페이지 이동요청 - /busapi");
		ModelAndView mav = new ModelAndView();
		
		//1. 버스 도착 정보 조회
		
		ArrayList<Bus> result  = apisvc.getBusArrive();
		mav.addObject("busList",result);
		
		//2. 버스도착정보 페이지
		mav.setViewName("BusList");
		
		
		
		return mav;
	}
	
	@RequestMapping(value="/busapi_ajax")
	public ModelAndView busapi_ajax() {
		System.out.println("busapi_ajax 이동 요청");
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("BusArriveInfo");
		
		return mav;
	}
	@RequestMapping(value="/getBusArr")
	public @ResponseBody String getBusArr(String nodeId,String cityCode) {
		System.out.println("버스 도착정보 조회 요청 - getBusArr");
		System.out.println("nodeId : "+nodeId);
		System.out.println("cityCode : "+cityCode);
		//1.SERVICE - 도착정보 조회 기능 호출
		String arrInfoList = null;
		try {
			arrInfoList = apisvc.getBusArrInfoList(nodeId,cityCode);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//2.도착정보 반환 	
		return arrInfoList;
	}
	
	@RequestMapping(value="getBusSttn")
	public @ResponseBody String getBusSttn(String lati,String longti) {
		System.out.println("좌표기반 주변 버스정류장 찾기");
		System.out.println("lati : "+lati);
		System.out.println("longti : "+longti);
		
		//1.서비스 호출
		String busSttn = null;
		try {
			busSttn = apisvc.getBusSttnList(lati,longti);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//정보 반환
		return busSttn;
	}
	
	@RequestMapping(value="GpsBusInfo")
	public @ResponseBody String GpsBusInfo(String cityCode,String routeId) {
		System.out.println("위치별 버스 조회");
		System.out.println("cityCode : "+cityCode);
		System.out.println("routeId : "+routeId);
		
		String GpsBusInfo = null;
		try {
			GpsBusInfo = apisvc.getGpsBusInfo(cityCode,routeId);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return GpsBusInfo;
	}
	
	@RequestMapping(value="NodeInfo")
	public @ResponseBody String NodeInfo(String cityCode,String routeId) {
		System.out.println("버스 노선 조회");
		System.out.println("cityCode : "+cityCode);
		System.out.println("routeId : "+routeId);
		
		String BusNodeInfo = null;
		try {
			 BusNodeInfo = apisvc.getBusNodeInfo(cityCode,routeId);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return BusNodeInfo;
	}
	
	
}
