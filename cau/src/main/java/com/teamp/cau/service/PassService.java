package com.teamp.cau.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamp.cau.dao.PassDAO;
import com.teamp.cau.dto.PassDTO;

@Service
public class PassService {
	@Autowired
	private PassDAO passDAO;



	public List<PassDTO> studentList(PassDTO passDTO) {
		return passDAO.studentList(passDTO);
	}

	public void passUpdate(PassDTO passDTO) {
		passDAO.passUpdate(passDTO);
	}

	public int result(PassDTO passDTO) {
		return passDAO.result(passDTO);
	}

	public List<PassDTO> departmentList() {
		return passDAO.departmentList();
	}

	public List<PassDTO> categoryList() {
		return passDAO.categoryList();
	}

	public void studentValue(PassDTO passDTO) {
		passDAO.studentValue(passDTO);
	}

	public int studentLimit(PassDTO passDTO) {
		return passDAO.studentLimit(passDTO);
	}

	public void studinfo(PassDTO passDTO) {
		passDAO.studinfo(passDTO);
		
	}

	public PassDTO studin(PassDTO passDTO) {
		return passDAO.studin(passDTO);
	}



}