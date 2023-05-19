package com.teamp.cau.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamp.cau.dao.ScheduleDAO;
import com.teamp.cau.dto.ScheduleDTO;
import com.teamp.cau.dto.StudentDTO;

@Service
public class ScheduleService {
	
	@Autowired
	private ScheduleDAO scheduleDAO;

	public List<Map<String, Object>> tableList() {
		
		return scheduleDAO.tableList();
	}

	public List<Map<String, Object>> scheduleCheck(ScheduleDTO dto) {
		
		return scheduleDAO.scheduleCheck(dto);
	}

	public void save(ScheduleDTO dto) {
		scheduleDAO.save(dto);
		
	}
	
	public void updatePayment(String KORN_FLNM, String USER_BRDT, int payment) {
		scheduleDAO.updatePayment(KORN_FLNM, USER_BRDT, payment);
		
	}

	 public boolean checkPayment(String KORN_FLNM, String USER_BRDT, int payment) {
	        List<StudentDTO> paymentList = scheduleDAO.paymentList(KORN_FLNM, USER_BRDT, payment);
	        return !paymentList.isEmpty();
	    }
	

	 public int paymentList(String KORN_FLNM, String USER_BRDT) {
		    StudentDTO studentDTO = scheduleDAO.paymentList(KORN_FLNM, USER_BRDT);
		    return studentDTO.getPayment();
		}
	

	public void updatePayments(String KORN_FLNM, String USER_BRDT, int payment) {
		
		scheduleDAO.updatePayments(KORN_FLNM, USER_BRDT, payment);
		
	}

	public int result(ScheduleDTO dto) {
		int result = scheduleDAO.result(dto);
		if(dto.getRECRT_SCHDL_CD() == "1") {
			dto.setSCHDL_NAME("정시");
		}else {
			dto.setSCHDL_NAME("수시");
		}
		if(result == 0) {
			scheduleDAO.addSch(dto);
		}
		
		return result;
	}

	
	
}
