package org.homey.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.homey.service.FPReqService;
import org.homey.service.FreePdtService;
import org.homey.service.MemberService;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.homey.domain.Criteria;
import org.homey.domain.FPReqVO;
import org.homey.domain.FreePdtVO;
import org.homey.domain.MemberVO;
import org.homey.domain.PageDTO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class FreePdtController {
	
	@Setter(onMethod_ = @Autowired)
	private FreePdtService freePdtService;				//제품 나눔 게시글 관련 서비스
	
	@Setter(onMethod_ = @Autowired)
	private FPReqService fPdtReqService;					//제품 나눔 신청 관련 서비스

	@Setter(onMethod_ = @Autowired)
	private MemberService memberService;				//회원 서비스 -> 당첨자 명단 볼 때 회원정보 표시하려고
	
	
	@GetMapping("/freePdt/list")
	public String list(Model model, Criteria cri) {		//결과 페이지로 보낼 값들을 model에 담음
		log.info("list......" + cri);
		
		model.addAttribute("list", freePdtService.fpListPaging(cri));
		model.addAttribute("pageDTO", new PageDTO(cri, freePdtService.fpTotalCount(cri)));	
	
		return "/freePdt/fPdtList";
	}//END list()
	
	
	@GetMapping("/freePdt/view")
	@PreAuthorize("isAuthenticated()")			//로그인한 경우에만 상세조회 가능
	public String view(int fpNo, String mid, Model model,  @ModelAttribute("cri") Criteria cri) {		//단건조회한 결과를 model에 담아서 보내야 함
	
		log.info("view....." + fpNo);
		
		//제품나눔글 상세조회 화면에서 신청버튼 표시할지 말지를 알아야 하니까
		//serviceImpl의 doubleCheck메서드를 호출한 후, 리턴값을 rttr에 담아서 view.jsp로 가야할듯!
		//view.jsp에서는 리턴값이 0인지 1인지를 판단한 후, 버튼 표시유무 결정
		
		model.addAttribute("checkResult", fPdtReqService.fpReqCheck(fpNo, mid));		//리턴값이 0인지 1인지에 따라 view.jsp에서 받아서 버튼 표시유무 판별
		model.addAttribute("fpvo", freePdtService.fpView(fpNo));
		
		return "/freePdt/fPdtView";
	}//END view()
	
	
	//display는 UploadController에도 있는데, eventImg 폴더에 업로드한 걸 가져와야 해서 여기에 따로 생성함.
	//업로드된 이미지 파일을 썸네일로 보여줌
	@GetMapping("/freePdt/display")												
	public ResponseEntity<byte[]> display(String fileName){			//fileName 보낼 때 : /display?fileName=upPath&+ uuid + _ + fileName -> ajaxAction.jsp에 내용있음
		//요청된 파일의 내용을 바이트 배열로 읽어와 브라우저에게 전달하므로, 이미지나 파일을 표시하거나 다운로드할 때 사용됨
		
		File file = new File("c:\\eventImg\\" + fileName);
		ResponseEntity<byte[]> result = null;							//띄울 이미지를 담을 result변수 준비
		
		try {
			HttpHeaders	header = new HttpHeaders();							//HttpHeaders는 스프링 걸로 임포트
			header.add("Content-type", Files.probeContentType(file.toPath()));
			
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file),
																		header,
																		HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}//END display();
	
	
	@GetMapping("/freePdt/register")
	@PreAuthorize("hasRole('ROLE_ADMIN')")			//ROLE_ADMIN인 사람이 접근할 때만 해당 메서드 실행
	public String register() {									//제품 나눔 게시글 목록에서 버튼 클릭하면 등록폼으로 이동할 수 있도록
		log.info("FreePdt register form......");
		
		return "/freePdt/fPdtRegi";
	}//END register()
	
	
	@PostMapping("/freePdt/register")
	@PreAuthorize("hasRole('ROLE_ADMIN')")			//ROLE_ADMIN인 사람이 접근할 때만 해당 메서드 실행
	public String register(FreePdtVO fpvo, @RequestParam("uploadFile") MultipartFile uploadFile, RedirectAttributes rttr) {		//등록 잘 됐는지 pid로 확인해보려고 rttr 사용(?)
		log.info("register......" + fpvo);
		
		//START 파일 업로드 처리
		String upFileNm =null;
		
	    if (!uploadFile.isEmpty()) {							//업로드파일이 있다면
	    	log.info("upload logic start action");		//업로드파일이 있음을 인식했는지 확인 (if문 들어왔는지 체크)
	        
	    	String upPath = "c:\\eventImg";			//upPath : 제품 사진이 저장될 경로

	    	File directory = new File(upPath);
	    	if (!directory.exists()) {							//"c:\\eventImg"가 존재하지 않는다면
	    	    directory.mkdir(); 								// 폴더를 생성
	    	}
	    	
			//UUID를 이용하여 파일명(UUID값_파일명) 중복 방지 처리
			UUID uuid = UUID.randomUUID();
			upFileNm = uuid + "_" + uploadFile.getOriginalFilename();
			
			File saveFile  = new File(upPath, upFileNm);			//upFolder 경로에 upFileNm의 이름으로 저장될 File객체 준비
			
			try {
				uploadFile.transferTo(saveFile);		//파일 업로드
				
				//이미지 파일의 썸네일 이미지 만들기
				//썸네일의 파일명은 's_'로 시작하도록 처리
				
				FileOutputStream fos = new FileOutputStream(								//파일 객체 만듦
													new File(upPath, "s_" + upFileNm));		//썸네일 경로
					
				Thumbnailator.createThumbnail(uploadFile.getInputStream(), fos, 100, 100);	//썸네일 만듦, 가로세로 크기 지정

				fos.close();		//FileOutputStream 사용 후 닫아줘야 함			
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			fpvo.setFpImg(upFileNm);
	    }else{
	    	// 파일이 선택되지 않은 경우에 대한 처리
	        fpvo.setFpImg(""); // 빈 문자열로 초기화
	    }//END 업로드 처리
	    
	    System.out.println("upFileNm : " + upFileNm);		//콘솔에서 파일명 확인
		
		if(freePdtService.fpRegister(fpvo)) {							//게시물이 잘 등록됐다면
			rttr.addFlashAttribute("msg", "게시글이 등록되었습니다.");	//목록에서 모달에 띄울 것
		}else {
			rttr.addFlashAttribute("msg", "게시글 등록에 실패하였습니다.");
		}
		return "redirect:/freePdt/list";		//fpvo 등록 후, register.jsp가 아닌 /freePdt/list로 이동할 거라 반환값 지정
		
		//스프링에서 리다이렉트할 때에는 메서드 파라미터에 RedirectAttributes를 선언하고,
		//함께 보내야 할 무언가가 있다면 rttr.addFlashAttribute에서 이름을 지정한 후 담으면 됨
	}//END register()
	
	
	
	
	@GetMapping("/freePdt/modify")
	@PreAuthorize("hasRole('ROLE_ADMIN')")			//ROLE_ADMIN인 사람이 접근할 때만 해당 메서드 실행
	public String modify(int fpNo, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("modify......" + fpNo);
		model.addAttribute("fpvo", freePdtService.fpView(fpNo));
		
		return "/freePdt/fPdtModi";
	}//END modify()
	
	
	@PostMapping("/freePdt/modify")
	@PreAuthorize("hasRole('ROLE_ADMIN')")			//ROLE_ADMIN인 사람이 접근할 때만 해당 메서드 실행
	public String modify(FreePdtVO fpvo, @RequestParam("uploadFile") MultipartFile uploadFile, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {	
		log.info("modify......" + fpvo);
	
		String upFileNm =null;
		
	    if (!uploadFile.isEmpty()) {							//업로드파일이 있다면 업로드 처리
	    	log.info("upload logic start action");		//업로드파일이 있음을 인식했는지 확인
	        
	    	//수정 필요
	    	String upPath = "c:\\eventImg";			//upPath : 제품 사진이 저장될 경로

			//UUID를 이용하여 파일명(UUID값_파일명) 중복 방지 처리
			UUID uuid = UUID.randomUUID();
			upFileNm = uuid + "_" + uploadFile.getOriginalFilename();
			
			File saveFile  = new File(upPath, upFileNm);			//upFolder 경로에 upFileNm의 이름으로 저장될 File객체 준비
			
			try {
				uploadFile.transferTo(saveFile);		//파일 업로드
				
				//이미지 파일의 썸네일 이미지 만들기
				//썸네일의 파일명은 's_'로 시작하도록 처리
				
				FileOutputStream fos = new FileOutputStream(								//파일 객체 만듦
													new File(upPath, "s_" + upFileNm));		//썸네일 경로
					
				Thumbnailator.createThumbnail(uploadFile.getInputStream(), fos, 100, 100);	//썸네일 만듦, 가로세로 크기 지정

				fos.close();		//FileOutputStream 사용 후 닫아줘야 함			
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			fpvo.setFpImg(upFileNm);
	    }//END 업로드 처리
	    
	    System.out.println("upFileNm : " + upFileNm);		//완성된 파일이름 확인
		
		if(freePdtService.fpModify(fpvo)) {							//fpvo 수정이 무사히 됐으면
			rttr.addFlashAttribute("result", "success");			//jsp에서 success 받았으면 "성공적으로 수정되었습니다." 띄우려고.
		}
		
		//modify 메서드는 redirect를 해서 요청객체가 새롭게 만들어지기 때문에 담겼던 cri가 list에 도착을 못함.
		//그래서 별도로 rttr 객체에 담아줘야 함
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		return "redirect:/freePdt/list";
		
		//스프링에서 리다이렉트할 때에는 메서드 파라미터에 RedirectAttributes를 선언하고,
		//함께 보내야 할 무언가가 있다면 rttr.addFlashAttribute에서 이름을 지정한 후 담으면 됨
	}//END modify()
	
	
	
	@PostMapping("/freePdt/remove")	
	@PreAuthorize("hasRole('ROLE_ADMIN')")			//ROLE_ADMIN인 사람이 접근할 때만 해당 메서드 실행
	public String remove(@RequestParam("fpNo")int fpNo, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info("remove......" + fpNo);
		
		if(freePdtService.fpRemove(fpNo) == true) {				//fpNo인 게시물이 잘 지워졌으면	
			rttr.addFlashAttribute("msg", "게시글이 삭제되었습니다.");
		}else {
			rttr.addFlashAttribute("msg", "게시글 삭제에 실패하였습니다.");
		}
		
		//remove 메서드도 redirect를 해서 요청객체가 새롭게 만들어지기 때문에 담겼던 cri가 list에 도착을 못함.
		//그래서 별도로 rttr 객체에 담아줘야 함
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		return "redirect:/freePdt/list";
	}//END remove()
	
	
	////////////////////////////////////////////////////////제품 나눔 신청 관련 메서드
	
	
	//"특정 제품 나눔글"의 당첨자 목록 -> 게시글 상세조회에서 [신청자조회] 버튼으로 들어옴
		@GetMapping("/freePdtReq/list")								//클라이언트가 '/freePdtReq/list'로 들어왔을 때
		@PreAuthorize("hasRole('ROLE_ADMIN')")					//ROLE_ADMIN인 사람이 접근할 때만 해당 메서드 실행
		public String list(Model model, @RequestParam("fpNo")int fpNo) {							//결과 페이지로 보낼 값들을 model에 담음
			log.info("(특정) 제품 나눔글의 신청자 목록............");
			
			//당첨자 목록 화면 상단에 "제품 나눔" 이름 띄워야 해서
			String fpTitle = freePdtService.fpView(fpNo).getFpTitle();
			
			//(로직)
			//1. fpNo로 <제품나눔신청DB>에서 fpNo의 당첨자 리스트를 가져오고, model에 담아
			//2. 당첨자 리스트에서 "당첨자 ID"를 변수에 담고, 당첨자 ID로 memberVO 담아오기
			//3. memberVO를 model에 담아서 jsp로 보내기
			
			List<FPReqVO> fpWinList = fPdtReqService.fpWinList(fpNo);		//FPReqVO에 MemberVO를 넣어둬서 쿼리 실행 결과 회원정보도 같이 옴
			model.addAttribute("fpWinList", fpWinList);	
			model.addAttribute("fpTitle", fpTitle);	
			
			//view에서 꺼낼 땐 그냥 ${}으로 꺼내면 됨
				
			return "/freePdtReq/freeReqList";
		}//END list()
		

		//로그인한 본인만 접근할 수 있도록 권한부여
		//나의 제품 나눔 신청 목록
		@GetMapping("/freePdtReq/myList")									//클라이언트가 '/freePdtReq/myList'로 들어왔을 때
		@PreAuthorize("principal.username == #mid")
		public String myList(Model model, String mid) {					//결과 페이지로 보낼 값들을 model에 담음
			log.info( mid + "회원의 list......");
			
			//"나의 제품나눔 신청목록"화면에서 띄울 내용은 전부 <제품 나눔 게시글DB>에 있음
			//어떤 제품 나눔 게시글VO를 가져올 것인지를 위해 fpListMine() 을 활용
			
			//(로직)
			//mid로 제품 나눔 신청 DB에서 내 것만 가져오기
			//나의 신청서 리스트에서 fpNo를 꺼내면서
			//그걸로 가져온 fpvo를 담은 리스트 만들기
			
			List<FPReqVO> myFpReqList =  fPdtReqService.fpListMine(mid);		//1번
			List<FreePdtVO> myfreePdtList = new ArrayList<>();
			
			for( FPReqVO myFpReq : myFpReqList ) {
				int fpno = myFpReq.getFpNo();
				myfreePdtList.add(freePdtService.fpView(fpno));	
			}
			
			model.addAttribute("myfreePdtList" , myfreePdtList);
			
			return "/freePdtReq/myFreeReq";
		}//END myList()
		
		
		
		
		//제품 나눔 신청 -> 제품 나눔 게시글 상세조회 페이지에서 이뤄짐
		@PostMapping("/freePdtReq/register")						//클라이언트가 '/freePdtReq/register'로 들어왔을 때
		@PreAuthorize("isAuthenticated()")							//현재 로그인된 상태인지 체크
		public String register(FPReqVO fprvo, RedirectAttributes rttr) {		//등록할 땐 리다이렉트 해야해서, rttr 객체 필요		
			log.info("제품 나눔 신청......");
			
			//view.jsp에서 
			//1. 로그인해있지 않다면 "나눔신청"버튼을 안띄움
			//2. doubleCheck한 결과를 가지고 "나눔신청"버튼을 띄울지말지 결정
			
			//나눔신청 버튼을 눌러서 register 메서드로 올 때 vo는 hidden 태그에 담아서 오는 걸로 해보기
			
			if(fPdtReqService.fpReqRegister(fprvo)) {						//신청에 성공했다면
				
				rttr.addFlashAttribute("msg", "신청이 완료되었습니다.");			//fpNo번 나눔 게시글에 신청이 잘 됐다고 모달에 띄우려고
				rttr.addFlashAttribute("fpNo", fprvo.getFpNo());
				rttr.addFlashAttribute("mid", fprvo.getMid());
			}
			return "redirect:/freePdt/view?fpNo="+fprvo.getFpNo()+"&mid="+fprvo.getMid();		
			
			//스프링에서 리다이렉트할 때에는 메서드 파라미터에 RedirectAttributes를 선언하고,
			//함께 보내야 할 무언가가 있다면 rttr.addFlashAttribute에서 이름을 지정한 후 담으면 됨

		}
		

	
}
