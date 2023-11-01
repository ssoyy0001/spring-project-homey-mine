package org.homey.controller;

import org.homey.domain.ConsultVO;
import org.homey.domain.ItemVO;
import org.homey.domain.QuotationVO;
import org.homey.domain.SiRequestVO;
import org.homey.domain.SireqCriteria;
import org.homey.domain.SireqPageDTO;
import org.homey.service.ConsultService;
import org.homey.service.ItemService;

import org.homey.service.QuotationService;
import org.homey.service.SiRequestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	
//	@GetMapping("/sireqList")
//	public void list(Model model) { //시공의뢰 전체목록
//		log.info("list......");
//		model.addAttribute("list", sireqService.getList()); //리스트 페이징
//
//	} 
	
	@GetMapping("/sireqList")
	public void list(Model model, SireqCriteria cri) { //시공의뢰 전체목록 + 페이징
		log.info("list......" + cri);
		model.addAttribute("list", sireqService.getList(cri)); //리스트 페이징
//		int totalCount = sireqService.totalCount(cri);
		model.addAttribute("pageDTO", new SireqPageDTO(cri, 500));//시공의뢰 전체 수

	} 
	
	@GetMapping("/sireqRegisterForm")
	//@PreAuthorize("isAuthenticated()")
	public String register(@RequestParam("quoNo") int quoNo, @RequestParam("consultNo") int consultNo, @RequestParam("itemNo") int itemNo, Model model, Model model2, Model model3  ) {
        
	// quoNo를 사용하여 해당 견적서 데이터를 가져오는 로직을 구현
    // Quotation 테이블에서 데이터 가져오기
	     model.addAttribute("qvo", quotationService.view(quoNo));
	     model2.addAttribute("cvo", consultService.view(consultNo));
	     model3.addAttribute("ivo", itemService.view(itemNo));

	// 모델에 데이터를 추가하여 JSP 페이지로 전달

        return "/sirequest/sireqRegisterForm";
    }
	
	@GetMapping(value = "/sireqRegister")
//	@PreAuthorize("isAuthenticated()")
	public String register(SiRequestVO sireq, RedirectAttributes redirectAttributes) { //시공의뢰 등록 + 첨부파일 등록
		ItemVO ivo = sireq.getIvo();
		QuotationVO qvo = sireq.getQuotationvo();

		log.info("@PostMapping sireqRegister: " + sireq);
		
		if (sireqService.register(sireq, ivo, qvo)) {
	        // 성공한 경우, 리다이렉션할 URL을 지정합니다.
	        // 여기에서는 "/success"로 리다이렉션 예시를 보여줍니다.
	        return "redirect:/sirequest/sireqList";
	    } else {
	        // 실패한 경우, 에러 메시지를 설정하여 리다이렉션할 URL을 지정합니다.
	        redirectAttributes.addFlashAttribute("error", "Registration failed");
	        return "redirect:/error";
	    }

//		return sireqService.register(sireq, ivo, qvo) ? new ResponseEntity<>("Success", HttpStatus.OK)
//				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	} 
	
	
	@PostMapping("/sireqModify")
//	@PreAuthorize("principal.username == #bvo.writer")
	public String modify(SiRequestVO sireq, Model model, RedirectAttributes rttr) { //시공의뢰내용 수정하기
		log.info("sireqModify: " + sireq);
		
		if(sireqService.modify(sireq)) {
			rttr.addFlashAttribute("result", "success");
		}

		return "redirect:/sirequest/sireqView";
	} 
	
	@PostMapping("/sireqRemove")
//	@Pr)eAuthorize("principal.username == #writer")
	public String remove(@RequestParam("sireqNo") int sireqNo, RedirectAttributes rttr ) { //시공의뢰내용 삭제하기
		log.info("remove....." + sireqNo);
		if(sireqService.remove(sireqNo)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/sirequest/sireqList";
	} 
	
	@GetMapping({"/sireqView", "/sireqModify"})
	public void view(@RequestParam("sireqNo") int sireqNo, Model model) { //시공의뢰 상세페이지, 수정페이지 조회하기
		model.addAttribute("sireq", sireqService.get(sireqNo));
	} 
	
//	public void deleteFiles(List<SiRequestAttachVO> sireqAttachList) { //시공의뢰 첨부파일 삭제
//		return;
//	} 
//	
//	@GetMapping(value="sireqAttachList")
//	public ResponseEntity<List<SiRequestAttachVO>> sireqAttachList(int sireqNo){ //시공의뢰 첨부파일 조회
//		return new ResponseEntity<>(sireqService.sireqAttachList(sireqNo), HttpStatus.OK);
//	} 
//	
//	@GetMapping("mylist")
//	public void list(Model model, String mid, SireqCriteria cri) { //나의 시공의뢰 전체목록 + 페이징
//		model.addAttribute("mylist", sireqService.mylist(mid, cri)); //리스트 페이징
//		int mytotalCount = sireqService.mytotalCount(mid, cri);
//		model.addAttribute("pageDTO", new PageDTO(cri, mytotalCount));//나의 시공의뢰 전체 수
//	} 

}
