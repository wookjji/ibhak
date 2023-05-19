package com.teamp.cau.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.teamp.cau.service.PaymentService;


@Controller
public class PaymentController {
	
	@Autowired
	private PaymentService paymentService;
	
	@GetMapping("/payment")
	public String payment() {
		return "payment";
	}
	
	
	@ResponseBody
	@GetMapping("/pms")	
	public String payments(@RequestParam("KORN_FLNM") String KORN_FLNM, @RequestParam("USER_BRDT") String USER_BRDT) {
		
		 try {
		        int payment = paymentService.paymentList(KORN_FLNM, USER_BRDT);
		        System.out.println(payment);

		        if (payment == 0) { // payment 값이 0일 경우에만 업데이트
		            if (paymentService.checkPayment(KORN_FLNM, USER_BRDT, payment)) {
		                paymentService.updatePayment(KORN_FLNM, USER_BRDT, payment);
		            	System.err.println("성공한거같은데??");
		                return "success";
		            } else {
		            	System.err.println("실패한거맞아?");
		                return "failed";
		            }   
		        } else { // payment 값이 1일 경우에는 결제를 막고 실패를 반환
		        	System.err.println("실패한거맞냐고");
		            return "blocked";
		        }
		    } catch (NullPointerException e) {
		        return "failed";
		    }
		}



	
	@ResponseBody
	@GetMapping("/failpay")	
	public String failpay(@RequestParam("KORN_FLNM") String KORN_FLNM, @RequestParam("USER_BRDT") String USER_BRDT) {
        int payment = paymentService.paymentList(KORN_FLNM, USER_BRDT);
        paymentService.failPayment(KORN_FLNM, USER_BRDT, payment);
		return "fail";

	}
}

