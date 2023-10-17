package org.homey.controller;

import org.homey.domain.Criteria;
import org.homey.domain.NoticeVO;
import org.homey.domain.PageDTO;
import org.homey.service.NoticeService;
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
@RequestMapping("/notice/*")
@AllArgsConstructor
public class NoticeController {
	
	  private NoticeService noticeService;
	
	//공지사항 등록 페이지로 이동하는 GET 요청
	//등록 (주소창 입력 get : register.JSP로 이동)
	@GetMapping("register")
	//@PreAuthorize("isAuthenticated()") //로그인 했을 시만 권한 적용
	public void register() { }
	
	//로그인 했을 시만 권한 적용
	@PostMapping("register")
	//@PreAuthorize("isAuthenticated()")
	public String register(NoticeVO nvo, RedirectAttributes rttr) {// BoardControllerTests에서 돌려보기
		log.info("register......");
		
		 // NoticeService를 사용하여 공지사항을 등록하고 등록 성공 시 메시지를 Flash 속성으로 추가
		if(noticeService.register(nvo)) {
			rttr.addFlashAttribute("result", nvo.getNotNo());
		}
		// 반환이 void면 /WEB-INF/views/board/list.jsp로 이동하는데 jsp로 가면 안되고 맵핑된 list로 가야함
		// 공지사항 등록 후, 공지사항 목록 페이지로 리다이렉
		return "redirect:/notice/list";
		// 얘는 @GetMapping("list")로 이동! -> select된 목록을 갖고 가야하므로 .do로 보내는 것과 동일
	}
	
	// 공지사항 목록을 조회하는 GET 요청
	@GetMapping("list")
	public void list(Model model, Criteria cri) {
		log.info("list......" + cri);

		// NoticeService를 사용하여 공지사항 목록 및 페이징 정보를 모델에 추가
		model.addAttribute("noticeList", noticeService.list(cri));
		int totalCount = noticeService.totalCount(cri);
		model.addAttribute("pageDTO", new PageDTO(cri, totalCount));
	}
	
	@GetMapping({"view", "modify"})
	public void view(@RequestParam("notNo") int notNo, Model model, 
				     @ModelAttribute("cri") Criteria cri) {
		log.info("view or modify......");
		
		// NoticeService를 사용하여 특정 공지사항 정보를 모델에 추가
		model.addAttribute("nvo", noticeService.view(notNo));
	}
	
	// 공지사항을 수정하는 POST 요청
	@PostMapping("modify") 
	//@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	public String modify(NoticeVO nvo, RedirectAttributes rttr, 
		     			 @ModelAttribute("cri") Criteria cri) {
		log.info("modify......");
		
		// NoticeService를 사용하여 공지사항을 수정하고 수정 성공 시 메시지를 Flash 속성
		if(noticeService.modify(nvo)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		//메서드 파라미터에 리다이렉트 관련을 선언하고, rttr에 더하여
		//저 result로 이름으로 , 다음의 값을 보냄
		//그 후 목록으로 리다이렉트, mapping하고 결과페이지가 같으면 void인데
		//우리는 list로 mapping할 것이기 때문에 string으로 변경

		// 공지사항 수정 후, 공지사항 목록 페이지로 리다이렉션
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/notice/list";
	}
	
	// 공지사항을 삭제하는 POST 요청
	@PostMapping("remove")
	//@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	public String remove(String writer, int notNo, RedirectAttributes rttr, 
		     			 @ModelAttribute("cri") Criteria cri) {
		log.info("remove...... notNo : " + notNo);

		// NoticeService를 사용하여 공지사항을 삭제하고 삭제 성공 시 메시지를 Flash 속성
		if(noticeService.remove(notNo)) {
			log.info("remove ok");
			rttr.addFlashAttribute("result", "success");
		}
		
		// 공지사항 삭제 후, 공지사항 목록 페이지로 리다이렉션
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/notice/list";
	}
	

}
