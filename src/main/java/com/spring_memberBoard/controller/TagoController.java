package com.spring_memberBoard.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring_memberBoard.Service.TagoService;

@Controller
public class TagoController {
	
	@Autowired
	TagoService tsvc;
	
	@RequestMapping(value = "/TagoBus")
	public ModelAndView tagoBus() {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("TagoBus");
		
		return mav;
	}
	
	@RequestMapping(value = "getTagoSttnList")
	public @ResponseBody String getTagoSttnList(String lati,String longti) {
		System.out.println("정류소 목록 조회 요청");
		System.out.println("위도 :"+lati);
		System.out.println("경도 :"+longti);
		
		String getBusSttnList = null;
		try {
			getBusSttnList = tsvc.getBusSttnList(lati,longti);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return getBusSttnList;
	}
	
	@RequestMapping(value= "busArrInfo")
	public @ResponseBody String busArrInfo(String citycode,String nodeid) {
		System.out.println("버스 도착 정보 목록");
		System.out.println("cityCode : "+citycode);
		System.out.println("nodeId : "+nodeid);
		
		String busArrInfo = null;
		try {
			busArrInfo = tsvc.getBusArrInfo(citycode,nodeid);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return busArrInfo;
	}
	
	@RequestMapping(value = "BusNodeInfo")
	public @ResponseBody String busNodeInfo(String citycode,String routeid) {
		System.out.println("버스 경유 정류소 목록");
		System.out.println("citycode : "+citycode);
		System.out.println("routeid : "+routeid);
		
		String busNodeInfo = null;
		try {
			busNodeInfo = tsvc.getBusNodeInfo(citycode,routeid);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return busNodeInfo;
	}
	
	@RequestMapping(value="LocInfo")
	public @ResponseBody String busLocInfo(String citycode,String routeid) {
		System.out.println("버스 위치 정보");
		
		String busLocInfo = null;
		try {
			busLocInfo = tsvc.getBusLocInfo(citycode,routeid);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return busLocInfo;
		
	}
}
