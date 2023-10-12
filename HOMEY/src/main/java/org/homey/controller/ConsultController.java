package org.homey.controller;

import org.homey.domain.ConsultVO;
import org.homey.domain.Criteria;
import org.homey.domain.PageDTO;
import org.homey.service.ConsultService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/consult/*")
@AllArgsConstructor 
public class ConsultController {
	
	 private ConsultService consultService;
	
	   // 견적상담 등록 페이지로 이동하는 GET 요청을 처리 ㅇㄴㅁㅇㄴㅁㅇㅁㄴㅇ뾰
	    @GetMapping("register")
	    @PreAuthorize("isAuthenticated") // 로그인 했을 시만 권한 적용
	    public void register() {
	    }

	    // 견적상담을 등록하는 POST 요청을 처리
	    @PostMapping("register")
	    @PreAuthorize("isAuthenticated")
	    public String register(ConsultVO cvo, RedirectAttributes rttr) {
	        if (consultService.register(cvo)) {
	            rttr.addFlashAttribute("result", cvo.getConsultNo());
	        }
	        return "redirect:/consult/list";
	    }

	    // 견적상담 목록을 조회하는 GET 요청을 처리
	    @GetMapping("list")
	    public void list(Model model, Criteria cri) {
	        model.addAttribute("consultList", consultService.list(cri));
	        int totalCount = consultService.totalCount(cri);
	        model.addAttribute("pageDTO", new PageDTO(cri, totalCount));
	    }

	    // 견적상담 상세 정보를 조회하는 GET 요청을 처리
	    @GetMapping({"view", "modify"})
	    public void view(@RequestParam("consultNo") int consultNo, Model model, @ModelAttribute("cri") Criteria cri) {
	        model.addAttribute("cvo", consultService.view(consultNo));
	    }

	    // 견적상담을 수정하는 POST 요청을 처리
	    @PostMapping("modify")
	    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	    public String modify(ConsultVO cvo, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
	        if (consultService.modify(cvo)) {
	            rttr.addFlashAttribute("result", "success");
	        }
	        rttr.addAttribute("type", cri.getType());
	        rttr.addAttribute("keyword", cri.getKeyword());
	        rttr.addAttribute("pageNum", cri.getPageNum());
	        rttr.addAttribute("amount", cri.getAmount());
	        return "redirect:/consult/list";
	    }

	    // 견적상담을 삭제하는 POST 요청을 처리
	    @PostMapping("remove")
	    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	    public String remove(int consultNo, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
	        if (consultService.remove(consultNo)) {
	            rttr.addFlashAttribute("result", "success");
	        }
	        rttr.addAttribute("type", cri.getType());
	        rttr.addAttribute("keyword", cri.getKeyword());
	        rttr.addAttribute("pageNum", cri.getPageNum());
	        rttr.addAttribute("amount", cri.getAmount());
	        return "redirect:/consult/list";
	    }

	

}
