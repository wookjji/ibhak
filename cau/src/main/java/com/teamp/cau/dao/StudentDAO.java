package com.teamp.cau.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.teamp.cau.dto.PassDTO;

@Repository
@Mapper

public interface StudentDAO {

	List<PassDTO> studentList(String KORN_FLNM);

	
	
	

}
