package com.teamp.cau.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamp.cau.dao.StudentDAO;
import com.teamp.cau.dto.PassDTO;

@Service
public class StudentService {
	
	@Autowired
	private StudentDAO studentDAO;

	public List<PassDTO> studentList(String KORN_FLNM) {
		
	 return studentDAO.studentList(KORN_FLNM);
	 
	}

	
	

}
