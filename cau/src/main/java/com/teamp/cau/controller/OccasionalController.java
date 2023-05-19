package com.teamp.cau.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.teamp.cau.dto.StudentDTO;
import com.teamp.cau.service.OccasionalService;

@Controller

public class OccasionalController {
	@Autowired
	private OccasionalService occasionalService;
	
	
	
	@GetMapping("/occasional")
	public String occasional() {
		return "occasional";
	}
	
	@ResponseBody		
	@GetMapping("/ocs")
	public List<StudentDTO> ocs(@RequestParam("KORN_FLNM") String KORN_FLNM) {
		
		List<StudentDTO> occList = occasionalService.occList(KORN_FLNM);
		
	    return occList;
		
	}
	
	
	@ResponseBody
	@PostMapping("/saves")	
	public String saveOccasional(@RequestBody List<StudentDTO> occasionals) {
	    occasionalService.updateOccasional(occasionals);
	    System.out.println(occasionals);
	    return "success";
	}
	
	

	
	
	

}
