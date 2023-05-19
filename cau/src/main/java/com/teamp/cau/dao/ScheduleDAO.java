package com.teamp.cau.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.teamp.cau.dto.ScheduleDTO;
import com.teamp.cau.dto.StudentDTO;

@Repository
@Mapper
public interface ScheduleDAO {

	List<Map<String, Object>> tableList();

	List<Map<String, Object>> scheduleCheck(ScheduleDTO dto);

	void save(ScheduleDTO dto);
	
	List<StudentDTO> paymentList(String KORN_FLNM, String USER_BRDT, int payment);

	void updatePayment(String KORN_FLNM, String USER_BRDT, int payment);

	StudentDTO paymentList(String KORN_FLNM, String USER_BRDT);

	void updatePayments(String KORN_FLNM, String USER_BRDT, int payment);

	int result(ScheduleDTO dto);

	void addSch(ScheduleDTO dto);

}
