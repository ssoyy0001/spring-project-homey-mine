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

import org.homey.domain.ASBoardAttachVO;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
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
public class AsUploadController {
//현재 시점의 '연/월/일' 폴더 경로 문자열을 생성하여 반환
public String getFolderSc() {
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
String str = sdf.format(new Date())+"-asboard";
return str.replace("-", File.separator);
}

//이미지 파일 여부 확인
public boolean isImage(File file) {
    try {
        String contentType = Files.probeContentType(file.toPath());
        return contentType.startsWith("image");
    } catch (IOException e) {
        e.printStackTrace();
    }

    return false;
}

//썸네일 이미지 파일 전송
@GetMapping("/asdisplay")
public ResponseEntity<byte[]> display(String fileName){
    File file = new File("c:\\\\\\\\upload\\\\\\\\" + fileName);
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
}

//파일 삭제
@PostMapping("/asdeleteFile")
public ResponseEntity<String> deleteFile(String fileName, String type){
    log.info("delete file : " + fileName);
    try {
        File file = new File("c:\\\\\\\\upload\\\\\\\\" +
                             URLDecoder.decode(fileName, "UTF-8"));

        file.delete();        //파일 삭제

        if(type.equals("image")) {
            String originFile = file.getAbsolutePath().replace("s_", "");
            file = new File(originFile);
            file.delete();    //썸네일 원본 이미지 파일 삭제
        }
    } catch (UnsupportedEncodingException e) {
        e.printStackTrace();
    }

    return new ResponseEntity<String>("deleted", HttpStatus.OK);
}

//업로드 결과 목록 반환
@PostMapping("/asupload/ajaxAction")
public ResponseEntity<List<ASBoardAttachVO>>
            uploadAjaxAction(MultipartFile[] uploadFile) {
    log.info("upload ajax action");
    String upPath = "c:\\\\\\\\upload";

    // 연/월/일 폴더 생성
    File upFolder = new File(upPath, getFolderSc());

    if(!upFolder.exists()) { // 생성된 폴더가 존재하지 않는 경우 폴더 만들기
        upFolder.mkdirs();
    }

    List<ASBoardAttachVO> list = new ArrayList<ASBoardAttachVO>();

    for(MultipartFile multi : uploadFile) {
        log.info("name : " + multi.getOriginalFilename());
        log.info("size : " + multi.getSize());
        log.info("----------------------------");

        //UUID를 이용하여 파일명('UUID값_파일명' 형태) 중복 방지 처리
        UUID uuid = UUID.randomUUID();
        String upFileNm = uuid + "_" + multi.getOriginalFilename();

        ASBoardAttachVO adto = new ASBoardAttachVO();
        adto.setFileName(multi.getOriginalFilename());
        adto.setUuid(uuid.toString());
        adto.setUpFolder(getFolderSc());

        File saveFile = new File(upFolder, upFileNm);

        try {
            multi.transferTo(saveFile);    //파일 업로드 처리

            if(isImage(saveFile)) {    //이미지 파일인 경우
                adto.setImage(true);    // 'image' 속성을 true로 설정

                //섬네일 이미지 만들기
                FileOutputStream fos = new FileOutputStream(
                        new File(upFolder, "s_" + upFileNm));

                Thumbnailator.createThumbnail(
                        multi.getInputStream(), fos, 100, 100);

                fos.close();
            } else {
                adto.setImage(false);    // 'image' 속성을 false로 설정
            }
        } catch (IllegalStateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        list.add(adto);
    }

    return new ResponseEntity<>(list, HttpStatus.OK);
}


}