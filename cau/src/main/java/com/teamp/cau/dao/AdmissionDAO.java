package com.teamp.cau.dao;

import com.teamp.cau.dto.Stud_infoDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
@Mapper
public interface AdmissionDAO {

    public int stud_info(Stud_infoDTO dto);

    public int test(String imges);

    List<Stud_infoDTO> testList();

	public String passcheck(Stud_infoDTO dto);
}
