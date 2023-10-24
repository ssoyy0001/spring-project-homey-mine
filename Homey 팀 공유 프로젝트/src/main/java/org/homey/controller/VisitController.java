package org.homey.controller;

import java.util.List;

import org.homey.domain.VisitVO;
import org.homey.service.VisitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RestController //JSON 받을 수 있는 controller // RESTful API 엔드포인트를 처리
@RequestMapping("/visit/") // API 엔드포인트 경로
//@AllArgsConstructor
public class VisitController {
	 @Autowired
	 private VisitService visitService;
	 
 	//방문 실측 스케줄 등록
    @PostMapping(value="add")
    public ResponseEntity<String> add(@RequestBody VisitVO vvo) {
    	  return visitService.register(vvo)
  	    		? new ResponseEntity<> ("Success", HttpStatus.OK)
  	    		: new ResponseEntity<> (HttpStatus.INTERNAL_SERVER_ERROR);
    }
	 
	//모든 스케줄 조회 (관리자용) 및 200 상태코드 반환
    @GetMapping
    public ResponseEntity<List<VisitVO>> list() {
        List<VisitVO> vvo = visitService.list();
        return new ResponseEntity<>(vvo, HttpStatus.OK);
    }
	    
	//특정 견적상담 번호를 기반으로 스케줄 조회 (회원)
    //http://localhost:8081/visit/18
    @GetMapping(value="{consultNo}")
    public ResponseEntity<VisitVO> view(
    		@PathVariable("consultNo") int consultNo) {
    		
    		log.info("getVisit의 컨트롤러, 방문실측 회원조회");
    		return new ResponseEntity<VisitVO> 
			(visitService.listByConsultNo(consultNo), HttpStatus.OK);
    }
	   
    //방문 실측 스케줄 수정, 성공시 200과 success, 실패하면 500 상태 코드 반환
    //API :: http://localhost:8081/visit/{visitNo}
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, value="{visitNo}")
    public ResponseEntity<String> modify(@RequestBody VisitVO vvo, @PathVariable("visitNo") int visitNo) {
		log.info("modify.............");
		return visitService.modify(vvo)
	    		? new ResponseEntity<> ("Success", HttpStatus.OK)
	    		: new ResponseEntity<> (HttpStatus.INTERNAL_SERVER_ERROR);
    }
    
    //방문 실측 스케줄 삭제, 성공시 200과 success, 실패하면 500 상태 코드 반환
	//API :: http://localhost:8081/visit/{visitNo}
    @DeleteMapping(value="{visitNo}")
    public ResponseEntity<String> remove(@PathVariable("visitNo") int visitNo) {
    	log.info("remove.............");
		return visitService.remove(visitNo)
	    		? new ResponseEntity<> ("Success", HttpStatus.OK)
	    		: new ResponseEntity<> (HttpStatus.INTERNAL_SERVER_ERROR);
    }
    
}
