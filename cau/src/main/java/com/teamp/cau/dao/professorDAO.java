package com.teamp.cau.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.teamp.cau.dto.PassDTO;
import com.teamp.cau.dto.professorDTO;

@Repository
public class professorDAO {

	@Autowired
	private SqlSession sqlsession;

	// 교수정보 검색 
	public List<Map<String, Object>> search(professorDTO dto){
		return sqlsession.selectList("INSTR_INFO.search",dto);
	}
	
	//교수정보 입력 저장
	public Integer prSave(Map<String, Object> infoEnter) {
		return sqlsession.insert("INSTR_INFO.prinfo_save", infoEnter);
	}
	
	// 교수정보 불러오기 
	public List<professorDTO> prinfo() {
		return sqlsession.selectList("INSTR_INFO.prlist");
	}

	// 지원자 정보 불러오기 
	public List<HashMap<String, Object>> select() {
		return sqlsession.selectList("APPL_INFO.callin");
	}

	//교수 아이디 보내기
	public Integer userSave(Map<String, Object> infoEnter) {
		return sqlsession.insert("USER_INFO.instr_user", infoEnter);
	}

	// 정보 수정 
	public Integer selfModify(Map<String, Object> selfmodi) {
		return sqlsession.update("INSTR_INFO.self_modify", selfmodi);
	}

	//점수 저장하기
	public int result(List<HashMap<String,Integer>> list) {
		return sqlsession.update("APPL_INFO.resultScore", list);
	}

	//권한주기
	public int givesave(List<HashMap<String, Integer>> authdto) {
		return sqlsession.update("INSTR_INFO.INSTR_auth", authdto);
	}

	public Integer getEndstNoByInstrNo(Integer instrNo) {
		return sqlsession.selectOne("INSTR_INFO.getEndstNoByInstrNo", instrNo);
	}


	//교수정보 불러오기 
		public professorDTO infoload(professorDTO dto) {
			
			professorDTO reDTO = sqlsession.selectOne("USER_INFO.studno", dto);
			dto.setINSTR_NO(reDTO.getINSTR_NO());
			return sqlsession.selectOne("USER_INFO.selfload", dto);
		}

		public void prchange(professorDTO prDTO) {
			professorDTO reDTO = sqlsession.selectOne("USER_INFO.studno", prDTO);
			prDTO.setINSTR_NO(reDTO.getINSTR_NO());
			sqlsession.update("USER_INFO.modifypr", prDTO);			
		}





	
	
}
