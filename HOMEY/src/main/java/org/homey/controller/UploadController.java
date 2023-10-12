package org.homey.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.homey.domain.AttachFileDTO;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	//현재 시점의 '연/월/일' 폴더 경로 문자열을 생성하여 반환
	public String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String str = sdf.format(new Date());
		return str.replace("-", File.separator);
	}//END getFolder() //yyyy-MM-dd 의 -는 file.separator로 변경

	//이미지 파일 여부 확인
	public boolean isImage(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image"); //contentType자체를 확인(파일명 보다)
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return false;
	}//END isImage()
	
	//썸네일 이미지 파일 전송
	@GetMapping("/display")
	public ResponseEntity<byte[]> display(String fileName){
		File file = new File("c:\\upload\\" + fileName);
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", 
					   Files.probeContentType(file.toPath()));
			
			result = new ResponseEntity<>(
							FileCopyUtils.copyToByteArray(file),
							header,
							HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}//END display()
	
	//일반 파일 다운로드
	//http://localhost:8081/download?fileName=test.txt로 테스트
	@GetMapping(value="/download",
				produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
	public ResponseEntity<Resource> download(String fileName){
		Resource resource = new FileSystemResource("c:\\upload\\" + fileName);
		
		if(!resource.exists()) {//파일 이름이 존재하지 않을 시
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		//파일 이름이 존재할 시
		String resourceFileNm = resource.getFilename();
		//파일명에서 UUID 제거
		resourceFileNm = resourceFileNm.substring(resourceFileNm.indexOf("_") + 1); //파일명에서 UUID 제거
		
		log.info(resourceFileNm);
		
		HttpHeaders header = new HttpHeaders();
		try {
			header.add("Content-Disposition", 
					   "attachment; filename=" + 
							   new String(resourceFileNm.getBytes("UTF-8"), "ISO-8859-1"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		//첨부파일과 첨부파일 이름을 만드는 과정
		return new ResponseEntity<>(resource, header, HttpStatus.OK);
	}//END download()
	
	//파일 삭제
	@PostMapping("/deleteFile")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> deleteFile(String fileName, String type){
		log.info("delete file : " + fileName);
		try {
			File file = new File("c:\\upload\\" + 
								 URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();		//파일 삭제
			
			if(type.equals("image")) {
				String originFile = file.getAbsolutePath().replace("s_", "");
				file = new File(originFile);
				file.delete();	//썸네일 원본 이미지 파일 삭제
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
	//업로드 결과 목록 반환
	@PostMapping("/upload/ajaxAction")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<List<AttachFileDTO>> 
				uploadAjaxAction(MultipartFile[] uploadFile) {
		log.info("upload ajax action");
		String upPath = "c:\\upload";
		
		// 연/월/일 폴더 생성
		File upFolder = new File(upPath, getFolder());
		
		if(!upFolder.exists()) { // 생성된 폴더가 존재하지 않는 경우 폴더 만들기
			upFolder.mkdirs(); //폴더를 한꺼번에 생성
		}
		
		List<AttachFileDTO> list = new ArrayList<AttachFileDTO>();
		
		for(MultipartFile multi : uploadFile) {
			log.info("name : " + multi.getOriginalFilename());	//파일명
			log.info("size : " + multi.getSize());				//사이즈
			log.info("----------------------------");
			
			
			//UUID를 이용하여 파일명('UUID값_파일명' 형태) 중복 방지 처리
			UUID uuid = UUID.randomUUID();
			String upFileNm = uuid + "_" + multi.getOriginalFilename();
			
			//(UUID) 전 단계 - 생성된 폴더로 경로를 변경하여야함
		    //File saveFile = new File(upFolder, multi.getOriginalFilename()); //생긴 폴더에 경로가 생겨야 하니까
			
			///DTO 객체 생성
			AttachFileDTO adto = new AttachFileDTO();
			adto.setFileName(multi.getOriginalFilename());
			adto.setUuid(uuid.toString());
			adto.setUpFolder(getFolder());
			
			System.out.println(upFileNm);
			
//			File saveFile = new File(upPath, multi.getOriginalFilename());
//			File saveFile = new File(upFolder, multi.getOriginalFilename());
			File saveFile = new File(upFolder, upFileNm);
			
			try {
				multi.transferTo(saveFile);		//파일 업로드 처리 시점
				
				//업로드 된 파일이 이미지 파일의 경우(isImage)에만 체크 후 섬네일 이미지 생성
				//이미지 파일의 경우 섬네일 이미지 만들기
				//파일명이 's_'로 시작하도록 처리
				if(isImage(saveFile)) {
					adto.setImage(true);
					
					FileOutputStream fos = new FileOutputStream(
							new File(upFolder, "s_" + upFileNm));
					
					Thumbnailator.createThumbnail(
							multi.getInputStream(), fos, 100, 100);
					
					fos.close();	//다 쓰면 fileoutputStream은 닫아야함				
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}	
			list.add(adto);//list에 DTO 추가
		}//END for
		
		return new ResponseEntity<>(list, HttpStatus.OK);
	}//END uploadAjaxAction()
	
	@GetMapping("/upload/ajaxAction")
	public void uploadAjax() {
//		UUID uuid = UUID.randomUUID();
//		System.out.println(uuid);	//uuid 테스트
		log.info("upload ajax");
	}
	
	@PostMapping("/upload/formAction")
	public void uploadAction(MultipartFile[] uploadFile) {
		log.info("upload action");
		String upPath = "c:\\upload";
		for(MultipartFile multi : uploadFile) {
			log.info("name : " + multi.getOriginalFilename());
			log.info("size : " + multi.getSize());
			log.info("----------------------------");
			
			File saveFile = new File(upPath, multi.getOriginalFilename());
			
			try {
				multi.transferTo(saveFile);		//파일 업로드 처리
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}	
		}
	}
	
	@GetMapping("/upload/formAction")
	public void uploadForm() {
		log.info("upload form");
	}
}

////썸네일 이미지 파일 전송 --------------------------------------------
//@GetMapping("/product/display")
//public ResponseEntity<byte[]> Productdisplay(String fileName){
//	File file = new File("c:\\upload\\" + fileName);
//	ResponseEntity<byte[]> result = null;
//	
//	HttpHeaders header = new HttpHeaders();
//	try {
//		header.add("Content-Type", Files.probeContentType(file.toPath()));
//		
//		result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),
//				header,
//				HttpStatus.OK);
//	} catch (IOException e) {
//		e.printStackTrace();
//	}
//	return result;
//}//END 썸네일 이미지 파일 전송 --------------------------------------------




