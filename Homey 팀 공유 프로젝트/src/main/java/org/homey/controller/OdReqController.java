package org.homey.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.homey.service.MemberService;
import org.homey.service.OdReqService;
import org.homey.service.OnedayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.homey.domain.Criteria;
import org.homey.domain.FPReqVO;
import org.homey.domain.FreePdtVO;
import org.homey.domain.MemberVO;
import org.homey.domain.OdReqVO;
import org.homey.domain.OnedayVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/odReq/*")		//대표 맵핑
public class OdReqController {
	
	@Setter(onMethod_ = @Autowired)
	private OdReqService odReqService;
	
	@Setter(onMethod_ = @Autowired)
	private OnedayService onedayService;
	
	@Setter(onMethod_ = @Autowired)
	private MemberService memberService;
	
	//원데이클래스 신청 -> 원데이클래스 게시글 상세조회 페이지에 폼이 있으므로 @GetMapping X
	@PreAuthorize("isAuthenticated()")													//현재 로그인된 상태인지 체크
	@GetMapping("register")
	public String register(OdReqVO odrvo, RedirectAttributes rttr) {		//등록할 땐 리다이렉트 해야해서, rttr 객체 필요		
		log.info("원데이클래스 신청......");
		
		//view.jsp에서 
		//1. 로그인해있지 않다면 "나눔신청"버튼을 안띄움
		//2. doubleCheck한 결과를 가지고 "나눔신청"버튼을 띄울지말지 결정
		
		
		if(odReqService.odReqRegister(odrvo)) {							//신청이 정상적으로 되었다면
			rttr.addFlashAttribute("msg", "신청되었습니다.");		
		}else {
			rttr.addFlashAttribute("msg", "신청에 실패하였습니다..");
		}
		return "redirect:/oneday/view?odNo="+odrvo.getOdNo()+"&mid="+odrvo.getMid();		//제품 나눔 신청 후, 원데이클래스 글목록으로 돌아감
		
		//스프링에서 리다이렉트할 때에는 메서드 파라미터에 RedirectAttributes를 선언하고,
		//함께 보내야 할 무언가가 있다면 rttr.addFlashAttribute에서 이름을 지정한 후 담으면 됨

	}
	
	
	
	//"특정 클래스"의 신청자 목록 : 원데이클래스 게시글 상세조회 페이지에서 [신청자 조회] 버튼에 파라미터로 보내는 것 2가지
	@GetMapping("list")											//클라이언트가 '/onedayReq/list'로 들어왔을 때
	@PreAuthorize("hasRole('ROLE_ADMIN')")			//ROLE_ADMIN인 사람이 접근할 때만 해당 메서드 실행
	public String list(Model model, @RequestParam("odNo")int odNo) {		//결과 페이지로 보낼 값들을 model에 담음
		log.info("(특정) 클래스의 신청자 목록......");
		
		//"클래스 신청자 목록" 화면에서, 위에 클래스명 표시하잖아?
		//원데이클래스 클래스명은 "신청자보기" 버튼 누를 때 파라미터로 받기 - 파라미터로 받을 땐 어떻게 받아옴??
		String odName = onedayService.odView(odNo).getOdName();
		
		model.addAttribute("odReqList", odReqService.odReqList(odNo));
		model.addAttribute("odName", odName);
		
		return "/onedayReq/odReqList";
	}//END list()
	
	

	//나의 원데이클래스 신청목록
	@GetMapping("myList")											//클라이언트가 '/onedayReq/myList'로 들어왔을 때
	@PreAuthorize("principal.username == #mid")
	public String myList(Model model, String mid) {		//결과 페이지로 보낼 값들을 model에 담음
		log.info( mid + "회원의 원데이클래스 신청 목록......");
		
		//"나의 원데이클래스 신청목록"화면에서 띄울 것 : 인덱스, 모집현황, 클래스 제목, 모집인원, 당첨여부
		
		//(로직)
		//1) odListAll에 모든 OnedayVO를 담기.
		//2) odListAll 속 OnedayVO의 odReqList를 돌면서 odReqVO의 mid가 (현재 아이디)인 OnedayVO를 찾기
		//3) 찾았다면? <OnedayVO>odMine 이라는 리스트에 담기 
		//4) 컨트롤러에서 odMine을 model에 담기

		//NullPointerException 발생. odReqList가 없대
		//odReqService에 mid 넣으면 나의 신청내역 뽑아올 수 있는 메서드 있지 않았나?  -> odReqListMine이다!!!
		
		System.out.println("현재 로그인한 id : " + mid);
		List<OdReqVO> myOdReqList = odReqService.odReqListMine(mid);		//mid(나)의 원데이클래스 신청목록을 최근 20개만 가져옴
		
		model.addAttribute("myOdReqList", myOdReqList);
		
		return "/onedayReq/myOdReq";
	}//END list()
	
	
	
	//원데이클래스 당첨자 목록 : 원데이클래스 게시글 상세조회 페이지에서 [당첨자 조회] 버튼에 파라미터로 보내는 것 2가지
	@GetMapping("winList")											//클라이언트가 '/onedayReq/winList'로 들어왔을 때
	@PreAuthorize("hasRole('ROLE_ADMIN')")			//ROLE_ADMIN인 사람이 접근할 때만 해당 메서드 실행
	public String winList(Model model, @RequestParam("odNo")int odNo) {		//결과 페이지로 보낼 값들을 model에 담음
		log.info( odNo + "번 게시글의 당첨자 목록......");
		
		//클래스 당첨자 목록 화면에 띄워야 하는 내용 : 인덱스, 당첨자ID, 당첨자 이름, 이메일, 연락처
		String odName = onedayService.odView(odNo).getOdName();
		
		List<OdReqVO> odWinList = odReqService.odWinList(odNo);
		
		model.addAttribute("odWinList", odWinList);			//OdReqVO에 MemberVO를 넣어둬서 쿼리 실행 결과 회원정보도 같이 옴
		model.addAttribute("odName", odName);	
		
		//view에서 꺼낼 땐 그냥 ${}으로 꺼내면 됨
		
		return "/onedayReq/odWinList";
	}//END list()
	
	
	@GetMapping("view")							//클라이언트가 '/onedayReq/view'로 들어왔을 때 : 원데이클래스 신청서 상세조회
	@PreAuthorize("principal.username == #mid or hasRole('ROLE_ADMIN')")
	public String view(int odReqNo, String mid, Model model, @RequestParam("odNo") int odNo, @ModelAttribute("cri") Criteria cri) {		//단건조회한 결과를 model에 담아서 보내야 함
		//위에서 mid는 mid일 경우에만 조회 권한 주려고 (시큐리티) 그런 건가? #writer 키워드로 검색해서 살펴보기
		
		log.info("view..... odReqNo : " + odReqNo);
		log.info("view..... odNo : " + odNo);
		OdReqVO odrvo = odReqService.odReqView(odReqNo);
		String odName = onedayService.odView(odNo).getOdName();

		model.addAttribute("odrvo", odrvo);
		model.addAttribute("odName", odName);
		model.addAttribute("odNo", odNo);
		
		//모집현황이 "모집중"일 때에만 [신청취소], [당첨자로 선정], [당첨취소] 버튼 표시해야 해서 odState 보내기
		int odState = onedayService.odView(odrvo.getOdNo()).getOdState();
		model.addAttribute("odState", odState);
		
		return "/onedayReq/odReqView";
	}//END view()

	

	//원데이클래스 당첨자 선정 -> 사실상 수정임. 원데이클래스 신청 DB의 "당첨여부" 컬럼을 수정
	@GetMapping("win")
	@PreAuthorize("hasRole('ROLE_ADMIN')")			//ROLE_ADMIN인 사람이 접근할 때만 해당 메서드 실행
	public String win(int odReqNo, int odNo, String mid, RedirectAttributes rttr) {	
		log.info("원데이클래스 당첨 선정(당첨여부 1로 수정)......" + odReqNo);
	
		if(odReqService.odReqWin(odReqNo)) {							//odReqNo의 "당첨여부" 컬럼을 1로 수정했다면
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("odReqNo", odReqNo);			//당첨자 선정 후, 컨트롤러의 "원데이클래스 신청자 상세보기('/onedayReq/view')"로 돌아갈 것
		rttr.addAttribute("odNo", odNo);
		rttr.addAttribute("mid", mid);
		
		return "redirect:/odReq/view";
		
		//스프링에서 리다이렉트할 때에는 메서드 파라미터에 RedirectAttributes를 선언하고,
		//함께 보내야 할 무언가가 있다면 rttr.addFlashAttribute에서 이름을 지정한 후 담으면 됨
	}//END win()
	
	
	
	//원데이클래스 당첨취소 -> 사실상 수정임. 원데이클래스 신청 DB의 "당첨여부" 컬럼을 수정
	@GetMapping("winX")
	@PreAuthorize("hasRole('ROLE_ADMIN')")			//ROLE_ADMIN인 사람이 접근할 때만 해당 메서드 실행
	public String winX(int odReqNo, int odNo, String mid, RedirectAttributes rttr) {	
		log.info("원데이클래스 당첨 취소(당첨여부 0으로 수정)......" + odReqNo);
	
		if(odReqService.odReqWinX(odReqNo)) {						//odReqNo의 "당첨여부" 컬럼을 0으로 수정했다면
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("odReqNo", odReqNo);		//리다이렉트된 페이지 URL에 odReqNo 파라미터가 추가	
																		//당첨자 선정 후, 컨트롤러의 "원데이클래스 신청자 상세보기('/onedayReq/view')"로 돌아갈 건데, 그 때 odReqNo를 알아야 하니까
		rttr.addAttribute("odNo", odNo);
		rttr.addAttribute("mid", mid);
		
		return "redirect:/odReq/view";
		
		//스프링에서 리다이렉트할 때에는 메서드 파라미터에 RedirectAttributes를 선언하고,
		//함께 보내야 할 무언가가 있다면 rttr.addFlashAttribute에서 이름을 지정한 후 담으면 됨
	}//END win()
	
	

	//원데이클래스 신청 철회하기
	@GetMapping("remove")							//클라이언트가 '/onedayReq/remove'로 들어왔을 때
	@PreAuthorize("principal.username == #mid")
	public String remove(int odReqNo, String mid, RedirectAttributes rttr) {	
		log.info(odReqNo + "번 원데이클래스 신청 철회 remove...");
		
		if(odReqService.odReqRemove(odReqNo)) {								//원데이클래스 신청철회가 잘 이뤄졌으면	
			rttr.addAttribute("mid", mid);
			rttr.addFlashAttribute("msg", "신청이 취소되었습니다.");				//원데이클래스 게시글 목록에서 "철회되었습니다" 모달 띄우기 위함
		}
		
		return "redirect:/odReq/myList";			//원데이클래스 신청 철회 후, 원데이클래스 게시글 목록으로 돌아가는 걸로 변경
	}//END remove()
	
	
	
}
