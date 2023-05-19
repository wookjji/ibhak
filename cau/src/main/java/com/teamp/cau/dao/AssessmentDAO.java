package com.teamp.cau.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.teamp.cau.dto.StudentDTO;

@Repository
@Mapper
public interface AssessmentDAO {

	List<StudentDTO> aplyList(String KORN_FLNM);

	void updateAssessment(StudentDTO assessment);

	Map<String, Object> selectPdf();

	


	

	



}
