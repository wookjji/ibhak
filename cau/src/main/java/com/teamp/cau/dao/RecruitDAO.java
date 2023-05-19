package com.teamp.cau.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.teamp.cau.dto.RecruitDTO;

@Repository
@Mapper
public interface RecruitDAO {

	List<Map<String, Object>> year();

	List<RecruitDTO> depart();

	List<Map<String, Object>> check(RecruitDTO dto);

	void saveNum(RecruitDTO dto);

	int result(RecruitDTO dto);

	void addRec(RecruitDTO dto);

}
