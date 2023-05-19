package com.teamp.cau.dto;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
public class Stud_infoDTO {
    private String eml_addr,korn_flnm,user_brdt,gender_cd,email_1,email_2,telno,rel_telno,rel_cd,zip,addr,daddr,images,passName,passBrd,department;
    private MultipartFile fileInput,image;
    private int age,stud_no,CRCLM_CD,RECRT_SCHDL_CD,nowYear;
    private double avg,korean,math,english,grade;
    private byte[]  pdf;



}
