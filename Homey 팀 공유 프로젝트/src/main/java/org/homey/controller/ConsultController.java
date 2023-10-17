package org.homey.controller;

import org.homey.domain.ConsultVO;
import org.homey.domain.Criteria;
import org.homey.domain.PageDTO;
import org.homey.service.ConsultService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/consult/*")
@AllArgsConstructor 
public class ConsultController {
	 private ConsultService consultService; //서비스 객체가 있어야함 !!!!!!!!!,, 
	
	    // 견적상담 등록 페이지로 이동하는 GET 요청을 처리
	    @GetMapping("register")
//	    @PreAuthorize("isAuthenticated") // 로그인 했을 시만 권한 적용
	    public void register() {
	    	log.info("Consult의 register.jsp . . .");
	    }

	    // 견적상담을 등록하는 POST 요청을 처리
	    @PostMapping("register")
//	    @PreAuthorize("isAuthenticated")
	    public String register(ConsultVO cvo, RedirectAttributes rttr) {
	    	log.info("Consult의 register. . .");
	    	if (consultService.register(cvo)) {
	            rttr.addFlashAttribute("result", cvo.getConsultNo());
	        }
	    	//견적상담 등록 성공 시 메인페이지로 이동
	        return "redirect:/gen/main";
	    }

	    // 전체 견적상담 목록을 조회하는 GET 요청을 처리
	    @GetMapping("list")
	    public void list(Model model, Criteria cri) {
	    	log.info("Consult의 list. . .");
	    	model.addAttribute("consultList", consultService.list(cri));
	        int totalCount = consultService.totalCount(cri);
	        model.addAttribute("pageDTO", new PageDTO(cri, totalCount));
	    }
	    
	    // 나의 전체 견적상담 목록을 조회하는 GET 요청을 처리
	    @GetMapping("list")
	    public void list(Model model, Criteria cri, @RequestParam String mid) {
	        //요청 매개변수 예시 : /list?mid=someMid
	    	log.info("Consult의 나의 list. . .");
	    	model.addAttribute("consultList", consultService.list(cri));
	        int totalCount = consultService.totalCount(cri);
	        model.addAttribute("pageDTO", new PageDTO(cri, totalCount));
	    }

	    // 견적상담 상세 정보를 조회하는 GET 요청을 처리
	    @GetMapping({"view", "modify"})
	    public void view(@RequestParam("consultNo") int consultNo, Model model, @ModelAttribute("cri") Criteria cri) {
	    	log.info("Consult의 View 또는 Modify . .");
	    	model.addAttribute("cvo", consultService.view(consultNo));
	    }

	    // 견적상담을 수정하는 POST 요청을 처리
	    @PostMapping("modify")
	    @ResponseBody //Ajax 요청임을 나타냄
//	    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	    public String modify(ConsultVO cvo) {
	    	log.info("Consult의 Modify . .");
	        if (consultService.modify(cvo)) {
	            return "success"; // 수정 성공 시 "success" 반환
	        } else {
	            return "error"; // 수정 실패 시 "error" 반환
	        }
	    }

	    // 견적상담을 삭제하는 POST 요청을 처리
	    @PostMapping("remove")
//	    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	    public String remove(int consultNo, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
	    	log.info("Consult의 remove . .");
	    	
	    	if (consultService.remove(consultNo)) {
	            rttr.addFlashAttribute("result", "success");
	        }
	    	//페이징 정보 추가
	        rttr.addAttribute("type", cri.getType());
	        rttr.addAttribute("keyword", cri.getKeyword());
	        rttr.addAttribute("pageNum", cri.getPageNum());
	        rttr.addAttribute("amount", cri.getAmount());
	        return "redirect:/consult/list";
	    }

//백업용 공간
//	    // 견적상담을 수정하는 POST 요청을 처리
//	    @PostMapping("modify")
//	    @ResponseBody //Ajax 요청임을 나타냄
//      @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
//	    public String modify(ConsultVO cvo, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
//	    	log.info("Consult의 Modify . .");
//	    	if (consultService.modify(cvo)) {
//	            rttr.addFlashAttribute("result", "success");
//	        }
//	        rttr.addAttribute("type", cri.getType());
//	        rttr.addAttribute("keyword", cri.getKeyword());
//	        rttr.addAttribute("pageNum", cri.getPageNum());
//	        rttr.addAttribute("amount", cri.getAmount());
//	        return "redirect:/consult/list";
//	    }
	

} // ConsultController end
