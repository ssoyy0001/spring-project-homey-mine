package org.homey.controller;

import org.homey.domain.ItemVO;
import org.homey.domain.QuotationVO;
import org.homey.service.ItemService;
import org.homey.service.QuotationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController // JSON
@Log4j
@RequestMapping("/quo/")
public class QuotationController {
	@Setter(onMethod_ = @Autowired)
	private QuotationService quotationService;
	@Setter(onMethod_ = @Autowired)
	private ItemService itemService;

	// 견적서 등록 및 item 테이블 값 변경
	@PostMapping(value = "register", produces = MediaType.TEXT_PLAIN_VALUE)
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	public ResponseEntity<String> register(@RequestBody QuotationVO qvo) { // @RequestBody는 단일객체만 받을 수 있음
		ItemVO ivo = qvo.getItem();
		try {
			return quotationService.register(qvo, ivo) ? new ResponseEntity<>("Success", HttpStatus.OK)
					: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		} catch (Exception e) {
			return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
	}

	// Modal 창 내에서 견적서 1개 조회 (test : http://localhost:8081/quo/38)
	@GetMapping(value = "{quoNo}")
	public ResponseEntity<QuotationVO> view(@PathVariable("quoNo") int quoNo) {
		log.info("view.............");
		return new ResponseEntity<QuotationVO>(quotationService.view(quoNo), HttpStatus.OK);
	}

	// 견적서 수정
	@PostMapping("modify")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@RequestMapping(method = { RequestMethod.PUT,
			RequestMethod.PATCH }, value = "{quoNo}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(@RequestBody QuotationVO qvo, @PathVariable("quoNo") int quoNo) {
		log.info("modify.............");
		ItemVO ivo = qvo.getItem();
		try {
			return quotationService.modify(qvo, ivo) ? new ResponseEntity<>("Success", HttpStatus.OK)
					: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		} catch (Exception e) {
			return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
	}

	// 견적서 삭제
	@DeleteMapping(value = "{quoNo}", produces = MediaType.TEXT_PLAIN_VALUE)
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	public ResponseEntity<String> remove(@PathVariable("quoNo") int quoNo) {
		log.info("remove.............");
		return quotationService.remove(quoNo) ? new ResponseEntity<>("Success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}// QuotationController end
