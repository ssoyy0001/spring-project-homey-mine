package org.homey.controller;

import java.util.List;

import org.homey.service.MemberService;
import org.homey.service.OdReqService;
import org.homey.service.OnedayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.homey.domain.SoCriteria;
import org.homey.domain.OdReqVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/odReq/*")		//대표 맵핑
public class OdReqController {
	
	@Setter(onMethod_ = @Autowired)
	private OdReqService odReqService;				//원데이클래스 신청 관련 서비스
	
	@Setter(onMethod_ = @Autowired)
	private OnedayService onedayService;			//원데이클래스 게시글 관련 서비스
	
	@Setter(onMethod_ = @Autowired)
	private MemberService memberService;			//회원 관련 서비스
	
	
	
	//원데이클래스 신청 -> 원데이클래스 게시글 상세조회 페이지에 폼이 있으므로 @GetMapping X
	@PreAuthorize("isAuthenticated()")
	@GetMapping("register")
	public String register(OdReqVO odrvo, RedirectAttributes rttr) {
		log.info("원데이클래스 신청......");
		
		if(odReqService.odReqRegister(odrvo)) {
			rttr.addFlashAttribute("msg", "신청되었습니다.");		
		}else {
			rttr.addFlashAttribute("msg", "신청에 실패하였습니다..");
		}
		return "redirect:/oneday/view?odNo="+odrvo.getOdNo()+"&mid="+odrvo.getMid();		//원데이클래스 신청 후, 신청한 게시글에 남아있음
	}
	
	
	
	//"특정 클래스"의 신청자 목록
	@GetMapping("list")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String list(Model model, @RequestParam("odNo")int odNo) {
		log.info("(특정) 클래스의 신청자 목록......");

		String odName = onedayService.odView(odNo).getOdName();
		
		model.addAttribute("odReqList", odReqService.odReqList(odNo));
		model.addAttribute("odName", odName);										//"클래스 신청자 목록" 화면 상단에 클래스명 표시하기 위함
		model.addAttribute("odNo", odNo);
		
		return "/onedayReq/odReqList";
	}//END list()
	
	

	//나의 원데이클래스 신청목록
	@GetMapping("myList")
	@PreAuthorize("principal.username == #mid")
	public String myList(Model model, String mid) {
		log.info( mid + "회원의 원데이클래스 신청 목록......");
		
		System.out.println("현재 로그인한 id : " + mid);
		List<OdReqVO> myOdReqList = odReqService.odReqListMine(mid);		//mid(나)의 원데이클래스 신청목록을 최근 20개만 담아옴
		
		model.addAttribute("myOdReqList", myOdReqList);
		
		return "/onedayReq/myOdReq";
	}//END list()
	
	
	
	//원데이클래스 당첨자 목록
	@GetMapping("winList")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String winList(Model model, @RequestParam("odNo")int odNo) {
		log.info( odNo + "번 게시글의 당첨자 목록......");
		
		//클래스 당첨자 목록 화면에 띄워야 하는 내용 : 인덱스, 당첨자ID, 당첨자 이름, 이메일, 연락처
		String odName = onedayService.odView(odNo).getOdName();
		List<OdReqVO> odWinList = odReqService.odWinList(odNo);
		
		model.addAttribute("odWinList", odWinList);			//OdReqVO에 MemberVO를 넣어뒀으므로, odWinList에 회원정보도 담겨있음
		model.addAttribute("odName", odName);	

		return "/onedayReq/odWinList";
	}//END list()
	
	
	//원데이클래스 신청서 상세조회
	@GetMapping("view")	
	@PreAuthorize("principal.username == #mid or hasRole('ROLE_ADMIN')")
	public String view(int odReqNo, String mid, Model model, @RequestParam("odNo") int odNo, @ModelAttribute("cri") SoCriteria cri) {
		
		log.info("view..... odReqNo : " + odReqNo);
		
		OdReqVO odrvo = odReqService.odReqView(odReqNo);
		String odName = onedayService.odView(odNo).getOdName();
		int odState = onedayService.odView(odrvo.getOdNo()).getOdState();	//모집현황이 "모집중"일 때에만 [신청취소], [당첨자로 선정], [당첨취소] 버튼 표시해야 해서 odState 보내기
		
		model.addAttribute("odrvo", odrvo);
		model.addAttribute("odName", odName);
		model.addAttribute("odNo", odNo);
		model.addAttribute("odState", odState);
		
		return "/onedayReq/odReqView";
	}//END view()

	

	//원데이클래스 당첨자 선정 -> 사실상 수정임. 원데이클래스 신청 DB의 "당첨여부" 컬럼을 수정
	@GetMapping("win")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String win(int odReqNo, int odNo, String mid, RedirectAttributes rttr) {	
		log.info("원데이클래스 당첨 선정(당첨여부 1로 수정)......" + odReqNo);
	
		if(odReqService.odReqWin(odReqNo)) {					//odReqNo의 "당첨여부" 컬럼을 1로 수정했다면
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("odReqNo", odReqNo);					//당첨자 선정 후, 컨트롤러의 "원데이클래스 신청자 상세보기('/onedayReq/view')"로 돌아갈 것
		rttr.addAttribute("odNo", odNo);
		rttr.addAttribute("mid", mid);
		
		return "redirect:/odReq/view";
	}//END win()
	
	
	
	//원데이클래스 당첨취소 -> 사실상 수정임. 원데이클래스 신청 DB의 "당첨여부" 컬럼을 수정
	@GetMapping("winX")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String winX(int odReqNo, int odNo, String mid, RedirectAttributes rttr) {	
		log.info("원데이클래스 당첨 취소(당첨여부 0으로 수정)......" + odReqNo);
	
		if(odReqService.odReqWinX(odReqNo)) {				//odReqNo의 "당첨여부" 컬럼을 0으로 수정했다면
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("odReqNo", odReqNo);		//당첨자 선정 후, 컨트롤러의 "원데이클래스 신청자 상세보기('/onedayReq/view')"로 돌아갈 것
		rttr.addAttribute("odNo", odNo);
		rttr.addAttribute("mid", mid);
		
		return "redirect:/odReq/view";
	}//END win()
	
	

	//원데이클래스 신청 철회하기
	@GetMapping("remove")
	@PreAuthorize("principal.username == #mid")
	public String remove(int odReqNo, String mid, RedirectAttributes rttr) {	
		log.info(odReqNo + "번 원데이클래스 신청 철회 remove...");
		
		if(odReqService.odReqRemove(odReqNo)) {						//원데이클래스 신청철회가 잘 이뤄졌으면	
			rttr.addAttribute("mid", mid);
			rttr.addFlashAttribute("msg", "신청이 취소되었습니다.");
		}
		
		return "redirect:/odReq/myList";										//원데이클래스 신청 철회 후, 원데이클래스 게시글 목록으로 이동
	}//END remove()
	
	
	
}
