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
import org.homey.domain.SoCriteria;
import org.homey.domain.FPReqVO;
import org.homey.domain.FreePdtVO;
import org.homey.domain.PageDTO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class FreePdtController {
	
	@Setter(onMethod_ = @Autowired)
	private FreePdtService freePdtService;					//제품 나눔 게시글 관련 서비스
	
	@Setter(onMethod_ = @Autowired)
	private FPReqService fPdtReqService;						//제품 나눔 신청 관련 서비스

	@Setter(onMethod_ = @Autowired)
	private MemberService memberService;					//회원 서비스 -> 당첨자 명단 볼 때 회원정보 표시하려고
	
	
	@GetMapping("/freePdt/list")
	public String list(Model model, SoCriteria cri) {		//결과 페이지로 보낼 값들을 model에 담음
		log.info("list......" + cri);
		
		model.addAttribute("list", freePdtService.fpListPaging(cri));
		model.addAttribute("pageDTO", new PageDTO(cri, freePdtService.fpTotalCount(cri)));	
	
		return "/freePdt/fPdtList";
	}//END list()
	
	
	@GetMapping("/freePdt/view")
	@PreAuthorize("isAuthenticated()")							//로그인한 경우에만 상세조회 가능
	public String view(int fpNo, String mid, Model model,  @ModelAttribute("cri") SoCriteria cri) {
	
		log.info("view....." + fpNo);
		
		//제품나눔글 상세조회 화면에서 [신청]버튼 표시여부 판별하기 위해
		//serviceImpl의 doubleCheck메서드를 호출한 후, 리턴값checkResult을 rttr에 담기
		//view.jsp에서는 리턴값이 0인지 1인지를 판단한 후, 버튼 표시유무 결정
		
		model.addAttribute("checkResult", fPdtReqService.fpReqCheck(fpNo, mid));
		model.addAttribute("fpvo", freePdtService.fpView(fpNo));
		
		return "/freePdt/fPdtView";
	}//END view()
	
	
	//display는 UploadController에도 있는데, eventImg 폴더에 업로드한 걸 가져와야 해서 여기에 따로 생성함.
	//업로드된 이미지 파일을 썸네일로 보여줌
	@GetMapping("/freePdt/display")												
	public ResponseEntity<byte[]> display(String fileName){
		//요청된 파일의 내용을 바이트 배열로 읽어와 브라우저에게 전달하므로, 이미지나 파일을 표시하거나 다운로드할 때 사용됨
		
		File file = new File("c:\\eventImg\\" + fileName);
		ResponseEntity<byte[]> result = null;							//띄울 이미지를 담을 result변수 준비
		
		try {
			HttpHeaders	header = new HttpHeaders();					//HttpHeaders는 '스프링' 패키지로 임포트
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
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String register() {
		log.info("FreePdt register form......");
		
		return "/freePdt/fPdtRegi";
	}//END register()
	
	
	@PostMapping("/freePdt/register")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String register(FreePdtVO fpvo, @RequestParam("uploadFile") MultipartFile uploadFile, RedirectAttributes rttr) {
		log.info("register......" + fpvo);
		
		//START 파일 업로드 처리
		String upFileNm =null;
		
	    if (!uploadFile.isEmpty()) {							//업로드파일이 있다면
	    	log.info("upload logic start action");
	        
	    	String upPath = "c:\\eventImg";				//upPath : 제품 사진이 저장될 경로
			UUID uuid = UUID.randomUUID();			//UUID를 이용하여 파일명(UUID값_파일명) 중복 방지 처리
			upFileNm = uuid + "_" + uploadFile.getOriginalFilename();
			
			File saveFile  = new File(upPath, upFileNm);			//upFolder 경로에 upFileNm의 이름으로 저장될 File객체 준비
			
			try {
				uploadFile.transferTo(saveFile);		//파일 업로드
				
				//이미지 파일의 썸네일 이미지 만들기
				//썸네일의 파일명은 's_'로 시작하도록 처리
				
				FileOutputStream fos = new FileOutputStream(							//파일 객체 만듦
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
	        fpvo.setFpImg(""); // 업로드파일이 없다면 '빈 문자열'로 초기화
	    }//END 업로드 처리
	    
	    System.out.println("upFileNm : " + upFileNm);				//콘솔에서 파일명 확인
		
		if(freePdtService.fpRegister(fpvo)) {								//게시물이 잘 등록됐다면
			rttr.addFlashAttribute("msg", "게시글이 등록되었습니다.");
		}else {
			rttr.addFlashAttribute("msg", "게시글 등록에 실패하였습니다.");
		}
		return "redirect:/freePdt/list";
		
	}//END register()
	
	
	
	
	@GetMapping("/freePdt/modify")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String modify(int fpNo, Model model, @ModelAttribute("cri") SoCriteria cri) {
		log.info("modify......" + fpNo);
		model.addAttribute("fpvo", freePdtService.fpView(fpNo));
		
		return "/freePdt/fPdtModi";
	}//END modify()
	
	
	
	@PostMapping("/freePdt/modify")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String modify(FreePdtVO fpvo, @RequestParam("uploadFile") MultipartFile uploadFile, RedirectAttributes rttr, @ModelAttribute("cri") SoCriteria cri) {	
		log.info("modify......" + fpvo);
	
		String upFileNm =null;
		
	    if (!uploadFile.isEmpty()) {							//업로드파일이 있다면 업로드 처리
	    	log.info("upload logic start action");
	        
	    	String upPath = "c:\\eventImg";				//upPath : 제품 사진이 저장될 경로
			UUID uuid = UUID.randomUUID();			//UUID를 이용하여 파일명(UUID값_파일명) 중복 방지 처리
			upFileNm = uuid + "_" + uploadFile.getOriginalFilename();
			
			File saveFile  = new File(upPath, upFileNm);			//upFolder 경로에 upFileNm의 이름으로 저장될 File객체 준비
			
			try {
				uploadFile.transferTo(saveFile);		//파일 업로드
				
				//이미지 파일의 썸네일 이미지 만들기
				//썸네일의 파일명은 's_'로 시작하도록 처리
				
				FileOutputStream fos = new FileOutputStream(							//파일 객체 만듦
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
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		return "redirect:/freePdt/view?fpNo=" + fpvo.getFpNo() + "&mid=" + fpvo.getMid();
	}//END modify()
	
	
	
	@PostMapping("/freePdt/remove")	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String remove(@RequestParam("fpNo")int fpNo, RedirectAttributes rttr, @ModelAttribute("cri") SoCriteria cri) {
		log.info("remove......" + fpNo);
		
		if(freePdtService.fpRemove(fpNo) == true) {						//fpNo인 게시물이 잘 지워졌으면	
			rttr.addFlashAttribute("msg", "게시글이 삭제되었습니다.");
		}else {
			rttr.addFlashAttribute("msg", "게시글 삭제에 실패하였습니다.");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		return "redirect:/freePdt/list";
	}//END remove()
	
	
	////////////////////////////////////////////////////////제품 나눔 신청 관련 메서드
	
	
	//"특정 제품 나눔글"의 당첨자 목록 -> 제품나눔게시글 상세조회에서 [신청자조회] 버튼으로 들어옴
	@GetMapping("/freePdtReq/list")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String list(Model model, @RequestParam("fpNo")int fpNo) {
		log.info("(특정) 제품 나눔글의 신청자 목록............");
		
		String fpTitle = freePdtService.fpView(fpNo).getFpTitle();		//당첨자 목록 화면 상단에 "제품 나눔 게시글명" 띄워야 해서
		
		//<제품나눔신청DB>에서 fpNo게시글의 당첨자 리스트를 가져와서 model에 담기
		//FPReqVO에 MemberVO 변수가 있으므로, fpWinList에 회원정보도 포함돼있음 -> view에서 ${}으로 활용가능
		List<FPReqVO> fpWinList = fPdtReqService.fpWinList(fpNo);
		model.addAttribute("fpWinList", fpWinList);	
		model.addAttribute("fpTitle", fpTitle);	
			
		return "/freePdtReq/freeReqList";
	}//END list()
		

	
	//나의 제품 나눔 신청 목록
	@GetMapping("/freePdtReq/myList")
	@PreAuthorize("principal.username == #mid")				//로그인한 본인만 접근할 수 있도록 권한부여
	public String myList(Model model, String mid) {
		log.info( mid + "회원의 list......");
		
		//"나의 제품나눔 신청목록"화면에서 띄울 내용은 전부 <제품 나눔 게시글DB>에 있음
		//(로직)
		//1. 제품 나눔 신청 DB에서 mid의 신청리스트 가져오기
		//2. "나의 신청서 리스트"의 fpNo를 활용하여
		//3. 해당 fpvo를 담은 리스트 만들기
		
		List<FPReqVO> myFpReqList =  fPdtReqService.fpListMine(mid);		//1번
		List<FreePdtVO> myfreePdtList = new ArrayList<>();
		
		for( FPReqVO myFpReq : myFpReqList ) {
			int fpno = myFpReq.getFpNo();													//2번
			myfreePdtList.add(freePdtService.fpView(fpno));							//3번
		}
		
		model.addAttribute("myfreePdtList" , myfreePdtList);
		
		return "/freePdtReq/myFreeReq";
	}//END myList()
	
	
	
	
	//제품 나눔 신청 -> 제품 나눔 게시글 상세조회 페이지에서 이뤄짐
	@PostMapping("/freePdtReq/register")	
	@PreAuthorize("isAuthenticated()")
	public String register(FPReqVO fprvo, RedirectAttributes rttr) {
		log.info("제품 나눔 신청......");
		
		//view.jsp에서 fprvo는 hidden태그에 담겨옴
		
		if(fPdtReqService.fpReqRegister(fprvo)) {							//신청에 성공했다면
			
			rttr.addFlashAttribute("msg", "신청이 완료되었습니다.");
			rttr.addFlashAttribute("fpNo", fprvo.getFpNo());
			rttr.addFlashAttribute("mid", fprvo.getMid());
		}
		return "redirect:/freePdt/view?fpNo="+fprvo.getFpNo()+"&mid="+fprvo.getMid();		
		
		//스프링에서 리다이렉트할 때에는 메서드 파라미터에 RedirectAttributes를 선언하고,
		//함께 보내야 할 무언가가 있다면 rttr.addFlashAttribute에서 이름을 지정한 후 담으면 됨

	}
		

	
}
