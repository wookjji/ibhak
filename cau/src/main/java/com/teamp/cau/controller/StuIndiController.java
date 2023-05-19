package com.teamp.cau.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.Base64;
import java.util.List;
import java.util.Base64.Encoder;
import java.util.Iterator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.teamp.cau.dto.PassDTO;
import com.teamp.cau.service.PassService;

@Controller
public class StuIndiController {

	@Autowired
	private PassService passService;

	@GetMapping("/student/stuinfo")
	public ModelAndView stuinfo() {
		PassDTO passDTO = new PassDTO();
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String USER_NO = authentication.getName(); // "user_NO" 컬럼에서 사용자 이름을 가져옴
		passDTO.setUSER_NO(USER_NO);
		PassDTO dto = passService.studin(passDTO);
		// System.out.println(dto.getPHOTO_FILE()[1]);
		// 이미지 데이터를 디코딩하여 PassDTO 객체에 저장
		byte[] PHOTO_FILE = dto.getPHOTO_FILE();

		if (PHOTO_FILE != null) {

			dto.setPa("");
			StringBuilder sb = new StringBuilder();
			for (int i = 0; i < PHOTO_FILE.length; i++) {
				sb.append((char) PHOTO_FILE[i]);
			}
			dto.setPa(sb.toString());
		}
		ModelAndView mv = new ModelAndView("/student/stuinfo");
		mv.addObject("dto", dto);
		return mv;
	}

	@ResponseBody
	@PostMapping("/studinfoupdate")
	public String studinfoupdate( @RequestParam("KORN_FLNM") String KORN_FLNM ,
			@RequestParam("TELNO") String TELNO,@RequestParam("EML_ADDR") String EML_ADDR,
			@RequestParam("REL_TELNO") String REL_TELNO,@RequestParam("ZIP") String ZIP,
			@RequestParam("ADDR") String ADDR,@RequestParam("DADDR") String DADDR,
			@RequestParam("USER_BRDT") String USER_BRDT,@RequestParam("GENDER_CD") String GENDER_CD,
			@RequestParam("FileInput") MultipartFile FileInput) throws IOException {
		PassDTO passDTO = new PassDTO();
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String USER_NO = authentication.getName(); // "user_NO" 컬럼에서 사용자 이름을 가져옴
		passDTO.setREL_TELNO(REL_TELNO);passDTO.setTELNO(TELNO);passDTO.setKORN_FLNM(KORN_FLNM);passDTO.setEML_ADDR(EML_ADDR);
		passDTO.setZIP(ZIP);passDTO.setADDR(ADDR);passDTO.setUSER_BRDT(USER_BRDT);passDTO.setGENDER_CD(GENDER_CD);
		passDTO.setDADDR(DADDR);passDTO.setUSER_NO(USER_NO);
		
		  Encoder encoder = Base64.getEncoder();
			byte[] bytes = FileInput.getBytes();
			byte[] te = encoder.encode(bytes);
			passDTO.setPHOTO_FILE(te);
		passService.studinfo(passDTO);

		return "";
	}

}