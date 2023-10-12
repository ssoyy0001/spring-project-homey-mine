package org.homey.controller;


import org.homey.domain.QuotationVO;
import org.homey.service.QuotationService;
import org.springframework.security.access.prepost.PreAuthorize;
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
	
	   // 견적상담 등록 페이지로 이동하는 GET 요청을 처리
	    @GetMapping("register")
	    @PreAuthorize("isAuthenticated") // 로그인 했을 시만 권한 적용
	    public void register() {
	    }

	    // 견적상담을 등록하는 POST 요청을 처리
	    @PostMapping("register")
	    @PreAuthorize("isAuthenticated")
	    public void register(QuotationVO qvo, RedirectAttributes rttr) {
	        if (quotationService.register(qvo)) {
	            rttr.addFlashAttribute("result", qvo.getQuoNo());
	        } //리스트 없어서 리턴 없음
	    }
	    
	    @GetMapping("view")
	    public void view(int quoNo, Model model) {
	        model.addAttribute("qvo", quotationService.view(quoNo));
	    }

	    // 견적상담을 수정하는 POST 요청을 처리
	    @PostMapping("modify")
	    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	    public void modify(QuotationVO qvo, RedirectAttributes rttr) {
	        if (quotationService.modify(qvo)) {
	            rttr.addFlashAttribute("result", "success");
	        }
	    }

	    // 견적상담을 삭제하는 POST 요청을 처리
	    @PostMapping("remove")
	    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	    public void remove(int quoNo, RedirectAttributes rttr) {
	        if (quotationService.remove(quoNo)) {
	            rttr.addFlashAttribute("result", "success");
	        }
	    }
}//컨트롤러 end
