package com.teamp.cau.controller;

import java.util.ArrayList;
import java.util.Base64;
import java.util.Base64.Encoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.teamp.cau.dto.RecruitDTO;
import com.teamp.cau.dto.professorDTO;
import com.teamp.cau.service.RecruitService;
import com.teamp.cau.service.professorService;
import com.teamp.cau.util.ConvertBinary;

@Controller
public class professorController {

   @Autowired
   private professorService prService;
   
   @Autowired
   private RecruitService recruitService;
   
   // 교수정보입력 페이지
   @GetMapping("/professor")
   public String pro_write() {
      return "professor";
   }

   // 교수정보입력 저장
   @ResponseBody
   @PostMapping("/professor_info")
   public Integer info_save(HttpServletRequest req) {
      String pr_id = req.getParameter("pr_id");
      String pr_pw = req.getParameter("pr_pw");
      String pr_no = req.getParameter("pr_no");
      String pr_dep = req.getParameter("pr_dep");
      String pr_name = req.getParameter("pr_name");
      String pr_telno = req.getParameter("pr_telno");
      String pr_birth = req.getParameter("pr_birth");
      String pr_email = req.getParameter("pr_email");
      Map<String, Object> infoEnter = new HashMap<>();
      infoEnter.put("pr_id", pr_id);
      infoEnter.put("pr_pw", pr_pw);
      infoEnter.put("pr_no", pr_no);
      infoEnter.put("pr_dep", pr_dep);
      infoEnter.put("pr_name", pr_name);
      infoEnter.put("pr_telno", pr_telno);
      infoEnter.put("pr_birth", pr_birth);
      infoEnter.put("pr_email", pr_email);
      //System.out.println(infoEnter);
      Integer enter = prService.prinfo_save(infoEnter); // instr_info로
      Integer enter2 = prService.instr_user(infoEnter); // user_info로
      return enter;
   }



   // 교수본인정보 수정 불러오기
   @GetMapping("/self_modify")
   public ModelAndView modify() {
      professorDTO professorDTO = new professorDTO();
      Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
      String USER_NO = authentication.getName(); // "user_NO" 컬럼에서 사용자 이름을 가져옴
      professorDTO.setUSER_NO(USER_NO);
      professorDTO dto = prService.infoload(professorDTO);
      byte[] PHOTO_FILE = dto.getPHOTO_FILE();
      if (PHOTO_FILE != null) {

         dto.setPa("");
         StringBuilder sb = new StringBuilder();
         for (int i = 0; i < PHOTO_FILE.length; i++) {
            sb.append((char) PHOTO_FILE[i]);
         }
         dto.setPa(sb.toString());
      }
      ModelAndView mv = new ModelAndView("self_modify");
      mv.addObject("dto", dto);
      return mv;
   }

   // 교수본인정보 수정
   @ResponseBody
   @PostMapping("/pr_self")
   public String self_save(@RequestParam("pr_no") int pr_no, @RequestParam("name_kr") String name_kr,
         @RequestParam("name_en") String name_en, @RequestParam("roadAddrPart1") String roadAddrPart1,
         @RequestParam("addrDetail") String addrDetail, @RequestParam("pr_telno") String pr_telno,
         @RequestParam("pr_email") String pr_email, @RequestParam("pr_birth") String pr_birth,
         @RequestParam("pr_gender") String pr_gender, @RequestParam("image") MultipartFile image) throws Exception {

     // ConvertBinary convert = new ConvertBinary();
      professorDTO prDTO = new professorDTO();
      Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
      String USER_NO = authentication.getName(); // "user_NO" 컬럼에서 사용자 이름을 가져옴
        prDTO.setUSER_NO(USER_NO);
      prDTO.setINSTR_NO(pr_no);
      prDTO.setKORN_FLNM(name_kr);
      prDTO.setENG_FLNM(name_en);
      prDTO.setADDR(roadAddrPart1);
      prDTO.setDADDR(addrDetail);
      prDTO.setTELNO(pr_telno);
      prDTO.setEML_ADDR(pr_email);
      prDTO.setUSER_BRDT(pr_birth);
      prDTO.setGENDER(pr_gender);
      Encoder encoder = Base64.getEncoder();
      byte[] bytes = image.getBytes();
      byte[] te = encoder.encode(bytes);
      prDTO.setPHOTO_FILE(te);
      prService.prchange(prDTO);
      return "";
   }

   // 교수정보 불러오기
   @GetMapping("/pr_info")
   public ModelAndView prinfo(HttpServletRequest request) {
      ModelAndView mv = new ModelAndView("pr_info");
      List<professorDTO> list = prService.prinfo();
      List<RecruitDTO> depart = recruitService.depart();
      mv.addObject("list", list);
      mv.addObject("depart",depart);
      return mv;
   }

   // 교수정보 검색
   @GetMapping("/pr_info_search")
   @ResponseBody
   public List<Map<String, Object>> search(@RequestParam("code") String code, @RequestParam("name") String name) {
      if(name == "") {
         name = "all";
      }
      professorDTO dto = new professorDTO();
      dto.setCRCLM_CD(code);
      dto.setKORN_FLNM(name);
      List<Map<String, Object>> list = prService.selectList(dto);
      return list;
   }

   // 권한주기
      @PostMapping("/pr_info_auth")
      @ResponseBody
      public String auth(@RequestParam HashMap<String, Object> autest, @RequestParam("num") int num) {   
         List<HashMap<String,Integer>> dto= new ArrayList<>();
         for (int i = 0; i < num; i++) {
            HashMap<String,Integer> map= new HashMap<>();
            map.put("INSTR_NO", Integer.parseInt((String) autest.get("auth_test[" + i + "][no]")));
            map.put("ENDST_NO", Integer.parseInt((String) autest.get("auth_test[" + i + "][auth]")));
            dto.add(map);}
         prService.giveautest(dto);
         return "redirect:/pr_info";
      }

   // 면접평가 불러오기
   @GetMapping("/pr_authority")
   public ModelAndView call_in() {
      ModelAndView mv = new ModelAndView("pr_authority");
      List<HashMap<String, Object>> appl_list = prService.selectList();
      // System.out.println(appl_list);
      mv.addObject("appl_list", appl_list);
      return mv;
   }

   // 면접평가 및 총 점수 저장
   @ResponseBody
   @PostMapping("/pr_score")
   public List<HashMap<String, Object>> score(HttpServletRequest req) {
      String[] appl_no = req.getParameterValues("appl_no");
      String[] interview = req.getParameterValues("inter_score");
      List<HashMap<String, Integer>> list = new ArrayList<HashMap<String, Integer>>();
      for (int i = 0; i < appl_no.length; i++) {
         HashMap<String, Integer> res_inner = new HashMap<String, Integer>();
         res_inner.put("appl_no", Integer.parseInt(appl_no[i]));
         res_inner.put("inter_score", Integer.parseInt(interview[i]));
         list.add(res_inner);
      }
      int result_row = prService.resultpoint(list);
      List<HashMap<String, Object>> appl_list = prService.selectList();
      // System.out.println(appl_list);
      
      return appl_list;
   }

}



















// test 
//      for (int i = 0; i < interview.length; i++) {
//         professorDTO dto = new professorDTO();
//         if (interview[i] != "0" || interview[i] != null || interview[i] != "") {
//            dto.setAppl_NO(Integer.parseInt(appl_no[i]));
//            dto.setInterview(Integer.parseInt(interview[i]));
//         }
//         res.add(dto);
//      }
//      for (int i = res.size()-1;  i >= 0; i--) {
//         if(res.get(i).getInterview() == 0) {
//            res.remove(i);
//         }
//      }
// for (professorDTO d : res) {
// System.out.println(d.getAppl_NO() + ":::" + d.getInterview());
// }
//      professorDTO dto = new professorDTO();
//      System.out.println(req.getParameterValues("inter_score"));
//      for (int i = 0; i < appl_no.length; i++) {
//
//          prService.scoreSave(dto);
//      }
//      scoreSave.put("inter_score", interview);
//      scoreSave.put("totalscore", total);
//      System.out.println(Arrays.toString());
//      Integer interviewScore = prService.resultscore("resultScore