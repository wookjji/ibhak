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
public class PassController {

	@Autowired
	private PassService passService;

	@GetMapping("/pass")
	public ModelAndView Passed() {
		List<PassDTO> list_d = passService.departmentList();
		List<PassDTO> list_c = passService.categoryList();
		
		ModelAndView mv = new ModelAndView("pass");
		mv.addObject("list_d", list_d);
		mv.addObject("list_c", list_c);

		return mv;
	}

	@ResponseBody
	@GetMapping("/passInfo")
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
	@PostMapping("/passUpdate1")
	public String passUpdate1(@RequestParam HashMap<String, Object> param, @RequestParam("num") int num) {
		PassDTO passDTO = new PassDTO();
		for (int i = 0; i < num; i++) {
			int PASS_INFO = Integer.parseInt((String) param.get("checkBoxArr[" + i + "][PASS_INFO]"));
			int appl_NO = Integer.parseInt((String) param.get("checkBoxArr[" + i + "][appl_NO]"));
			passDTO.setAppl_NO(appl_NO);
			passDTO.setPASS_INFO(PASS_INFO);
			passService.passUpdate(passDTO);
		}
		return "";
	}
	// 예비번호 문자보내기버튼

	@PostMapping("/permit1")
	@ResponseBody
	public String permit1(@RequestParam HashMap<String, Object> param, @RequestParam("num") int num) {
		message message = new message();
		for (int i = 0; i < num; i++) {
			String telno = (String) param.get("checkBoxArr[" + i + "][telno_m]");
			String content = param.get("checkBoxArr[" + i + "][name_m]") + "님의 합격순번은  "
					+ param.get("checkBoxArr[" + i + "][passrank]") + "입니다.";
			message.sendSMS(telno, content);
		}
		return "";
	}
	// 계좌번호 문자보내기 버튼

	@PostMapping("/permit2")
	@ResponseBody
	public String permit2(@RequestParam HashMap<String, Object> param, @RequestParam("num") int num) {
		message message = new message();
		for (int i = 0; i < num; i++) {
			String telno = (String) param.get("checkBoxArr[" + i + "][telno_m]");
			String content = param.get("checkBoxArr[" + i + "][name_m]")
					+ "님 국민은행 938002-00-123456 으로 입금해주시면 등록이 확정이됩니다..";
			message.sendSMS(telno, content);
		}
		return "";
	}

	@ResponseBody
	@PostMapping("/admission")
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