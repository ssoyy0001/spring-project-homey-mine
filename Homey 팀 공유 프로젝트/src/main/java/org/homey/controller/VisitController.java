package org.homey.controller;

import java.io.Console;
import java.util.List;

import org.homey.domain.ConsultVO;
import org.homey.domain.VisitVO;
import org.homey.service.ConsultService;
import org.homey.service.VisitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;

@RestController // JSON controller
@RequestMapping("/visit/")
@AllArgsConstructor
public class VisitController {
	@Autowired
	private VisitService visitService;
	@Autowired
	private ConsultService consultService;

	// 방문 실측 스케줄 등록
	 @PostMapping("/add")
	    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	    public ResponseEntity<String> addVisitSchedule(@RequestBody List<VisitVO> visitList) {
	        // 해당 견적상담번호가 존재하는지 확인
	        for (VisitVO visit : visitList) {
	            ConsultVO consult = consultService.view(visit.getConsultNo());
	            if (consult == null) {
	            	System.out.println("consult table에 그런 번호 없다.");
	                // 해당 견적상담번호가 존재하지 않는 경우
	                return new ResponseEntity<>("해당 견적상담번호가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
	            }
	        }

	        if (visitService.register(visitList)) {
	            // 새로운 방문 스케줄 리소스의 URI를 반환 (예: "/visit/{newVisitNo}")
	        	System.out.println("consult table에 그런 번호 있다.");
	            return new ResponseEntity<>("New visit schedule added successfully", HttpStatus.CREATED);
	        } else {
	            return new ResponseEntity<>("Failed to add visit schedule", HttpStatus.INTERNAL_SERVER_ERROR);
	        }
	    }

	// 모든 스케줄 조회 (관리자용)
	@GetMapping
	public ResponseEntity<List<VisitVO>> getAllVisitSchedules() {
		List<VisitVO> visitSchedules = visitService.list();
		return new ResponseEntity<>(visitSchedules, HttpStatus.OK);
	}

	// 특정 견적상담 번호를 기반으로 스케줄 조회 (회원)
	@GetMapping("/{consultNo}")
	public ResponseEntity<VisitVO> getVisitSchedules(@PathVariable int consultNo) {
		VisitVO visitSchedule = visitService.listByConsultNo(consultNo);
		if (visitSchedule != null) {
			return new ResponseEntity<>(visitSchedule, HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}

	// 스케줄 수정
	@PatchMapping("/{visitNo}")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	public ResponseEntity<String> updateVisitSchedule(@PathVariable int visitNo, @RequestBody List<VisitVO> visitList) {
		for (VisitVO visitVO : visitList) {
			visitVO.setVisitNo(visitNo);
			if (visitService.modify(visitList)) {
				return new ResponseEntity<>("Visit schedule updated successfully", HttpStatus.OK);
			}
		}
		return new ResponseEntity<>("Failed to update visit schedule", HttpStatus.INTERNAL_SERVER_ERROR);
	}

	// 스케줄 삭제
	@DeleteMapping("/{visitNo}")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	public ResponseEntity<String> deleteVisitSchedule(@PathVariable int visitNo) {
		if (visitService.remove(visitNo)) {
			return new ResponseEntity<>("Visit schedule deleted successfully", HttpStatus.NO_CONTENT);
		} else {
			return new ResponseEntity<>("Failed to delete visit schedule", HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

}
