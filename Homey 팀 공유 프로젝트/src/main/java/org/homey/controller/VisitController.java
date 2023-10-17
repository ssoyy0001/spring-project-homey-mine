package org.homey.controller;

import java.util.List;

import org.homey.domain.VisitVO;
import org.homey.service.VisitService;
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
	 private VisitService visitService;
	 
 	//방문 실측 스케줄 등록
    @PostMapping
    public ResponseEntity<String> addVisitSchedule(@RequestBody VisitVO visitVO) {
        if (visitService.register(visitVO)) {
            // 새로운 방문 스케줄 리소스의 URI를 반환 (예: "/visit/{newVisitNo}")
            return new ResponseEntity<>("New visit schedule added successfully", HttpStatus.CREATED);
        } else {
            return new ResponseEntity<>("Failed to add visit schedule", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
	 
	//모든 스케줄 조회 (관리자용)
    @GetMapping
    public ResponseEntity<List<VisitVO>> getAllVisitSchedules() {
        List<VisitVO> visitSchedules = visitService.list();
        return new ResponseEntity<>(visitSchedules, HttpStatus.OK);
    }
	    
	    
	//특정 견적상담 번호를 기반으로 스케줄 조회 (회원)
    @GetMapping("/{consultNo}")
    public ResponseEntity<VisitVO> getVisitSchedules(@PathVariable int consultNo) {
        VisitVO visitSchedule = visitService.listByConsultNo(consultNo);
        if (visitSchedule != null) {
            return new ResponseEntity<>(visitSchedule, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
	   
    //스케줄 수정
    @PutMapping("/{visitNo}")
    public ResponseEntity<String> updateVisitSchedule(@PathVariable int visitNo, @RequestBody VisitVO visitVO) {
        visitVO.setVisitNo(visitNo);
        if (visitService.modify(visitVO)) {
            // 수정된 방문 스케줄 리소스의 URI를 반환 (예: "/visit/{visitNo}")
            return new ResponseEntity<>("Visit schedule updated successfully", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("Failed to update visit schedule", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    //스케줄 삭제
    @DeleteMapping("/{visitNo}")
    public ResponseEntity<String> deleteVisitSchedule(@PathVariable int visitNo) {
        if (visitService.remove(visitNo)) {
            return new ResponseEntity<>("Visit schedule deleted successfully", HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>("Failed to delete visit schedule", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
}
