package com.teamp.cau.controller;

import com.teamp.cau.dto.Stud_infoDTO;
import com.teamp.cau.service.AdmissionService;
import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.HashMap;
import java.util.List;

@Controller
public class testcon {
    @Autowired
    AdmissionService admissionService;
    @GetMapping("/test")
    public ModelAndView filetest(){
        List<Stud_infoDTO> list = admissionService.testList();
        ModelAndView mv = new ModelAndView("test");
        mv.addObject("list", list);
        return mv;
    }
    @PostMapping("/test")
    public String fileup(Stud_infoDTO dto)throws Exception{
        String imges;
        MultipartFile image = dto.getImage();
        System.out.println(image);
        imges = convertBinary(image);
      //  System.out.println(imges);
        int result1 = admissionService.test(imges);
        System.out.println(result1);
        return "redirect:/test";
    }
    public String convertBinary(MultipartFile files) throws Exception{

        String fileName = StringUtils.cleanPath(files.getOriginalFilename()) ;
        BufferedImage image = ImageIO.read(files.getInputStream());
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(image, fileName.substring(fileName.lastIndexOf(".") + 1), baos);
        return new String(Base64.encodeBase64(baos.toByteArray()));
    }

}
