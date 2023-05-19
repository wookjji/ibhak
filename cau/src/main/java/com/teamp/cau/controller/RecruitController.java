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

import com.teamp.cau.dto.RecruitDTO;
import com.teamp.cau.service.RecruitService;

@Controller
public class RecruitController {

	@Autowired
	private RecruitService recruitService;

	@GetMapping("/recruit")
	public ModelAndView recruit() {
		ModelAndView mv = new ModelAndView("recruit");
		List<Map<String, Object>> year = recruitService.year();
		List<RecruitDTO> depart = recruitService.depart();
		mv.addObject("year", year);
		mv.addObject("depart", depart);
		return mv;
	}

	@GetMapping("/check")
	@ResponseBody
	public List<Map<String, Object>> check(@RequestParam("year") String year, @RequestParam("depart") String depart, @RequestParam("category") int category) {
		RecruitDTO dto = new RecruitDTO();
		dto.setRECRT_YEAR(year);
		dto.setDEPARTMENT(depart);
		dto.setRECRT_SCHDL_CD(category);
		
		List<Map<String, Object>> data = recruitService.check(dto);

		return data;
	}
	@PostMapping("/recruitSave")
	@ResponseBody
	public String recruitSave(@RequestParam HashMap<String, Object> map, @RequestParam("ea") int ea) {
		RecruitDTO dto = new RecruitDTO();
		for(var i=0; i < ea; i++) {
			String year = (String) map.get("recArray[" + i + "][year]");
			int cd = Integer.parseInt((String) map.get("recArray[" + i + "][name]")); 
			String depart = (String) map.get("recArray[" + i + "][depart]");
			int num = Integer.parseInt((String) map.get("recArray[" + i + "][num]"));
			dto.setRECRT_YEAR(year);
			dto.setRECRT_SCHDL_CD(cd);
			dto.setDEPARTMENT(depart);
			dto.setAPPL_NUM(num);
			recruitService.saveNum(dto);
		}
		
		return "";
	}
	
	@PostMapping("/addRec")
	@ResponseBody
	public Object addRec(@RequestParam("year")String year,@RequestParam("cd")int cd,@RequestParam("type")int type,@RequestParam("num")int num,@RequestParam("depart")String depart) {
		RecruitDTO dto = new RecruitDTO();
		dto.setRECRT_YEAR(year);
		dto.setRECRT_SCHDL_CD(cd);
		dto.setCRCLM_CD(type);
		dto.setDEPARTMENT(depart);
		dto.setAPPL_NUM(num);
		int result = recruitService.result(dto);
		if(result == 0) {
			dto.setDEPARTMENT("all");
			List<Map<String, Object>> list = recruitService.check(dto);
			return list;
		}else {
			return "fail";
		}
	}
	
}
