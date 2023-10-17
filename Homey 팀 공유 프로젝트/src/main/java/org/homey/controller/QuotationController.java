package org.homey.controller;


import java.util.List;

import org.homey.domain.ItemVO;
import org.homey.domain.QuotationVO;
import org.homey.service.QuotationService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/quo/*")
@AllArgsConstructor 
public class QuotationController {
	  private QuotationService quotationService;
	
	   // 견적서 등록 페이지로 이동하는 GET 요청을 처리
	    @GetMapping("register")
//	    @PreAuthorize("isAuthenticated") // 로그인 했을 시만 권한 적용
	    public void register() {
	    }

	    // 견적상담을 등록하는 POST 요청을 처리
	    @PostMapping("register")
//	    @PreAuthorize("isAuthenticated")
	    public void register(QuotationVO qvo, RedirectAttributes rttr) {
	    	log.info("Quotation의 register. . .");
	    	if (quotationService.register(qvo)) {
	            rttr.addFlashAttribute("result", qvo.getQuoNo());
	        } //리스트 없어서 리턴 없음
	    }
	    
	    @GetMapping("view")
	    public void view(int quoNo, Model model) {
	    	log.info("Quotation의 view. . .");
	        QuotationVO qvo = quotationService.view(quoNo);
	        List<ItemVO> itemVOList = quotationService.getItemsByConsultNo(qvo.getConsultNo());
	        model.addAttribute("qvo", qvo);
	    }

	    // 견적상담을 수정하는 POST 요청을 처리
	    @PostMapping("modify")
//	    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	    public void modify(QuotationVO qvo, RedirectAttributes rttr) {
	    	log.info("Quotation의 modify. . .");
	    	if (quotationService.modify(qvo)) {
	            rttr.addFlashAttribute("result", "success");
	        }
	    }

	    // 견적상담을 삭제하는 POST 요청을 처리
	    @PostMapping("remove")
//	    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	    public void remove(int quoNo, RedirectAttributes rttr) {
	    	log.info("Quotation의 remove. . .");
	    	if (quotationService.remove(quoNo)) {
	            rttr.addFlashAttribute("result", "success");
	        }
	    }
}//QuotationController end
