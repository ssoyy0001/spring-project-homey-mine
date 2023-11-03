package org.homey.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.homey.service.OdReqService;
import org.homey.service.OnedayService;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.homey.domain.SoCriteria;
import org.homey.domain.OnedayVO;
import org.homey.domain.PageDTO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
@RequestMapping("/oneday/*")		//대표 맵핑
public class OnedayController {
	
	@Setter(onMethod_ = @Autowired)
	private OnedayService onedayService;
	
	@Setter(onMethod_ = @Autowired)
	private OdReqService odReqService;

	
	@GetMapping("list")
	public String list(Model model, SoCriteria socri) {
		log.info("list......" + socri);
		
		int totalCount = onedayService.odTotalCount(socri);							//주어진 조건에 맞는 게시물 건수를 계산

		model.addAttribute("list", onedayService.odListPaging(socri));
		model.addAttribute("pageDTO", new PageDTO(socri, totalCount));	

		return "/oneday/onedayList";
	}//END list()
	
	
	@GetMapping("view")	
	@PreAuthorize("isAuthenticated()")
	public String view(int odNo, String mid, Model model,  @ModelAttribute("socri") SoCriteria socri) {
		log.info("view....." + odNo);
		
		OnedayVO odvo = onedayService.odView(odNo);
		
		//onedayVO의 odDate의 포맷 재설정
		String odDate = odvo.getOdDate();
		SimpleDateFormat before = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
		SimpleDateFormat after = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		try {
			Date date = before.parse(odDate);
			odDate = after.format(date);
			odvo.setOdDate(odDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		//END onedayVO의 odDate의 포맷 재설정
		
		//원데이클래스 게시글 상세조회 화면에서 "신청하기"버튼 표시할지 말지를 알아야 하니까
		//serviceImpl의 doubleCheck메서드를 호출한 후, 리턴값을 rttr에 담기
		//view.jsp에서는 리턴값이 0인지 1인지를 판단한 후, 버튼 표시유무 결정
		
		model.addAttribute("odvo", odvo);
		model.addAttribute("checkResult", odReqService.doubleCheck(odNo, mid));
		
		return "/oneday/onedayView";
	}//END view()
	
	
	
	//display는 UploadController에도 있는데, eventImg 폴더에 업로드한 걸 가져와야 해서 여기에 따로 생성함.
	//업로드된 이미지 파일을 썸네일로 보여줌
	@GetMapping("/display")												
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
	
	
	


//	@Secured("ROLE_ADMIN")									//이걸로 바꿔 사용해도 가능
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("register")
	public String register() {					
		log.info("register form......");
		
		return "/oneday/onedayRegi";
	}//END register()
	
	

	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping("register")
	public String register(OnedayVO odvo, @RequestParam("uploadFile") MultipartFile uploadFile, RedirectAttributes rttr) {
		log.info("register logic......" + odvo);
		
		//START 파일 업로드 처리
		String upFileNm =null;
		
	    if (!uploadFile.isEmpty()) {							//업로드파일이 있다면
	    	log.info("upload logic start action");		//업로드파일이 있음을 인식했는지 확인 (if문 들어왔는지 체크)
	        
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
			odvo.setOdImg(upFileNm);		//중복방지처리한 파일이름을 odvo에 저장
			
		    System.out.println("upFileNm : " + upFileNm);				//콘솔에서 파일명 확인
			
	    }else {
	        odvo.setOdImg(""); 		 // 파일이 선택되지 않은 경우에 대한 처리 빈 문자열로 초기화
	    }//END 업로드 처리
		
		if(onedayService.odRegister(odvo)) {									//게시물이 잘 등록됐다면
			rttr.addFlashAttribute("msg", "게시글이 등록되었습니다.");
		}else {
			rttr.addFlashAttribute("msg", "게시글 등록에 실패하였습니다.");
		}
		return "redirect:/oneday/list";
		
	}//END register()
	
	
	
	
	@GetMapping("modify")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String modify(int odNo, Model model, @ModelAttribute("socri") SoCriteria socri) {
		log.info("modify......" + odNo);
		model.addAttribute("odvo", onedayService.odView(odNo));
		
		return "/oneday/onedayModi";
	}//END modify()
	
	
	
	@PostMapping("modify")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String modify(OnedayVO odvo, @RequestParam("uploadFile") MultipartFile uploadFile, RedirectAttributes rttr, @ModelAttribute("socri") SoCriteria socri) {	
		log.info("modify......" + odvo);
	
		String upFileNm =null;
		
	    if (!uploadFile.isEmpty()) {							//업로드파일이 있다면 업로드 처리
	    	log.info("upload logic start action");		//업로드파일이 있음을 인식했는지 확인
	        
	    	String upPath = "c:\\eventImg";			//upPath : 제품 사진이 저장될 경로
			UUID uuid = UUID.randomUUID();		//UUID를 이용하여 파일명(UUID값_파일명) 중복 방지 처리
			upFileNm = uuid + "_" + uploadFile.getOriginalFilename();
			
			File saveFile  = new File(upPath, upFileNm);			//upFolder 경로에 upFileNm의 이름으로 저장될 File객체 준비
			
			try {
				uploadFile.transferTo(saveFile);		//파일 업로드
				
				//이미지 파일의 썸네일 이미지 만들기
				//썸네일의 파일명은 's_'로 시작하도록 처리
				
				FileOutputStream fos = new FileOutputStream(								//파일 객체 만듦
													new File(upPath, "s_" + upFileNm));			//썸네일 경로
					
				Thumbnailator.createThumbnail(uploadFile.getInputStream(), fos, 100, 100);	//썸네일 만듦, 가로세로 크기 지정

				fos.close();		//FileOutputStream 사용 후 닫아줘야 함			
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			odvo.setOdImg(upFileNm);
	    }//END 업로드 처리
	    
	    System.out.println("upFileNm : " + upFileNm);					//완성된 파일이름 확인
		
		if(onedayService.odModify(odvo)) {
			rttr.addFlashAttribute("msg", "게시글이 수정되었습니다.");
		}else {
			rttr.addFlashAttribute("msg", "게시글 수정에 실패하였습니다.");
		}
		
		rttr.addAttribute("pageNum", socri.getPageNum());
		rttr.addAttribute("amount", socri.getAmount());
		
		return "redirect:/oneday/view?odNo="+odvo.getOdNo()+"&mid="+odvo.getMid();
	}//END modify()
	
	

	@PostMapping("remove")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String remove(@RequestParam("odNo") int odNo, RedirectAttributes rttr, @ModelAttribute("socri") SoCriteria socri) {
		log.info("remove......" + odNo);
		
		if(onedayService.odRemove(odNo) == true) {						//odNo번 게시물이 잘 지워졌으면	
			rttr.addFlashAttribute("msg", "게시글이 삭제되었습니다.");
		}else {
			rttr.addFlashAttribute("msg", "게시글 삭제에 실패하였습니다.");
		}
		
		rttr.addAttribute("pageNum", socri.getPageNum());
		rttr.addAttribute("amount", socri.getAmount());
		
		return "redirect:/oneday/list";
	}//END remove()
	
	

	
}
