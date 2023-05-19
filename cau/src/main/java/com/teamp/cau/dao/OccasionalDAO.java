package com.teamp.cau.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.teamp.cau.dto.StudentDTO;

@Repository
@Mapper
public interface OccasionalDAO {

	List<StudentDTO> data();

	void updateOccasional(StudentDTO occasional);

	List<StudentDTO> occList(String KORN_FLNM);



}
