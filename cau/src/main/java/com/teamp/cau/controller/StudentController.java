    


package com.teamp.cau.controller;

import java.util.Base64;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.teamp.cau.dto.PassDTO;
import com.teamp.cau.service.StudentService;


@Controller
public class StudentController {
	@Autowired
	private StudentService studentService;
	
	@GetMapping("student")
	public String student(){
		return "student";
	}
	
	@ResponseBody
	@GetMapping("/info")
	public List<PassDTO> student(@RequestParam("KORN_FLNM") String KORN_FLNM) {
		
		
		List<PassDTO> studentList = studentService.studentList(KORN_FLNM);
		// 이미지 파일을 Base64로 인코딩하여 photoFile 필드에 저장
		// db에는 바이너리값이 정확하게 찍혀있지만 불러왔을때는 다른값이 찍혀서 디코딩 해주어야 합니다.
	    for (PassDTO student : studentList) {
	        byte[] PHOTO_FILE = student.getPHOTO_FILE();
	        if (PHOTO_FILE != null) {
	            String encodedPhotoFile = new String(PHOTO_FILE);
	            byte[] decodedPhotoFile = Base64.getDecoder().decode(encodedPhotoFile);
	            student.setPHOTO_FILE(decodedPhotoFile);
	        }
	        
  }
	    return studentList;
}

}
