package com.teamp.cau.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.teamp.cau.dto.StudentDTO;

@Repository
@Mapper

public interface PaymentDAO {

	List<StudentDTO> paymentList(String KORN_FLNM, String USER_BRDT, int payment);

	void updatePayment(String KORN_FLNM, String USER_BRDT, int payment);

	StudentDTO paymentList(String KORN_FLNM, String USER_BRDT);

	void failPayment(String kORN_FLNM, String uSER_BRDT, int payment);


}
	