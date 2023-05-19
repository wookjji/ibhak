package com.teamp.cau.service;

import com.teamp.cau.dao.AdmissionDAO;
import com.teamp.cau.dto.Stud_infoDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class AdmissionService {
    @Autowired
    private AdmissionDAO admissiondao;
    public int stud_info(Stud_infoDTO dto){
        return admissiondao.stud_info(dto);
    }

    public int test(String imges) {return admissiondao.test(imges);}


    public List<Stud_infoDTO> testList() {
        return admissiondao.testList();
    }

	public String passcheck(Stud_infoDTO dto) {
		return admissiondao.passcheck(dto);
	}
}
