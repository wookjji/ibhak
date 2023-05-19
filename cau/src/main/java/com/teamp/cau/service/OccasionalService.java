package com.teamp.cau.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamp.cau.dao.OccasionalDAO;
import com.teamp.cau.dto.StudentDTO;

@Service
public class OccasionalService {
	
	@Autowired
	private OccasionalDAO occasionalDAO;


	public List<StudentDTO> data() {
		return occasionalDAO.data() ;
	}
	
	public void updateOccasional(List<StudentDTO> occaisonals) {
	    for (StudentDTO occasional : occaisonals) {
	        occasionalDAO.updateOccasional(occasional);
	    }
	}

	public List<StudentDTO> occList(String KORN_FLNM) {
		return occasionalDAO.occList(KORN_FLNM);
	}
	
	



}
