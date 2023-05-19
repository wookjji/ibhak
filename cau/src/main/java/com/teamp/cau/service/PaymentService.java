package com.teamp.cau.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamp.cau.dao.PaymentDAO;
import com.teamp.cau.dto.StudentDTO;

@Service
public class PaymentService {
	
	@Autowired
	private PaymentDAO paymentDAO;

	
	public void updatePayment(String KORN_FLNM, String USER_BRDT, int payment) {
		paymentDAO.updatePayment(KORN_FLNM, USER_BRDT, payment);
		
	}

	 public boolean checkPayment(String KORN_FLNM, String USER_BRDT, int payment) {
	        List<StudentDTO> paymentList = paymentDAO.paymentList(KORN_FLNM, USER_BRDT, payment);
	        return !paymentList.isEmpty();
	    }
	

	 public int paymentList(String KORN_FLNM, String USER_BRDT) {
		    StudentDTO studentDTO = paymentDAO.paymentList(KORN_FLNM, USER_BRDT);
		    return studentDTO.getPayment();
		}

	 public void failPayment(String KORN_FLNM, String USER_BRDT, int payment) {
			paymentDAO.failPayment(KORN_FLNM, USER_BRDT, payment);
			
		}
	

}
