package com.teamp.cau.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.teamp.cau.dao.professorDAO;
import com.teamp.cau.dto.professorDTO;

@Service
public class professorService {

	@Autowired
	private professorDAO prDAO;
	
   private final PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

	// 교수정보 불러오기 
	public List<professorDTO> prinfo() {
		return prDAO.prinfo();
	}

	//교수정보 검색 
	public List<Map<String, Object>> selectList(professorDTO dto) {
		return prDAO.search(dto);
	}

	//교수정보입력 저장 
	public Integer prinfo_save(Map<String, Object> infoEnter) {
		
		infoEnter.put("pr_pw",passwordEncoder.encode((CharSequence) infoEnter.get("pr_pw")));
		return prDAO.prSave(infoEnter);
	}

	// 지원자 정보 불러오기
	public List<HashMap<String, Object>> selectList() {
		return prDAO.select();
	}

	//교수 아이디 보내기
	public Integer instr_user(Map<String, Object> infoEnter) {
		return prDAO.userSave(infoEnter);
	}

	//본인정보 수정 
	public Integer selfSave(Map<String, Object> selfmodi) {
		return prDAO.selfModify(selfmodi);
	}

	//점수저장하기
	public int resultpoint(List<HashMap<String,Integer>> res) {
		return prDAO.result(res);
	}

	//권한주기  
	public int giveautest(List<HashMap<String, Integer>> authdto) {
		return prDAO.givesave(authdto);
	}

	
	  public Integer getEndstNoByInstrNo(Integer instrNo) {
	        return prDAO.getEndstNoByInstrNo(instrNo);
	    }

	//로그인 정보 불러오기 
		public professorDTO infoload(professorDTO professorDTO) {
			return prDAO.infoload(professorDTO);
		}

		public void prchange(professorDTO prDTO) {
			prDAO.prchange(prDTO);	
		}


	

	

	
}
