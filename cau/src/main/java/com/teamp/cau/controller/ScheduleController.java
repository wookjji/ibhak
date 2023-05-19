package com.teamp.cau.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.teamp.cau.dto.ScheduleDTO;
import com.teamp.cau.service.RecruitService;
import com.teamp.cau.service.ScheduleService;

@Controller
public class ScheduleController {
	
	@Autowired
	private ScheduleService scheduleService;
	@Autowired
	private RecruitService recruitService;
	
	@GetMapping("/schedule")
	public ModelAndView Schedule() {
		ModelAndView mv = new ModelAndView("schedule");
		mv.addObject("depart", recruitService.depart());
		mv.addObject("year", recruitService.year());
		return mv;
	}
	
	@GetMapping("/sch")
	@ResponseBody
	public List<Map<String, Object>> schtable(){
		List<Map<String, Object>> list = scheduleService.tableList();
		
		return list;
	}
	@GetMapping("/scheduleCheck")
	@ResponseBody
	public List<Map<String, Object>> scheduleCheck(@RequestParam("year") String year){
		ScheduleDTO dto = new ScheduleDTO();
		dto.setRECRT_YEAR(year);
		List<Map<String, Object>> list = scheduleService.scheduleCheck(dto);
		return list;
	}
	@PostMapping("/ScheduleSave")
	@ResponseBody
	public String ScheduleSave(@RequestParam HashMap<String, Object> map, @RequestParam("num") int num) {
		System.out.println(map);
		System.out.println(num);
		ScheduleDTO dto = new ScheduleDTO();
		for(var i = 0; i < num; i++) {
			System.out.println(map.get("schArray[" + i + "][year]"));
			String recCD = (String)map.get("schArray[" + i + "][recCD]");
			String year = (String) map.get("schArray[" + i + "][year]");
			String start = (String) map.get("schArray[" + i + "][start]");
			String end = (String) map.get("schArray[" + i + "][end]");
			dto.setRECRT_YEAR(year);
			dto.setRECRT_SCHDL_CD(recCD);
			dto.setSCHDL_START(start);
			dto.setSCHDL_END_DT(end);
			scheduleService.save(dto);
		}
		return "";
	}
	@PostMapping("/addSch")
	@ResponseBody
	public Object addSch(@RequestParam("year") String year,@RequestParam("cd") String cd,@RequestParam("start") String start, @RequestParam("end") String end){
		ScheduleDTO dto = new ScheduleDTO();
		dto.setRECRT_YEAR(year);
		dto.setRECRT_SCHDL_CD(cd);
		dto.setSCHDL_START(start);
		dto.setSCHDL_END_DT(end);
		int result = scheduleService.result(dto);
		
		if(result == 0) {
			dto.setRECRT_YEAR("all");
		List<Map<String, Object>> list = scheduleService.scheduleCheck(dto);
		return list;
		}else{
			
			return "fail";
		}
	}
}
