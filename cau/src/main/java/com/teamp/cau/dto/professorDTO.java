package com.teamp.cau.dto; 

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
@Data
public class professorDTO {

	private String KORN_FLNM, USER_BRDT, EML_ADDR, TELNO, ADDR, DADDR, GENDER, CRCLM_CD, 
					 department, INSTR_ID, INSTR_PW, ENG_FLNM, ROLE_CODE;
	
	private int INSTR_NO, appl_NO, RECRT_YEAR, total, grade, ENDST_NO, interview, RECRT_SCHDL_CD;
	String USER_NO;
	private MultipartFile IMG_FILE;
    private byte[] PHOTO_FILE;

    private String pa;

}
