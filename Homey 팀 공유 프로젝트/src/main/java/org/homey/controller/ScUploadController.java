package org.homey.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.homey.domain.AttachFileDTO;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class ScUploadController {
	//현재 시점의 '연/월/일' 폴더 경로 문자열을 생성하여 반환
	public String getFolderSc() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String str = sdf.format(new Date())+"-showcase";
		return str.replace("-", File.separator);
	}//END getFolder()

	//이미지 파일 여부 확인
	public boolean isImage(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return false;
	}//END isImage()
	


	
	//업로드 결과 목록 반환
	@PostMapping("/scupload/ajaxAction")

	public ResponseEntity<List<AttachFileDTO>> 
				uploadAjaxAction(MultipartFile[] uploadFile) {
		log.info("upload ajax action");
		String upPath = "c:\\upload";
		
		// 연/월/일 폴더 생성
		File upFolder = new File(upPath, getFolderSc());
		
		if(!upFolder.exists()) { // 생성된 폴더가 존재하지 않는 경우 폴더 만들기
			upFolder.mkdirs();
		}
		
		List<AttachFileDTO> list = new ArrayList<AttachFileDTO>();
		
		for(MultipartFile multi : uploadFile) {
			log.info("name : " + multi.getOriginalFilename());
			log.info("size : " + multi.getSize());
			log.info("----------------------------");
			
			
			//UUID를 이용하여 파일명('UUID값_파일명' 형태) 중복 방지 처리
			UUID uuid = UUID.randomUUID();
			String upFileNm = uuid + "_" + multi.getOriginalFilename();
			
			AttachFileDTO adto = new AttachFileDTO();
			adto.setFileName(multi.getOriginalFilename());
			adto.setUuid(uuid.toString());
			adto.setUpFolder(getFolderSc());
			
			System.out.println(upFileNm);
			
//			File saveFile = new File(upPath, multi.getOriginalFilename());
//			File saveFile = new File(upFolder, multi.getOriginalFilename());
			File saveFile = new File(upFolder, upFileNm);
			
			try {
				multi.transferTo(saveFile);		//파일 업로드 처리
				
				//이미지 파일의 경우 섬네일 이미지 만들기				
					FileOutputStream fos = new FileOutputStream(
							new File(upFolder, "s_" + upFileNm));
					
					Thumbnailator.createThumbnail(
							multi.getInputStream(), fos, 100, 100);
					
					fos.close();					
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}	
			list.add(adto);
		}//END for
		
		return new ResponseEntity<>(list, HttpStatus.OK);
	}//END uploadAjaxAction()
	

}




