package org.homey.controller;

import org.homey.domain.ItemVO;
import org.homey.domain.QuotationVO;
import org.homey.domain.SiRequestVO;
import org.homey.domain.SireqCriteria;
import org.homey.domain.SireqPageDTO;
import org.homey.service.ConsultService;
import org.homey.service.ItemService;
import org.homey.service.MemberService;
import org.homey.service.QuotationService;
import org.homey.service.SiRequestService;
import org.homey.service.SiScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/sirequest/")
@AllArgsConstructor
public class SiRequestController {
   @Setter(onMethod_ = @Autowired)
   private SiRequestService sireqService;
   @Setter(onMethod_ = @Autowired)
   private ConsultService consultService;
   @Setter(onMethod_ = @Autowired)
   private QuotationService quotationService;
   @Setter(onMethod_ = @Autowired)
   private ItemService itemService;
   @Setter(onMethod_ = @Autowired)
   private MemberService memberService;
   @Setter(onMethod_ = @Autowired)
   private SiScheduleService sicheService;
   
//   @GetMapping("/sireqList")
//   public void list(Model model) { //시공의뢰 전체목록
//      log.info("list......");
//      model.addAttribute("list", sireqService.getList()); //리스트 페이징
//
//   } 
   
   @GetMapping("/sireqList")
   @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')") // 관리자 또는 멤버일 경우에만 접근
   public void list(Model model, SireqCriteria cri) { //시공의뢰 전체목록 + 페이징
      log.info("list......" + cri);
      model.addAttribute("list", sireqService.getList(cri)); //리스트 페이징
//      model.addAttribute("pageDTO", new SireqPageDTO(cri, 500));//시공의뢰 전체 수
      int totalCount = sireqService.totalCount(cri);
      log.info("totalCount: " + totalCount);
      model.addAttribute("pageDTO", new SireqPageDTO(cri, totalCount));//시공의뢰 전체 수

   } 
   
   @GetMapping("/sireqRegisterForm")
   @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')") // 관리자 또는 멤버일 경우에만 접근
   public String register(@RequestParam("quoNo") int quoNo, @RequestParam("consultNo") int consultNo, @RequestParam("itemNo") int itemNo, Model model, Model model2, Model model3  ) {
        
   // quoNo를 사용하여 해당 견적서 데이터를 가져오는 로직을 구현
    // Quotation 테이블에서 데이터 가져오기
        model.addAttribute("qvo", quotationService.view(quoNo));
        model2.addAttribute("cvo", consultService.view(consultNo));
        model3.addAttribute("ivo", itemService.view(itemNo));

   // 모델에 데이터를 추가하여 JSP 페이지로 전달
       log.info("qvo: " + quotationService.view(quoNo));
      log.info("cvo: " + consultService.view(consultNo));
      log.info("ivo: " + itemService.view(itemNo));

        return "/sirequest/sireqRegisterForm";
    }
   
   @GetMapping(value = "/sireqRegister")
   @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')") // 관리자 또는 멤버일 경우에만 접근
   public String register(SiRequestVO sireq, String mid, RedirectAttributes redirectAttributes) { //시공의뢰 등록 + 첨부파일 등록
      ItemVO ivo = sireq.getIvo();
      QuotationVO qvo = sireq.getQuotationvo();
      
      //테스트중
      sireq.setMvo(memberService.view(mid));
      
      log.info("@PostMapping sireqRegister: " + sireq);
      log.info("@PostMappint getQuotationvo: " + sireq.getQuotationvo());
      log.info("@PostMappint getIvo: " + sireq.getIvo());
      
      if (sireqService.register(sireq, ivo, qvo)) {
           // 성공한 경우, 리다이렉션할 URL을 지정하기
           return "redirect:/sirequest/sireqList";
       } else {
           // 실패한 경우, 에러 메시지를 설정하여 리다이렉션할 URL을 지정하기
           redirectAttributes.addFlashAttribute("error", "Registration failed");
           return "redirect:/error";
       }

   } 
   
   @GetMapping({"/sireqView"})
   @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')") // 관리자 또는 멤버일 경우에만 접근
   public void view(@RequestParam("sireqNo") int sireqNo, Model model) { //시공의뢰 상세페이지, 수정페이지 조회하기
      log.info("sireqView.....sireqNo: " + sireqNo);
      model.addAttribute("sireq", sireqService.get(sireqNo));
      model.addAttribute("checkRegist",sicheService.checkSicheRegist(sireqNo));
   } 
   
   @GetMapping({"/sireqModifyForm"})
   @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')") // 관리자 또는 멤버일 경우에만 접근
   public String view(@RequestParam("sireqNo")int sireqNo, @RequestParam("quoNo") int quoNo, @RequestParam("consultNo") int consultNo, @RequestParam("itemNo") int itemNo, Model model, Model model2, Model model3, Model model4) { //시공의뢰 상세페이지, 수정페이지 조회하기
      log.info("sireqModifyForm...." + sireqNo);
      model.addAttribute("sireq", sireqService.get(sireqNo));
      model2.addAttribute("qvo", sireqService.get(quoNo));
      model3.addAttribute("cvo", sireqService.get(consultNo));
      model4.addAttribute("ivo", sireqService.get(itemNo));
      
      log.info("qvo: " + sireqService.get(sireqNo).getQuotationvo());
      log.info("cvo: " + sireqService.get(sireqNo).getConsultvo());
      log.info("ivo: " + sireqService.get(sireqNo).getIvo().getItemNo());
      return "/sirequest/sireqModifyForm";
   } 
   
   @GetMapping("/sireqModify")
   @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')") // 관리자 또는 멤버일 경우에만 접근
   public String modify(SiRequestVO sireq, RedirectAttributes redirectAttributes) { //시공의뢰내용 수정하기 
      int sireqNo = sireq.getSireqNo();
      ItemVO ivo = sireq.getIvo();
      QuotationVO qvo = sireq.getQuotationvo();
      
      log.info("@PostMappint sireqModify: " + sireq);
      log.info("@PostMappint getQuotationvo: " + sireq.getQuotationvo());
      log.info("@PostMappint getIvo: " + sireq.getIvo());
      
      if(sireqService.modify(sireqNo, sireq, ivo, qvo)) {
         // 성공한 경우, 리다이렉션할 URL을 지정하기
           return "redirect:/sirequest/sireqList";
      } else {
           // 실패한 경우, 에러 메시지를 설정하여 리다이렉션할 URL을 지정하기
         redirectAttributes.addFlashAttribute("error", "Registration failed");
           return "redirect:/error";
      }
   } 
   
   @GetMapping("/sireqRemove")
   @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')") // 관리자 또는 멤버일 경우에만 접근
   public String remove(@RequestParam("sireqNo") int sireqNo, RedirectAttributes rttr ) { //시공의뢰내용 삭제하기
      log.info("remove....." + sireqNo);
      if(sireqService.remove(sireqNo)) {
         rttr.addFlashAttribute("result","success");
      }
      return "redirect:/sirequest/sireqList";
   } 
   
//   public void deleteFiles(List<SiRequestAttachVO> sireqAttachList) { //시공의뢰 첨부파일 삭제
//      return;
//   } 
//   
//   @GetMapping(value="sireqAttachList")
//   public ResponseEntity<List<SiRequestAttachVO>> sireqAttachList(int sireqNo){ //시공의뢰 첨부파일 조회
//      return new ResponseEntity<>(sireqService.sireqAttachList(sireqNo), HttpStatus.OK);
//   } 
   
   @GetMapping("/mySireqList")
   @PreAuthorize("hasAnyRole('ROLE_MEMBER')") // 관리자 또는 멤버일 경우에만 접근
   public void mylist(Model model, @RequestParam String mid) { //나의 시공의뢰 전체목록 + 페이징
      
               log.info( mid + "회원의 시공의뢰 목록......");
               model.addAttribute("mySireqList", sireqService.mylist(mid));
   } 
   
//   @GetMapping({"/quotationView"})
////   @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')") // 관리자 또는 멤버일 경우에만 접근
//   public void quoSelect(@RequestParam("quoNo") int quoNo, SiRequestVO sireq, Model model) { //시공의뢰 상세페이지, 수정페이지 조회하기
//      log.info("quotationView........." + quoNo);
//      model.addAttribute("sireq", sireqService.quoSelect(quoNo));
//   } 

}
