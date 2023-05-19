package com.teamp.cau.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.teamp.cau.dto.PassDTO;
import com.teamp.cau.dto.professorDTO;
import com.teamp.cau.security.CustomAuthenticationToken;
import com.teamp.cau.service.PassService;
import com.teamp.cau.service.professorService;
import com.teamp.cau.vo.UserVo;
import com.teamp.cau.vo.UserVo.UserRoleEnum;

@Controller
public class commonController {
	
@Autowired
private professorService professorService;

		@GetMapping("/index")
		public String index(Authentication authentication,Model model  ) {
			
		if (authentication != null && authentication.isAuthenticated()) {
		UserVo userVo = ((CustomAuthenticationToken) authentication).getUserVo();
		if (userVo != null) {
			   String kornFlnm = userVo.getKORN_FLNM();
			   UserRoleEnum userRole = userVo.getROLE_CODE();
		Integer studNo = userVo.getSTUD_NO();
		Integer instrNo = userVo.getINSTR_NO();
			System.err.println(userVo);
		    System.err.println(studNo);
		    System.err.println(instrNo);
		    model.addAttribute("userRole", userRole);
            model.addAttribute("kornFlnm", kornFlnm);
            // INSTR_NO에 해당하는 ENDST_NO 값을 가져옵니다.
            Integer endstNo = professorService.getEndstNoByInstrNo(instrNo);
		    System.err.println(endstNo);

            model.addAttribute("endstNo", endstNo);
		}
		}
		
		
		return "index";
	}

	@GetMapping("/com_department")
	public String department() {
		return "com_department";
	}

	public professorService getProfessorService() {
		return professorService;
	}

	public void setProfessorService(professorService professorService) {
		this.professorService = professorService;
	}

	
	
}
