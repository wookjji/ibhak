package com.teamp.cau.controller;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.client.RestClientException;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.teamp.cau.dto.MessageDTO;
import com.teamp.cau.dto.SmsResponseDTO;
import com.teamp.cau.service.SmsService;

import lombok.RequiredArgsConstructor;
 
@Controller
@RequiredArgsConstructor
public class SmsController {
	
	private final SmsService smsService;
	
	@GetMapping("/send") // 문자 메세지 발송 페이지
	public String getSmsPage() {
		return "sendSms";
	}
	
	@PostMapping("/sms/send")  // 문자 메세지 발송
	public String sendSms(MessageDTO messageDto, Model model) throws JsonProcessingException, RestClientException, URISyntaxException, InvalidKeyException, NoSuchAlgorithmException, UnsupportedEncodingException {
		SmsResponseDTO response = smsService.sendSms(messageDto);
		model.addAttribute("response", response);
		return "redirect:/";
	}
 
	
}