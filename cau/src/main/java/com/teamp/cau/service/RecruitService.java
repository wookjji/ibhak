package com.teamp.cau.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamp.cau.dao.RecruitDAO;
import com.teamp.cau.dto.RecruitDTO;

@Service
public class RecruitService {
	
	@Autowired
	private RecruitDAO recruitDAO;

	public List<Map<String, Object>> year() {
		
		return recruitDAO.year();
	}

	public List<RecruitDTO> depart() {
		
		return recruitDAO.depart();
	}

	public List<Map<String, Object>> check(RecruitDTO dto) {
		
		return recruitDAO.check(dto);
	}

	public void saveNum(RecruitDTO dto) {
		recruitDAO.saveNum(dto);
		
	}

	public int result(RecruitDTO dto) {
		int result = recruitDAO.result(dto);
		if(result == 0) {
			recruitDAO.addRec(dto);
		}
		return result;
	}

}
