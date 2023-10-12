package org.homey.controller;

import java.util.List;

import org.homey.domain.VisitVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;

@RestController //JSON 받을 수 있는 controller // RESTful API 엔드포인트를 처리
@RequestMapping("/visit/") //visit 경로 아래의 요청을 처리
@AllArgsConstructor
public class VisitController {

	 @Autowired
	 private org.homey.service.VisitService visitService;
	 
	 //방문 실측 스케줄 조회
	 @GetMapping("/{consultNo}")
	    public ResponseEntity<List<VisitVO>> getVisitSchedules(@PathVariable int consultNo) {
	        List<VisitVO> visitSchedules = visitService.listByConsultNo(consultNo);
	        return new ResponseEntity<>(visitSchedules, HttpStatus.OK);
	    }
	    
	 	//방문 실측 스케줄 등록
	    @PostMapping
	    public ResponseEntity<VisitVO> addVisitSchedule(@RequestBody VisitVO visitVO) {
	        if (visitService.register(visitVO)) {
	            return new ResponseEntity<>(visitVO, HttpStatus.CREATED);
	        } else {
	            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	        }
	    }
	    
	    //방문 실측 스케줄 수정
	    @PutMapping("/{visitNo}")
	    public ResponseEntity<VisitVO> updateVisitSchedule(@PathVariable int visitNo, @RequestBody VisitVO visitVO) {
	        visitVO.setVisitNo(visitNo);
	        if (visitService.modify(visitVO)) {
	            return new ResponseEntity<>(visitVO, HttpStatus.OK);
	        } else {
	            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	        }
	    }
	    
	    //방문 실측 스케줄 삭제
	    @DeleteMapping("/{visitNo}")
	    public ResponseEntity<Void> deleteVisitSchedule(@PathVariable int visitNo) {
	        if (visitService.remove(visitNo)) {
	            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
	        } else {
	            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	        }
	    }
}
