package org.homey.controller;

import org.homey.domain.ConsultVO;
import org.homey.domain.Criteria;
import org.homey.domain.ItemVO;
import org.homey.domain.PageDTO;
import org.homey.service.ConsultService;
import org.homey.service.QuotationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/consult/*")
public class ConsultController {
	@Setter(onMethod_ = @Autowired)
	private ConsultService consultService;
	@Setter(onMethod_ = @Autowired)
	QuotationService quotationService;

	// 견적상담 등록 페이지로 이동하는 GET 요청
	@GetMapping("register")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')") // 관리자 또는 멤버일 경우에만 접근
	public void register(Model model) {
		log.info("Consult의 register.jsp . . .");
		String mid = null;
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
			UserDetails userDetails = (UserDetails) authentication.getPrincipal();
			mid = userDetails.getUsername();
		}
		// 모델에 로그안한 사람이 id추가
		model.addAttribute("mid", mid);

	}

	// 견적상담을 등록하는 POST 요청
	@PostMapping("register")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')") // 관리자 또는 멤버일 경우
	public String register(ConsultVO cvo, ItemVO ivo, RedirectAttributes rttr) {
		log.info("Consult의 register. . .");

		// 사용자 이름(mid) 가져오기
		String mid = null;
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
			UserDetails userDetails = (UserDetails) authentication.getPrincipal();
			mid = userDetails.getUsername();
		}
		// MID를 ConsultVO 객체에 설정
		cvo.setMid(mid);
		// 견적 등록과 item테이블에 insert
		int consultResult = consultService.register(cvo, ivo);
		if (consultResult > 0) {
			rttr.addFlashAttribute("result", cvo.getConsultNo());
		}
		// 견적상담 등록 성공 시 메인페이지로 이동
		return "redirect:/gen/main";
	}

	// 전체 견적상담 목록을 조회하는 GET 요청
	@GetMapping("list")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	public void list(Model model, Criteria cri) {
		log.info("Consult의 list. . .");
		int totalCount = consultService.totalCount(cri);
		model.addAttribute("consultList", consultService.list(cri));
		model.addAttribute("pageDTO", new PageDTO(cri, totalCount));
		model.addAttribute("totalCount", totalCount); // 전체 견적상담 목록 카운팅
	}

	// 나의 전체 견적상담 목록을 조회하는 GET 요청
	@GetMapping("myList")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	public void myList(Model model, @RequestParam String mid) {
		// 마이페이지에서 타고 넘어온 mid
		log.info(mid + "의 견적 상담 list. . .");
		model.addAttribute("consultList", consultService.myList(mid));
	}

	// 견적상담 상세 정보를 조회하는 GET 요청
	@GetMapping({ "consultManage", "modify" })
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	public String view(@RequestParam("consultNo") int consultNo, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("Consult의 View 또는 Modify . .");
		
		model.addAttribute("cvo", consultService.view(consultNo));
		
		ItemVO quotationItem = quotationService.selectItem(consultNo); //견적서에 시공 및 철거항목 표시
		model.addAttribute("quotationItem", quotationItem);
		return "consult/consultManage"; // consultManage.jsp로 포워딩
	}

	// 견적상담을 수정하는 POST 요청
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')") // 관리자 또는 멤버일 경우
	@PostMapping("modify")
	public String modify(ConsultVO cvo, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info("Consult의 Modify . .");

		if (consultService.modify(cvo)) {
			rttr.addFlashAttribute("resultM", cvo.getConsultNo()); // list에 보낼 result에 견적상담번호 담아보냄
		}

		// 페이징 정보 추가
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());

		// 현재 사용자의 권한에 따라 리다이렉트 주소 설정
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		boolean isAdmin = authentication.getAuthorities().stream()
				.anyMatch(auth -> auth.getAuthority().equals("ROLE_ADMIN"));
		if (isAdmin) {
			return "redirect:/consult/list";
		} else {
			return "redirect:/consult/myList?mid=" + authentication.getName();
		}
	}

	// 견적상담 삭제 POST 요청
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')") //관리자만 삭제 가능
	@PostMapping("remove")
	public String remove(int consultNo, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info("Consult의 remove . . 삭제된 견적상담 번호" + consultNo);

		if (consultService.remove(consultNo)) {
			log.info("remove ok");
			rttr.addFlashAttribute("resultD", consultNo); // list에 보낼 result에 견적상담번호 담아보냄
		}
	// 페이징 정보 추가
	rttr.addAttribute("type", cri.getType());
	rttr.addAttribute("keyword", cri.getKeyword());
	rttr.addAttribute("pageNum", cri.getPageNum());
	rttr.addAttribute("amount", cri.getAmount());
	return "redirect:/consult/list";
	}
} // ConsultController end
