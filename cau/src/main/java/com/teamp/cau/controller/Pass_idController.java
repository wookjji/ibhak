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

import com.teamp.cau.dto.PassDTO;
import com.teamp.cau.service.PassService;

@Controller
public class Pass_idController {

	@Autowired
	private PassService passService;

	@GetMapping("/pass_id")
	public ModelAndView Passed() {
		List<PassDTO> list_d = passService.departmentList();
		List<PassDTO> list_c = passService.categoryList();
		
		ModelAndView mv = new ModelAndView("pass_id");
		mv.addObject("list_d", list_d);
		mv.addObject("list_c", list_c);

		return mv;
	}

	@ResponseBody
	@GetMapping("/passInfo_id")
	public Map<String, Object> Pass(@RequestParam(value = "KORN_FLNM", required = false) String KORN_FLNM,
			@RequestParam(value = "CRCLM_CD", required = false) String CRCLM_CD,
			@RequestParam(value = "RECRT_SCHDL_CD", required = false) String RECRT_SCHDL_CD,
			@RequestParam(value = "RECRT_YEAR", required = false) String RECRT_YEAR) {
		PassDTO passDTO = new PassDTO();
		passDTO.setCRCLM_CD(CRCLM_CD);
		passDTO.setRECRT_SCHDL_CD(RECRT_SCHDL_CD);
		passDTO.setRECRT_YEAR(RECRT_YEAR);
		passDTO.setKORN_FLNM(KORN_FLNM);
		List<PassDTO> list = passService.studentList(passDTO);
		int list_L = passService.studentLimit(passDTO);
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("list", list);
		result.put("list_L", list_L);
		return result;
	}

	@ResponseBody
	@PostMapping("/admission_id")
	public String StudentID(@RequestParam HashMap<String, Object> param, @RequestParam("num") int num) {
		PassDTO passDTO = new PassDTO();
		for (int i = 0; i < num; i++) {
			int appl_NO = Integer.parseInt((String) param.get("checkBoxArr[" + i + "][appl_NO]"));
			String ID = (String) param.get("checkBoxArr[" + i + "][Student_id]");
			passDTO.setAppl_NO(appl_NO);
			passDTO.setStudent_ID(ID);
			passService.studentValue(passDTO);
		}
		return "";
	}

}